# Running Example Jobs on the HPC Clusters

Follow the directions below to begin running simple jobs on Adroit.
After SSHing to Adroit the first step is to `cd` (change directory)
to your directory on `/scratch/network/<YourNetID>`. We do this because `/scratch/network`
is a much faster filesystem with more space than /home.

```
ssh <YourNetID>@adroit.princeton.edu
cd /scratch/network/<YourNetID>
git clone https://github.com/PrincetonUniversity/hpc_beginning_workshop.git
cd hpc_beginning_workshop/job_examples
```

Then choose an example and follow the directions. For instance:

```
cd serial_python
cat README.md
```

## Where to store your files

![tigress](https://tigress-web.princeton.edu/~jdh4/tigress_is_slow2.png)

**IMPORTANT**: *You should run your jobs out of /scratch/network on Adroit and /scratch/gpfs on the other clusters. These filesystems are very fast and provide vast amounts of storage. Do not run jobs out of tigress. The tigress filesystem is slow and should only be used for backing up the files you produce on the /scratch/gpfs or /scratch/network filesystems. Your home directory on all clusters is small and disk access is slow. It should only be used for storing source code and executables*.

