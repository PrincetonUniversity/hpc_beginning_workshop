# Running Example Jobs on the HPC Clusters

Follow the directions below to begin running simple jobs on Adroit.
After connecting to Adroit the first step is to change directories
to your directory on /scratch/network. We do this because /scratch/network
is a much faster filesystem with more space.

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
