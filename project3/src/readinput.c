#include <stdio.h>
#include <stdlib.h>
#include "memory.c" 

//function for reading the number of atoms
size_t read_Natoms(FILE* input_file) {
    size_t Natoms;
    if (input_file == NULL) {
        fprint(stderr, "Error: Input file is NULL.\n");
        exit(EXIT_FAILURE);
    }    
    if (fscanf(input_file, "%zu", &Natoms) != 1) {
        fprint(stderr, "Error: Failed to read the number of atoms from the input file.\n");
        exit(EXIT_FAILURE);
    }
    return Natoms;
}

//function for reading coordinates and atomic masses
void read_molecule(FILE* input_file, size_t Natoms, double** coord, double* mass) {
    //are files and arrays  valid?
    if (input_file == NULL) {
        fprintf(stderr, "Error: Input file is NULL.\n");
        exit(EXIT_FAILURE);
    }
    if (coord == NULL || mass == NULL) {
        fprintf(stderr, "Error: Coordinate or mass array is NULL.\n");
        exit(EXIT_FAILURE);
    }

    for (size_t i = 0; i < Natoms; i++) {
        if (fscanf(input_file, "%lf %lf %lf %lf", &coord[i][0], &coord[i][1], &coord[i][2], &mass[i]) !=4) {
            fprint(stderr, "Error: Failed to read data for atom %zu.\n", i);
            exit(EXIT_FAILURE);
        }
    }
}
