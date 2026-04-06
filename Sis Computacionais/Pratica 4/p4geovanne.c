#include <pthread.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>

pthread_mutex_t mutex = PTHREAD_MUTEX_INITIALIZER;
pthread_cond_t cond = PTHREAD_COND_INITIALIZER;

int cont = 1;

void* th1() {
    while (1) {
        pthread_mutex_lock(&mutex);
        while (cont != 1)
            pthread_cond_wait(&cond, &mutex);

        printf("1\n");
        fflush(stdout);
        cont = 2;
        pthread_cond_broadcast(&cond);  // Acorda as outras threads
        pthread_mutex_unlock(&mutex);
        sleep(1);
    }
}

void* th2() {
    while (1) {
        pthread_mutex_lock(&mutex);
        while (cont != 2)
            pthread_cond_wait(&cond, &mutex);

        printf("2\n");
        fflush(stdout);
        cont = 3;
        pthread_cond_broadcast(&cond);
        pthread_mutex_unlock(&mutex);
        sleep(2);
    }
}

void* th3() {
    while (1) {
        pthread_mutex_lock(&mutex);
        while (cont != 3)
            pthread_cond_wait(&cond, &mutex);

        printf("3\n");
        fflush(stdout);
        cont = 1;
        pthread_cond_broadcast(&cond);
        pthread_mutex_unlock(&mutex);
        sleep(3);
    }
}

int main() {
    pthread_t thread1, thread2, thread3;

    pthread_create(&thread1, NULL, th1, NULL);
    pthread_create(&thread2, NULL, th2, NULL);
    pthread_create(&thread3, NULL, th3, NULL);

    pthread_join(thread1, NULL);
    pthread_join(thread2, NULL);
    pthread_join(thread3, NULL);

    return 0;
}