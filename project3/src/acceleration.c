#include "acceleration.h"
#include "memory.h"
#include <math.h>
#include <stdio.h>

void compute_acc(size_t Natoms, double** coord, double* mass, double** distance, double** acceleration, double EPSILON, double SIGMA) {
    for (size_t i = 0; i < Natoms; i++) {
        for (size_t j = 0; j < 3; j++) {
            acceleration[i][j] = 0.0;
        }
    }

    if (distance == NULL) {
        printf("Allocating and calculating distances dynamically in compute_acc.\n");
        distance = malloc_2d(Natoms, Natoms);
        if (distance == NULL) {
            fprintf(stderr, "Failed to allocate memory for distances in compute_acc.\n");
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
                double sr = SIGMA / r;
                double sr6 = pow(sr, 6);
                double sr12 = sr6 * sr6;
                double force = 24 * EPSILON * (2 * sr12 - sr6) / (r * r);

                acceleration[i][0] += force * (coord[i][0] - coord[j][0]) / mass[i];
                acceleration[i][1] += force * (coord[i][1] - coord[j][1]) / mass[i];
                acceleration[i][2] += force * (coord[i][2] - coord[j][2]) / mass[i];

                acceleration[j][0] -= force * (coord[i][0] - coord[j][0]) / mass[j];
                acceleration[j][1] -= force * (coord[i][1] - coord[j][1]) / mass[j];
                acceleration[j][2] -= force * (coord[i][2] - coord[j][2]) / mass[j];
            }
        }
    }
}
