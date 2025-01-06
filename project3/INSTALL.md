# Installation Guide
This document provides instructions on how to compile and run the molecular dynamics simulation program.

## Prerequisites:
Before starting, ensure the following software is installed:
- **GCC Compiler** (or another C compiler)
- **Gnuplot** (if you want to visualize energy data)

-----

## Steps to Compile and Run
### 1. Clone or Copy the project
Ensure all project files, including source code, test files, and input files, are in a single directory.

-----

### 2. Compile the Program 
#### Option 1. Manual compliation 
To compile the program, open a terminal and navigate to the project directory. Run the following command:

bash:

*gcc -o md_simulation main.c memory.c readinput.c distances.c lj_potential.c energies.c acceleration.c verlet.c -lm*

This will generate an executable named md_simulation.

#### Option 2. Using Makefile
Antother way to compile the program and build artifacts, is using *Makefile*. After writing all the lines that take care of the building, cleaning and debugging the program, on terminal we type **make** command to produce the executable named md_simulation.
In case we have build artifacts, we clean them up first by **make clean** command, and then use **make** again to compile, and produce the executable for running the MD simulation.

-----

### 3. Run the Program
Run the program with an input file:

*./md_simulation inp.txt*

The program will generate an output file named trajectory.xyz containing the results of the simulation.

### 4. Test the Program
To verify the program's functionality, run the provided test cases:

*gcc -o tests/test tests/test.c memory.c readinput.c distances.c lj_potential.c energies.c acceleration.c -lm
./tests/test*

If all tests pass, you’ll see the message: All tests passed.

### 5. Visualize the Results
If you have Gnuplot installed, you can visualize the energy values from the output file (trajectory.xyz):

  #### Step 1.
  Extract the energy data into a new file:
  
*grep "Step" trajectory2.xyz | awk -F'|' '{
    step=$1;
    ke=$3;
    pe=$2;
    gsub("Step ", "", step);
    gsub("Kinetic Energy: ", "", ke);
    gsub("Potential Energy: ", "", pe);
    total_energy=sprintf("%.5f", ke + pe);
    print step, ke, pe, total_energy
}' > formatted_energy_data.txt*

The command will generate new file formatted_energy_data.txt including Step, Kinetic Energy, Potential Energy and Total Energy in each column.

  #### Step 2.
  Open Gnuplot (command: **gnuplot**)

  #### Step 3.
  Plot the energy data:
  
*set title "Energy vs Steps"
set xlabel "Steps"
set ylabel "Energy"
plot "energy_data.txt" using 1:2 with lines title "Kinetic Energy", \
     "energy_data.txt" using 1:3 with lines title "Potential Energy", \
     "energy_data.txt" using 1:4 with lines title "Total Energy"*

  #### Step 4.
  Save the plot (Optional): Before the plot command, use following command to save the plot as a .png file:
  
*set terminal pngcairo size 800,600 enhanced font 'Arial,12'
set output "energy_plot.png"*
