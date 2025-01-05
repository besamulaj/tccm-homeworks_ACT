#ifndef ACCELERATION_H
#define ACCELERATION_H
 
#include <stdlib.h>
#include <math.h>
 
// Function to compute accelerations
void compute_acc(size_t Natoms, double** coord, double* mass, double** distance, double** acceleration, double epsilon, double sigma);
 
#endif // ACCELERATION_H
