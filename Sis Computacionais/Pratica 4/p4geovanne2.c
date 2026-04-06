#include <pthread.h>
#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <semaphore.h>
#include <unistd.h>

sem_t sem;

void * th1(void *n){
    int id = *(int*)n;
    int i;

    while(1){
        

        printf("Thread %d entrou\n", id);

        for(i=0;i<5;i++){
            printf("%d\n", id);
            fflush(stdout);
            sleep(1);
        }

        printf("Thread %d saiu\n", id);

        sem_post(&sem); 
        sleep(1); 
    }
}

int main(int argc, char **argv){
    pthread_t thread1, thread2, thread3, thread4;
    int thread_ids[4] = {0, 1, 2, 3};

    sem_init(&sem, 0, 2); 

    if(pthread_create(&thread1, NULL, th1, &thread_ids[0])) {
        fprintf(stderr, "Error creating thread\n");
        return 1;
    }

    if(pthread_create(&thread2, NULL, th1, &thread_ids[1])) {
        fprintf(stderr, "Error creating thread\n");
        return 1;
    }

    if(pthread_create(&thread3, NULL, th1, &thread_ids[2])) {
        fprintf(stderr, "Error creating thread\n");
        return 1;
    }

    if(pthread_create(&thread4, NULL, th1, &thread_ids[3])) {
        fprintf(stderr, "Error creating thread\n");
        return 1;
    }

    
    pthread_join(thread1, NULL);
    pthread_join(thread2, NULL);
    pthread_join(thread3, NULL);
    pthread_join(thread4, NULL);

    sem_destroy(&sem); 

    return 0;
}
