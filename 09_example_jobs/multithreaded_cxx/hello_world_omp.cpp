// export OMP_NUM_THREADS=4; g++ -Wall -fopenmp -o hw_omp hw_omp.cpp; srun -n 1 -c $OMP_NUM_THREADS -t 1:00 ./hw_omp
#include <iostream>
#include <omp.h>

int main(int argc, char* argv[]) {
  using namespace std;
 
  #pragma omp parallel
  {
  int id = omp_get_thread_num();
  int nthrds = omp_get_num_threads();
  cout << "Hello from thread " << id << " of " << nthrds << endl;
  }
  return 0;
}
