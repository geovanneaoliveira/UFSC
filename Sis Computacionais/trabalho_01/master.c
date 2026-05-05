#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <pthread.h>
#include <arpa/inet.h>
#include <sys/select.h>

#define PORT 8080
#define BATCH_SIZE 25
#define MAX_HASHES 10000
#define MAX_LINE 256

char *hashes[MAX_HASHES];
int total_hashes = 0;
int current = 0;
int hashes_processed = 0; // Controla quando o Master deve encerrar

FILE *output_file;

// Mutexes para evitar condição de corrida entre os workers conectados
pthread_mutex_t master_lock;
pthread_mutex_t file_lock;

void load_hashes(const char *file) {
    FILE *f = fopen(file, "r");
    if (!f) {
        perror("Erro abrindo hashes");
        exit(1);
    }
    char line[MAX_LINE];
    while (fgets(line, sizeof(line), f)) {
        line[strcspn(line, "\n")] = 0;
        hashes[total_hashes++] = strdup(line);
    }
    fclose(f);
}

// Função que cada thread do Master vai rodar para atender um Worker
void *handle_worker(void *arg) {
    int sock = *(int*)arg;
    free(arg); // Libera o ponteiro do socket
    
    while (1) {
        char buffer[8192] = {0};
        int sent_in_this_batch = 0;

        // --- ETAPA 1: Pegar os próximos 25 hashes de forma segura ---
        pthread_mutex_lock(&master_lock);
        if (current >= total_hashes) {
            pthread_mutex_unlock(&master_lock);
            send(sock, "\n", 1, 0); // Sinaliza para o worker que acabou
            break;
        }
        
        for (int i = 0; i < BATCH_SIZE && current < total_hashes; i++, current++) {
            strcat(buffer, hashes[current]);
            strcat(buffer, "\n");
            sent_in_this_batch++;
        }
        pthread_mutex_unlock(&master_lock);

        // Envia o lote para o worker
        send(sock, buffer, strlen(buffer), 0);

        // --- ETAPA 2: Aguardar os resultados deste worker ---
        char resp_buffer[4096] = {0};
        int bytes = read(sock, resp_buffer, sizeof(resp_buffer));
        
        if (bytes <= 0) break; // Worker desconectou ou deu erro

        // --- ETAPA 3: Salvar resultados no txt de forma segura ---
        if (strcmp(resp_buffer, "NONE\n") != 0) {
            pthread_mutex_lock(&file_lock);
            printf("%s", resp_buffer);
            fprintf(output_file, "%s", resp_buffer);
            fflush(output_file);
            pthread_mutex_unlock(&file_lock);
        }

        // Atualiza a contagem de hashes finalizados
        pthread_mutex_lock(&master_lock);
        hashes_processed += sent_in_this_batch;
        if (hashes_processed >= total_hashes) {
            pthread_mutex_unlock(&master_lock);
            break; // Todo o arquivo foi processado
        }
        pthread_mutex_unlock(&master_lock);
    }

    close(sock);
    return NULL;
}

int main() {
    int server_fd;
    struct sockaddr_in address;
    int addrlen = sizeof(address);

    load_hashes("hashes.txt");
    output_file = fopen("senhas_encontradas.txt", "w");
    
    pthread_mutex_init(&master_lock, NULL);
    pthread_mutex_init(&file_lock, NULL);

    server_fd = socket(AF_INET, SOCK_STREAM, 0);
    int opt = 1;
    setsockopt(server_fd, SOL_SOCKET, SO_REUSEADDR, &opt, sizeof(opt));

    address.sin_family = AF_INET;
    address.sin_addr.s_addr = INADDR_ANY;
    address.sin_port = htons(PORT);

    bind(server_fd, (struct sockaddr *)&address, sizeof(address));
    listen(server_fd, 10);

    printf("Master aguardando workers...\n");

    // Loop principal usando select para não travar no accept() e permitir
    // que o Master se encerre automaticamente para o comando 'time' funcionar.
    while (1) {
        // Verifica se todos os hashes já voltaram dos workers
        pthread_mutex_lock(&master_lock);
        if (hashes_processed >= total_hashes) {
            pthread_mutex_unlock(&master_lock);
            break;
        }
        pthread_mutex_unlock(&master_lock);

        fd_set readfds;
        FD_ZERO(&readfds);
        FD_SET(server_fd, &readfds);
        
        // Timeout de 1 segundo para o select
        struct timeval tv;
        tv.tv_sec = 1;
        tv.tv_usec = 0;

        int activity = select(server_fd + 1, &readfds, NULL, NULL, &tv);
        
        if (activity > 0 && FD_ISSET(server_fd, &readfds)) {
            int *client_socket = malloc(sizeof(int));
            *client_socket = accept(server_fd, (struct sockaddr *)&address, (socklen_t*)&addrlen);
            printf("Novo Worker conectado!\n");
            
            pthread_t thread_id;
            pthread_create(&thread_id, NULL, handle_worker, client_socket);
            pthread_detach(thread_id); // Libera a thread para rodar solta
        }
    }

    printf("Todos os hashes foram processados. Encerrando o Master.\n");
    sleep(1); // Dá tempo para o último sinal '\n' chegar no worker antes de fechar tudo

    fclose(output_file);
    close(server_fd);
    pthread_mutex_destroy(&master_lock);
    pthread_mutex_destroy(&file_lock);
    return 0;
}
