#include <stdio.h>
#include <stdlib.h>
#include <pthread.h>
#include <semaphore.h>

/* Semaphores */
sem_t R1, R2, R3;

void *P1(void *param) {
    while(1){
        sem_wait(&R2);
        sem_wait(&R1);
        
        printf("P1\n");

        sem_post(&R1);
        sem_post(&R2);
    
    }
}

void *P2(void *param) {
    while (1){
    

        sem_wait(&R2);
        sem_wait(&R1);                
        sem_wait(&R3);

        printf("P2\n");

        sem_post(&R3);
        sem_post(&R1);        
        sem_post(&R2);
    }
}

void *P3(void *param) {
    while (1){
        sem_wait(&R3);
        sem_wait(&R2);
    
        printf("P3\n");

        sem_post(&R2);
        sem_post(&R3);
    }
}


int main() {
    pthread_t T1, T2, T3;

    // Inicializa os semafaros.
    sem_init(&R1, 0, 1);
    sem_init(&R2, 0, 2);
    sem_init(&R3, 0, 1);


    // Cria as threads
    pthread_create(&T1, NULL, P1, NULL);
    pthread_create(&T2, NULL, P2, NULL);
    pthread_create(&T3, NULL, P3, NULL);

    // Aguarda as threads terminarem
    pthread_join(T1, NULL);
    pthread_join(T2, NULL);
    pthread_join(T3, NULL);

    // Destrói os mutexes
    sem_destroy(&R1);
    sem_destroy(&R2);
    sem_destroy(&R3);

    return 0;
}
