# Flow 2: Railway Auto-Build Performance Results (Rerun)

Performance test results for Flow 2 (Railway Auto-Build) on `flow2-retest` branch.

**Test Date:** 2026-04-02
**Branch:** flow2-retest
**Railway Region:** us-east4

---

## Results Summary (Cold Build)

| Test Case | Description | Time | vs Flow 1 | vs Flow 3 | vs Flow 4 |
|-----------|-------------|------|-----------|-----------|-----------|
| **1. Baseline** | No changes, cold build | **34.20s** | 4.7x faster | 4.1x faster | Similar |
| **2. Comment Change** | Source comment modified | TBD | TBD | TBD | TBD |
| **3. New Function** | New utils.ts file | TBD | TBD | TBD | TBD |
| **4. New Dependency** | Package.json change | TBD | TBD | TBD | TBD |
| **5. Major Changes** | Multiple new packages | TBD | TBD | TBD | TBD |

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
