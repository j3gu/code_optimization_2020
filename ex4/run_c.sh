#!/bin/bash

icc -debug -O0 prog_d.c -o helloworld_c
ifort -debug -O0 prog_d.f90 -o helloworld_f


