#include <stdlib.h>
#include <stdio.h>
#include <time.h>

#define NUM 1000

int main(int argc, char** argv) {
    unsigned int *vector1 = (unsigned int*)malloc(NUM * sizeof(unsigned int));
    unsigned int *vector2 = (unsigned int*)malloc(NUM * sizeof(unsigned int));

    srand(time(NULL));
    unsigned int result = 0;
    for (int index = 0; index < NUM; index++) {
        vector1[index] = rand() % 100;
        vector2[index] = rand() % 100;
        result += vector1[index] * vector2[index];
    }
    printf("%d\n", result);
    free(vector1);
    free(vector2);
    return 0;
}