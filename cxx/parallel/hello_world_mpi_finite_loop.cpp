#include <iostream>
#include <mpi.h>
#include <cmath>

void slow_function(int N) {
  double x;
  for (int i = 0; i < N; i++)
    for (int j = 0; j < N; j++)
      for (int k = 0; k < N; k++)
        x = sin(i) * cos(j) * tan(k);
}

int main(int argc, char** argv) {
  using namespace std;
  
  MPI_Init(&argc, &argv);

  int world_size, world_rank;
  MPI_Comm_size(MPI_COMM_WORLD, &world_size);
  MPI_Comm_rank(MPI_COMM_WORLD, &world_rank);

  // Get the name of the processor
  char processor_name[MPI_MAX_PROCESSOR_NAME];
  int name_len;
  MPI_Get_processor_name(processor_name, &name_len);

  // Print off a hello world message
  cout << "Process " << world_rank << " of " << world_size
       << " says hello from " << processor_name << endl;
  
  // uncomment next line to make CPU-cores work (infinitely)
  // while (true) {};

  // finite loop (adjust N to set execution time)
  int N = 5000;
  slow_function(N);

  MPI_Finalize();
  return 0;
}
