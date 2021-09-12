# Software

Enterprise Linux configurations like those used on Adroit often have very
out of date system packages. This provides great stability, but is often not
useful for development and data science.

The way around this is the `module` system.

## Using Pre-Installed Software with Environment **Modules**

Several applications and software libraries are already available on each cluster, and can be accessed through [environment modules](https://researchcomputing.princeton.edu/support/knowledge-base/modules).

### What Modules Are Available?

To see the modules that are available on a cluster, run this command:

```
$ module avail
```

To see the module avail for a specific software, for example Julia, then do:

```
$ module avail julia
------------- /usr/licensed/Modules/modulefiles -------------
julia/0.4.7 julia/0.5.1 julia/0.7.0 julia/1.0.3 julia/1.2.0
julia/0.5.0 julia/0.6.0 julia/1.0.1 julia/1.1.0 julia/1.3.0
```

### How Do I Use a Module?

Use the `module load <module-name>` command to activate a module.

For example, to use Julia:

```
$ module load julia/1.2.0      # loads julia module
$ julia                        # starts julia
               _
   _       _ _(_)_     |  Documentation: https://docs.julialang.org
  (_)     | (_) (_)    |
   _ _   _| |_  __ _   |  Type "?" for help, "]?" for Pkg help.
  | | | | | | |/ _` |  |
  | | |_| | | | (_| |  |  Version 1.2.0 (2019-08-20)
 _/ |\__'_|_|_|\__'_|  |  Official https://julialang.org/ release
|__/                   |

julia>
```
Note that you need to include the full path, with the version you've selected, for it to work. For example, if using Julia, the command `module load julia/1.2.0` specifies the full path, while the command `module load julia` does not.

To see all of the options for the module command you can run `module help` or see [this page](https://researchcomputing.princeton.edu/faq/using-environment-modules).

### How Do I Get Rid of a Module?

To unload a specific module, use `module unload <name>`. You can unload all modules by simply relogging into the cluster, or more easily, via the command `module purge`.

### How Do Modules Work?

Modules work by setting various environment variables, especially your `$PATH`, to point to the appropriate, more up-to-date installations provided as part of the software on the cluster.

To see exactly what a module is doing, use the command `module show <module-name>`.

For example:

```
$ module show cudatoolkit/10.2
-------------------------------------------------------------------
/usr/local/share/Modules/modulefiles/cudatoolkit/10.2:

module-whatis	 Sets up cudatoolkit102 10.2 in your environment
prepend-path	 PATH /usr/local/cuda-10.2/bin
prepend-path	 LD_LIBRARY_PATH /usr/local/cuda-10.2/lib64
prepend-path	 LIBRARY_PATH /usr/local/cuda-10.2/lib64
prepend-path	 MANPATH /usr/local/cuda-10.2/doc/man
append-path	 -d   LDFLAGS -L/usr/local/cuda-10.2/lib64
append-path	 -d   INCLUDE -I/usr/local/cuda-10.2/include
append-path	 CPATH /usr/local/cuda-10.2/include
append-path	 -d   FFLAGS -I/usr/local/cuda-10.2/include
append-path	 -d   LOCAL_LDFLAGS -L/usr/local/cuda-10.2/lib64
append-path	 -d   LOCAL_INCLUDE -I/usr/local/cuda-10.2/include
append-path	 -d   LOCAL_CFLAGS -I/usr/local/cuda-10.2/include
append-path	 -d   LOCAL_FFLAGS -I/usr/local/cuda-10.2/include
append-path	 -d   LOCAL_CXXFLAGS -I/usr/local/cuda-10.2/include
-------------------------------------------------------------------
```
Again, modules only change the values of environment variables. They do not install or uninstall software.

### A Word on Python Modules
<!--
When you first connect to the cluster, none of the module are loaded, and the system Python–which is old–will be used by default:

```
$ python --version
Python 2.7.5

$ which python
/usr/bin/python
```
-->

To get an Anaconda Python implementation (the recommended way to use Python), simply load one of the available anaconda3/ modules. For example:

```
$ module load anaconda3/2020.7
$ python --version
Python 3.7.3

$ which python
/usr/licensed/anaconda3/2019.3/bin/python
```

To see all the packages that are included in Anaconda Python run this command:

```
$ conda list
```
Additional resources on [using Python on the clusters](https://researchcomputing.princeton.edu/support/knowledge-base/python) can be found on the Research Computing website.

### A Word on R Modules

An updated version of R is ready to be used without loading any modules.

To start R, simply type:

```
$ R       # this starts R on the clusters
```

You can expect to see output that looks something like this:
```
R version 4.0.3 (2020-10-10) -- "Bunny-Wunnies Freak Out"
Copyright (C) 2020 The R Foundation for Statistical Computing
Platform: x86_64-redhat-linux-gnu (64-bit)

R is free software and comes with ABSOLUTELY NO WARRANTY.
You are welcome to redistribute it under certain conditions.
Type 'license()' or 'licence()' for distribution details.

  Natural language support but running in an English locale

R is a collaborative project with many contributors.
Type 'contributors()' for more information and
'citation()' on how to cite R or R packages in publications.

Type 'demo()' for some demos, 'help()' for on-line help, or
'help.start()' for an HTML browser interface to help.
Type 'q()' to quit R.

```

To quit R, simply type:
```
> q()
```
There are older versions of R available though, which you can see through the `module avail R` command.

```
$ module avail R

--------------------- /usr/local/share/Modules/modulefiles ---------------------
R/3.6.3

```

Note that RStudio is available through the [MyAdroit](https://myadroit.princeton.edu) or [MyDella](https://della.princeton.edu) web portals.

Additional resources on [using R on the clusters](https://researchcomputing.princeton.edu/support/knowledge-base/rrstudio) can be found on the Research Computing website.

### Final Tips on Modules

Remember that no modules are loaded upon connecting to a cluster. Best practice is to load them each time.

**Don't put module commands in your .bashrc file.** You may be tempted to put these in `.bashrc`. Don't. By all means set up an alias for your use, but `.bashrc` is not implicitly loaded for a SLURM job. You're likely to set up a situation where you have tangled modules and not quite sure why your job is failing to behave as expected.

More information on modules can be found on our [Environment Module](https://researchcomputing.princeton.edu/support/knowledge-base/modules) resource page.

If you need software that is not installed or made available through **modules**, you will most likely have to install the software yourself. The following section provides the needed guidelines.

## Installing Software Not Available on the Clusters

In general, to install software not available as a module, we recommend that you create a directory such as `/home/<YourNetID>/software` to build and store software. (As a reminder, your home directory is backed-up.)

One exception to this general recommendation is when installing Python and R packages. Python and R packages are installed by default in your home directory, and therefore don't require that you set up a special folder for them. See more about installing Python or R packages below.

Two notes:

+ Be sure to run the `checkquota` command regularly to make sure you have enough space. Errors found when installing packages can often come down to this.
+ Commands like `sudo yum install` or `sudo apt-get install` will not work.

### Installing Python Packages on the HPC Clusters

See this [guide to installing Python packages with conda or pip](https://researchcomputing.princeton.edu/support/knowledge-base/python#managers) on Princeton Research Computing's [Python resource page](https://researchcomputing.princeton.edu/support/knowledge-base/python).

### Installing R Packages on the HPC Cluster

See this [guide to installing R packages](https://researchcomputing.princeton.edu/support/knowledge-base/rrstudio#install) on Princeton Research Computing's [R resource page](https://researchcomputing.princeton.edu/support/knowledge-base/rrstudio).

It's important to be aware of the need to update the compiler before installing certain R packages. This is mentioned in the *Compiling Software, GNU Compiler Collection (GCC)* section, and is described in more detail in the linked guide to installing R packages.


### Using Software Containers

We do not allow [Docker](https://www.docker.com) but [Singularity](https://researchcomputing.princeton.edu/support/knowledge-base/singularity) can be used:

```
$ singularity pull docker://hello-world
$ singularity run hello-world_latest.sif
...
Hello from Docker!
This message shows that your installation appears to be working correctly.
...
```

For more information see [Containers on the HPC Clusters](https://researchcomputing.princeton.edu/support/knowledge-base/singularity).


### Compiling Software, GNU Compiler Collection (GCC)

Software that comes in source form must be compiled before it can be installed in your `/home` directory.

One popular tool suite for doing this is the GNU Compiler Collection (GCC) which is composed of compilers, a linker, libraries, and tools.

To provide a stable environment for building software on our HPC clusters, the default version of GCC is kept the same for years at a time. To see the current version of the GNU C++ compiler, namely g++, run the following command on one of the HPC clusters (e.g., Della):

```
$ g++ --version
g++ (GCC) 4.8.5 20150623 (Red Hat 4.8.5-39)
```

While most R packages will compile with the current long-term but older version of GCC, some require a newer version. Della and Tiger both have these older versions of GCC, and a newer version is made available by loading one of the latest Red Hat Developer Toolset (rh/devtoolset) modules:
```
$ module load rh/devtoolset/8
$ g++ --version
g++ (GCC) 8.3.1 20190311 (Red Hat 8.3.1-3)
```
Common errors when the `rh` module is not loaded include:

+ `g++: error: unrecognized command line option -std=c++17`
+ `gcc: error: unrecognized command line option '-std=c++14'`
+ `'for' loop initial declarations are only allowed in C99 mode`.

Note that Adroit has a newer version of GCC, and the rh/devtoolset module is therefore not needed on this cluster.

When compiling a parallel code that uses the message-passing interface (MPI), you will need to load an MPI module. You can load the Intel compilers and Intel MPI library with:

```
$ module load intel/19.1.1.217 intel-mpi/intel/2019.7 
Loading intel/19.1.1.217
  Loading requirement: intel-mkl/2020.1

Loading intel-mpi/intel/2019.7
  Loading requirement: ucx/1.9.0
$ mpicc --version
icc (ICC) 19.1.1.217 20200306
```

Note that the C and Fortran compilers and related tools are also updated by this method which is important for some software. The relevant tools are `gcc`, `g++`, `gfortran`, `make`, `ld`, `ar`, `as`, `gdb`, `gprof`, `gcov` and more.



### Vectorization

Modern CPUs can perform more than one operation per cycle using vector execution units. A common example is elementwise vector addition.

[Vectorized code](https://en.wikipedia.org/wiki/Automatic_vectorization) generated for one processor will not run on another processor unless it supports those instructions. Such an attempt will produce an `illegal instruction` error if the instructions are not supported.

#### Della

Della is composed of three different Intel Xeon microarchitectures:

+ Broadwell (AVX2)
+ Skylake (AVX-512)
+ Cascade Lake (AVX-512)

The head node `della5` is Broadwell. If you compile a code on the head node it will not take advantage of the AVX-512 instructions available on the Skylake and Cascade Lake nodes unless you add the appropriate flags (i.e., -xCORE-AVX2 -axCORE-AVX512).

#### TigerCPU vs. TigerGPU

The processor on `tigercpu` supports AVX512 instructions while those on `tigergpu` can only do `AVX2`.

Be sure to compile codes for `tigercpu` by ssh-ing to `tigercpu.princeton.edu` and compile codes for `tigergpu` by ssh-ing to `tigergpu.princeton.edu`.

If you ssh to `tiger.princeton.edu` then you will land on `tigercpu.princeton.edu`.
