#include <stdlib.h>
#include <stdio.h>

// Allocate a 2D array
double** malloc_2d(size_t m, size_t n) {
    double** a = malloc(m * sizeof(double*)); 
    if (a==NULL) {
        fprintf(stderr, "Error: Unable to allocate memory for 2D array pointers.\n");
        return NULL;
    }
//Allocate a contiguous block of memory for the elements of 2D array
    a[0] = malloc(m * n * sizeof(double));
    if (a[0] ==NULL) {
        fprintf(stderr, "Error: Unable to allocate memory for 2D array data.\n");
        free(a);
        return NULL;
    }

    //pointers to each row
    for (size_t i = 1; i < m; i++) {
        a[i] = a[i - 1] + n;
    }
    return a;
}
//Function to free memory for a 2D array
void free_2d(double** a) {
    free(a[0]); //free the contiguous block of memory
    a[0]= NULL
    free(a);   //free the array of pointers 
    
}
