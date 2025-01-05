#include "memory.h"
#include <stdlib.h>

double** malloc_2d(size_t rows, size_t cols) {
    double** array = malloc(rows * sizeof(double*));
    if (array == NULL) {
        return NULL;
    }

    array[0] = malloc(rows * cols * sizeof(double));
    if (array[0] == NULL) {
        free(array);
        return NULL;
    }

    for (size_t i = 1; i < rows; i++) {
        array[i] = array[0] + i * cols;
    }

    return array;
}

void free_2d(double** array) {
    free(array[0]);
    free(array);
}
