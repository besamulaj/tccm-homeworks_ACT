#include <stdio.h>
#include <stdlib.h>
#include "../src/memory.c"  //for memory allocation
#include "../src/input.c"  //

int main() {
    FILE* input_file = fopen("inp.txt", "r");
    if (!input_file) {
        printf("Error: Cannot open input file.\n");
        return 1;
    }

    size_t Natoms = read_Natoms(input_file);
    printf("Number of atoms: %zu\n", Natoms);

    double** coord = malloc_2d(Natoms, 3); //memory allocation for coordinates
    double* mass = malloc(Natoms * sizeof(double)); //memory allocation for masses

    read_molecule(input_file, Natoms, coord, mass);

    for (size_t i = 0; i < Natoms; i++) {
        printf("Atom %zu: x=%.2f, y=%.2f, z=%.2f, mass=%.2f\n",
               i + 1, coord[i][0], coord[i][1], coord[i][2], mass[i]);
    }

    //free allocated memory
    free_2d(coord);
    free(mass);
    fclose(input_file);

    return 0;
}
