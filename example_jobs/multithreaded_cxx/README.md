# Multi-threaded C++ Program

Here is the source code for a simple multi-threaded C++ program:

```
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
```

Compile the program using the following commands:

```
module load intel
icpc -qopenmp -o hello_world_omp hello_world_omp.cpp
```

Submit the job to the cluster:

```
sbatch job.slurm
```

The output of the code should be:

```
Hello from thread Hello from thread Hello from thread Hello from thread Hello from thread Hello from thread 3 of 826 of 0584 of 8
Hello from thread 

 of  of 8
7 of 8
 of 8
Hello from thread 1 of 8
8
```
