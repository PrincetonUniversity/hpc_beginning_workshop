# Why Use Princeton's HPC Clusters?

## Reasons to Use the Clusters

In a nutshell, our clusters are where you go once your personal computer can no longer handle your computations.

- Lots of processing capacity, ability to do parallel computing (e.g., you could use 1000 CPU-cores for a single job)  
- Nodes have 100's GB of memory  
- One can store large datasets on `/scratch/gpfs`
- Lots of software is available and already configured (e.g., MPI, compilers, commercial software)
- Keep your laptop free of use by running the work on the clusters
- GPUs are available in large numbers on TigerGPU and Traverse
- There is a team of people maintaining and supporting the clusters

## Clusters Do Not Run Your Code Faster by Magic - Often Need Parallelization
[!!! INSERT CONTENT]
To get your code to run faster, this often involves the explicit task of parallelizing your code. The burden of modifying code to take advantage of multiple cores or nodes is on you as the programmer.

### 4 Basic Ways to Think About Parallelizing Code

Although learning how to parallelize code is outside the scope of this workshop, for our purposes it is useful to at least be familiar with the typical ways in which code can be parallelized.

1. **'Light' Parallelization (not a technical term)** - Runs serially, run a bunch of copies of the same thing, each with different input parameters (ARRAY JOBS)
2. **Shared memory parallelization** - single program that can access many cores; single node on a single machine, independent runs, program can access multiple cores during the run of a single program
3. **Distributed memory parallelization** - processes you're running are not entirely independent of each other (one piece needs to wait for another to finish), divide your data up into 20 pieces, for instances, each core works on 1 of the 10 pieces, but at some point need to communicate with each other and coordinate (for example all working on one for loop) (good for GPU use too?)
4. **Using accelerators (GPUS & FPGA)** - take the part of the code that needs speed up and send it to GPU or FPGA for processing those parts just plain faster

The burden of modifying the code to take advantage of multiple cores or multiple nodes in on the programmer. Just running code a ‘bigger’ computer doesn’t make it run faster.
