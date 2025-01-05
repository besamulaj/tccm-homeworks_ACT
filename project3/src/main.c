#include "memory.h"         
#include "readinput.h"      
#include "distances.h"      
#include "lj_potential.h"  
#include "energies.h"      
#include "acceleration.h"   
#include "verlet.h" 
#include "functions.h"

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
    double** velocity = malloc_2d(Natoms, 3);
    double** acceleration = malloc_2d(Natoms, 3);
    double** distance = malloc_2d(Natoms, Natoms);
    double* mass = malloc(Natoms * sizeof(double));

    if (coord == NULL || velocity == NULL || acceleration == NULL || distance == NULL || mass == NULL) {
        fprintf(stderr, "Memory allocation failed\n");
        return EXIT_FAILURE;
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
    FILE* energy_file = fopen("energy.dat", "w");
    if (!energy_file) {
        perror("Error opening energy file");
        return EXIT_FAILURE;
    }
    fprintf(energy_file, "# Step\tKinetic Energy\tPotential Energy\tTotal Energy\n");
 
    // Print initial message
    printf("Starting Molecular Dynamics simulation with %zu atoms...\n", Natoms);
 
    for (int step = 0; step < MAX_STEPS; step++) {
        // Compute initial distances
        compute_distances(Natoms, coord, distance);
        
        // Compute potential energy
        double potential_energy = V(EPSILON, SIGMA, Natoms, distance);
 
        // Compute kinetic energy
        double kinetic_energy = T(Natoms, velocity, mass);
 
        // Check if the total energy is conserved
        double total_energy = potential_energy + kinetic_energy;

        // Write energies to the energy file
        fprintf(energy_file, "%d\t%.6f\t%.6f\t%.6f\n", step, kinetic_energy, potential_energy, total_energy);
 
        // Print progress every 100 steps
        if (step % 100 == 0) {
            printf("Step %d: Kinetic = %.6f, Potential = %.6f, Total = %.6f\n", step, kinetic_energy, potential_energy, total_energy);
        }
 
        // Write trajectory to output.xyz every 10 steps
        if (step % 10 == 0) {
            write_xyz(output_file, coord, Natoms, step, potential_energy, kinetic_energy);
       
        // Compute accelerations
        compute_acc(Natoms, coord, mass, distance, acceleration, EPSILON, SIGMA);

        // Run molecular dynamics simulation with Verlet algorithm
        verlet(Natoms, coord, velocity, acceleration, mass, TIME_STEP, MAX_STEPS, output_file);
        
        }

    }

    // Clean up
    fclose(output_file);
    free_2d(coord);
    free_2d(velocity);
    free_2d(acceleration);
    free_2d(distance);
    free(mass);

    printf("Simulation complete. Results written to trajectory.xyz\n and energy.dat.\n");
    return EXIT_SUCCESS;
}

