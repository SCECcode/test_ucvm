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
