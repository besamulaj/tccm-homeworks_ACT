#include <assert.h>
#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include "../memory.h"
#include "../readinput.h"
#include "../distances.h"
#include "../lj_potential.h"
#include "../energies.h"
#include "../verlet.h"

void test_malloc_2d() {
    double** matrix = malloc_2d(3, 3);
    assert(matrix != NULL);
    free_2d(matrix);
    printf("test_malloc_2d passed.\n");
}

void test_read_Natoms() {
    FILE* file = fopen("tests/test_input1.txt", "r");
    assert(file != NULL);
    size_t Natoms = read_Natoms(file);
    fclose(file);
    assert(Natoms == 3);  // Expected from the input file
    printf("test_read_Natoms passed.\n");
}

void test_read_molecule() {
    FILE* file = fopen("tests/test_input1.txt", "r");
    assert(file != NULL);
    size_t Natoms = read_Natoms(file);
    double** coord = malloc_2d(Natoms, 3);
    double* mass = malloc(Natoms * sizeof(double));
    read_molecule(file, Natoms, coord, mass);
    fclose(file);

    // Check parsed data
    assert(coord[0][0] == 0.0 && coord[0][1] == 0.0 && coord[0][2] == 0.0);
    assert(mass[0] == 39.948);
    free_2d(coord);
    free(mass);
    printf("test_read_molecule passed.\n");
}

void test_compute_distances() {
    double** coord = malloc_2d(3, 3);
    coord[0][0] = 0.0; coord[0][1] = 0.0; coord[0][2] = 0.0;
    coord[1][0] = 0.0; coord[1][1] = 0.0; coord[1][2] = 0.5;
    coord[2][0] = 0.1; coord[2][1] = 0.2; coord[2][2] = -0.5;

    double** distance = malloc_2d(3, 3);
    compute_distances(3, coord, distance);
    assert(fabs(distance[0][1] - 0.5) < 1e-6);  // Expected distance
    free_2d(coord);
    free_2d(distance);
    printf("test_compute_distances passed.\n");
}

void test_V() {
    double epsilon = 0.0661, sigma = 0.3345;
    double** coord = malloc_2d(3, 3);
    coord[0][0] = 0.0; coord[0][1] = 0.0; coord[0][2] = 0.0;
    coord[1][0] = 0.0; coord[1][1] = 0.0; coord[1][2] = 0.5;
    coord[2][0] = 0.1; coord[2][1] = 0.2; coord[2][2] = -0.5;

    double potential = V(epsilon, sigma, 3, coord, NULL);
    assert(potential < 0);  // Potential should be negative
    free_2d(coord);
    printf("test_V passed.\n");
}

int main() {
    test_malloc_2d();
    test_read_Natoms();
    test_read_molecule();
    test_compute_distances();
    test_V();
    printf("All tests passed.\n");
    return 0;
}

