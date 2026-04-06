#include <pthread.h>
#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <unistd.h>
#include <time.h>

#define TOTAL_IPS   30
#define BUFFERSZ    5
#define STRLEN      64

static char buffer[BUFFERSZ][STRLEN];
static int in, out;
static volatile int count;

static const char format[] = "ping -c 1 -w 1 %s";

/*
 * Realizando envio e recebimento do PING.
 */
int ping_ip(const char *ip)
{
    char str[1024];
    char command[128];
    FILE *fpipe;

    snprintf(command, sizeof(command), format, ip);

    fpipe = popen(command, "r");
    if (fpipe == NULL) {
        perror("popen");
        return -1;
    }

    /* Primeira linha do ping */
    if (fgets(str, sizeof(str), fpipe) != NULL) {
        str[strcspn(str, "\n")] = '\0';
    }

    /* Segunda linha indica se houve resposta */
    if (fgets(str, sizeof(str), fpipe) != NULL) {
        if (strcmp(str, "\n") != 0)
            printf("    [PING] %s -> Alive\n", ip);
        else
            printf("    [PING] %s -> Not responding\n", ip);
    } else {
        printf("    [PING] %s -> No output\n", ip);
    }

    pclose(fpipe);
    return 0;
}

/*
 * Faz Espera Ocupada, problemas de concorrência. 
 */
void getFromBuf(char *str, int consumer_id)
{
    while (count == 0);

    strncpy(str, buffer[out], STRLEN - 1);
    str[STRLEN - 1] = '\0';

    out = (out + 1) % BUFFERSZ;
    count--;
}

void setToBuf(const char *str)
{
    while (count == BUFFERSZ);

    strncpy(buffer[in], str, STRLEN - 1);
    buffer[in][STRLEN - 1] = '\0';

    in = (in + 1) % BUFFERSZ;
    count++;
}

/* Thread produtora */
void *producer(void *arg)
{
    int num = *(int *)arg;
    char str[STRLEN];

    while (num--) {
        snprintf(str, sizeof(str), "%d.%d.%d.%d",
                 rand() % 126 + 1,
                 rand() % 256,
                 rand() % 256,
                 rand() % 256);

        setToBuf(str);
    }

    return NULL;
}

/* Thread consumidora */
void *consumer(void *arg)
{
    int id = *(int *)arg;
    char str[STRLEN];

    while (1) {
        getFromBuf(str, id);
        ping_ip(str);
        fflush(stdout);

        /* Pequeno atraso para tornar o interleaving mais legível */
        usleep(150000);
    }

    return NULL;
}

int main(int argc, char **argv)
{
    pthread_t prod, *con;
    int *ids;
    int i, numthr;
    int n_ips = TOTAL_IPS;

    srand(time(NULL));

    in = 0;
    out = 0;
    count = 0;
    memset(buffer, 0, sizeof(buffer));

    if (argc < 2) {
        printf("Uso: %s <num_threads_consumidoras>\n", argv[0]);
        return 0;
    }

    numthr = atoi(argv[1]);
    if (numthr <= 0) {
        printf("Informe um número válido de threads consumidoras.\n");
        return 1;
    }

    ids = malloc(numthr * sizeof(int));
    con = malloc(numthr * sizeof(pthread_t));

    if (ids == NULL || con == NULL) {
        fprintf(stderr, "Erro de alocação de memória.\n");
        free(ids);
        free(con);
        return 2;
    }

    for (i = 0; i < numthr; i++) {
        ids[i] = i;
    }

    if (pthread_create(&prod, NULL, producer, &n_ips) != 0) {
        fprintf(stderr, "Erro ao criar thread produtora.\n");
        free(ids);
        free(con);
        return 3;
    }

    for (i = 0; i < numthr; i++) {
        if (pthread_create(&con[i], NULL, consumer, &ids[i]) != 0) {
            fprintf(stderr, "Erro ao criar thread consumidora %d.\n", i);
            free(ids);
            free(con);
            return 4;
        }
    }

    if (pthread_join(prod, NULL) != 0) {
        fprintf(stderr, "Erro ao aguardar thread produtora.\n");
        free(ids);
        free(con);
        return 5;
    }

    /*
     * Continua coerente com a proposta original:
     * espera o buffer esvaziar sem sincronização adequada.
     */
    while (count > 0) {
        printf("[MAIN] Aguardando esvaziamento do buffer... count = %d\n", count);
        sleep(1);
    }

    printf("[MAIN] Buffer esvaziado. Encerrando processo.\n");

    free(ids);
    free(con);
    return 0;
}