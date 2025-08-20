# CUDA-Aware MPI

This example is based on the tutorial here: <https://www.olcf.ornl.gov/tutorials/gpudirect-mpich-enabled-cuda>.

### Adroit (GPU)

```
$ cd hpc_beginning_workshop/RC_example_jobs/cuda_mpi
$ module load intel/19.1/64/19.1.1.217 cudatoolkit/10.2 openmpi/cuda-10.2/intel-19.1
$ mpicc -lcudart direct.c -o direct.out
$ sbatch job.slurm
```

### Della-GPU

```
$ cd hpc_beginning_workshop/RC_example_jobs/cuda_mpi
$ module load nvhpc/25.5 openmpi/cuda-12.9/nvhpc-25.5/4.1.8 cudatoolkit/12.9
$ mpicc direct.c -o direct.out -lcudart
$ sbatch job.slurm  # be sure to load the correct modules in job.slurm
```

Or to use GCC:

```
$ cd hpc_beginning_workshop/RC_example_jobs/cuda_mpi
$ module load cudatoolkit/11.1 openmpi/cuda-11.1/gcc/4.1.1
$ mpicc -lcudart direct.c -o direct.out
$ sbatch job.slurm  # be sure to load the correct modules in job.slurm
```
