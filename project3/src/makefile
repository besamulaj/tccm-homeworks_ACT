# Compiler and flags
CC = gcc
CFLAGS = -Wall -Wextra -std=c99
 
# Source and object files
SRC = acceleration.c distances.c energies.c main.c lj_potential.c readinput.c memory.c verlet.c
OBJ = $(SRC:.c=.o)
EXEC = md_simulation
 
# Build the executable
all: $(EXEC)
 
$(EXEC): $(OBJ)
        $(CC) $(OBJ) -o $(EXEC) -lm
 
%.o: %.c
        $(CC) $(CFLAGS) -c $< -o $@
 
clean:
        rm -f $(OBJ) $(EXEC)
~                                     
