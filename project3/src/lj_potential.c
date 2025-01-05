#include "lj_potential.h"
#include "memory.h"
#include <math.h>
#include <stdio.h>

double V(double epsilon, double sigma, size_t Natoms, double** coord, double** distance) {
    double total_potential = 0.0;

    if (distance == NULL) {
        printf("Allocating and calculating distances dynamically in V.\n");
        distance = malloc_2d(Natoms, Natoms);
        if (distance == NULL) {
            fprintf(stderr, "Failed to allocate memory for distances in V.\n");
            exit(EXIT_FAILURE);
        }

        for (size_t i = 0; i < Natoms; i++) {
            for (size_t j = i + 1; j < Natoms; j++) {
                double dx = coord[i][0] - coord[j][0];
                double dy = coord[i][1] - coord[j][1];
                double dz = coord[i][2] - coord[j][2];
                distance[i][j] = sqrt(dx * dx + dy * dy + dz * dz);
            }
        }
    }

    for (size_t i = 0; i < Natoms; i++) {
        for (size_t j = i + 1; j < Natoms; j++) {
            double r = distance[i][j];
            if (r > 0) {
                double sr = sigma / r;
                double sr6 = pow(sr, 6);
                double sr12 = sr6 * sr6;
                total_potential += 4 * epsilon * (sr12 - sr6);
            }
        }
    }

    free_2d(distance); // Free the dynamically allocated distance array
    return total_potential;
}
