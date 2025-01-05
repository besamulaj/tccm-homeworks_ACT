# Compiler and flags
CC = gcc
CFLAGS = -Wall -Wextra -std=c99
 
# Source and object files
SRC = acceleration.c distance.c energy.c main.c potential.c readinput.c utils.c verlet.c
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
