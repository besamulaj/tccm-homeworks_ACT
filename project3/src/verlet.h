#ifndef VERLET_H
#define VERLET_H
 
#include <stdlib.h>
 
// Function to perform Verlet integration step
void verlet_step(size_t Natoms, double** coord, double** velocity, double** acceleration, double dt);
 
#endif // VERLET_H
