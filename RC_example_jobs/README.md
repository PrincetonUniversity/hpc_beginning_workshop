# Running Example Jobs on the HPC Clusters

The sample jobs above are written for Nobel, Adroit, Perseus, Dell and Tiger in mind. You will probably need to use different environment modules on Traverse.

Follow the directions below to begin running simple jobs on Adroit.
After SSHing to Adroit the first step is to `cd` (change directory)
to your directory on `/scratch/network/<YourNetID>`. We do this because `/scratch/network`
is a much faster filesystem with more space than `/home`.

```
ssh <YourNetID>@adroit.princeton.edu  # vpn required from off-campus
cd /scratch/network/<YourNetID>  # on tiger, della or perseus replace /scratch/network/ with /scratch/gpfs/
git clone https://github.com/PrincetonUniversity/hpc_beginning_workshop
cd hpc_beginning_workshop/RC_example_jobs
```

Then choose an example and follow the directions. For instance:

```
cd serial_python
cat README.md
```

## Where to store your files

![tigress](https://tigress-web.princeton.edu/~jdh4/hpc_princeton_filesystems.png?)

**IMPORTANT**: *You should run your jobs out of /scratch/network on Adroit and /scratch/gpfs on the other clusters. These filesystems are very fast and provide vast amounts of storage. Do not run jobs out of /tigress or /projects. These filesystem are slow and should only be used for backing-up the files that you produce on /scratch/gpfs or /scratch/network. Your /home directory on all clusters is small should only be used for storing source code, executables, Conda environments and small data sets*.

