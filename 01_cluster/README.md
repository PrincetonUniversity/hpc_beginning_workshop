# What's an HPC cluster?

[Table of Contents](/hpc_beginning_workshop/)


[![Beowulf Cluster](beowulf2.png)](beowulf.png)
[*By Mukarramahmad (Own work) [Public domain], via Wikimedia Commons*](https://commons.wikimedia.org/wiki/File:Beowulf.png)

## Terminology

* Head Node
  * The server that connects a cluster to the an outside network.
* Compute Node
  * A server that is used for running computations, sometimes managed by a scheduler.
* Cores
  * A shorthand way to refer to the number of
  processor cores (usually physical) of a CPU
  in a node.
  
**IMPORTANT**: *You may run test jobs on the head nodes that run for up to 10 minutes and use up to 10% of the CPU cores and memory. You will likely disrupt the work of others if you exceed these limits.*

## Some Clusters At Princeton
For more detail, see:
[Computational Hardware @ Princeton](https://researchcomputing.princeton.edu/systems-and-services/available-systems)

### [Nobel](https://researchcomputing.princeton.edu/systems-and-services/available-systems/nobel)
  This cluster is most appropriate for interactive work. Any member of the
  university community can request access for their work. Two nodes (Davisson and Compton), no distinction between login/compute.

### [Adroit](https://www.princeton.edu/researchcomputing/computational-hardware/adroit/)
  Also available generally to members of the university community. It is composed of 9 Skylake nodes, 7 Ivybridge nodes for MyAdroit and 2 GPU nodes consisting of either Tesla K40c or v100 GPUs.

### Other Clusters
  These <a href="https://researchcomputing.princeton.edu/systems-and-services/available-systems" target="_blank">other clusters</a> such as Perseus, Tiger, Della and Traverse are research
  clusters with many more nodes and GPFS networked storage between clusters.

  See [https://www.princeton.edu/researchcomputing/access/](https://www.princeton.edu/researchcomputing/access/)
  for details:

  > Proposals for the large  cluster systems should be submitted as PDF or MS Word documents not to exceed 3 pages. The proposal, which can be submitted through an online form . . . etc.

## The filesystems

![Tigress](https://tigress-web.princeton.edu/~jdh4/tigress_is_slow.png)

+ `/home/<YourNetID>`: source code and executables
+ `/scratch/gpfs/<YourNetID>`: job output and intermediate results
+ `/tigress/<YourNetID>`: final results for the long term

*IMPORTANT*: Tigress is for non-volatile files only. Do not make the mistake of writing your job output here. Users are tempted to do this because tigress is backed-up while /scratch/gpfs is not. However, this is a mistake and you may adversely affect other users by writing or reading job files from /tigress for your production runs.
