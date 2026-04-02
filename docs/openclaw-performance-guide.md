# OpenClaw Performance Testing with Depot CI

## Overview

This guide covers performance testing using the **actual OpenClaw application** - a comprehensive personal AI assistant with a complex build process.

## Why OpenClaw?

OpenClaw is an ideal candidate for demonstrating Depot CI's value because:

| Factor | OpenClaw | Impact |
|--------|----------|--------|
| **Dependencies** | 13,301-line pnpm-lock.yaml | Large install time |
| **Build System** | Bun + pnpm, multi-stage | Complex build pipeline |
| **Extensions** | Optional plugin system | Conditional build steps |
| **UI Bundle** | Separate UI build step | Multiple compilation stages |
| **Source Files** | 50+ source directories | Large codebase |

## Project Structure

```
openclaw/
├── Dockerfile              # Multi-stage build (265 lines)
├── package.json            # 62K+ lines, massive dependency tree
├── pnpm-lock.yaml          # 13,301 lines
├── pnpm-workspace.yaml     # Monorepo workspace
├── openclaw.mjs            # Entry point
├── src/                    # Main source (50+ directories)
├── ui/                     # UI subproject
├── extensions/             # Optional plugins
├── skills/                 # Skill modules
└── scripts/                # Build scripts
```

## Build Pipeline

### Stage 1: ext-deps
- Extract extension dependencies
- Prepare for optional plugin builds

### Stage 2: build
```
1. Install Bun (for build scripts)
2. pnpm install --frozen-lockfile  ← Cache-critical
3. pnpm build:docker               ← TypeScript compilation
4. pnpm ui:build                   ← UI bundling
```

### Stage 3: runtime-assets
```
5. pnpm prune --prod               ← Remove dev deps
6. Strip .d.ts, .map files
```

### Stage 4: Runtime
```
7. Install system packages
8. Copy production artifacts
9. Setup pnpm/Corepack
10. Configure non-root user
```

## Workflows

### Workflow 1: Depot CI - OpenClaw

**File:** `.github/workflows-openclaw/depot-ci-openclaw.yml`

```yaml
# Key steps:
1. Checkout OpenClaw repository
2. Apply test case changes
3. Build with: depot build -t openclaw:test .
```

**How to run:**
1. Copy workflow to `.github/workflows/`
2. Configure `DEPOT_TOKEN` and `DEPOT_PROJECT_ID` secrets
3. Go to Actions → Depot CI - OpenClaw
4. Click "Run workflow" → Select test case

### Workflow 2: GitHub Actions Baseline

**File:** `.github/workflows-openclaw/github-actions-baseline-openclaw.yml`

```yaml
# Key steps:
1. Checkout OpenClaw repository
2. Apply test case changes
3. Build with: docker buildx build -t openclaw:test .
```

**How to run:**
1. Copy workflow to `.github/workflows/`
2. Go to Actions → GitHub Actions Baseline - OpenClaw
3. Click "Run workflow" → Select test case

## Test Cases

### Test 1: Baseline (No Changes)
- **Purpose:** Measure fully cached build
- **Changes:** None
- **Expected:** All layers cached (~100%)
- **Depot CI:** ~30-45 seconds (after initial warm-up)
- **GitHub Actions:** ~3-5 minutes (even with cache)

### Test 2: Comment Change
- **Purpose:** Measure trivial source change impact
- **Changes:** Add comment to README.md
- **Layers affected:** COPY README only
- **Expected Cache:** ~90%
- **Depot CI:** ~35-50 seconds
- **GitHub Actions:** ~3-5 minutes

### Test 3: New Function
- **Purpose:** Measure small code addition impact
- **Changes:** Add `src/test-perf.ts` with simple function
- **Layers affected:** COPY src, build stage
- **Expected Cache:** ~70%
- **Depot CI:** ~45-60 seconds
- **GitHub Actions:** ~4-6 minutes

### Test 4: New Dependency
- **Purpose:** Measure package.json change impact
- **Changes:** Add `tsup` to devDependencies
- **Layers affected:** pnpm install, build, runtime
- **Expected Cache:** ~30%
- **Depot CI:** ~60-90 seconds
- **GitHub Actions:** ~6-10 minutes

### Test 5: Major Changes
- **Purpose:** Measure significant changes impact
- **Changes:** Multiple packages + new files + comment
- **Layers affected:** All stages (near-full rebuild)
- **Expected Cache:** ~10%
- **Depot CI:** ~2-3 minutes (optimized infrastructure)
- **GitHub Actions:** ~8-15 minutes

## Expected Results

### Performance Comparison

| Test Case | GitHub Actions | Depot CI | Speedup |
|-----------|----------------|----------|---------|
| Baseline (cached) | 3-5 min | 30-45s | **4-7x** |
| Comment | 3-5 min | 35-50s | **4-7x** |
| New Function | 4-6 min | 45-60s | **4-7x** |
| New Dependency | 6-10 min | 60-90s | **5-8x** |
| Major Changes | 8-15 min | 2-3 min | **3-5x** |

### Why Depot CI is Faster

1. **Distributed Layer Caching**
   - Global cache shared across all builds
   - Intelligent cache pre-fetching
   - Parallel layer downloads

2. **Optimized Infrastructure**
   - Faster CPUs (dedicated build runners)
   - Better networking (faster package downloads)
   - SSD storage with optimized I/O

3. **Smart Build Orchestration**
   - Parallel dependency resolution
   - Incremental compilation optimization
   - Build stage parallelization

## Setup Instructions

### 1. Fork OpenClaw Repository

```bash
# Optional: Fork to your own GitHub account for testing
# Or use the official openclaw/openclaw directly
```

### 2. Configure GitHub Secrets

In your depot-railway-build repository, add these secrets:

| Secret | Value | How to Get |
|--------|-------|------------|
| `DEPOT_TOKEN` | Your Depot API token | depot.dev/settings/tokens |
| `DEPOT_PROJECT_ID` | Your Depot project ID | depot.dev/dashboard |

### 3. Copy Workflows

```bash
# Copy workflows to your .github/workflows directory
cp .github/workflows-openclaw/*.yml .github/workflows/
```

### 4. Run Workflows

#### Depot CI Build:
1. Go to **Actions** → **Depot CI - OpenClaw**
2. Click **Run workflow**
3. Select test case
4. Click **Run workflow**

#### GitHub Actions Baseline:
1. Go to **Actions** → **GitHub Actions Baseline - OpenClaw**
2. Click **Run workflow**
3. Select test case
4. Click **Run workflow**

## Recording Results

Use this template to record your results:

```
OpenClaw Performance Test Results
==================================

Test 1 (Baseline):
  GitHub Actions: ___ seconds
  Depot CI:       ___ seconds
  Speedup:        ___x

Test 2 (Comment):
  GitHub Actions: ___ seconds
  Depot CI:       ___ seconds
  Speedup:        ___x

Test 3 (New Function):
  GitHub Actions: ___ seconds
  Depot CI:       ___ seconds
  Speedup:        ___x

Test 4 (New Dependency):
  GitHub Actions: ___ seconds
  Depot CI:       ___ seconds
  Speedup:        ___x

Test 5 (Major Changes):
  GitHub Actions: ___ seconds
  Depot CI:       ___ seconds
  Speedup:        ___x

Average Speedup: ___x
```

## Key Differences from Sample App

| Aspect | Sample App | OpenClaw |
|--------|-----------|----------|
| Dependencies | ~50 packages | ~500+ packages |
| Build Time | 20-60 seconds | 2-15 minutes |
| Cache Impact | Moderate | Significant |
| Real-World | Simplified | Production-grade |

## Troubleshooting

### Workflow fails with "repository not found"
- Ensure OpenClaw repository is accessible
- Check token permissions

### Build takes longer than expected on first run
- First builds are slower (cache warming)
- Run baseline test twice for accurate results

### pnpm install fails
- Check pnpm version (should be 9.x)
- Verify pnpm-lock.yaml is intact

### Out of memory during build
- OpenClaw build is resource-intensive
- Consider increasing runner resources

## Next Steps

1. **Run all 5 test cases** for both workflows
2. **Record actual times** from workflow logs
3. **Calculate speedup** for each test case
4. **Create comparison chart** for presentation
5. **Document findings** in comparison-summary.md

## References

- [OpenClaw Repository](https://github.com/openclaw/openclaw)
- [OpenClaw Documentation](https://docs.openclaw.ai)
- [Depot Documentation](https://depot.dev/docs)
- [Depot CI Overview](./depot-summary.md)
- [Sample App Testing Guide](./performance-testing/comparison-summary.md)

---

**Note:** OpenClaw is a production-grade application with a complex build pipeline. Performance results will vary based on:
- Geographic location
- Time of day (CI load)
- Network conditions
- Cache state

For consistent results, run each test case 2-3 times and use the average.
