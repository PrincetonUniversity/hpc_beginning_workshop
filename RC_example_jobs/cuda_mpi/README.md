# CUDA aware MPI

This example is based on the tutorial here: <https://www.olcf.ornl.gov/tutorials/gpudirect-mpich-enabled-cuda>.

To compile:

```bash
module load intel/19.1 cudatoolkit openmpi/cuda-10.2/intel-19.1
mpicc -lcudart direct.c -o direct.out
```

Then submit with the provided `submit.sbatch`.
