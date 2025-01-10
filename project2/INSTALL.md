# Installation Guide
This document provides instructions on how to compile and run the **Sparse Matrix Multiplication** program written in Fortran.

---

## Prerequisites
Before starting, ensure the following software is installed:
- **GNU Fortran (gfortran)** or any compatible Fortran compiler.
- A terminal or command-line interface to execute commands.

---

## Steps to Compile and Run

### 1. Obtain the Project Files
Ensure all project files, including source code, Makefile, and input matrix files, are in a single directory.

---

### 2. Compile the Program
#### Option 1: Manual Compilation
To manually compile the program, navigate to the project directory and run the following command in bash:

*gfortran -O2 -std=legacy -ffree-line-length-none -o MATRIX_APP \
    performance_analysis.f90 profiling_analysis.f90 scaling_analysis.f90 timing_analysis.f90 \
    read_sparse_matrix.f90 sparse_to_dense.f90 multiply_sparse_matrix.f90 multiply_dense_matrix.f90 \
    main.f90*

This will generate an executable named MATRIX_APP.

#### Option 2. Using Makefile
Antother way to compile the program and build artifacts, is using *Makefile*. After writing all the lines that take care of the building, cleaning and debugging the program, on terminal we type **make** command to produce the executable named MATRIX_APP.
In case we have build artifacts, we clean them up first by **make clean** command, and then use **make** again to compile, and produce the executable for Fortran program MATRIX_APP.

-----

### 3. Run the Program
Run the program with an input file:

*./MATRIX_APP*

-----

### 4. Test the Program
To verify the program's functionality, run the provided tests in the **tests** directory.
