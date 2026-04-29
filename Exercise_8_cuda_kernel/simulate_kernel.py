from os.path import join
import sys

import numpy as np
from numba import cuda
from time import perf_counter

def load_data(load_dir, bid):
    SIZE = 512
    u = np.zeros((SIZE + 2, SIZE + 2))
    u[1:-1, 1:-1] = np.load(join(load_dir, f"{bid}_domain.npy"))
    interior_mask = np.load(join(load_dir, f"{bid}_interior.npy"))
    return u, interior_mask

@cuda.jit
def jacobi_kernel(u, mask, out):
    i, j = cuda.grid(2)

    if mask[i,j]:
        out[i+1, j+1] = 0.25 * (u[i, j+1] + u[i+2, j+1] + u[i+1, j+2] + u[i+1, j])


def jacobi(u, interior_mask, max_iter, threads_per_grid=16):
    N = 512
    tpb = (threads_per_grid, threads_per_grid)
    bpg = (N // threads_per_grid, N // threads_per_grid)

    up = cuda.pinned_array((N+2,N+2), np.float64)
    maskp = cuda.pinned_array((N,N), np.bool_)
    outp = cuda.pinned_array((N+2,N+2), np.float64)
    
    up[:, :] = np.copy(u)
    maskp[:, :] = interior_mask 
    outp[:,:] = np.copy(u)

    # Move data to gpu
    d_u = cuda.to_device(up)
    d_mask = cuda.to_device(maskp)
    d_out = cuda.to_device(outp)

    for i in range(max_iter):
        jacobi_kernel[bpg, tpb](d_u, d_mask, d_out)
        cuda.synchronize()
        d_u, d_out = d_out, d_u

    return d_u.copy_to_host()

def summary_stats(u, interior_mask):
    u_interior = u[1:-1, 1:-1][interior_mask]
    mean_temp = u_interior.mean()
    std_temp = u_interior.std()
    pct_above_18 = np.sum(u_interior > 18) / u_interior.size * 100
    pct_below_15 = np.sum(u_interior < 15) / u_interior.size * 100
    return {
        'mean_temp': mean_temp,
        'std_temp': std_temp,
        'pct_above_18': pct_above_18,
        'pct_below_15': pct_below_15,
    }


if __name__ == '__main__':
    # Start timer
    start = perf_counter()

    # Load data
    LOAD_DIR = '/dtu/projects/02613_2025/data/modified_swiss_dwellings/'
    with open(join(LOAD_DIR, 'building_ids.txt'), 'r') as f:
        building_ids = f.read().splitlines()

    if len(sys.argv) < 2:
        N = 1
    else:
        N = int(sys.argv[1])
    building_ids = building_ids[:N]

    # Load floor plans
    all_u0 = np.empty((N, 514, 514))
    all_interior_mask = np.empty((N, 512, 512), dtype='bool')
    for i, bid in enumerate(building_ids):
        u0, interior_mask = load_data(LOAD_DIR, bid)
        all_u0[i] = u0
        all_interior_mask[i] = interior_mask

    # Run jacobi iterations for each floor plan
    MAX_ITER = 20_000

    all_u = np.empty_like(all_u0)
    for i, (u0, interior_mask) in enumerate(zip(all_u0, all_interior_mask)):
        u = jacobi(u0, interior_mask, MAX_ITER, 16)
        all_u[i] = u

    # Print summary statistics in CSV format
    stat_keys = ['mean_temp', 'std_temp', 'pct_above_18', 'pct_below_15']
    print('building_id, ' + ', '.join(stat_keys))  # CSV header
    for bid, u, interior_mask in zip(building_ids, all_u, all_interior_mask):
        stats = summary_stats(u, interior_mask)
        print(f"{bid},", ", ".join(str(stats[k]) for k in stat_keys))

    # End time
    time = perf_counter()-start

    # Print total time
    print(f"Total time: {time:.4f}!!!", file=sys.stderr)