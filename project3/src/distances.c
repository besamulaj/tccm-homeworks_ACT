#include <math.h>
#include <stdio.h>
#include <stddef.h>
#include "memory.c" 

// Function for computing distances between atoms
void compute_distances(size_t Natoms, double** coord, double** distance) {
    // Looping through all pairs of atoms
    for (size_t i = 0; i < Natoms; i++) {
        for (size_t j = 0; j < Natoms; j++) {
            if (i == j) {
                distance[i][j] = 0.0; // Distance to self is 0
            } else {
                double dx = coord[i][0] - coord[j][0];
                double dy = coord[i][1] - coord[j][1];
                double dz = coord[i][2] - coord[j][2];
                distance[i][j] = sqrt(dx * dx + dy * dy + dz * dz);

            }
        }
    }
}
