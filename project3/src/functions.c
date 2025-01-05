#include "functions.h"
 
void initialize_velocities(double** velocity, size_t Natoms) {
    for (size_t i = 0; i < Natoms; i++) {
        for (size_t j = 0; j < 3; j++) {
            velocity[i][j] = 0.0; // Set initial velocities to zero
        }
    }
}
 
 
void write_xyz(FILE* file, double** coord, size_t Natoms, int step, double potential_energy, double kinetic_energy) {
    if (!file) {
        fprintf(stderr, "Error: Output file is not open\n");
        exit(EXIT_FAILURE);
    }
    fprintf(file, "%zu\n", Natoms);
    fprintf(file, "Step %d | Potential Energy: %.6f | Kinetic Energy: %.6f\n", step, potential_energy, kinetic_energy);
    for (size_t i = 0; i < Natoms; i++) {
        fprintf(file, "Ar %.6f %.6f %.6f\n", coord[i][0], coord[i][1], coord[i][2]);
    }
}
