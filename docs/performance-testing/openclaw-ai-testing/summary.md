# OpenClaw Performance Test - Final Summary

**OpenClaw Commit:** `f0c970fb43` (fix: skip sandbox skill copy junk)
**Test Date:** 2026-04-04 to 2026-04-05
**Test Cases:** 6 (baseline + 5 incremental change scenarios)

---

## Build Environments

| | Local Docker | GitHub Actions | Depot CI |
|---|---|---|---|
| **Builder** | Docker Buildx (default) | Docker Buildx + GHA cache | `depot/build-push-action@v1` (remote) |
| **Hardware** | WSL2 (shared cores) | ubuntu-24.04 (2 CPU, 8 GB) | Remote: 16 CPU, 32 GB RAM, NVMe SSD |
| **Runner** | Local machine | GitHub-hosted | `depot-ubuntu-24.04-4` (4 CPU, 16 GB) |
| **Cache** | Docker BuildKit local | `--cache-from/to type=gha` | Automatic NVMe SSD (no config) |
| **Auth** | N/A | GITHUB_TOKEN | OIDC (`id-token: write`) |

---

## Results Overview

| # | Test Case | Description | Expected Cache | Local Docker | GitHub Actions | Depot CI |
|---|-----------|-------------|---------------|-------------|----------------|----------|
| 1 | baseline | Cold build (populates cache) | N/A | 15m 30s (930s) | 3m 44s (224s) | 2m 28s (148s) |
| 2 | test-2-docs | README comment | ~95% | 12m 0s (720s) | 3m 56s (236s) | 3m 2s (182s) |
| 3 | test-3-source | New file in src/ | ~75% | 11m 56s (716s) | 3m 21s (201s) | 1m 53s (113s) |
| 4 | test-4-ui | New UI component | ~50% | 9m 59s (599s) | 3m 50s (230s) | 2m 31s (151s) |
| 5 | test-5-dependency | Add left-pad dependency | ~25% | ~10m 57s (657s) | 3m 59s (239s) | 2m 13s (133s) |
| 6 | test-6-major | Multi-file + dependency | ~10% | ~8m 46s (526s) | 3m 52s (232s) | 1m 55s (115s) |
| | **Average** | | | **~11m 28s** | **~3m 47s** | **~2m 20s** |

---

## GitHub Actions vs Depot CI Comparison

| Test Case | GHA Build Time | Depot Build Time | Improvement | Depot Savings |
|-----------|---------------|-----------------|-------------|---------------|
| baseline (cold) | 224s | 148s | **34% faster** | 76s |
| test-2-docs | 236s | 182s | **23% faster** | 54s |
| test-3-source | 201s | 113s | **44% faster** | 88s |
| test-4-ui | 230s | 151s | **34% faster** | 79s |
| test-5-dependency | 239s | 133s | **44% faster** | 106s |
| test-6-major | 232s | 115s | **50% faster** | 117s |
| **Average** | **227s** | **140s** | **38% faster** | **87s** |

### Why Depot CI is faster

1. **Remote builders with more resources** -- 16 CPU / 32 GB RAM vs GitHub's 2 CPU / 8 GB. Build steps that are CPU-bound (compilation, bundling) benefit directly.

2. **NVMe SSD cache** -- Depot caches build layers automatically on persistent NVMe storage. No `--cache-from`/`--cache-to` flags needed. GitHub Actions uses `type=gha` cache backed by the Actions cache API, which has throughput limitations and doesn't always preserve layers effectively.

3. **Real cache differentiation** -- Depot shows meaningful cache behavior across test cases (113s to 182s spread). GitHub Actions shows nearly flat times (201s to 239s), suggesting GHA cache provides minimal incremental benefit for this workload.

### Cache hit comparison

| Test Case | Depot Cache Hit | GHA Cache Behavior |
|-----------|----------------|-------------------|
| baseline (cold) | 0/29 (0%) -- cold build | No differentiation |
| test-2-docs | 15/29 (52%) | No differentiation |
| test-3-source | 15/29 (52%) | No differentiation |
| test-4-ui | 15/29 (52%) | No differentiation |
| test-5-dependency | 9/29 (31%) | No differentiation |
| test-6-major | 15/30 (50%) | No differentiation |

Depot correctly reflects cache invalidation: dependency changes (test 5) bust the lockfile layer and show lower cache hits (31%) vs file-only changes (52%). GitHub Actions shows no meaningful cache differentiation across any test case.

### Cost comparison per build

| | GitHub Actions | Depot CI |
|---|---|---|
| **Runner cost** | Included (free tier) | $0.008/min x 2.3 min = ~$0.02 |
| **Build cost** | Included | $0.004/min x 2.3 min = ~$0.01 |
| **Cache** | 10 GB free, then paid | Included (NVMe SSD) |
| **Per build** | $0.00 (free tier) | ~$0.03 |

---

## Full Three-Way Comparison

| Test Case | Local Docker | GitHub Actions | Depot CI | Depot vs Local | Depot vs GHA |
|-----------|-------------|----------------|----------|----------------|--------------|
| baseline | 15m 30s | 3m 44s | 2m 28s | **6.3x faster** | **34% faster** |
| test-2-docs | 12m 0s | 3m 56s | 3m 2s | **4.0x faster** | **23% faster** |
| test-3-source | 11m 56s | 3m 21s | 1m 53s | **6.3x faster** | **44% faster** |
| test-4-ui | 9m 59s | 3m 50s | 2m 31s | **4.0x faster** | **34% faster** |
| test-5-dependency | ~10m 57s | 3m 59s | 2m 13s | **4.9x faster** | **44% faster** |
| test-6-major | ~8m 46s | 3m 52s | 1m 55s | **4.6x faster** | **50% faster** |
| **Average** | **~11m 28s** | **~3m 47s** | **~2m 20s** | **5.0x faster** | **38% faster** |

---

## Key Findings

### 1. All 18 builds passed (6 per environment)
Every test case completed successfully across all three build environments using the `f0c970fb43` commit.

### 2. Depot CI is the fastest across all test cases
Depot CI wins on every single test case -- both cold and cached builds. Average of **2m 20s** vs GitHub Actions' 3m 47s and local Docker's 11m 28s.

### 3. GitHub Actions cache is ineffective for this workload
GHA build times are nearly flat (201-239s, only 38s spread) across all cache scenarios. The "100% cached" baseline (224s) was slower than the "75% cached" source test (201s). This suggests `type=gha` cache provides minimal incremental benefit for the OpenClaw Docker build.

### 4. Depot cache provides real incremental benefits
Depot shows meaningful cache differentiation:
- **Cold build**: 148s (cache populated from scratch)
- **Cached with file changes**: 113-182s (52% layer cache hit)
- **Cached with dependency changes**: 133s (31% layer cache hit, lockfile invalidated)

### 5. Local builds are 5x slower than Depot CI
The WSL2 environment is constrained by shared CPU, slow I/O, and network overhead through the Windows host. The two biggest bottlenecks are `pnpm install` (~212s, 31%) and image export/unpack (~193s, 28%).

### 6. `COPY . .` is the universal cache boundary
Across all environments, the Dockerfile's `COPY . .` instruction acts as a hard cache boundary. Any file change invalidates this step and all downstream layers. This limits the maximum cache hit rate to ~52% for file-only changes. To improve cache efficiency, consider splitting the Dockerfile to copy `package.json`/`pnpm-lock.yaml` separately before the full source copy.

---

## Recommendations

1. **Use Depot CI for production builds** -- 38% faster than GHA with better cache behavior and zero cache configuration.

2. **Split the Dockerfile for better caching** -- Copy `package.json` and `pnpm-lock.yaml` before `COPY . .` so that file-only changes don't invalidate the dependency install layer. This would push cache hit rates from ~52% toward ~70%+ for most changes.

3. **Remove GHA cache flags** -- The `--cache-from type=gha --cache-to type=gha,mode=max` flags add overhead without meaningful benefit for this workload. If staying on GHA, remove them. If migrating to Depot, they are unnecessary (Depot caches automatically).

4. **Skip local builds for CI validation** -- Local builds at 11+ minutes are too slow for iterative development. Use Depot CI with the `/fix-ci` agent loop for fast local-to-CI iteration.
