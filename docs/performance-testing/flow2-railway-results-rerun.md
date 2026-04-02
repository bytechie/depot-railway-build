# Flow 2: Railway Auto-Build Performance Results (Rerun)

Performance test results for Flow 2 (Railway Auto-Build) on `flow2-retest` branch.

**Deployment Target:** Railway (native auto-build)
**Test Date:** 2026-04-02
**Branch:** flow2-retest
**Railway Region:** us-east4

> **Note:** These results measure Railway's Docker **build time only**. Railway automatically builds and deploys the image when you push to the connected branch.

---

## Results Summary (Cold Build)

| Test Case | Description | Time | vs Flow 1 | vs Flow 3 | vs Flow 4 |
|-----------|-------------|------|-----------|-----------|-----------|
| **1. Baseline** | No changes, cold build | **34.20s** | 4.7x faster | 4.1x faster | Similar |
| **2. Comment Change** | Source comment modified | **23.60s** | Similar | 2.8x faster | Similar |
| **3. New Function** | New utils.ts file | **18.02s** | TBD | TBD | TBD |
| **4. New Dependency** | Package.json change | **40.75s** | TBD | TBD | TBD |
| **5. Major Changes** | Multiple new packages | **27.73s** | TBD | TBD | TBD |

---

## Detailed Analysis

### Test Case 1: Baseline (Cold Build)

**Log:** `flow2-railway-build-logs/railway-test2/flow2-railway-rerun-test-case-1-logs.1775093099988.log`

**Time:** **34.20 seconds**

**Build Breakdown:**
- npm ci (deps): ~15s
- npm ci (production-deps): ~15s
- TypeScript build: ~1.3s
- Total: 34.20s

**Cache Behavior:**
- Cold build on new branch (no cache)
- All layers built from scratch
- Health check: Passed

**Comparison:**
| Flow | Time | vs Flow 2 |
|------|------|-----------|
| Flow 1 (Local) | 162s | 4.7x slower |
| Flow 2 (Railway) | **34.20s** | baseline |
| Flow 3 (GitHub Actions) | 141s | 4.1x slower |
| Flow 4 (Depot CI) | 31s | Depot 1.1x faster |

**Key Insight:** Railway's cold build (34.20s) is still very competitive! Only Depot CI (31s) is slightly faster.

**Note:** Previous test showed 3.66s but that was with warm cache on a reused branch. This 34.20s is the true cold build time.

---

## Next Steps

**Remaining tests to run:**
- Test 2: Comment Change
- Test 3: New Function
- Test 4: New Dependency
- Test 5: Major Changes

---

## How to Run Remaining Tests

**On flow2-retest branch:**

For each test case:
```bash
# 1. Apply test case
./scripts/apply-test-case-N.sh

# 2. Commit and push
git add sample-app/
git commit -m "Test Case N: [name]"
git push

# 3. Watch Railway dashboard for "Build time: XX seconds"
# 4. Record the time
```

**Reset between tests:**
```bash
git reset --hard HEAD^
git clean -fd sample-app/
```

---

### Test Case 2: Comment Change

**Log:** `flow2-railway-build-logs/railway-test2/flow2-railway-rerun-Applying-Test-Case-2-Comment-Change-logs.1775093870911.log`

**Time:** **23.60 seconds**

**Build Breakdown:**
- All dependency layers: CACHED ✅
- Source copy: Rebuilt (~1s)
- TypeScript build: ~4s
- Total: 23.60s

**Cache Behavior:**
- Excellent cache hit! Only source layers rebuilt
- Both `npm ci` layers cached from previous build
- Only `COPY . .` and `npm run build` executed

**Comparison:**
| Flow | Time | vs Flow 2 |
|------|------|-----------|
| Flow 1 (Local) | 14s | Local 1.7x faster |
| Flow 2 (Railway) | **23.60s** | baseline |
| Flow 3 (GitHub Actions) | 65s | GitHub 2.8x slower |
| Flow 4 (Depot CI) | 23s | Similar |

**Key Insight:** Railway's layer caching works excellently! 31% faster than cold build (34.20s → 23.60s). Only Local with persistent cache beats it for tiny changes.

---

---

### Test Case 3: New Function

**Log:** `flow2-railway-build-logs/railway-test2/flow2-railway-reun-Applying-Test-Case-3-New-Function-logs.1775094312937.log`

**Time:** **18.02 seconds**

**Build Breakdown:**
- All dependency layers: CACHED ✅
- New utils.ts file + source copy: Rebuilt (~2s)
- TypeScript build: ~2s
- Total: 18.02s

**Cache Behavior:**
- Excellent cache hit! Only source layers rebuilt
- Both `npm ci` layers cached from previous build
- Only `COPY . .` and `npm run build` executed

**Comparison:**
| Flow | Time | vs Flow 2 |
|------|------|-----------|
| Flow 1 (Local) | 17s | Similar |
| Flow 2 (Railway) | **18.02s** | baseline |
| Flow 3 (GitHub Actions) | 64s | GitHub 3.6x slower |
| Flow 4 (Depot CI) | 23s | Depot 1.3x slower |

**Key Insight:** Railway is comparable to Local (18.02s vs 17s) for function additions! The cache works perfectly and build time is excellent.

---

---

### Test Case 4: New Dependency

**Log:** `flow2-railway-build-logs/railway-test2/flow2-railway-rerun-Test-Case-4-applied-Added-ESLint-dependency-logs.1775096999162.log`

**Time:** **40.75 seconds**

**Build Breakdown:**
- npm ci (deps): ~19s (rebuilt with ESLint)
- npm ci (production-deps): ~19s (rebuilt with ESLint)
- TypeScript build: ~2s
- Total: 40.75s

**Cache Behavior:**
- Dependency layers: REBUILT ❌ (package.json changed)
- Both `npm ci` layers had to reinstall
- Source and build layers: fast copy
- Added ESLint package (+108 dev dependencies)

**Comparison:**
| Flow | Time | vs Flow 2 |
|------|------|-----------|
| Flow 1 (Local) | 143s | Local 3.5x slower |
| Flow 2 (Railway) | **40.75s** | baseline |
| Flow 3 (GitHub Actions) | 193s | GitHub 4.7x slower |
| Flow 4 (Depot CI) | 31s | Depot 1.3x faster |

**Key Insight:** Railway beats Local for dependency changes by 3.5x! Better network to npm registry makes a huge difference. Depot CI is slightly faster due to advanced caching.

---

---

### Test Case 5: Major Changes

**Log:** `flow2-railway-build-logs/railway-test2/flow2-railway-rerun-Test-Case-5-5-Major-Changes-logs.1775097536195.log`

**Time:** **27.73 seconds**

**Build Breakdown:**
- npm ci (deps): ~11s (rebuilt with lodash + moment)
- npm ci (production-deps): ~12s (rebuilt with lodash + moment)
- TypeScript build: ~2s
- Total: 27.73s

**Cache Behavior:**
- Dependency layers: REBUILT ❌ (package.json changed again)
- Both `npm ci` layers had to reinstall
- Source and build layers: fast copy
- Added lodash + moment packages (+12 new dependencies)

**Comparison:**
| Flow | Time | vs Flow 2 |
|------|------|-----------|
| Flow 1 (Local) | 206s | Local 7.4x slower |
| Flow 2 (Railway) | **27.73s** | baseline |
| Flow 3 (GitHub Actions) | 133s | GitHub 4.8x slower |
| Flow 4 (Depot CI) | 26s | Depot 1.1x faster |

**Key Insight:** Railway beats Local by 7.4x for major changes! Only slightly slower than Depot CI (27.73s vs 26s). Excellent performance for substantial codebase changes.

---

## Final Summary

**All 5 test cases completed!**

| Test Case | Time | vs Baseline |
|-----------|------|-------------|
| Baseline (Cold) | 34.20s | baseline |
| Comment Change | 23.60s | 31% faster |
| New Function | 18.02s | 47% faster |
| New Dependency | 40.75s | 19% slower |
| Major Changes | 27.73s | 19% faster |

**Railway Performance:** Consistently fast across all scenarios! The only slower test was New Dependency (40.75s) because both npm ci layers had to rebuild from scratch. Even then, Railway beat Local by 3.5x thanks to better cloud network.

