#include <math.h>
#include "lj_potential.h"
 
double V(double EPSILON, double SIGMA, size_t Natoms, double** distance) {
    double potential_energy = 0.0;
    for (size_t i = 0; i < Natoms; i++) {
        for (size_t j = i + 1; j < Natoms; j++) {
            double r = distance[i][j];
            if (r > 0) {
                double r6 = pow(SIGMA / r, 6);
                double r12 = r6 * r6;
                potential_energy += 4 * EPSILON * (r12 - r6);
            }
        }
    }
    return potential_energy;
}
