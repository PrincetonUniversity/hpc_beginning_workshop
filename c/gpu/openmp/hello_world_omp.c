#include <stdio.h>
#include <omp.h>

int main(int argc, char* argv[]) {
 
  #pragma omp target
  #pragma omp parallel
  {
  int id = omp_get_thread_num();
  int nthrds = omp_get_num_threads();
  printf("Hello from thread %d of %d\n", id, nthrds);
  }
  return 0;
}
