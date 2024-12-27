#include <stdlib.h>
#include <stdio.h>

// Allocate a 2D array
double** malloc_2d(size_t m, size_t n) {
    double** array = malloc(m * sizeof(double*)); 
    if (!array) {
        fprintf(stderr, "Error: Unable to allocate memory for 2D array pointers.\n");
        return NULL;
    }

    array[0] = malloc(m * n * sizeof(double));
    if (!array[0]) {
        fprintf(stderr, "Error: Unable to allocate memory for 2D array data.\n");
        free(array);
        return NULL;
    }

    //pointers to each row
    for (size_t i = 1; i < m; i++) {
        array[i] = array[i - 1] + n;
    }
    return array;
}

void free_2d(double** array) {
    if (array) {
        free(array[0]); 
        free(array);   
    }
}
