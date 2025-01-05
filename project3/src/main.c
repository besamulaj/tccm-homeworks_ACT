#include "memory.h"         
#include "readinput.h"      
#include "distances.h"      
#include "lj_potential.h"  
#include "energies.h"      
#include "acceleration.h"   
#include "verlet.h" 

#define MAX_STEPS 1000  // total number of steps for the simulation
#define TIME_STEP 0.2   // time step for the simulation
#define EPSILON 0.0661 // Depth of the Lennard-Jones potential well (in J/mol)
#define SIGMA 0.3345   // Distance at which the potential is zero (in nm)

int main(int argc, char* argv[]) {
    if (argc < 2) {
        fprintf(stderr, "Usage: %s <input_file>\n", argv[0]);
        return EXIT_FAILURE;
    }

    // Open input file
    FILE* input_file = fopen(argv[1], "r");
    if (input_file == NULL) {
        perror("Error opening input file");
        return EXIT_FAILURE;
    }

    // Read the number of atoms
    size_t Natoms = read_Natoms(input_file);

    // Allocate memory for coordinates, masses, distances, velocities, and accelerations
    double** coord = malloc_2d(Natoms, 3);
    if (coord == NULL) {
    fprintf(stderr, "Failed to allocate memory for coord\n");
    return EXIT_FAILURE;
    }

    double** velocity = malloc_2d(Natoms, 3);
    if (velocity == NULL) {
    fprintf(stderr, "Failed to allocate memory for velocity\n");
    return EXIT_FAILURE;
    }

    double** acceleration = malloc_2d(Natoms, 3);
    if (acceleration == NULL) {
    fprintf(stderr, "Failed to allocate memory for acceleration\n");
    return EXIT_FAILURE;
    }

    double* mass = malloc(Natoms * sizeof(double));
    if (mass == NULL) {
    fprintf(stderr, "Failed to allocate memory for mass\n");
    return EXIT_FAILURE;
    }


    if (coord == NULL || velocity == NULL || acceleration == NULL || mass == NULL) {
        fprintf(stderr, "Memory allocation failed\n");
        return EXIT_FAILURE;
    }

    for (size_t i = 0; i < Natoms; i++) {
        for (int j = 0; j < 3; j++) {
            velocity[i][j] = 0.0;
        }
    }

    read_molecule(input_file, Natoms, coord, mass);
    fclose(input_file);

    FILE* output_file = fopen("trajectory.xyz", "w");
    if (output_file == NULL) {
        perror("Error opening output file");
        return EXIT_FAILURE;
    }

    verlet(Natoms, coord, velocity, acceleration, mass, TIME_STEP, MAX_STEPS, output_file);

    fclose(output_file);
    free_2d(coord);
    free_2d(velocity);
    free_2d(acceleration);
    free(mass);

    printf("Simulation complete. Results written to trajectory.xyz\n");
    return EXIT_SUCCESS;
}


