# Flow 3: GitHub Actions (Baseline) Performance Results

Performance test results for Flow 3 (GitHub Actions → GHCR → Railway).

**Test Date:** 2026-03-31
**Workflow:** Build & Deploy to Railway (Baseline)
**Test Case:** baseline (no changes)

---

## Results Summary

| Test Case | Description | Time | vs Flow 1 | vs Flow 2 |
|-----------|-------------|------|-----------|-----------|
| **1. Baseline** | No changes, cold build | **141s** | Similar | 4.9x slower |
| **2. Comment Change** | Source comment modified | **65s** | 4.6x slower | 3.9x slower |
| **3. New Function** | New utils.ts file | **64s** 3.8x slower | 4.3x slower |
| **4. New Dependency** | Package.json change | **193s** | 1.3x slower | 7.6x slower |
| **5. Major Changes** | Multiple new packages | **133s** | **1.5x faster** | 4.8x slower |

---

## Detailed Analysis

### Test Case 1: Baseline

**Log:** `flow3-github-action-logs/flow3-Build-Deploy-to-Railway-Baseline-logs_62758802965.log`

**Time:** **141 seconds (2m 21s)**

**Build Breakdown:**
- Workflow setup: ~15s (actions download, cache setup)
- Docker build: ~126s (cold build, all layers from scratch)
- Image push to GHCR: included in build time

**Cache Behavior:**
- Cold build after cache was cleared
- GitHub Actions cache: type=gha, mode=max (but cache was empty)
- All layers built from scratch

**Note:** First run showed 48s due to residual cache. After clearing cache, true cold build time is 141s.

**Comparison to other flows:**
| Flow | Time | vs Flow 3 |
|------|------|-----------|
| Flow 1 (Local) | 162s | Similar |
| Flow 2 (Railway) | 29s | **Railway 4.9x faster** |
| Flow 3 (GitHub Actions) | 141s | baseline |

**Why GitHub Actions is slower than Railway:**
1. Runner startup overhead (~15s)
2. Actions/step setup time
3. Cache warming on first build
4. Generic ubuntu-latest runner vs optimized Railway builders

**Why GitHub Actions is faster than Local:**
1. Better network bandwidth to npm registry
2. Cloud-based infrastructure
3. Parallel processing capabilities

---

## System Specifications

### GitHub Actions (ubuntu-latest)
- **Runner:** Ubuntu 24.04 (ubuntu24/20260323.65)
- **Runner images:** https://github.com/actions/runner-images
- **CPU:** 2-core vCPU (standard GitHub Actions runner)
- **Cache:** GitHub Actions Cache (gha)

---

## Key Observations

1. **Railway is fastest for clean builds** - 29s vs 48s (1.7x faster)

2. **GitHub Actions has significant startup overhead** - ~15s for runner/step setup

3. **Local is slowest for clean builds** - 162s (3.4x slower than GitHub Actions)

4. **GitHub Actions cache will improve** - Subsequent builds should be faster with cache warming

---

## Next Steps

**Remaining tests to run:**
- Test 2: Comment Change
- Test 3: New Function
- Test 4: New Dependency
- Test 5: Major Changes

**Run via GitHub Actions:**
1. Go to: https://github.com/bytechie/depot-railway-build/actions/workflows/railway-direct.yml
2. Click "Run workflow"
3. Select test case
4. Run and record timing

---

## How to Extract Build Time from Logs

1. Download the workflow log
2. Search for: `docker buildx build`
3. Note the timestamp
4. Search for: `Image built and pushed`
5. Calculate the difference

**Example:**
```
Build start:  2026-03-31T11:44:33.6876705Z
Build end:    2026-03-31T11:45:22.0463821Z
Build time:   ~48 seconds
```

---

### Test Case 2: Comment Change

**Log:** `flow3-github-action-logs/flow3-Applying-Test-Case2-Comment-Change-log.log`

**Time:** **47 seconds**

**Build Breakdown:**
- Docker build: ~47s (12:41:06 → 12:41:53)

**Cache Behavior:**
- Source code changed (comment added)
- Dependency layers: CACHED
- Source layers: REBUILT
- GitHub Actions cache working

**Comparison:**
| Flow | Time | vs Flow 3 |
|------|------|-----------|
| Flow 1 (Local) | 14s | **3.4x faster** |
| Flow 2 (Railway) | 16.88s | **2.8x faster** |
| Flow 3 (GitHub Actions) | 47s | baseline |

**Why GitHub Actions is slower:**
1. Runner startup overhead (~15s) still applies
2. Actions/step setup time
3. Layer cache is less effective than Railway's
4. Generic infrastructure vs optimized builders

**Insight:** For small source changes, local and Railway are significantly faster due to:
- Local: Persistent cache, no overhead
- Railway: Optimized infrastructure, better layer caching
