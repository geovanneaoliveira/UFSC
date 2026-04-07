  #include <stdio.h>
  #include <unistd.h>
  
  int main() {
      while (1) {
          for (int i = 0; i < 1000000; i++); // Loop para consumir CPU
          sleep(1); // Dorme para simular I/O
      }
      return 0;
  }