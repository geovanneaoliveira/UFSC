#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <pthread.h>
#include <arpa/inet.h>
#include <crypt.h>

#define MAX_PASSWORDS 15000000
#define MAX_PASSWORD_LENGTH 128
#define MAX_HASHES 25

char **password_list;
char *hashes[MAX_HASHES];
int num_hashes;
int total_passwords; // Armazena o total para iterar mais rápido

int num_threads;
int current_index = 0;

pthread_mutex_t lock;
pthread_mutex_t result_lock;
char batch_results[4096]; // Armazena senhas descobertas do lote atual

int loadpasswd(const char* filename) {
    char passwd[MAX_PASSWORD_LENGTH];
    FILE* file = fopen(filename, "r");
    if (!file) {
        perror("Erro ao abrir wordlist");
        exit(1);
    }

    password_list = malloc(MAX_PASSWORDS * sizeof(char*));

    int i = 0;
    while (fgets(passwd, MAX_PASSWORD_LENGTH, file)) {
        passwd[strcspn(passwd, "\n")] = 0;
        password_list[i++] = strdup(passwd);
    }
    
    fclose(file);
    return i;
}

void *worker_thread(void *arg) {
    struct crypt_data data;
    data.initialized = 0;

    while (1) {
        pthread_mutex_lock(&lock);
        int idx = current_index++;
        pthread_mutex_unlock(&lock);

        if (idx >= num_hashes) break;

        char *hash = hashes[idx];
        char salt[12];

        strncpy(salt, hash, 11);
        salt[11] = '\0';

        for (int i = 0; i < total_passwords; i++) {
            char *res = crypt_r(password_list[i], salt, &data);

            if (strcmp(res, hash) == 0) {
                // Ao encontrar, salva no buffer de resultados protegido por mutex
                pthread_mutex_lock(&result_lock);
                char temp[256];
                sprintf(temp, "%s %s\n", password_list[i], hash);
                strcat(batch_results, temp);
                pthread_mutex_unlock(&result_lock);
                break; // Senha encontrada, parte para o próximo hash
            }
        }
    }

    return NULL;
}

int main(int argc, char *argv[]) {
    if (argc < 4) {
        printf("Uso: %s <threads> <rockyou> <ip>\n", argv[0]);
        return 1;
    }

    num_threads = atoi(argv[1]);
    total_passwords = loadpasswd(argv[2]);

    int sock = socket(AF_INET, SOCK_STREAM, 0);
    struct sockaddr_in serv_addr;

    serv_addr.sin_family = AF_INET;
    serv_addr.sin_port = htons(8080);
    inet_pton(AF_INET, argv[3], &serv_addr.sin_addr);

    if (connect(sock, (struct sockaddr *)&serv_addr, sizeof(serv_addr)) < 0) {
        perror("Erro de conexao");
        return 1;
    }

    pthread_mutex_init(&lock, NULL);
    pthread_mutex_init(&result_lock, NULL);

    while (1) {
        char buffer[8192] = {0};
        int bytes_read = read(sock, buffer, sizeof(buffer));

        // Condição de parada: socket fechado ou envio de quebra de linha 
        if (bytes_read <= 0 || buffer[0] == '\n') {
            printf("Processamento finalizado.\n");
            break;
        }

        // Resetando variáveis para o novo lote
        num_hashes = 0;
        current_index = 0;
        memset(batch_results, 0, sizeof(batch_results));

        // Separar hashes e salvar no array
        char *token = strtok(buffer, "\n");
        while (token != NULL) {
            hashes[num_hashes++] = strdup(token);
            token = strtok(NULL, "\n");
        }

        // Criar e aguardar threads processarem o lote atual
        pthread_t threads[num_threads];
        for (int i = 0; i < num_threads; i++) {
            pthread_create(&threads[i], NULL, worker_thread, NULL);
        }

        for (int i = 0; i < num_threads; i++) {
            pthread_join(threads[i], NULL);
        }

        // Limpar hashes da memória para o próximo lote
        for (int i = 0; i < num_hashes; i++) {
            free(hashes[i]);
        }

        // Devolve ao master a lista de senhas descobertas 
        if (strlen(batch_results) > 0) {
            send(sock, batch_results, strlen(batch_results), 0);
        } else {
            send(sock, "NONE\n", 5, 0); // Responde para o master não travar
        }
    }

    close(sock);
    pthread_mutex_destroy(&lock);
    pthread_mutex_destroy(&result_lock);

    return 0;
}
