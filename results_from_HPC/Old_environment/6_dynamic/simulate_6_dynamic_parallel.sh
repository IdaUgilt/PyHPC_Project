#!/bin/bash
#BSUB -J simulate_dynamic_parallel
#BSUB -q hpc
#BSUB -W 1000
#BSUB -R "rusage[mem=1GB]"
#BSUB -o 02613_HPC/Miniproject/Output_error_files/simulate_dynamic_parallel__no2_.sh_%J.out
#BSUB -e 02613_HPC/Miniproject/Output_error_files/simulate_dynamic_parallel__no2_.sh_%J.err
#BSUB -n 32
#BSUB -R "select[model==XeonGold6226R] span[hosts=1]"

# Initialize Python environment
source /dtu/projects/02613_2025/conda/conda_init.sh
conda activate 02613

# Run Python script
python 02613_HPC/Miniproject/simulate_6_dynamic_parallel.py 100