#include <stdio.h>
#include <stdlib.h>
#include <pthread.h>

pthread_mutex_t first_mutex;
pthread_mutex_t second_mutex;

void *do_work_one(void *param) {
    while(1){
        pthread_mutex_lock(&first_mutex);
        pthread_mutex_lock(&second_mutex);
    
        printf("do_work_one\n");
    
        pthread_mutex_unlock(&second_mutex);
        pthread_mutex_unlock(&first_mutex);

        // liberar na ordem que trancou
    }
}

void *do_work_two(void *param) {
    while (1){
        pthread_mutex_lock(&second_mutex);
        pthread_mutex_lock(&first_mutex);
    
        printf("do_work_two\n");
    
        pthread_mutex_unlock(&first_mutex);
        pthread_mutex_unlock(&second_mutex);
    }
    
    
}

int main() {
    pthread_t thread_one, thread_two;

    // Inicializa os mutexes
    pthread_mutex_init(&first_mutex, NULL);
    pthread_mutex_init(&second_mutex, NULL);

    // Cria as threads
    pthread_create(&thread_one, NULL, do_work_one, NULL);
    pthread_create(&thread_two, NULL, do_work_two, NULL);

    // Aguarda as threads terminarem
    pthread_join(thread_one, NULL);
    pthread_join(thread_two, NULL);

    // Destrói os mutexes
    pthread_mutex_destroy(&first_mutex);
    pthread_mutex_destroy(&second_mutex);

    return 0;
}
