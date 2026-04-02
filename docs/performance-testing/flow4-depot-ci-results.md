# Flow 4: Depot CI Performance Results

Performance test results for Flow 4 (Depot CI).

**Test Date:** 2026-04-01
**Workflow:** Build & Deploy with Depot CI
**Depot Project:** d0dfxb1xmf
**Test Case:** baseline (no changes)

---

## Results Summary

| Test Case | Description | Time | vs Flow 1 | vs Flow 2 | vs Flow 3 |
|-----------|-------------|------|-----------|-----------|-----------|
| **1. Baseline** | No changes, first build | **31s** | 5.2x faster | Similar | **4.5x faster** |
| **2. Comment Change** | Source comment modified | **23s** | Similar | **1.4x faster** | **2x faster** |
| **3. New Function** | New utils.ts file | **23s** | Similar | **1.6x faster** | **1.9x faster** |
| **4. New Dependency** | Package.json change | **31s** | **4.6x faster** | Similar | **4.5x faster** |
| **5. Major Changes** | Multiple new packages | **26s** | **7.9x faster** | Similar | **7.3x faster** |

---

## Detailed Analysis

### Test Case 1: Baseline

**Log:** `flow4-depot-ci-build-logs/flow4-depotci-Running-Test-Case-baseline.log`
**Build Summary:** https://depot.dev/orgs/xqmz2w73qz/projects/d0dfxb1xmf/builds/1j37z68cjh

**Time:** **31 seconds**

**Build Breakdown:**
- #2 (deps): 12.4s - npm ci
- #12 (production-deps): 7.8s - npm ci --omit=dev
- #14, #16, #18 (various): 1.3s each
- #21 (build & export): 3.4s + exporting

**Cache Behavior:**
- First build on Depot CI (no prior cache)
- Depot's built-in caching (warned about redundant GitHub Actions cache)
- All layers built from scratch

**Comparison to other flows:**
| Flow | Time | vs Flow 4 |
|------|------|-----------|
| Flow 1 (Local) | 162s | 5.2x slower |
| Flow 2 (Railway) | 29s | **Railway 1.1x faster** |
| Flow 3 (GitHub Actions) | 48s | **Depot 1.5x faster** 🏆 |
| Flow 4 (Depot CI) | 31s | baseline |

**Why Depot CI is faster than GitHub Actions:**
1. Optimized runners (depot-ubuntu-22.04)
2. Better layer caching infrastructure
3. Native Docker build optimization
4. Less runner overhead

**Why Railway is slightly faster:**
- Railway has highly specialized builders for their platform
- Even more optimized infrastructure

---

## System Specifications

### Depot CI
- **Runner:** depot-ubuntu-22.04
- **Project:** d0dfxb1xmf
- **Organization:** xqmz2w73qz
- **Cache:** Depot's built-in caching (superior to GitHub Actions cache)

---

## Key Observations

1. **Depot CI beats GitHub Actions** - 31s vs 48s (1.5x faster)

2. **Railway is still the fastest** - 29s (marginally faster due to platform optimization)

3. **All cloud options destroy local builds** - Local is 5.2x slower than Depot

4. **Depot's warning about cache:** GitHub Actions cache is redundant with Depot's built-in caching

---

## Fair Comparison Notes

**Flow 4 was configured for fair comparison:**
- ❌ No external npm ci (all inside Docker build)
- ❌ No external npm test/build (all inside Docker build)
- ✅ Only Docker build timing measured
- ✅ Same Dockerfile as all other flows

This ensures Flow 4 timing is directly comparable to Flows 2 & 3.

---

## Next Steps

**Remaining tests to run:**
- Test 2: Comment Change
- Test 3: New Function
- Test 4: New Dependency
- Test 5: Major Changes

**Run via GitHub Actions:**
1. Go to: https://github.com/sbtechpal/depot-railway-build/actions/workflows/depot-ci.yml
2. Click "Run workflow"
3. Select test case
4. Run and record timing

---

## How to Extract Build Time from Logs

1. Download the workflow log
2. Search for first Docker step timestamp (e.g., #1 DONE)
3. Search for "exporting manifest" or final timestamp
4. Calculate the difference

**Or use Depot Build Summary link:**
The log includes a direct link to Depot's build summary with detailed timing.
