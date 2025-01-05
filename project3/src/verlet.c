#include "verlet.h"

// Verlet algorithm for molecular dynamics
void verlet(size_t Natoms, double** coord, double** velocity, double** acceleration, double dt, size_t steps, FILE* output_file) {
    for (size_t step = 0; step < steps; step++) {
        // Update positions
        for (size_t i = 0; i < Natoms; i++) {
            for (int k = 0; k < 3; k++) {
                coord[i][k] += velocity[i][k] * dt + 0.5 * acceleration[i][k] * dt * dt;
            }
        }

        // Final velocity update
        for (size_t i = 0; i < Natoms; i++) {
            for (int k = 0; k < 3; k++) {
                velocity[i][k] += 0.5 * acceleration[i][k] * dt;
            }
        }

        // Write coordinates to output file every 10 steps
        if (step % 10 == 0) {
            fprintf(output_file, "%zu\n", Natoms);
            fprintf(output_file, "Step %zu\n", step);
            for (size_t i = 0; i < Natoms; i++) {
                fprintf(output_file, "Ar %.3lf %.3lf %.3lf\n", coord[i][0], coord[i][1], coord[i][2]);
            }
        }
    }
}
