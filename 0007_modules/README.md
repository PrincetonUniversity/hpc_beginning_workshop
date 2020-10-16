# How to Access the Software Already Installed on the Clusters

## Use Pre-Installed Software with Environment Modules

Several applications and software libraries are already available on each cluster. To see the modules that are available on Della, for example, run this command:

```
$ module avail
```

To see the module avail for a specific software, say Julia, then do:

```
$ module avail julia
------------- /usr/licensed/Modules/modulefiles -------------
julia/0.4.7 julia/0.5.1 julia/0.7.0 julia/1.0.3 julia/1.2.0
julia/0.5.0 julia/0.6.0 julia/1.0.1 julia/1.1.0 julia/1.3.0
```

Use the `module load <module-name>` command to activate a module. For example:

```
$ julia
-bash: julia: command not found
$ module load julia
$ julia
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

To compile a parallel code that uses the message-passing interface (MPI) you will need to load an MPI module. You can load the Intel compilers and Intel MPI library with:

```
$ module load intel intel-mpi
$ mpicc --version
icc (ICC) 19.0.3.199 20190206
Copyright (C) 1985-2019 Intel Corporation.  All rights reserved.
```

To see exactly what a module is doing use `module show <module-name>`. Modules only change the values of environment variables. They do not install or uninstall software. For example:

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

To see all the options run `module help` or see [this page](https://researchcomputing.princeton.edu/faq/using-environment-modules).

If you need software that is not installed, you will most likely have to do it yourself.

## A Word on Python Modules

When you first connect to the cluster, before loading any modules, the system Python (old) will used by default:

```
$ python --version
Python 2.7.5

$ which python
/usr/bin/python
```

To get the newer Anaconda Python implementation, simply load the module:

```
$ module load anaconda3
$ python --version
Python 3.7.3

$ which python
/usr/licensed/anaconda3/2019.3/bin/python
```

To see all the packages that are included in Anaconda Python run this command:

```
$ conda list
```

## Installing Python Packages on the HPC Clusters

See [this guide](https://github.com/PrincetonUniversity/installing_python_packages).

## A Word on R - No Module Needed

An updated version of R is ready to be used without loading any modules. To start R and then immediately exit:

```
$ R
> q()
```

Note that RStudio is available through the [MyAdroit](https://myadroit.princeton.edu) web portal.

## Installing R Packages on the HPC Clusters

See [this guide](https://github.com/PrincetonUniversity/installing_R_packages).
