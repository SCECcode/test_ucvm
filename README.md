README.md

== Overview ==

This contains scripts that will create ucvm meshes on Frontier.

$sbatch makemesh.sh
$sbatch make_lahabrah.sh
$sbatch make_norcal.sh

== makemesh. ==
This is a single node job that queries cvmsi in southern California.
It confirms that the serial ucvm binaries have been built.

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

== $sbatch make_lahabra ==
Moderates outhern california mesh that uses the MPI executables.

== $sbatch make_norcal ==
Currently this is a mesh for the detailed region of the nothern California areas.

== Operating detail ==
On frontier, once ucvm is installed, you want to run it on the compute nodes, not interactively. 
To submit ucvm to the queue, you create two files:
(1) slurm script - a bash script and 
(2) a ucvm2mesh configuration file that gives the box, the resolution, and information about the file system like where scratch is and what you want to name the output files.

Edit the norcal_ucvm2mesh.conf file. Then, specify the number of nodes on in the make_norcal.sh script.
