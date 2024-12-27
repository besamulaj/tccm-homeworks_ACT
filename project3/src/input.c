#include <stdio.h>
#include <stdlib.h>

//function for reading the number of atoms
size_t read_Natoms(FILE* input_file) {
    size_t Natoms;
    fscanf(input_file, "%zu", &Natoms); // Read the number of atoms
    return Natoms;
}

//function for reading coordinates and atomic masses
void read_molecule(FILE* input_file, size_t Natoms, double** coord, double* mass) {
    for (size_t i = 0; i < Natoms; i++) {
        fscanf(input_file, "%lf %lf %lf %lf", &coord[i][0], &coord[i][1], &coord[i][2], &mass[i]);
    }
}
