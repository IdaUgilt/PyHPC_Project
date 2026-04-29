#!/bin/bash
#BSUB -J simulate
#BSUB -q hpc
#BSUB -W 00:30
#BSUB -R "rusage[mem=1GB]"
#BSUB -o simulate_%J.out
#BSUB -e simulate_%J.err
#BSUB -n 1
#BSUB -R "select[model==XeonGold6226R] span[hosts=1]"

# Initialize Python environment
source /dtu/projects/02613_2025/conda/conda_init.sh
conda activate 02613_2026

# Run Python script
python simulate_original.py 20 > results_simulate.csv