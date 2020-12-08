#include <stdio.h>
#include <stdlib.h>
#include <sys/time.h>
#define PTS 10000000
#define MXSTRIDE 20
void main() {
  unsigned long i, istride, msec;
  double *data, cnorm, mean, rate;
  struct timeval tm1, tm2;
  data = malloc(PTS*MXSTRIDE*sizeof(double));
  cnorm = 1.0 / (RAND_MAX + 1.0);
  for (i = 0; i <= PTS*MXSTRIDE; i++) {
    data[i] = (rand() + 1) * cnorm;
  }
  for (istride = 1; istride <= MXSTRIDE; istride++) {
    mean = 0.;
    gettimeofday(&tm1, NULL);
    for (i = 0; i < PTS*istride; i += istride) {
      mean = mean + data[i];
    }
    gettimeofday(&tm2, NULL);
    mean = mean / PTS;
    msec = 1000 * (tm2.tv_sec - tm1.tv_sec) + \
        (tm2.tv_usec - tm1.tv_usec) / 1000;
    rate = sizeof(double)*PTS*(1000.0/msec) / (1024*1024);
    printf("stride %2lu, mean %f, ", istride, mean);
    printf("time %3lu msec, rate %4.0f MB/s\n", msec, rate);
  }
}

