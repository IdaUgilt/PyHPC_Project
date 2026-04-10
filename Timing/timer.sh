#!/bin/bash
#BSUB -J timer_new                          # Job name
#BSUB -q hpc                                # Queue name
#BSUB -W 120                                 # Wall-clock time
#BSUB -R "rusage[mem=25GB]"                  # Resources
#BSUB -o Timer_new%J.out                 # Output file (stdout)
#BSUB -e Timer_new%J.err                 # Output file (stderr)
#BSUB -R "select[model==XeonGold6226R]"     # Select CPU model
#BSUB -n 1                                  # Select number of cores
#BSUB -R "span[hosts=1]"                    # Specify that the number of cores must be on the same host

# InitializePythonenvironment
source /dtu/projects/02613_2025/conda/conda_init.sh
conda activate 02613_2026

# Run Python script
echo "5"
for i in 1 2 3; do
    time python3 simulate.py 5
done

echo "10"
for i in 1 2 3; do
    time python3 simulate.py 10
done

echo "12"
for i in 1 2 3; do
    time python3 simulate.py 12
done

echo "15"
for i in 1 2 3; do
    time python3 simulate.py 15
done

echo "17"
for i in 1 2 3; do
    time python3 simulate.py 17
done

echo "20"
for i in 1 2 3; do
    time python3 simulate.py 20
done