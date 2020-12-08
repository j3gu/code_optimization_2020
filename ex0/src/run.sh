#!/bin/bash
icc -O0 -no-vec  Driver.c Multiply.c -o NoVectMult
icc -O2 -qopt-report=2 -qopt-report-phase=vec Driver.c Multiply.c -o VectMult
