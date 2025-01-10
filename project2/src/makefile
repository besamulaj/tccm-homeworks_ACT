# Compiler and options
FC = gfortran
FFLAGS = -O2 -std=legacy -ffree-line-length-none
 
# Files and dependencies
OBJS = performance_analysis.o profiling_analysis.o scaling_analysis.o \
       timing_analysis.o read_sparse_matrix.o sparse_to_dense.o \
       multiply_sparse_matrix.o multiply_dense_matrix.o main.o
 
# Target executable
TARGET = matrix_app
 
# Default rule
all: $(TARGET)
 
# Link the target executable
$(TARGET): $(OBJS)
        $(FC) $(FFLAGS) -o $@ $(OBJS)
 
# Compile each object file
%.o: %.f90
        $(FC) $(FFLAGS) -c $<
 
# Clean rule
clean:
        rm -f $(OBJS) *.mod $(TARGET)
