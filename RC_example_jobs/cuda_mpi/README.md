# CUDA aware MPI

This example is based on the tutorial here: <https://www.olcf.ornl.gov/tutorials/gpudirect-mpich-enabled-cuda>.

### TigerGPU and Adroit (GPU)

To compile:

```bash
$ cd hpc_beginning_workshop/RC_example_jobs/cuda_mpi
$ module load intel/19.1 cudatoolkit openmpi/cuda-10.2/intel-19.1
$ mpicc -lcudart direct.c -o direct.out
```

Then submit with the provided `submit.sbatch`.

### Traverse

```
$ cd hpc_beginning_workshop/RC_example_jobs/cuda_mpi
$ module load cudatoolkit/11.0 openmpi/cuda-11.0/gcc/4.0.4/64 
$ mpicc -lcudart direct.c -o direct.out
$ sbatch submit.sbatch
```
