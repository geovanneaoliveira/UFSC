  #include <stdio.h>
  #include <unistd.h>
  
  int main() {
      while (1) {
          // Dorme por 1 segundo para simular tarefa I/O-bound
          sleep(1);
      }
      return 0;
  }
