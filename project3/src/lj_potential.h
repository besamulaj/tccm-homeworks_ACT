#ifndef LJ_POTENTIAL_H
#define LJ_POTENTIAL_H
 
#include <math.h>
#include <stdlib.h>
 
// Function to compute Lennard-Jones potential energy
double V(double epsilon, double sigma, size_t Natoms, double** distance);
 
#endif // LJ_POTENTIAL_H
