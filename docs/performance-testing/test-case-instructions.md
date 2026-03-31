# Docker Build Performance Test Cases - Step-by-Step Guide

Complete instructions for running each test case individually for all 4 flows.

---

## Quick Reference: All Flows

| Flow | How to Run | Tool |
|------|-------------|------|
| **Flow 1: Local** | `./scripts/run-flow1-tests.sh` | Automated script ⚡ |
| **Flow 2: Railway** | `./scripts/run-flow2-tests.sh` | Automated script ⚡ |
| **Flow 3: GitHub Actions** | Workflow dropdown | GitHub UI |
| **Flow 4: Depot CI** | Workflow dropdown | GitHub UI |

---

---

## Quick Start: Using Workflow Dropdowns ⚡

**Flows 3 & 4 (GitHub Actions & Depot CI) now have built-in test case selection!**

### How It Works

```
┌─────────────────────────────────────────────────────────────┐
│  GitHub Actions Workflow UI                                 │
├─────────────────────────────────────────────────────────────┤
│                                                             │
│  Run workflow ▼                                             │
│  ┌──────────────────────────────────────┐                  │
│  │ Use workflow from:                  │                  │
│  │ Branch: main                    ▼   │                  │
│  │                                     │                  │
│  │ Performance Test Case ▼            │  ← Select here!   │
│  │ ┌───────────────────────────────┐  │                  │
│  │ │ • baseline                     │  │                  │
│  │ │ • test-2-comment               │  │                  │
│  │ │ • test-3-function             │  │                  │
│  │ │ • test-4-dependency            │  │                  │
│  │ │ • test-5-major                 │  │                  │
│  │ └───────────────────────────────┘  │                  │
│  │                                     │                  │
│  │ [ Run workflow ]                   │                  │
│  └──────────────────────────────────────┘                  │
│                                                             │
└─────────────────────────────────────────────────────────────┘
```

### Flow 3: GitHub Actions → Railway

1. Go to: https://github.com/bytechie/depot-railway-build/actions/workflows/railway-direct.yml
2. Click **"Run workflow"**
3. Select test case from dropdown
4. Click **"Run workflow"**

### Flow 4: Depot CI → Railway

1. Go to: https://github.com/bytechie/depot-railway-build/actions/workflows/depot-ci.yml
2. Click **"Run workflow"**
3. Select test case from dropdown
4. Click **"Run workflow"**

**The workflow automatically:**
- ✅ Applies the test case changes
- ✅ Displays expected cache hit percentage
- ✅ Shows timing for each build step
- ✅ Deploys to Railway

---

## Preparation

**Before starting, ensure you have:**
1. Clean git state: `git status` shows no uncommitted changes
2. Access to GitHub Actions (for Flows 3 & 4)
3. Railway CLI installed (for Flows 1 & 3)
4. Docker running locally (for Flow 1)

**To reset between tests:**
```bash
# Discard test changes
git checkout sample-app/package.json
git checkout sample-app/package-lock.json
git checkout sample-app/src/
rm -f sample-app/src/utils.ts
rm -f sample-app/src/database.ts
rm -f sample-app/src/cache.ts
rm -f sample-app/.eslintrc.js
```

---

## Flow 1: Local → Railway ⚡

### Using the Automated Test Runner

**All test cases with one command!**

```bash
./scripts/run-flow1-tests.sh
```

**Features:**
- ✅ Automatically applies each test case
- ✅ Runs Docker build with timing
- ✅ Shows cache hit statistics
- ✅ Records results to CSV
- ✅ Resets state between tests

**What happens:**
```
1. Select test case (1-6) from menu
2. Script applies changes
3. Builds Docker image
4. Records build time
5. Resets for next test
```

**View results:**
```bash
cat docs/performance-testing/results/performance-results.csv
```

---

## Flow 2: Railway Auto-Build ⚡

### Using the Automated Test Runner

**All test cases with one command!**

```bash
./scripts/run-flow2-tests.sh
```

**Features:**
- ✅ Automatically applies each test case
- ✅ Creates temporary commit
- ✅ Pushes to trigger Railway
- ✅ Prompts for build time
- ✅ Resets state between tests
- ✅ No branch management needed!

**What happens:**
```
1. Select test case (1-6) from menu
2. Script applies changes
3. Creates temporary commit
4. Pushes to Railway
5. Railway builds automatically
6. Enter the time you see in Railway dashboard
7. Script resets to clean state
```

**Important:** The script uses temporary commits that get reset after each test. No branch pollution!

---

---

## Flow 3: GitHub Actions → Railway

### Using the Test Case Dropdown ⚡

**All test cases are now available as dropdown options!**

**Steps for any test case:**
1. Go to: https://github.com/bytechie/depot-railway-build/actions/workflows/railway-direct.yml
2. Click **"Run workflow"**
3. Select test case from dropdown:
   - `baseline` - No changes
   - `test-2-comment` - Comment change
   - `test-3-function` - New function
   - `test-4-dependency` - New dependency
   - `test-5-major` - Major changes
4. Click **"Run workflow"**
5. Watch the progress
6. Record total workflow time from logs

**The workflow automatically:**
- Applies the test case changes
- Displays expected cache hit
- Builds and deploys
- Shows timing for each step

---

## Flow 4: Depot CI → Railway

### Using the Test Case Dropdown ⚡

**All test cases are now available as dropdown options!**

**Steps for any test case:**
1. Go to: https://github.com/bytechie/depot-railway-build/actions/workflows/depot-ci.yml
2. Click **"Run workflow"**
3. Select test case from dropdown:
   - `baseline` - No changes
   - `test-2-comment` - Comment change
   - `test-3-function` - New function
   - `test-4-dependency` - New dependency
   - `test-5-major` - Major changes
4. Click **"Run workflow"**
5. Watch the progress
6. Record total workflow time from logs

**The workflow automatically:**
- Applies the test case changes
- Displays expected cache hit
- Builds with Depot CI
- Shows timing for each step

---

## Results Template

Copy and fill in this template after completing all tests:

```
Docker Build Performance Test Results
=====================================

Flow 1: Local → Railway
Test 1 (Baseline):     ___ seconds (100% cache)
Test 2 (Comment):      ___ seconds (~80% cache)
Test 3 (Function):     ___ seconds (~60% cache)
Test 4 (Dependency):   ___ seconds (~40% cache)
Test 5 (Major):        ___ seconds (~10% cache)

Flow 2: Railway Auto-Build
Test 1 (Baseline):     3.81 seconds (cached)
Test 2 (Comment):      ___ seconds
Test 3 (Function):     ___ seconds
Test 4 (Dependency):   ___ seconds
Test 5 (Major):        ___ seconds

Flow 3: GitHub Actions
Test 1 (Baseline):     ___ seconds (100% cache)
Test 2 (Comment):      ___ seconds
Test 3 (Function):     ___ seconds
Test 4 (Dependency):   ___ seconds
Test 5 (Major):        ___ seconds

Flow 4: Depot CI
Test 1 (Baseline):     ___ seconds (100% cache)
Test 2 (Comment):      ___ seconds
Test 3 (Function):     ___ seconds
Test 4 (Dependency):   ___ seconds
Test 5 (Major):        ___ seconds
```

---

## Reset Between Tests

**Quick reset command:**
```bash
git checkout sample-app/package.json \
            sample-app/package-lock.json \
            sample-app/src/ && \
rm -f sample-app/src/utils.ts \
     sample-app/src/database.ts \
     sample-app/src/cache.ts \
     sample-app/.eslintrc.js
```

**Or reset everything:**
```bash
git reset --hard HEAD
git clean -fd sample-app/
```

---

## Tips

1. **Run each test 2-3 times** - First run after reset may be slower
2. **Record exact times** - Use the time shown in workflow logs
3. **Note cache behavior** - Check which layers were rebuilt
4. **Compare across flows** - Same test case across all 4 flows shows true difference
5. **Document environment** - Note your machine specs for local builds
6. **Use dropdowns for Flows 3 & 4** - Much easier than manual script running!

## Workflow Test Case Quick Reference

| Flow | How to Select Test Case |
|------|------------------------|
| **Flow 1: Local** | Run `./scripts/apply-test-case-N.sh` manually |
| **Flow 2: Railway** | Run script, then `git push` |
| **Flow 3: GitHub Actions** | Use dropdown in workflow UI ⚡ |
| **Flow 4: Depot CI** | Use dropdown in workflow UI ⚡ |

---

## Quick Reference

| Command | Purpose |
|---------|---------|
| `./scripts/apply-test-case-2.sh` | Apply comment change |
| `./scripts/apply-test-case-3.sh` | Apply new function |
| `./scripts/apply-test-case-4.sh` | Apply new dependency |
| `./scripts/apply-test-case-5.sh` | Apply major changes |
| `git reset --hard HEAD` | Reset all changes |
| `docker build -t test .` | Local build test |
| `time <command>` | Measure execution time |
