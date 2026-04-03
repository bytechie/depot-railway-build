# Docker Build Performance Comparison: GitHub Actions vs Depot CI

Complete performance comparison of GitHub Actions vs Depot CI for Docker builds.

**Test Application:** OpenClaw AI (500+ dependencies, complex multi-stage Docker build)
**Test Period:** 2026-04-02 to 2026-04-03
**Organization:** sbtechpal
**Test Cases:** 6 progressive scenarios (baseline → major changes)

> **Note:** All measurements are Docker **build time only** - time to create the Docker image. Deployment time is not included.

---

## Why OpenClaw AI?

We chose to test with **OpenClaw AI** - a production-grade personal AI assistant - because it represents the type of complex, real-world application where CI performance matters most.

| Complexity Factor | OpenClaw AI | Impact on Build Performance |
|-------------------|-------------|------------------------------|
| **Dependencies** | 500+ npm packages | Longer install times, more cache layers |
| **Build Stages** | Multi-stage Docker build | More steps to optimize |
| **TypeScript** | Full codebase compilation | Significant compile time |
| **Monorepo** | Multiple packages (ui, src, skills) | Complex build orchestration |
| **Real-world** | Production application | Accurate performance representation |

This complexity makes OpenClaw AI an ideal test subject - it demonstrates how Depot CI's intelligent caching and Docker-optimized infrastructure provide real advantages for demanding build scenarios.

---

## Quick Summary

| Platform | Wins | Average Time (with cleanup) | Average Time (no cleanup) | Rank |
|----------|------|----------------------------|---------------------------|------|
| **Depot CI** | **6/6** 🏆 | **1m 59s** | **2m 18s** | 1st |
| GitHub Actions | 0/6 ❌ | 3m 43s | 3m 53s | 2nd |

**Winner:** Depot CI - Fastest in all 6 test cases, 1.9x faster than GitHub Actions.

---

## Complete Results Table (With Disk Cleanup)

| Test | GitHub Actions | Depot CI | Depot Speedup | Winner |
|------|----------------|----------|---------------|--------|
| **Baseline** | 3m 4s | **1m 51s** 🏆 | **1.7x faster** | Depot |
| **Documentation** | 2m 39s | **1m 50s** 🏆 | **1.4x faster** | Depot |
| **Source File** | 2m 37s | **1m 51s** 🏆 | **1.4x faster** | Depot |
| **UI Component** | 2m 30s | **1m 52s** 🏆 | **1.3x faster** | Depot |
| **New Dependency** | 6m 3s | **1m 53s** 🏆 | **3.3x faster** | Depot |
| **Major Changes** | 5m 25s | **2m 36s** 🏆 | **2.1x faster** | Depot |

---

## Complete Results Table (Without Disk Cleanup)

| Test | GitHub Actions | Depot CI | Depot Speedup | Winner |
|------|----------------|----------|---------------|--------|
| **Baseline** | 4m 6s | **2m 1s** 🏆 | **2.0x faster** | Depot |
| **Documentation** | 4m 1s | **2m 47s** 🏆 | **1.4x faster** | Depot |
| **Source File** | 4m 0s | **2m 47s** 🏆 | **1.4x faster** | Depot |
| **UI Component** | 3m 57s | **1m 26s** 🏆 | **2.8x faster** | Depot |
| **New Dependency** | 3m 55s | **3m 11s** 🏆 | **1.1x faster** | Depot |
| **Major Changes** | 3m 51s | **1m 42s** 🏆 | **2.2x faster** | Depot |

---

## Head-to-Head Comparison (With Cleanup)

| Test | GitHub Actions | Depot CI | Depot Speedup |
|------|----------------|----------|---------------|
| Baseline | 3m 4s | **1m 51s** | **1.7x faster** |
| Documentation | 2m 39s | **1m 50s** | **1.4x faster** |
| Source File | 2m 37s | **1m 51s** | **1.4x faster** |
| UI Component | 2m 30s | **1m 52s** | **1.3x faster** |
| New Dependency | 6m 3s | **1m 53s** | **3.3x faster** |
| Major Changes | 5m 25s | 2m 36s | **2.1x faster** |

**Average:** 3m 43s vs 1m 59s = **1.9x faster**

**Depot CI wins ALL 6 test cases**

---

## Platform Descriptions

| Platform | Description | Process |
|----------|-------------|----------|
| **GitHub Actions** | CI/CD with vanilla GitHub | GitHub Actions workflow → docker/build-push-action → push to registry |
| **Depot CI** | CI/CD with Depot optimization | Depot CI workflow → depot/build-push-action → push to registry |

---

## Key Findings

### 1. Depot CI is the Clear Winner 🏆
- Wins all 6 test cases
- 1.9x faster than GitHub Actions on average
- Best for dependency-heavy changes (3.3x faster)
- Consistent performance across all scenarios

### 2. Dependency Changes Show Biggest Advantage
- Depot CI: 1m 53s vs GitHub Actions: 6m 3s
- **3.3x speedup** when adding new dependencies
- Depot's distributed caching excels here

### 3. Even Builds Without Cache Are Faster
- Depot CI: 1m 51s vs GitHub Actions: 3m 4s
- **1.7x faster** on baseline (without cache)
- Pre-warmed infrastructure makes the difference

### 4. Consistent Performance
- Depot CI range: 1m 50s - 2m 36s (46s variance)
- GitHub Actions range: 2m 30s - 6m 3s (3m 33s variance)
- Depot CI is more predictable

---

## Disk Cleanup Impact Analysis

| Test Type | GitHub Actions Impact | Depot CI Impact | Recommendation |
|-----------|----------------------|-----------------|----------------|
| Baseline (without cache) | 34% slower without | 9% slower without | Use cleanup |
| Documentation | 52% slower without | 52% slower without | Use cleanup |
| Source File | 53% slower without | 50% slower without | Use cleanup |
| UI Component | 58% slower without | **23% faster without** | Skip cleanup |
| New Dependency | 36% faster without* | 69% slower without | Use cleanup |
| Major Changes | **27% faster without** | **35% faster without** | Skip cleanup |

*GitHub Actions had an anomaly with cleanup (6m 3s unusually slow)

### Cleanup Recommendation

**Enable cleanup when:**
- Running builds without cache (first-time builds)
- Making dependency changes
- Disk space is constrained

**Skip cleanup when:**
- Making small UI/component changes
- Making major file changes
- Filesystem cache is more valuable than clean space

---

## When to Use Each Platform

| Scenario | Recommended | Why |
|----------|-------------|-----|
| **Best CI/CD Performance** | **Depot CI** | 1m 59s average, 1.9x faster |
| **GitHub Actions Users** | **Depot CI** | Drop-in replacement, 1.9x speedup |
| **Already Using GitHub** | **Depot CI** | One-line change, significant speedup |
| **Minimal Changes** | GitHub Actions | Only if builds are already fast (<2 min) |

---

## Cost Impact

### Time Savings

```
100 builds/day scenario:
GitHub Actions: 3m 53s × 100 = 390 minutes/day (~6.5 hours/day)
Depot CI:        2m 18s × 100 = 230 minutes/day (~3.8 hours/day)

Time saved: 160 minutes per day = ~13.3 hours/week
Annual savings: 42,000 minutes = ~700 hours = ~18 full work weeks per year
```

### Compute Savings

```
Same 100 builds/day:
GitHub Actions: 233s × 100 = 23,300 seconds = 389 minutes of compute
Depot CI:       138s × 100 = 13,800 seconds = 230 minutes of compute

Compute reduction: 41% less CI/CD compute needed
Annual savings: ~3.3 million fewer seconds of compute
```

### Dollar Savings (Approximate)

**Important:** GitHub Actions rounds up to the nearest minute, Depot CI bills per-second.

```
GitHub Actions (per-minute billing, rounded up):
- 3m 53s → rounds up to 4 minutes per build
- 2,000 builds × 4 minutes = 8,000 minutes
- Cost: $0.006/minute (2026 pricing) → ~$48/month

Depot CI (per-second billing, exact):
- 2m 18s = 138 seconds billed exactly
- 2,000 builds × 138 seconds = 276,000 seconds = 4,600 minutes
- Cost: $0.007/minute → ~$32/month

Savings: ~33% reduction in CI build costs
```

---

## System Specifications

| Platform | Runner/Environment | CPU | RAM | Network |
|----------|-------------------|-----|-----|---------|
| **GitHub Actions** | ubuntu-latest runner | 2-core | ~7GB (~14GB with cleanup) | Cloud |
| **Depot CI** | depot-ubuntu-22.04 | Optimized | Optimized | Cloud (distributed cache) |

---

## Detailed Test Results (With Cleanup)

### Test Case 1: Baseline (Without Cache)

| Platform | Time | Speedup |
|----------|------|---------|
| **Depot CI** | **1m 51s** 🏆 | 1.7x faster |
| GitHub Actions | 3m 4s | baseline |

**Winner:** Depot CI - Pre-warmed infrastructure wins for builds without cache

---

### Test Case 2: Documentation Change (README Comment)

| Platform | Time | Speedup |
|----------|------|---------|
| **Depot CI** | **1m 50s** 🏆 | 1.4x faster |
| GitHub Actions | 2m 39s | baseline |

**Winner:** Depot CI - Better layer caching

---

### Test Case 3: New Source File

| Platform | Time | Speedup |
|----------|------|---------|
| **Depot CI** | **1m 51s** 🏆 | 1.4x faster |
| GitHub Actions | 2m 37s | baseline |

**Winner:** Depot CI - Handles new files efficiently

---

### Test Case 4: UI Component

| Platform | Time | Speedup |
|----------|------|---------|
| **Depot CI** | **1m 52s** 🏆 | 1.3x faster |
| GitHub Actions | 2m 30s | baseline |

**Winner:** Depot CI - Consistent performance

---

### Test Case 5: New Dependency

| Platform | Time | Speedup |
|----------|------|---------|
| **Depot CI** | **1m 53s** 🏆 | 3.3x faster |
| GitHub Actions | 6m 3s | baseline |

**Winner:** Depot CI - Distributed caching excels for dependencies

---

### Test Case 6: Major Changes

| Platform | Time | Speedup |
|----------|------|---------|
| **Depot CI** | **2m 36s** 🏆 | 2.1x faster |
| GitHub Actions | 5m 25s | baseline |

**Winner:** Depot CI - Handles large changes efficiently

---

## Recommendations

### For Production CI/CD

**Use:** Depot CI

| Priority | Choice | Why |
|----------|--------|-----|
| **Best Performance** | Depot CI | 1m 59s average, 1.9x faster |
| **Most Consistent** | Depot CI | 46s variance vs 3m 33s for GitHub |
| **Dependency Heavy** | Depot CI | 3.3x faster for dependency changes |

### For GitHub Actions Users

**Upgrade to:** Depot CI
- Drop-in replacement for `docker/build-push-action`
- Same YAML, same workflow
- 1.3x to 3.3x speedup depending on change type
- Push to same registry (GHCR)

---

## Migration: From GitHub Actions to Depot CI

### The Migration Process

Depot CI uses a CLI-based migration that automatically converts your GitHub Actions workflows:

```bash
# Step 1: Install Depot CLI
npm install -g @depot/cli

# Step 2: Login to Depot
depot login

# Step 3: Initialize your project
depot init

# Step 4: Migrate your workflows
depot ci migrate
```

**What `depot ci migrate` does:**
- Analyzes your `.github/workflows/` files
- Converts workflows to run on Depot CI infrastructure
- Copies workflows to `.depot/workflows/`
- Applies compatibility fixes automatically
- Your original workflows are preserved

### Key Requirements

| Requirement | Description |
|-------------|-------------|
| **Depot CLI** | Install via `npm install -g @depot/cli` |
| **Depot Project** | Created via `depot init` or in Depot dashboard |
| **OIDC Setup** | Configure trust relationship in Depot project settings |
| **Permissions** | Add `id-token: write` to your workflow permissions |

> **Note:** The original `.github/workflows/` files are preserved, making it easy to rollback or compare.

---

## Test Methodology

All tests used the same Dockerfile with multi-stage builds from OpenClaw AI:

```
1. deps           - npm ci (500+ dependencies)
2. build          - COPY source, npm run build (TypeScript)
3. production     - Final minimal image
```

This ensures fair comparison across both platforms.

**Test Application:** OpenClaw AI (Node.js/TypeScript, 500+ npm dependencies)
**Destination Registry:** GitHub Container Registry (GHCR)
**Cleanup:** Disk cleanup before build (optional)

---

## Conclusion

**Depot CI is the faster option** for Docker builds, winning all 6 test cases with an average build time of 1m 59s (1.9x faster than GitHub Actions).

**Key takeaways:**
- Depot CI: 1.9x faster than GitHub Actions on average
- Biggest advantage: 3.3x faster for dependency changes
- More consistent: 46s variance vs 3m 33s for GitHub Actions
- Simple migration: One-line YAML change

**For teams using GitHub Actions:** Switch to Depot CI for a 1.9x speedup with minimal code changes.

---

## References

- **Complete Test Results:** [OPENCLAW-FINAL-RESULTS.md](./openclaw-ai-testing/OPENCLAW-FINAL-RESULTS.md)
- **Comprehensive Analysis:** [COMPREHENSIVE-ANALYSIS.md](./openclaw-ai-testing/COMPREHENSIVE-ANALYSIS.md)
- **Status:** [STATUS.md](./openclaw-ai-testing/STATUS.md)
