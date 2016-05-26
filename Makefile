# simple makefile for a Rappture-based program

CC=g++

RAPPTURE_DIR	= /usr/local/rappture/
INCLUDES	= -I$(RAPPTURE_DIR)/include
LIBS		= -L$(RAPPTURE_DIR)/lib -lrappture -lm

INCLUDES += `gsl-config --cflags`  # to get boost

jacob: jacob.cpp 
	$(CC) $(INCLUDES) $< -o $@ $(LIBS)

all: jacob

clean:
	$(RM) jacob

clean_runs:
	$(RM) run*.xml driver*.xml

clean_rappture: clean_runs
	$(RM) jacob
