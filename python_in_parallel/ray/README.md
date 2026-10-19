# Python Parallelization with Ray

Unlike Dask, Ray is not included in the default Anaconda module, so you'll need to create a conda environment with it first:

```bash
module load anaconda3/2026.7
conda create -n ray-env ray -c conda-forge
conda activate ray-env
```

To get started with Ray in parallel, see [here](https://docs.ray.io/en/latest/ray-core/examples/highly_parallel.html)