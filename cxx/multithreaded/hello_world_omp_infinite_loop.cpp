#include <iostream>
#include <omp.h>

int main(int argc, char* argv[]) {
  using namespace std;
 
  #pragma omp parallel
  {
  int id = omp_get_thread_num();
  int nthrds = omp_get_num_threads();
  cout << "Hello from thread " << id << " of " << nthrds << endl;
  // next line causes CPU-cores to work (infinite loop)
  while (true) {};
  }
  return 0;
}
