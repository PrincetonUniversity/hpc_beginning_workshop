# CUDA C Kernel

Below is the simplest GPU code:

```C
#include <stdio.h>

void CPUFunction() {
  printf("Hello world from the CPU.\n");
}

__global__ void GPUFunction() {
  printf("Hello world from the GPU.\n");
}

int main() {
  // function to run on the cpu
  CPUFunction();

  // function to run on the gpu
  GPUFunction<<<1, 1>>>();
  
  // kernel execution is asynchronous so sync on its completion
  cudaDeviceSynchronize();
}
```

This can be compiled with:

```
module load cudatoolkit
nvcc -o hello_world_gpu hello_world_gpu.cu
```

This can be run with: `srun --gres=gpu:1 -t 1 ./hello_world_gpu`

```
#!/bin/bash
#SBATCH --job-name=cuda_c        # create a short name for your job
#SBATCH --nodes=1                # node count
#SBATCH --ntasks=1               # total number of tasks across all nodes
#SBATCH --cpus-per-task=1        # cpu-cores per task (>1 if multi-threaded tasks)
#SBATCH --mem-per-cpu=4G         # memory per cpu-core (4G is default)
#SBATCH --gres=gpu:1             # number of gpus per node
#SBATCH --time=00:01:00          # total run time limit (HH:MM:SS)
#SBATCH --mail-type=begin        # send email when job begins
#SBATCH --mail-type=end          # send email when job ends
#SBATCH --mail-user=<YourNetID>@princeton.edu

module purge
module load cudatoolkit

srun ./hello_world_gpu
```

The output should be:

```
Hello world from the CPU.
Hello world from the GPU.
```
