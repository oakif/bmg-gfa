#!/bin/bash

#SBATCH -a 1-20
#SBATCH -p day
#SBATCH -n 4
#SBATCH -J NiCu
#SBATCH -t 00:10:00
#SBATCH -N 1
#SBATCH -o slurm/%x-%A_%a.out

##SBATCH --mail-user=oion.akif@yale.edu
##SBATCH --mail-type=END,FAIL

# Timestamp
date

# Variables

system="NiCu"

fA=( $(seq -f "%0.2f" 0.05 0.05 0.95) )
N_cores=4

lmp_path=/gpfs/loomis/pi/balou/sh2352/lammps_build_for_Fernanda/lammps-11Aug17/src/lmp_mpi
script_name="$system.lammps"

# Variables (Other)
fA=${fA[$SLURM_ARRAY_TASK_ID-1]}

# Load modules and do other housekeeping
module load StdEnv OpenMPI/3.1.1-iccifort-2018.3.222-GCC-7.3.0-2.30 OpenMPI/3.1.1-GCC-7.3.0-2.30 foss/2018b gompi/2018b tbb/2018_U5-GCCcore-7.3.0 CMake/3.12.1-GCCcore-7.3.0 imkl/2018.3.222-iompi-2018b iomkl/2018b GCCcore/7.3.0

# Run script
$lmp_path -in $script_name -var input_traj $system-$fA

# Timestamp
date