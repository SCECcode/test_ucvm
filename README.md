## README.md

## Overview of UCVM Mesh Scripts for Frontier

This contains scripts that will create ucvm meshes on Frontier.

* $sbatch makemesh.sh
* $sbatch make_lahabrah.sh
* $sbatch make_norcal.sh

## makemesh.sh
This is a single node job that queries cvmsi in southern California.
It confirms that the serial ucvm binaries have been built.

The associated ucvm configuraiton file is included as small_cvmsi.config which
includes the details of specified mesh.

<pre>
[pmaech@login11.frontier test_ucvm]$ more makemesh.sh
#!/bin/bash
#SBATCH -A geo156
#SBATCH -J ucvm_cvmsi_test
#SBATCH -o %x-%j.out
#SBATCH -t 0:10:00
# #SBATCH -p batch
#SBATCH -q debug
#SBATCH -N 1
#SBATCH --threads-per-core=1
#SBATCH --mail-type=ALL
#SBATCH --mail-user=maechlin@usc.edu

date

MEMBERWORK=/lustre/orion/scratch/pmaech/geo156
PROJWORK=/lustre/orion/geo156/proj-shared
WORLDWORK=/lustre/orion/geo156/world-shared
SCRATCH=/lustre/orion/scratch/pmaech/geo156
BIN_DIR=${UCVM_INSTALL_PATH}/bin
CONF_DIR=${UCVM_INSTALL_PATH}/conf

cd ${MEMBERWORK}/ucvm
cp ${PROJWORK}/pmaech/test_ucvm/makemesh.sh ./run_makemesh.sh
cp ${PROJWORK}/pmaech/test_ucvm/small_cvmsi.conf ./small_cvmsi.conf
# -N --nodes= minimum nodes to assign
# -n --ntasks= maximum number of tasks
srun -N1 -n4 $BIN_DIR/ucvm2mesh -f ./small_cvmsi.conf
cp ./small_cvmsi.grid ${PROJWORK}/pmaech/test_ucvm/small_cvmsi.grid
cp ./small_cvmsi.media ${PROJWORK}/pmaech/test_ucvm/small_cvmsi.media
date
</pre>

## make_lahabra.sh
This is a slurm script that will submit a two node job on frontier to create a mesh for
la_habra simulation. This means a southern California CVM.

This runs successfully, then the ucvm MPI executables are correctly built and the slurm script is convfigure
to request the right number of nodes and tasks to build the mesh.

$sbatch make_lahabra

The associated ucvm configuratmion file is also included as lahabra_ucvm2mesh.conf

##  make_norcals
This is a mesh building configuration that build a full size ucvm mesh (2.1B mesh points) using
the new sfcvm, cca, and nc1d cvms.

The defined region is based on a simlation volume for the planned CyberShake study.

The values below show different configurations distributing the same mesh onto different nmber of nodes including 108, 858, and 2000.
The 2000 is large enought to get queue priority.

<pre>
# Spacing of cells
spacing=100.0

# Projection
proj=+proj=utm +datum=WGS84 +zone=10
rot=-53.9
x0=-121.9
y0=36.3
z0=0.0

# Number of cells along each dim (3000*1400*520=2,184,000,000)
# x is mostly n-s,y is mostly e-w
nx=3000
ny=1400
nz=520

# Partitioning of grid among processors (request px*py*pz processes in mpi submit)
#The mesh pts in x,y,z must be evenly divisible by the number of mpi tasks defined to build the mesh. Frontier nodes are 56 cores (available) per node.
# Norcal mesh dimensions (with cell resolution defined as 100m)
#3000/30 = 100
#1400/20 = 70
#520/10 = 52
#30 x 20 x 10 = 6000 tasks needed
#108 nodes x 56 cores/node = 6048
##Config 2:
## Norcal Mesh dimension but divided onto more tasks
#3000/60 = 50
#1400/40 = 35
#520/20 = 26
#60 x 40 x 20 = 48,000 tasks
#48,000/56 = 857.1
#858 nodes x 56 cores/node = 48,048
##Config 3:
### Divided the mesh onto more equal number of nodes in each dimension
#3000/100 = 30
#1400/56 = 25
#520/20 = 26
#100 x 56 x 20 =  112,000 tasks
#112,000/56 = 2000 nodes
px=100
py=56
pz=20
</pre>

## Operating detail

On frontier, once ucvm is installed, you want to run it on the compute nodes, not interactively. 
To submit ucvm to the queue, you create two files:
(1) slurm script - a bash script and 
(2) a ucvm2mesh configuration file that gives the box, the resolution, and information about the file system like where scratch is and what you want to name the output files.

Before you run, make confirm the two mesh files are consistent, the slurm script and ucvm_mesh.conf files. Then submit the slurm script
$sbatch make_norcal.sh

## Test Cases
The test cases implemented here include distributing the meshing onto more tasks, which should presumably run shorter. I would like to measure at least three sizes of the same problem to get strong scaling results.
norcal
nc_2
nc_3
are all tests of ucvm extract for a sord file. they differe by number of nodes requested (108, 858, 2000).
Only the 2000 core version gets priority access.

