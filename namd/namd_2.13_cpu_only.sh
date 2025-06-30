#!/bin/bash

# this script will download and install a CPU-only version of NAMD with MPI

wget https://www.ks.uiuc.edu/Research/namd/2.13/download/412487/NAMD_2.13_Source.tar.gz
tar xzf NAMD_2.13_Source.tar.gz
cd NAMD_2.13_Source
tar xf charm-6.8.2.tar
cd charm-6.8.2

module purge
module load intel-oneapi/2024.2 intel-mpi/oneapi/2021.13
module list

env MPICXX=mpicxx ./build charm++ mpi-linux-x86_64 --with-production
cd mpi-linux-x86_64/tests/charm++/megatest
make pgm
#srun -N 1 -n 4 -t 1 ./pgm  ### uncomment this line to run tests
cd ../../../../..

wget http://www.ks.uiuc.edu/Research/namd/libraries/fftw-linux-x86_64.tar.gz
tar xzf fftw-linux-x86_64.tar.gz
mv linux-x86_64 fftw
wget http://www.ks.uiuc.edu/Research/namd/libraries/tcl8.5.9-linux-x86_64.tar.gz
wget http://www.ks.uiuc.edu/Research/namd/libraries/tcl8.5.9-linux-x86_64-threaded.tar.gz
tar xzf tcl8.5.9-linux-x86_64.tar.gz
tar xzf tcl8.5.9-linux-x86_64-threaded.tar.gz
mv tcl8.5.9-linux-x86_64 tcl
mv tcl8.5.9-linux-x86_64-threaded tcl-threaded

cd arch
wget https://raw.githubusercontent.com/PrincetonUniversity/hpc_beginning_workshop/master/RC_example_jobs/namd/Linux-x86_64-intel.arch
cd ..
sed -i 's/icpc/icpx/g' arch/Linux-x86_64-intel.arch
sed -i 's/icc/icx -Wno-implicit-function-declaration/g' arch/Linux-x86_64-intel.arch
./config Linux-x86_64-intel --charm-arch mpi-linux-x86_64
cd Linux-x86_64-intel
make
