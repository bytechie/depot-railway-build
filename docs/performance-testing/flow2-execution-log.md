# Flow 2: Railway Auto-Build - Test Execution Guide

Running Flow 2 (Railway Auto-Build) performance tests step-by-step.

---

## Test Execution Log

**Date:** 2026-03-31
**Railway Region:** us-east4

---

## Test Case 1: Baseline (Already Measured)

From `docs/performance-testing/railway-build-results.md`:

| Metric | Value |
|--------|-------|
| Initial build | 29.06 seconds |
| Cached rebuild | 3.81 seconds |
| Speedup | 7.6x faster |

**Reference:** docs/performance-testing/railway-build-time-logs.1774871772380.log

---

## Test Case 2: Comment Change

**Step 1: Apply test case**
```bash
./scripts/apply-test-case-2.sh
```

**Step 2: Commit and push**
```bash
git add sample-app/src/index.ts
git commit -m "Test Case 2: Comment Change"
git push
```

**Step 3: Watch Railway dashboard**

**Expected result:** ~10-15 seconds (similar to GitHub Actions cached build)

---

## Test Case 3: New Function

**Step 1: Apply test case**
```bash
./scripts/apply-test-case-3.sh
```

**Step 2: Commit and push**
```bash
git add sample-app/
git commit -m "Test Case 3: New Function"
git push
```

**Step 3: Watch Railway dashboard**

**Expected result:** ~15-20 seconds (slightly more than comment change due to new file)

---

## Test Case 4: New Dependency

**Step 1: Apply test case**
```bash
./scripts/apply-test-case-4.sh
```

**Step 2: Commit and push**
```bash
git add sample-app/
git commit -m "Test Case 4: New Dependency"
git push
```

**Step 3: Watch Railway dashboard**

**Expected result:** ~30-40 seconds (package.json change invalidates npm cache)

---

## Test Case 5: Major Changes

**Step 1: Apply test case**
```bash
./scripts/apply-test-case-5.sh
```

**Step 2: Commit and push**
```bash
git add sample-app/
git commit -m "Test Case 5: Major Changes"
git push
```

**Step 3: Watch Railway dashboard**

**Expected result:** ~60-90 seconds (multiple new packages)

---

## How to Run Manually

Since Flow 2 requires watching Railway dashboard for build times, here's the recommended approach:

1. **Open Railway dashboard in your browser:**
   - https://railway.app/project/xxx

2. **For each test case:**
   - Apply test case script
   - Commit and push changes
   - Watch the "Build time" in Railway logs
   - Record the time

3. **Reset between tests:**
   ```bash
   git reset --hard HEAD^
   git clean -fd sample-app/
   ```

---

## Interactive Script Usage

The `run-flow2-tests.sh` script handles:
- ✅ Applying test cases
- ✅ Committing and pushing
- ✅ Resetting state
- ⏸️ **Manual step:** You enter build time from Railway dashboard

**To use:**
```bash
./scripts/run-flow2-tests.sh
```

Then:
1. Select test case (2-6)
2. Wait for Railway build
3. Check Railway dashboard for "Build time: XX seconds"
4. Enter that time when prompted
5. Script resets automatically for next test

---

## Comparison: Flow 1 vs Flow 2 (So Far)

| Test | Flow 1 (Local) | Flow 2 (Railway) | Winner |
|------|----------------|-------------------|--------|
| 1a. Clean | 162s | 29s | **Railway 5.6x** |
| 1b. Cached | 2s | 3.8s | **Local 1.9x** |
| 2. Comment | 14s | TBD | - |
| 3. Function | 17s | TBD | - |
| 4. Dependency | 143s | TBD | - |
| 5. Major | 206s | TBD | - |

---

## Expected Results Based on Flow 1

**Railway advantages:**
- Better network bandwidth to npm
- Cached base images
- Optimized build servers

**Railway disadvantages:**
- No persistent local cache between tests
- Each commit triggers fresh build

**Predictions:**
- Railway will be faster for clean builds (better infrastructure)
- Local may be faster for cached builds (persistent cache)
- Dependency changes will be expensive on both
