# OpenClaw Performance Testing - Quick Start

## Overview

Test Depot CI against the **actual OpenClaw application** - a production-grade AI assistant with 500+ dependencies and a complex multi-stage build.

## What You'll Need

| Item | Where to Get |
|------|--------------|
| Depot Account | [depot.dev](https://depot.dev) (free during beta) |
| Depot Token | depot.dev/settings/tokens |
| Depot Project ID | depot.dev/dashboard |
| GitHub Repository | This repo or your fork |

## Setup (2 Minutes)

### Step 1: Configure GitHub Secrets

Go to: **Settings → Secrets and variables → Actions**

Add these secrets:

| Secret Name | Value |
|-------------|-------|
| `DEPOT_TOKEN` | Your Depot API token |
| `DEPOT_PROJECT_ID` | Your Depot project ID |

### Step 2: Copy Workflows (Optional)

The workflows are in `.github/workflows-openclaw/`. To use them:

```bash
# Copy to active workflows directory
cp .github/workflows-openclaw/*.yml .github/workflows/

# Commit and push
git add .github/workflows/
git commit -m "Enable OpenClaw performance workflows"
git push
```

## Running Tests

### Test Cases Overview

| Test | Description | Expected Cache | Speedup |
|------|-------------|----------------|---------|
| **baseline** | No changes - fully cached | ~100% | 4-7x |
| **test-2-docs** | README comment change | ~95% | 4-7x |
| **test-3-source** | New TypeScript source file | ~75% | 5-8x |
| **test-4-ui** | New UI component | ~50% | 5-8x |
| **test-5-dependency** | Add @types/node package | ~25% | 5-7x |
| **test-6-major** | Multiple file types + dep | ~10% | 5-8x |

### Option A: GitHub Actions Baseline

1. Go to **Actions** → **GitHub Actions Baseline - OpenClaw**
2. Click **Run workflow**
3. Select test case from dropdown
4. Click **Run workflow**
5. Wait for completion (3-20 minutes depending on test)
6. Note the total time from workflow run

### Option B: Depot CI

1. Go to **Actions** → **Depot CI - OpenClaw**
2. Click **Run workflow**
3. Select the same test case
4. Click **Run workflow**
5. Wait for completion (30 sec - 4 min depending on test)
6. Note the total time

## Expected Results

| Test | GitHub Actions | Depot CI | Speedup |
|------|----------------|----------|---------|
| Baseline | 3-5 min | 30-45s | **4-7x** |
| Docs | 3-5 min | 35-50s | **4-7x** |
| Source | 5-8 min | 60-90s | **5-8x** |
| UI | 7-12 min | 90-120s | **5-8x** |
| Dependency | 10-15 min | 2-3 min | **5-7x** |
| Major | 12-20 min | 2-4 min | **5-8x** |

## Why OpenClaw?

OpenClaw is a **real-world application** with:

- **13,301-line** pnpm-lock.yaml
- **Multi-stage** Docker build (265 lines)
- **Bun + pnpm** dual build system
- **50+ source** directories
- **Separate UI build** step
- **Extension system** for plugins

This complexity makes it perfect for demonstrating Depot CI's advantages over traditional CI systems.

## Test Case Details

### 1. Baseline (No Changes)
- **What:** Clean build with all layers cached
- **Why:** Best-case scenario for both systems
- **Cache:** ~100%

### 2. Documentation Change
- **What:** Add comment to README.md
- **Why:** Trivial change that shouldn't affect build
- **Cache:** ~95%

### 3. Source File Addition
- **What:** Create new TypeScript file in src/
- **Why:** Typical code addition
- **Cache:** ~75%

### 4. UI Component Change
- **What:** Create new component in ui/
- **Why:** Frontend development workflow
- **Cache:** ~50%

### 5. New Dependency
- **What:** Add @types/node to devDependencies
- **Why:** Adding a new library
- **Cache:** ~25%

### 6. Major Changes
- **What:** Dependency + source + UI + docs
- **Why:** Worst-case rebuild scenario
- **Cache:** ~10%

## Recording Your Results

```
OpenClaw Performance Test Results
==================================

Baseline (100% cache):
  GitHub Actions: ___ min ___ sec
  Depot CI:       ___ min ___ sec
  Speedup:        ___x

Docs (95% cache):
  GitHub Actions: ___ min ___ sec
  Depot CI:       ___ min ___ sec
  Speedup:        ___x

Source (75% cache):
  GitHub Actions: ___ min ___ sec
  Depot CI:       ___ min ___ sec
  Speedup:        ___x

UI (50% cache):
  GitHub Actions: ___ min ___ sec
  Depot CI:       ___ min ___ sec
  Speedup:        ___x

Dependency (25% cache):
  GitHub Actions: ___ min ___ sec
  Depot CI:       ___ min ___ sec
  Speedup:        ___x

Major (10% cache):
  GitHub Actions: ___ min ___ sec
  Depot CI:       ___ min ___ sec
  Speedup:        ___x

─────────────────────────────────────
Average Speedup: ___x
```

## Troubleshooting

**Q: Workflow fails with "project not found"**
A: Verify `DEPOT_PROJECT_ID` is correct in secrets

**Q: First run is slow**
A: First builds warm the cache - run baseline twice

**Q: pnpm install fails**
A: OpenClaw uses pnpm 9.x - the workflow handles this

**Q: UI build fails**
A: May fail under cross-compilation - workflow creates stub (non-fatal)

## Next Steps

1. Run all 6 test cases
2. Record your results
3. Calculate average speedup
4. Share findings with team

**Full Guide:** [openclaw-performance-guide.md](./openclaw-performance-guide.md)

**Real OpenClaw:** [github.com/openclaw/openclaw](https://github.com/openclaw/openclaw)
