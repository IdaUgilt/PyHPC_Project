![Python](https://img.shields.io/badge/Python-3.11-blue)
![Numba](https://img.shields.io/badge/Numba-JIT-orange)
![CUDA](https://img.shields.io/badge/CUDA-GPU-green)

# Floorplan Heat Simulation Optimization (02613 Python and High Performance Computing)

This repository contains solutions for the floorplan heat diffusion project from the course **02613 Python and High Performance Computing**.

The project explores optimization of a Jacobi-based heat simulation across thousands of floorplans using:

- Baseline Python implementation
- Multiprocessing (static and dynamic scheduling)
- CPU acceleration with Numba JIT
- GPU acceleration with custom CUDA kernels
- GPU acceleration using CuPy
- Performance profiling and scalability analysis

Each exercise is organized in its own folder with code, experiments, plots, and results.

---

## Repository Structure

```bash
.
├── exercise1_data_exploration/
├── exercise2_reference_timing/
├── exercise3_visualization/
├── exercise4_profiling/
├── exercise5_static_parallel/
├── exercise6_dynamic_parallel/
├── exercise7_numba_jit/
├── exercise8_cuda_kernel/
├── exercise9_cupy/
├── exercise10_nsys_profiling/
├── exercise11_optional_optimizations/
├── exercise12_final_analysis/
└── README.md
```

Each folder contains:
- Source code
- Batch scripts for experiments
- Timing results
- Figures and plots
- Notes/report material related to the exercise

---

## Authors
Course project for **02613 Python and High Performance Computing**

```