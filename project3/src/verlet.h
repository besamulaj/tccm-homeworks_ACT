#ifndef VERLET_H
#define VERLET_H
 
#include <stdlib.h>
#include <stdio.h>
 
// Function to perform Verlet integration step
void verlet(size_t Natoms, double** coord, double** velocity, double** acceleration, double* mass, double dt, size_t steps, FILE* output_file);
 
#endif // VERLET_H
