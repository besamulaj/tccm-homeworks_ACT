#ifndef READINPUT_H
#define READINPUT_H
 
#include <stdio.h>
#include <stdlib.h>
 
// Function to read the number of atoms from an input file
size_t read_Natoms(FILE* input_file);
 
// Function to read atomic coordinates and masses
void read_molecule(FILE* input_file, size_t Natoms, double** coord, double* mass);
 
#endif // READINPUT_H
