#ifndef FUNCTIONS_H
#define FUNCTIONS_H
 
#include <stdlib.h>
#include <stdio.h>
 
void initialize_velocities(double** velocity, size_t Natoms);
void write_xyz(FILE* file, double** coord, size_t Natoms, int step, double potential_energy, double kinetic_energy);
 
#endif // FUNCTIONS_H
