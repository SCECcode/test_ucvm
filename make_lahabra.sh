#!/bin/bash
#SBATCH -A geo156
#SBATCH -J lahabra
#SBATCH -o %x-%j.out
#SBATCH -t 1:00:00
#SBATCH -p batch
#SBATCH -N 2
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
cp ${PROJWORK}/pmaech/test_ucvm/lahabra_ucvm2mesh.conf ./lahabra_ucvm2mesh.conf
# -N --nodes= minimum nodes to assign
# -n --ntasks= maximum number of tasks
srun -N2 -n64 -m block:cyclic ${BIN_DIR}/ucvm2mesh_mpi -f ./lahabra_ucvm2mesh.conf
date
