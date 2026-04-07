#include <stdio.h>
#include <semaphore.h>
#include <pthread.h>
#include <unistd.h>
#include <stdlib.h>

struct philo_data{
	int id;
	pthread_mutex_t* fork_rigth;
	pthread_mutex_t* fork_left;
};

enum philo_state {THINKING, EATING, HUNGRY};

void* philosopher(void *p){
	struct philo_data *dt = (struct philo_data*)p;
	enum philo_state state = THINKING;

	printf("Philosopher %d running.\n", dt->id);
	fflush(stdout);

	/*FIXME: Insert philosophers sincronization !!! */

	while(1){
		switch(state){
			case THINKING:
				printf("Philosopher %d thinking.\n", dt->id);
				fflush(stdout);
				sleep(rand()%10);
				state = HUNGRY;
				break;

			case HUNGRY:
				printf("Philosopher %d hungry.\n", dt->id);
				fflush(stdout);
				state = EATING;
				sleep(rand()%10);
				break;

			case EATING:
				printf("Philosopher %d eating.\n", dt->id);
				fflush(stdout);
				sleep(rand()%10);
				state = THINKING;
				break;
		}


	}
}

int main(int argc, char** argv){
	pthread_mutex_t *fork_list;
	unsigned int n_philo, i;
	struct philo_data* dt;
	pthread_t t;

	if(argc < 2){
		printf("Usage: %s <nummber of philosophers>\n", argv[0]);
		exit(0);
	}

	srand(time(NULL));

	n_philo = atoi(argv[1]);

	fork_list = (pthread_mutex_t *) malloc(n_philo * sizeof(pthread_mutex_t));

	pthread_mutex_init(&fork_list[0], NULL);
	for(i=0; i<n_philo; i++){
		dt = (struct philo_data*)malloc(sizeof(struct philo_data));
		dt->id = i;
		dt->fork_rigth = &fork_list[i];
		if(i != n_philo - 1){
			pthread_mutex_init(&fork_list[i+1], NULL);
			dt->fork_left = &fork_list[i+1];
		}else{
			dt->fork_left = &fork_list[0];
		}
		pthread_create(&t, NULL, philosopher, dt);
	}


	printf("Press any key to finish.\n");
	getchar();

	/*All data allocated will be free finishing the program.*/

	return 0;
}