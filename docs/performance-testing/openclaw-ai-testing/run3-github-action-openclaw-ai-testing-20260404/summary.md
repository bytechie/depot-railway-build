# GitHub Run 3 - OpenClaw Performance Test Summary (with GHA Cache)

**Date:** 2026-04-05
**OpenClaw Commit:** `f0c970fb43` (fix: skip sandbox skill copy junk)
**Runner:** ubuntu-24.04 / Ubuntu 24.04.4 LTS
**Build System:** Docker Buildx with `--cache-from type=gha --cache-to type=gha,mode=max`

---

## Results Overview

| # | Test Case | Description | Expected Cache | Build Time | Image Size | Status |
|---|-----------|-------------|---------------|------------|------------|--------|
| 1 | baseline | Fully cached build | ~100% | 224s (3m 44s) | 3.12GB | PASS |
| 2 | test-2-docs | Documentation change - README comment | ~95% | 236s (3m 56s) | 3.12GB | PASS |
| 3 | test-3-source | New source file - perf-test.ts in src/ | ~75% | 201s (3m 21s) | 3.12GB | PASS |
| 4 | test-4-ui | UI change - New component in ui/ | ~50% | 230s (3m 50s) | 3.12GB | PASS |
| 5 | test-5-dependency | New dependency - Add left-pad | ~25% | 239s (3m 59s) | 3.12GB | PASS |
| 6 | test-6-major | Major changes - Multiple file types + dependency | ~10% | 232s (3m 52s) | 3.12GB | PASS |

---

## Key Findings

### All 6 builds passed
Every test case completed successfully using the `f0c970fb43` commit (the previous commit `b6355767` had a broken `doctor-contract.js` import that caused build failures).

### Build times are remarkably consistent
- **Fastest:** Test 3 (source file) at **201s**
- **Slowest:** Test 5 (dependency) at **239s**
- **Spread:** Only **38s** difference between fastest and slowest
- **Average:** ~227s (~3m 47s)

### No meaningful cache differentiation
Despite expecting cache hit rates from 10% to 100%, all builds completed in a very narrow 201-239s window. The "100% cached" baseline (224s) was actually *slower* than the "75% cached" source test (201s) and comparable to the "10% cached" major changes test (232s). This suggests the GHA cache is either not being utilized effectively or the build layers are being invalidated across all tests regardless of change scope.

### Consistent image size
All images are exactly **3.12GB** regardless of test case modifications.

### Timeline
- **Test 1 start:** 06:02 UTC
- **Test 6 end:** 06:33 UTC
- **Total wall time:** ~31 minutes for all 6 sequential runs

---

## Comparison Notes

This run used the `f0c970fb43` commit with GHA cache enabled. The cache hit behavior does not match expectations - build times are nearly flat across all cache scenarios, suggesting the GHA Docker layer cache may not be providing meaningful incremental build benefits for this project.
