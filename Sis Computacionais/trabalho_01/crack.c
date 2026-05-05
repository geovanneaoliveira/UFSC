#include <stdio.h>
#include <string.h>
#include <crypt.h>
#include <stdlib.h>

#define MAX_PASSWORDS 15000000
#define MAX_PASSWORD_LENGTH 128

char **password_list;

int loadpasswd(const char* filename) {
    char passwd[MAX_PASSWORD_LENGTH];
    FILE* file = fopen(filename, "r");
    if (file == NULL) {
        perror("fopen(): ");
        return -1;
    }
    password_list = malloc(MAX_PASSWORDS * sizeof(char*));

    int i = 0;
    while (i < MAX_PASSWORDS && fgets(passwd, MAX_PASSWORD_LENGTH, file) != NULL) {
        passwd[strcspn(passwd, "\n")] = 0;  // Remove newline
        password_list[i] = strdup(passwd);
        i++;
    }

    fclose(file);
    return i;
}


int main(int argc, char* argv[]) {
    // The password hash from the shadow file (user-provided example)
    char *shadow_hash;
    char salt[12];
    

    if(argc < 3) {
        printf("Usage: %s <hash> <dict file>\n", argv[0]);
        return 1;
    }

    int npasswd = loadpasswd(argv[2]);

    shadow_hash = argv[1];    

    // Extracting the salt from the shadow_hash, it includes "$1$" and ends before the second "$"
    strncpy(salt, shadow_hash, 11);
    salt[11] = '\0';  // Ensure null termination

    for (int i=0; i<npasswd; i++) {
    	// em multithread use crypt_r(), pois crypt() não é threadsafe. 
        char *new_hash = crypt(password_list[i], salt);
        if (strcmp(shadow_hash, new_hash) == 0) {
            printf("Password found: %s\n", password_list[i]);
            return 0;
        }
    }

    printf("Password not found!");
    
    return 0;
}
