#!/bin/bash
#SBATCH -J ludecomp        # job name
#SBATCH -o ludecomp.o%j    # output/error file (%j = jobID)
#SBATCH -e ludecomp.e%j
#SBATCH -N 1               # number of nodes required
#SBATCH -n 1               # number of MPI tasks requested
#SBATCH -t 00:05:00        # run time (hh:mm:ss)
#SBATCH --qos=stafftest

date
env|sort>variables.txt
module load gsl
model load intel
set -x

export MATRIX=3000
OUT=t$SLURM_JOB_ID.txt

echo Shell is $SHELL
count=0
for lib in nr gsl lapack
do
  /usr/bin/time -f '%e' ./$lib -n $MATRIX 1> $OUT 2> nrtime.txt
  if test $? -eq 0
  then
    export RUNTIME=`cat nrtime.txt`
    # The application is compiled so that -f shows the compiler flags.
    echo $RUNTIME `./$lib -f` >> results.txt
  fi
  count=$((count+1))
done

date
hostname
