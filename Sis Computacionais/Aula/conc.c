#include <pthread.h>
#include <stdio.h>

#define TOTAL 1000
unsigned int sum = 0;

/* thread */
void *incr(){
	unsigned int i;
	
	for(i=0;i<TOTAL;i++){
		sum += 1;
	}
	
	return NULL;
}

int main(){

	pthread_t thread1;
	pthread_t thread2;

	if(pthread_create(&thread1, NULL, incr, NULL)) {
		fprintf(stderr, "Error creating thread\n");
		return 1;
	}
	
	if(pthread_create(&thread2, NULL, incr, NULL)) {
		fprintf(stderr, "Error creating thread\n");
		return 1;
	}


	if(pthread_join(thread1, NULL)) {
		fprintf(stderr, "Error joining thread\n");
		return 2;
	}

	if(pthread_join(thread2, NULL)) {
		fprintf(stderr, "Error joining thread\n");
		return 2;
	}

	printf("SUM: %d\n", sum);

	return 0;
}

