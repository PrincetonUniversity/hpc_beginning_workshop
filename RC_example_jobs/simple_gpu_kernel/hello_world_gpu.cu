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
