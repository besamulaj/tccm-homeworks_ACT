#include "memory.h"         
#include "readinput.h"      
#include "distances.h"      
#include "lj_potential.h"  
#include "energies.h"      
#include "acceleration.h"   
#include "verlet.h"     

#define MAX_STEPS 1000  // total number of steps for the simulation
#define TIME_STEP 0.2   // time step for the simulation

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
    double** velocity = malloc_2d(Natoms, 3);
    double** acceleration = malloc_2d(Natoms, 3);
    double** distance = malloc_2d(Natoms, Natoms);
    double* mass = malloc(Natoms * sizeof(double));

    if (coord == NULL || velocity == NULL || acceleration == NULL || distance == NULL || mass == NULL) {
        fprintf(stderr, "Memory allocation failed\n");
        return EXIT_FAILURE;
    }

    // Initialize velocities to zero
    for (size_t i = 0; i < Natoms; i++) {
        for (int j = 0; j < 3; j++) {
            velocity[i][j] = 0.0;
        }
    }

    // Read atomic data from the input file
    read_molecule(input_file, Natoms, coord, mass);
    fclose(input_file);

    // Open output file for writing the trajectory
    FILE* output_file = fopen("trajectory.xyz", "w");
    if (output_file == NULL) {
        perror("Error opening output file");
        return EXIT_FAILURE;
    }

    // Compute initial distances
    compute_distances(Natoms, coord, distance);

    // Compute initial accelerations
    double epsilon = 0.0661; // Lennard-Jones parameter ε in kJ/mol
    double sigma = 0.3345;   // Lennard-Jones parameter σ in nm
    compute_acc(Natoms, coord, mass, distance, acceleration, epsilon, sigma);

    // Compute pairwise distances
    compute_distances(Natoms, coord, distance);
 
    // Compute potential energy
    double potential_energy = V(EPSILON, SIGMA, Natoms, distance);
 
    // Compute kinetic energy
    double kinetic_energy = T(Natoms, velocity, mass);
 
    // Check if the total energy is conserved
    double total_energy = potential_energy + kinetic_energy;
 
    // Compute accelerations
    compute_acc(Natoms, coord, mass, distance, acceleration, EPSILON, SIGMA);

    // Run molecular dynamics simulation with Verlet algorithm
    verlet(Natoms, coord, velocity, acceleration, mass, TIME_STEP, MAX_STEPS, output_file);

    // Clean up
    fclose(output_file);
    free_2d(coord);
    free_2d(velocity);
    free_2d(acceleration);
    free_2d(distance);
    free(mass);

    printf("Simulation complete. Results written to trajectory.xyz\n");
    return EXIT_SUCCESS;
}

