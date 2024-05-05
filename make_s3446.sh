#!/bin/bash
#SBATCH -A geo156
#SBATCH -J cs_s3446
#SBATCH -o %x-%j_s3446.out
#SBATCH -t 4:00:00
#SBATCH -p batch
#SBATCH -N 115
#SBATCH --mail-type=ALL
#SBATCH --mail-user=maechlin@usc.edu

now=$(date)
echo $now

MEMBERWORK=/lustre/orion/scratch/pmaech/geo156
PROJWORK=/lustre/orion/geo156/proj-shared
WORLDWORK=/lustre/orion/geo156/world-shared
SCRATCH=/lustre/orion/scratch/pmaech/geo156
BIN_DIR=${UCVM_INSTALL_PATH}/bin
CONF_DIR=${UCVM_INSTALL_PATH}/conf

cd ${MEMBERWORK}/ucvm
cp ${PROJWORK}/pmaech/test_ucvm/s3446_ucvm2mesh.conf ./s3446_ucvm2mesh.conf
# -N --nodes= minimum nodes to assign
# -n --ntasks= maximum number of tasks
srun -N115 -n6400 ${BIN_DIR}/ucvm2mesh_mpi -f ./s3446_ucvm2mesh.conf

now=$(date)
echo $now
