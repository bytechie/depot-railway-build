# OpenClaw Performance Testing - Quick Start

## Overview

Test Depot CI against the **actual OpenClaw application** - a production-grade AI assistant with 500+ dependencies and a complex multi-stage build.

## What You'll Need

| Item | Where to Get |
|------|--------------|
| Depot Account | [depot.dev](https://depot.dev) (free trial available) |
| Depot CLI | `brew install depot/tap/depot` (macOS) or `curl -L https://depot.dev/install-cli.sh | sh` (Linux) |
| GitHub App | Install **Depot Code Access** app via Depot dashboard (required for Depot CI) |
| Depot Token | depot.dev/settings/tokens |
| Depot Project ID | depot.dev/dashboard |
| GitHub Repository | This repo or your fork |

## Install Depot CLI (First Time Only)

### macOS
```bash
brew install depot/tap/depot
```

### Linux
```bash
curl -L https://depot.dev/install-cli.sh | sh
```

### Login & Connect
```bash
depot login
# Then install Depot Code Access GitHub App via the Depot dashboard
```

This one-time setup enables both Depot CI workflows and the Depot CLI.

## Setup (2 Minutes)

### Step 1: Configure GitHub Secrets

Go to: **Settings → Secrets and variables → Actions**

Add these secrets:

| Secret Name | Required | Value |
|-------------|----------|-------|
| `DEPOT_PROJECT_ID` | ✅ Yes | Your Depot project ID |
| `DEPOT_TOKEN` | ⚠️ Optional | Your Depot API token (for OIDC fallback) |

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

| Test | Description | Expected Cache | Depot vs GHA |
|------|-------------|----------------|--------------|
| **baseline** | Build without cache | ~0% | 34% faster |
| **test-2-docs** | README comment change | ~95% | 23% faster |
| **test-3-source** | New TypeScript source file | ~75% | 44% faster |
| **test-4-ui** | New UI component | ~50% | 34% faster |
| **test-5-dependency** | Touch package.json (new dep) | ~25% | 44% faster |
| **test-6-major** | Multiple file types + dep | ~10% | 50% faster |

### Option A: GitHub Actions Baseline

1. Go to **Actions** → **GitHub Actions Baseline - OpenClaw**
2. Click **Run workflow**
3. Select test case from dropdown
4. Select cleanup disk option (recommended)
5. Click **Run workflow**
6. Wait for completion (2-6 minutes depending on test)
7. Note the total time from workflow run

### Option B: Depot CI

1. Go to **Actions** → **Depot CI - OpenClaw**
2. Click **Run workflow**
3. Select the same test case
4. Select cleanup disk option (recommended)
5. Click **Run workflow**
6. Wait for completion (1-3 minutes depending on test)
7. Note the total time

## Expected Results

| Test | Local Docker | GitHub Actions | Depot CI | Depot vs GHA |
|------|-------------|----------------|----------|-------------|
| Baseline | 15m 30s | 3m 44s | 2m 28s | **34% faster** |
| Docs | 12m 0s | 3m 56s | 3m 2s | **23% faster** |
| Source | 11m 56s | 3m 21s | 1m 53s | **44% faster** |
| UI | 9m 59s | 3m 50s | 2m 31s | **34% faster** |
| Dependency | ~10m 57s | 3m 59s | 2m 13s | **44% faster** |
| Major | ~8m 46s | 3m 52s | 1m 55s | **50% faster** |

> **Average:** Depot CI 38% faster than GHA (~2m 20s vs ~3m 47s), 5x faster than Local Docker (~2m 20s vs ~11m 28s)

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
  Local Docker:   ___ min ___ sec
  GitHub Actions: ___ min ___ sec
  Depot CI:       ___ min ___ sec
  Improvement:    ___% faster than GHA

Docs (95% cache):
  Local Docker:   ___ min ___ sec
  GitHub Actions: ___ min ___ sec
  Depot CI:       ___ min ___ sec
  Improvement:    ___% faster than GHA

Source (75% cache):
  Local Docker:   ___ min ___ sec
  GitHub Actions: ___ min ___ sec
  Depot CI:       ___ min ___ sec
  Improvement:    ___% faster than GHA

UI (50% cache):
  Local Docker:   ___ min ___ sec
  GitHub Actions: ___ min ___ sec
  Depot CI:       ___ min ___ sec
  Improvement:    ___% faster than GHA

Dependency (25% cache):
  Local Docker:   ___ min ___ sec
  GitHub Actions: ___ min ___ sec
  Depot CI:       ___ min ___ sec
  Improvement:    ___% faster than GHA

Major (10% cache):
  Local Docker:   ___ min ___ sec
  GitHub Actions: ___ min ___ sec
  Depot CI:       ___ min ___ sec
  Improvement:    ___% faster than GHA

─────────────────────────────────────
Average Improvement: ___% faster than GHA
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
