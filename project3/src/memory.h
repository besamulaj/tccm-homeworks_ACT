#ifndef MEMORY_H
#define MEMORY_H
 
#include <stdlib.h>
 
double** malloc_2d(size_t rows, size_t cols);
void free_2d(double** array);
 
#endif // MEMORY_H
