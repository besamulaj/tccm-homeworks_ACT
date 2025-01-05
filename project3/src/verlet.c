#include "verlet.h"
#include "acceleration.h"
#include "energies.h"
#include "lj_potential.h"
#include <stdio.h>

void verlet(size_t Natoms, double** coord, double** velocity, double** acceleration, double* mass, double dt, size_t steps, FILE* output_file) {
    for (size_t step = 0; step < steps; step++) {
        // Update positions
        for (size_t i = 0; i < Natoms; i++) {
            for (int k = 0; k < 3; k++) {
                coord[i][k] += velocity[i][k] * dt + 0.5 * acceleration[i][k] * dt * dt;
            }
        }

        // Half-step velocity update
        for (size_t i = 0; i < Natoms; i++) {
            for (int k = 0; k < 3; k++) {
                velocity[i][k] += 0.5 * acceleration[i][k] * dt;
            }
        }

        // Recompute accelerations
        compute_acc(Natoms, coord, mass, NULL, acceleration, 0.0661, 0.3345);

        // Final velocity update
        for (size_t i = 0; i < Natoms; i++) {
            for (int k = 0; k < 3; k++) {
                velocity[i][k] += 0.5 * acceleration[i][k] * dt;
            }
        }

        // Compute energies
        double potential_energy = V(0.0661, 0.3345, Natoms, coord, NULL);
        double kinetic_energy = T(Natoms, velocity, mass);

        if (step % 10 == 0) {
            fprintf(output_file, "%zu\n", Natoms);
            fprintf(output_file, "Step %zu | Potential Energy: %.6f | Kinetic Energy: %.6f\n",
                    step, potential_energy, kinetic_energy);
            for (size_t i = 0; i < Natoms; i++) {
                fprintf(output_file, "Ar %.6f %.6f %.6f\n", coord[i][0], coord[i][1], coord[i][2]);
            }
        }
    }
}
