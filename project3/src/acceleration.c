#include <math.h>
#include "acceleration.h"
 
void compute_acc(size_t Natoms, double** coord, double* mass, double** distance, double** acceleration, double EPSILON, double SIGMA) {
    for (size_t i = 0; i < Natoms; i++) {
        for (size_t j = 0; j < 3; j++) {
            acceleration[i][j] = 0.0; // Reset acceleration
        }
    }
 
    for (size_t i = 0; i < Natoms; i++) {
        for (size_t j = i + 1; j < Natoms; j++) {
            double r = distance[i][j];
            if (r > 0) {
                double r6 = pow(SIGMA / r, 6);
                double r12 = r6 * r6;
                double force = 24 * EPSILON * (2 * r12 - r6) / (r * r);
 
                for (size_t k = 0; k < 3; k++) {
                    double d = coord[i][k] - coord[j][k];
                    acceleration[i][k] += force * d / mass[i];
                    acceleration[j][k] -= force * d / mass[j];
                }
            }
        }
    }
}
