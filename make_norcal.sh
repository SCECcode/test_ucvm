#!/bin/bash
#SBATCH -A geo156
#SBATCH -J cs_nocal
#SBATCH -o %x-%j.out
#SBATCH -t 2:00:00
#SBATCH -p batch
#SBATCH -N 32
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
cp ${PROJWORK}/pmaech/test_ucvm/norcal_ucvm2mesh.conf ./norcal_ucvm2mesh.conf
# -N --nodes= minimum nodes to assign
# -n --ntasks= maximum number of tasks
srun -N32 -n512 ${BIN_DIR}/ucvm2mesh_mpi -f ./norcal_ucvm2mesh.conf
date

# ---ATCH -N 8
#srun -N8 -n512 block:cyclic ${BIN_DIR}/ucvm2mesh_mpi -f ./norcal_ucvm2mesh.conf
#srun: error: Unable to create step for job 1875534: More processors requested than permitted
#
#srun -N8 -c -m block:cyclic ${BIN_DIR}/ucvm2mesh_mpi -f ./norcal_ucvm2mesh.conf
#srun: error: Invalid numeric value "-m" for --cpus-per-task.
#
#srun -N8 -c --ntasks-per-core=1 -m block:cyclic ${BIN_DIR}/ucvm2mesh_mpi -f ./norcal_ucvm2mesh.conf
#srun: error: Invalid numeric value "--ntasks-per-core=1" for --cpus-per-task.
#
#srun -N8 -c --ntasks-per-node=64 --ntasks-per-core=1 -m block:cyclic ${BIN_DIR}/ucvm2mesh_mpi -f ./norcal_ucvm2mesh.conf
#srun: error: Invalid numeric value "--ntasks-per-node=64" for --cpus-per-task.
#
#srun -N8 -n256 -m block:cyclic ${BIN_DIR}/ucvm2mesh_mpi -f ./norcal_ucvm2mesh.conf
#PMPI_Type_create_darray(448): Invalid argument array_of_psizes
#
#srun -N8 -n512 -m block:cyclic ${BIN_DIR}/ucvm2mesh_mpi -f ./norcal_ucvm2mesh.conf
#srun: error: Unable to create step for job 1871180: More processors requested than permitted
#Tue 23 Apr 2024 02:36:50 AM EDT
