#/bin/bash

module load intel/19.1.1

icc -O1 -o no_opt stride_prog.c
icc -O2 -o opt stride_prog.c
