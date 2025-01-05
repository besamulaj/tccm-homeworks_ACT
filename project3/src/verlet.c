#include "verlet.h"
 
void verlet_step(size_t Natoms, double** coord, double** velocity, double** acceleration, double dt) {
    for (size_t i = 0; i < Natoms; i++) {
        for (size_t k = 0; k < 3; k++) {
            coord[i][k] += velocity[i][k] * dt + 0.5 * acceleration[i][k] * dt * dt;
            velocity[i][k] += 0.5 * acceleration[i][k] * dt;
        }
    }
    // Recalculate accelerations
    // Call compute_acc here
    for (size_t i = 0; i < Natoms; i++) {
        for (size_t k = 0; k < 3; k++) {
            velocity[i][k] += 0.5 * acceleration[i][k] * dt;
        }
    }
}
