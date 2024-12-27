#include <stdio.h>
#include "../src/memory.c"
#include "../src/input.c"
#include "../src/distances.c"

int main() {
    FILE* input_file = fopen("../tests/inp.txt", "r");
    if (!input_file) {
        printf("Error: Cannot open input file.\n");
        return 1;
    }

    size_t Natoms = read_Natoms(input_file);
    double** coord = malloc_2d(Natoms, 3);
    double* mass = malloc(Natoms * sizeof(double));
    read_molecule(input_file, Natoms, coord, mass);

    double** distance = malloc_2d(Natoms, Natoms);
    compute_distances(Natoms, coord, distance);

    //printing the distance matrix
    printf("Distance matrix:\n");
    for (size_t i = 0; i < Natoms; i++) {
        for (size_t j = 0; j < Natoms; j++) {
            printf("%.3f ", distance[i][j]);
        }
        printf("\n");
    }

    free_2d(coord);
    free_2d(distance);
    free(mass);
    fclose(input_file);

    return 0;
}
