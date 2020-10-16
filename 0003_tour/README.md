# A Brief Tour of Princeton's HPC Clusters & How to Get Access

Princeton University has a range of high-performance computing resources that are available to faculty and students.

Broadly speaking, there are two types of systems, small and large, which are described in more detail below. The smaller systems are meant for exploration, small production runs, and visualization, and are available upon request to any Princeton University user. The larger systems are meant for solving computationally demanding research and getting access to these systems requires a proposal or sponsorship by a faculty member that is already using it.

If your job requires more nodes than there are on adroit for instance, then it is clear that you need a larger system. Baring clear resources limitation, there is no hard rule for deciding what consists in a small or large production run. If you are unsure about which system you need, you should start on a small system.

Adroit is often a good choice to get started because it is configured the same way as the larger systems like tiger and della, so the workflow you develop on adroit will be exactly replicable on the larger systems.

## Princeton's Small Clusters
For more detail, see:
[Computational Hardware @ Princeton](https://researchcomputing.princeton.edu/systems-and-services/available-systems)

### [Nobel](https://researchcomputing.princeton.edu/systems-and-services/available-systems/nobel)
  This cluster is most appropriate for interactive work. Any member of the
  university community can request access for their work. Two nodes (Davisson and Compton), no distinction between login/compute.

### [Adroit](https://www.princeton.edu/researchcomputing/computational-hardware/adroit/)
  Also available generally to members of the university community. It is composed of 9 Skylake nodes, 7 Ivybridge nodes for MyAdroit and 2 GPU nodes consisting of either Tesla K40c or v100 GPUs.

### [Tigressdata](https://researchcomputing.princeton.edu/systems-and-services/available-systems/tigressdata)
  Intended for (1) small production runs, post-processing, and remote visualization of data produced on the large systems, and (2) developing, debugging, and testing code.

## Princeton's Larger Clusters

### [Della](https://researchcomputing.princeton.edu/systems-and-services/available-systems/della)
  General purpose cluster that works well for most parallel jobs and for users with large numbers of serial jobs.

### [Tiger](https://researchcomputing.princeton.edu/systems-and-services/available-systems/tiger)
  General purpose cluster used by the largest, most demanding parallel codes. Supports GPU jobs.

![tiger-cluster](https://researchcomputing.princeton.edu/sites/researchcomputing2/files/styles/panopoly_image_original/public/media/tiger-diagram_0.jpg?itok=NCJUQOsC)

*IMPORTANT*: The Tiger cluster is designed for large parallel jobs. In an effort to dissuade users from running small jobs on Tiger, such as serial or single-node jobs, the scheduler has been configured to penalize these submissions by causing long queue times. Della is ideal for serial jobs. If you only have an account on Tiger and you want to run several small jobs then please write to cses@princeton.edu to request an account on Della. Be sure to explain the situation.

### [Perseus](https://researchcomputing.princeton.edu/systems-and-services/available-systems/perseus)
  Primarily for astrophysics research. Well suited for large, computationally intensive parallel jobs because of high core count per node.

### [Traverse](https://researchcomputing.princeton.edu/traverse)
  Primarily for plasma physics research.

## How to Get Access to Princeton's clusters

As mentioned previously, access to the smaller systems are available upon request to any Princeton University user, while access to the larger systems requires a proposal or sponsorship by a faculty member that is already using it.

An important note is that the Perseus and Traverse clusters are largely dedicated to astrophysics and plasma physics research, respectively. Researchers outside those two fields who need larger clusters are encouraged to use Della or Tiger.

For details on getting access to either smaller or larger clusters, see [https://www.princeton.edu/researchcomputing/access/](https://www.princeton.edu/researchcomputing/access/).

  > Proposals for the large  cluster systems should be submitted as PDF or MS Word documents not to exceed 3 pages. The proposal, which can be submitted through an online form . . . etc.
