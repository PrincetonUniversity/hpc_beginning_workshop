# Quick Primer on Types of Parallel Programming

## Serial versus Parallel Programming

Serial Programming
![Older CPUs](https://hpc.llnl.gov/sites/default/files/serialProblem.gif)

Parallel Programming
![Modern CPUs](https://hpc.llnl.gov/sites/default/files/parallelProblem.gif)

Nodes Connected by Network
![Nodes to Cores](https://hpc.llnl.gov/sites/default/files/nodesNetwork.gif)

*Images sourced from Lawrence Livermore National Laboratory's Introduction to [Parallel Computing Tutorial](https://hpc.llnl.gov/training/tutorials/introduction-parallel-computing-tutorial).*

## 4 Basic Ways to Think About Parallelizing Code

1. **Embarassingly parallel** - Runs serially, run a bunch of copies of the same thing, each with different input parameters (ARRAY JOBS)
2. **Shared memory parallelization** - single program that can access many cores; single node on a single machine, independent runs, program can access multiple cores during the run of a single program
3. **Distributed memory parallelization** - processes you're running are not entirely independent of each (one piece needs to wait for another to finish), divide your data up into 20 pieces, for instances, each core works on 1 of the 10 pieces, but at some point need to communicate with each other and coordinate (for example all working on one for loop) (good for GPU use too?)
4. **Using accelerators (GPUS & FPGA)** - take the part of the code that needs speed up and send it to GPU or FPGA for processing those parts just plain faster

The burden of modifying the code to take advantage of multiple cores or multiple nodes in on the programmer. Just running code a ‘bigger’ computer doesn’t make it run faster.
