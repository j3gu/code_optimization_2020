COMPILER=icc
#FFLAGS=-g
FFLAGS=-O3 -ipo -xCORE-AVX2 -axCORE-AVX512,MIC-AVX512
BATCH=sbatch job.sh

LAPACKLIB=mkl

.PHONY: all list submit clean package

COMMONFILES=options.c options.h flag.h la_flag.h
NRFILES=nr.c nrutil.c nrutil.h
GSLFILES=gsl.c
LAPACKFILES=lapack.c

all: nr gsl $(LAPACKLIB)

flag.h: Makefile
	echo 'const char* g_flag="$(COMPILER) $(FFLAGS)";' > flag.h

la_flag.h: Makefile
	echo 'const char* g_flag="$(COMPILER) $(FFLAGS) -$(LAPACKLIB)";' > la_flag.h

nr: $(NRFILES) $(COMMONFILES)
	$(COMPILER) $(FFLAGS) nr.c nrutil.c options.c -o nr

gsl: $(GSLFILES) $(COMMONFILES)
	$(COMPILER) $(FFLAGS) gsl.c options.c -I$(TACC_GSL_INC) -L$(TACC_GSL_LIB) -lgsl -lgslcblas -lm -o gsl


mkl: $(LAPACKFILES) $(COMMONFILES)
	$(COMPILER) $(FFLAGS) -DLALIB lapack.c options.c -mkl -o lapack


count:
	@echo nr `cat $(NRFILES) $(COMMONFILES) | wc -l`
	@echo gsl `cat $(GSLFILES) $(COMMONFILES) | wc -l`

list:
	find . -type f -perm +100 -size +10k -exec {} -f \;

submit:
	$(BATCH)

clean:
	-rm -f *~ *.o ludecomp.o* core.*
	-find . -type f -perm /100 -size +20k -exec rm {} \;

distclean:
	make clean
	-rm -f *.txt *flag.h

package:
	make distclean
	cd ..; rm -f ludecomp.tgz; tar zcvf ludecomp.tgz ludecomp

