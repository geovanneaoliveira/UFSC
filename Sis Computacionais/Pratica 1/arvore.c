#include <stdio.h>
#include <unistd.h>
#include <sys/types.h>

int main() {
    pid_t p2, p3, p4, p5;

    printf("P1: PID = %d\n", getpid());

    p2 = fork();

    if (p2 == 0) {
        // Processo P2
        printf("P2: PID = %d, PPID = %d\n", getpid(), getppid());

        p4 = fork();

        if (p4 == 0) {
            // Processo P4
            printf("P4: PID = %d, PPID = %d\n", getpid(), getppid());
        } else {
            p5 = fork();

            if (p5 == 0) {
                // Processo P5
                printf("P5: PID = %d, PPID = %d\n", getpid(), getppid());
            }
        }

    } else {
        p3 = fork();

        if (p3 == 0) {
            // Processo P3
            printf("P3: PID = %d, PPID = %d\n", getpid(), getppid());
        }
    }

    // Mantém todos os processos vivos para inspeção
    getchar();

    return 0;
}