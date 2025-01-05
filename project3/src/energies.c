#include "energies.h"
 
double T(size_t Natoms, double** velocity, double* mass) {
    double kinetic_energy = 0.0;
    for (size_t i = 0; i < Natoms; i++) {
        double v2 = velocity[i][0] * velocity[i][0] +
                    velocity[i][1] * velocity[i][1] +
                    velocity[i][2] * velocity[i][2];
        kinetic_energy += 0.5 * mass[i] * v2;
    }
    return kinetic_energy;
