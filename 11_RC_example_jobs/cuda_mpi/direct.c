#include <stdio.h>
#include <stdlib.h>
#include <cuda_runtime.h>
#include <mpi.h>
#include <mpi-ext.h>

/* Based on the tutorial here:  https://www.olcf.ornl.gov/tutorials/gpudirect-mpich-enabled-cuda/ */

int main( int argc, char** argv ) {

    MPI_Init (&argc, &argv);

    int direct;
    int rank, size;
    int *h_buff = NULL;
    void *d_rank = NULL;
    void *d_buff = NULL;
    size_t bytes;
    int i;

    // Get MPI rank and size
    MPI_Comm_rank (MPI_COMM_WORLD, &rank);
    MPI_Comm_size (MPI_COMM_WORLD, &size);

    if(rank == 0) {
        printf("Compile time check:\n");
#       if defined(MPIX_CUDA_AWARE_SUPPORT) && MPIX_CUDA_AWARE_SUPPORT
            printf("This MPI library has CUDA-aware support.\n");
#       elif defined(MPIX_CUDA_AWARE_SUPPORT) && !MPIX_CUDA_AWARE_SUPPORT
            printf("This MPI library does not have CUDA-aware support.\n");
#       else
            printf("This MPI library cannot determine if there is CUDA-aware support.\n");
#       endif /* MPIX_CUDA_AWARE_SUPPORT */

        printf("Run time check:\n");
#       if defined(MPIX_CUDA_AWARE_SUPPORT)
            if (1 == MPIX_Query_cuda_support()) {
                printf("This MPI library has CUDA-aware support.\n");
            } else {
                printf("This MPI library does not have CUDA-aware support.\n");
            }
#       else /* !defined(MPIX_CUDA_AWARE_SUPPORT) */
            printf("This MPI library cannot determine if there is CUDA-aware support.\n");
#       endif /* MPIX_CUDA_AWARE_SUPPORT */
    }

    // Allocate host and device buffers and copy rank value to GPU
    bytes = size*sizeof(int);
    h_buff = (int*)malloc(bytes);
    cudaMalloc(&d_buff, bytes);
    cudaMalloc(&d_rank, sizeof(int));
    cudaMemcpy(d_rank, &rank, sizeof(int), cudaMemcpyHostToDevice);

    // Sync at this point (would make log nicer)
    MPI_Barrier(MPI_COMM_WORLD);

    // Preform Allgather using device buffer
    MPI_Allgather(d_rank, 1, MPI_INT, d_buff, 1, MPI_INT, MPI_COMM_WORLD);

    // Check that the GPU buffer is correct
    cudaMemcpy(h_buff, d_buff, bytes, cudaMemcpyDeviceToHost);
    for(i=0; i<size; i++){
        if(h_buff[i] != i) {
            printf ("Alltoall Failed!\n");
            exit (EXIT_FAILURE);
        }
    }

    if(rank==0)
        printf("Success!\n");

    // Clean up
    free(h_buff);
    cudaFree(d_buff);
    cudaFree(d_rank);
    MPI_Finalize();

    return 0;
}
