# A Brief Tour of Princeton's HPC Clusters & How to Get Access

Princeton University has a range of high-performance computing resources that are available to faculty and students. Broadly speaking, there are two types of systems, small and large.

The smaller systems (Nobel, Adroit, Tigressdata) are meant for exploration, small production runs, and visualization. Two of them (Nobel and Adroit) are available upon request to any Princeton University user. Access to Tigressdata is automatically granted with access to the larger systems, such as Della or Tiger.

The larger systems (Della, Tiger, Stellar, Traverse) are meant for solving computationally demanding research and getting access to these systems requires a proposal or sponsorship by a faculty member that is already using it.

**To find which system that will best suit you, we recommend exploring the [Systems Overview table](https://researchcomputing.princeton.edu/systems/systems-overview#:~:text=Princeton%27s%20Research%20Computing-,Systems,-The%20following%20table) on the Princeton Research Computing website.** There is also a more technical [Hardware Overview](https://researchcomputing.princeton.edu/systems/research-computing-systems/hardware-overview) table for anyone interested.

Adroit is often a good choice for getting started because it is configured the same way as the larger systems like Tiger and Della. Therefore, the workflow you develop on Adroit will be exactly replicable on the larger systems. If, however, your job requires more nodes than there are on Adroit, then it is clear that you need a larger system.

<!--
## Princeton's Small Systems and Clusters

### [Nobel](https://researchcomputing.princeton.edu/systems/nobel)
  This system is most appropriate for interactive work. Any member of the
  university community can request access for their work. Two nodes (Davisson and Compton), no distinction between login/compute.

### [Adroit](https://researchcomputing.princeton.edu/systems/adroit/)
  Also available generally to members of the university community. It is composed of 9 Skylake nodes, 7 Ivybridge nodes for MyAdroit and 2 GPU nodes consisting of either Tesla K40c or v100 GPUs.

### [Tigressdata](https://researchcomputing.princeton.edu/systems/tigressdata)
  Intended for (1) small production runs, post-processing, and remote visualization of data produced on the large systems, and (2) developing, debugging, and testing code.

## Princeton's Larger Clusters

### [Della](https://researchcomputing.princeton.edu/systems/della)
  General purpose cluster that works well for most parallel jobs and for users with large numbers of serial jobs. Supports GPU jobs.

### [Tiger](https://researchcomputing.princeton.edu/systems/tiger)
  General purpose cluster used by the largest, most demanding parallel codes. Supports GPU jobs.

![tiger-cluster](https://researchcomputing.princeton.edu/sites/researchcomputing2/files/styles/panopoly_image_original/public/media/tiger-diagram_0.jpg?itok=NCJUQOsC)

*IMPORTANT*: The Tiger cluster is designed for large parallel jobs. In an effort to dissuade users from running small jobs on Tiger, such as serial or single-node jobs, the scheduler has been configured to penalize these submissions by causing long queue times. Della is ideal for serial jobs. If you only have an account on Tiger and you want to run several small jobs then please write to cses@princeton.edu to request an account on Della. Be sure to explain the situation.

### [Stellar](https://researchcomputing.princeton.edu/systems/stellar)
  Primarily for research in astrophysical sciences, plasma physics, physics, chemical and biological engineering and atmospheric and oceanic sciences. Well suited for large, computationally intensive parallel jobs because of high core count per node. Supports GPU jobs.

### [Traverse](https://researchcomputing.princeton.edu/systems/traverse)
  Primarily for plasma physics research. Supports GPU jobs.
-->

## How to Get Access to Princeton's clusters

Details on gaining access to a specific cluster can be found on that cluster's dedicated page on the [Research Computing](https://researchcomputing.princeton.edu/) website (found in the Systems submenu).

All members of Princeton with a netID already have access to Nobel. Access to Adroit is available upon request to any Princeton University user. Access to the larger systems requires a proposal or sponsorship by a faculty member that is already using it.

An important note is that the Stellar and Traverse clusters are largely dedicated to astrophysics, plasma physics research, chemical and biological engineering and atmospheric and oceanic sciences. Researchers outside those fields who need larger clusters are encouraged to use Della or Tiger.
