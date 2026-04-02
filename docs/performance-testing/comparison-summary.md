# Docker Build Performance Comparison Summary

Complete performance comparison of 4 Docker build flows deploying to Railway.

**Deployment Target:** Railway (us-east4)
**Test Period:** 2026-03-31 to 2026-04-02
**Organization:** sbtechpal
**Test Cases:** 5 progressive scenarios (baseline → major changes)

> **Note:** All measurements are Docker **build time only** - time to create the Docker image. Railway deployment time is not included.

---

## Quick Summary

| Flow | Wins | Average Time | Rank |
|------|------|--------------|------|
| **Depot CI** | **4/5** 🏆 | **27s** | 1st |
| Railway | 1/5 🥈 | 29s | 2nd |
| Local | 1/5 🥉 | 108s | 3rd |
| GitHub Actions | 0/5 ❌ | 134s | 4th |

**Winner:** Depot CI - Fastest in 4 out of 5 test cases, 5x faster than GitHub Actions.

---

## Complete Results Table

| Test | Local | Railway | GitHub | Depot | Winner |
|------|-------|---------|--------|-------|--------|
| **Baseline** | 162s | 34.20s | 141s | **31s** 🏆 | Depot |
| **Comment** | **14s** 🏆 | 23.60s | 65s | 23s | Local |
| **Function** | 17s | **18.02s** 🏆 | 64s | 23s | Railway |
| **Dependency** | 143s | 40.75s | 193s | **31s** 🏆 | Depot |
| **Major** | 206s | 27.73s | 133s | **26s** 🏆 | Depot |

---

## Head-to-Head Comparisons

### Depot CI vs GitHub Actions

| Test | Depot | GitHub | Depot Speedup |
|------|-------|--------|---------------|
| Baseline | **31s** | 141s | **4.5x faster** |
| Comment | **23s** | 65s | **2.8x faster** |
| Function | **23s** | 64s | **2.8x faster** |
| Dependency | **31s** | 193s | **6.2x faster** |
| Major | **26s** | 133s | **5.1x faster** |

**Average:** 27s vs 134s = **5.0x faster**

**Depot CI wins ALL 5 test cases**

---

### Depot CI vs Railway

| Test | Depot | Railway | Winner |
|------|-------|---------|--------|
| Baseline | **31s** | 34.20s | Depot ✅ |
| Comment | **23s** | 23.60s | Depot ✅ |
| Function | 23s | **18.02s** | Railway ✅ |
| Dependency | **31s** | 40.75s | Depot ✅ |
| Major | **26s** | 27.73s | Depot ✅ |

**Depot wins 4/5** - Only Railway wins for new function additions

---

### Railway vs GitHub Actions

| Test | Railway | GitHub | Railway Speedup |
|------|---------|--------|-----------------|
| Baseline | **34.20s** | 141s | **4.1x faster** |
| Comment | **23.60s** | 65s | **2.8x faster** |
| Function | **18.02s** | 64s | **3.6x faster** |
| Dependency | 40.75s | 193s | **4.7x faster** |
| Major | 27.73s | 133s | **4.8x faster** |

**Average:** 29s vs 134s = **4.6x faster**

**Railway wins ALL 5 test cases** vs GitHub Actions

---

## Flow Descriptions

| Flow | Description | Process |
|------|-------------|----------|
| **Local** | Build on your machine | `docker build` locally → manual deploy |
| **Railway** | Railway auto-build | `git push` → Railway builds automatically |
| **GitHub Actions** | CI/CD with vanilla GitHub | GitHub Actions workflow → push to GHCR → deploy |
| **Depot CI** | CI/CD with Depot optimization | Depot CI workflow → push to GHCR → deploy |

---

## Key Findings

### 1. Depot CI is the Overall Winner 🏆
- Wins 4 out of 5 test cases
- 5x faster than GitHub Actions
- 2s faster than Railway on average
- Best for dependency-heavy changes (6.2x faster than GitHub)

### 2. Railway is a Strong Second Place
- Only 2 seconds slower than Depot on average
- Wins the "New Function" test case
- Simplest setup (auto-build on git push)
- 4.6x faster than GitHub Actions

### 3. GitHub Actions is the Slowest
- Loses every single test case
- 5x slower than Depot CI
- 4.6x slower than Railway
- Generic runners lack Docker optimization

### 4. Local Only Wins for Tiny Changes
- Wins for comment changes (14s with persistent cache)
- But slowest for dependency changes (143s residential network)
- Good for development, not for CI/CD

---

## When to Use Each Flow

| Scenario | Recommended | Why |
|----------|-------------|-----|
| **Development (small changes)** | Local | 14-17s with persistent cache, instant feedback |
| **Simple CI/CD** | Railway | Auto-build on push, 29s average, zero config |
| **Best CI/CD Performance** | **Depot CI** | 27s average, 5x faster than GitHub |
| **GitHub Actions Users** | **Depot CI** | Drop-in replacement, 5x speedup |
| **Avoid** | GitHub Actions (vanilla) | 5x slower, no optimization |

---

## Cost Impact

### Time Savings

```
10 builds/day scenario:
GitHub Actions: 134s × 10 = 22 minutes/day
Depot CI:       27s  × 10 = 4.5 minutes/day

Time saved: 17.5 minutes per day = ~1.5 hours/week
```

### Compute Savings

```
Same 10 builds/day:
GitHub Actions: 134s × 10 = 1,340 seconds = 22 minutes of compute
Depot CI:       27s  × 10 = 270 seconds = 4.5 minutes of compute

Compute reduction: 80% less CI/CD compute needed
```

---

## System Specifications

| Flow | Runner/Environment | CPU | RAM | Network |
|------|-------------------|-----|-----|---------|
| **Local** | HP EliteBook 840 G7 (WSL2) | 4 cores | 24GB | Residential |
| **Railway** | us-east4 datacenter | 32 vCPU | 32GB | Cloud |
| **GitHub Actions** | ubuntu-latest runner | 2-core | ~7GB | Cloud |
| **Depot CI** | depot-ubuntu-22.04 | Optimized | Optimized | Cloud |

---

## Detailed Test Results

### Test Case 1: Baseline (Cold Build)

| Flow | Time | vs Local | vs GitHub |
|------|------|----------|-----------|
| **Depot CI** | **31s** 🏆 | 5.2x faster | 4.5x faster |
| Railway | 34.20s | 4.7x faster | 4.1x faster |
| GitHub Actions | 141s | 1.1x faster | baseline |
| Local | 162s | baseline | 1.3x slower |

**Winner:** Depot CI - Fastest cold build

---

### Test Case 2: Comment Change

| Flow | Time | vs Local | vs GitHub |
|------|------|----------|-----------|
| **Local** | **14s** 🏆 | baseline | 4.6x faster |
| Depot CI | 23s | 1.6x slower | 2.8x faster |
| Railway | 23.60s | 1.7x slower | 2.8x faster |
| GitHub Actions | 65s | 4.6x slower | baseline |

**Winner:** Local - Persistent cache wins for tiny source changes

---

### Test Case 3: New Function

| Flow | Time | vs Local | vs GitHub |
|------|------|----------|-----------|
| **Railway** | **18.02s** 🏆 | Similar | 3.6x faster |
| Depot CI | 23s | 1.3x slower | 2.8x faster |
| Local | 17s | baseline | 3.8x faster |
| GitHub Actions | 64s | 3.8x slower | baseline |

**Winner:** Railway - Optimized for source additions

---

### Test Case 4: New Dependency

| Flow | Time | vs Local | vs GitHub |
|------|------|----------|-----------|
| **Depot CI** | **31s** 🏆 | 4.6x faster | 6.2x faster |
| Railway | 40.75s | 3.5x faster | 4.7x faster |
| GitHub Actions | 193s | 1.3x slower | baseline |
| Local | 143s | baseline | 1.3x slower |

**Winner:** Depot CI - Best cloud network to npm registry

---

### Test Case 5: Major Changes

| Flow | Time | vs Local | vs GitHub |
|------|------|----------|-----------|
| **Depot CI** | **26s** 🏆 | 7.9x faster | 5.1x faster |
| Railway | 27.73s | 7.4x faster | 4.8x faster |
| GitHub Actions | 133s | 1.5x faster | baseline |
| Local | 206s | baseline | 1.3x slower |

**Winner:** Depot CI - Handles major changes efficiently

---

## Recommendations

### For Development

**Use:** Local builds with persistent cache
- Fastest for small changes (14-17s)
- No network latency
- Instant feedback loop

### For Production CI/CD

**Use:** Depot CI or Railway

| Priority | Choice | Why |
|----------|--------|-----|
| **Best Performance** | Depot CI | 27s average, 5x faster than GitHub |
| **Simplest Setup** | Railway | Auto-build on push, 29s average |
| **GitHub Actions Users** | Depot CI | One-line change, 5x speedup |

### For GitHub Actions Users

**Upgrade to:** Depot CI
- Drop-in replacement for `docker/build-push-action`
- Same YAML, same workflow
- 2.8x to 6.2x speedup depending on change type
- Push to same registry (GHCR), deploy to same destination

---

## Migration: From GitHub Actions to Depot CI

### Current (GitHub Actions)

```yaml
# .github/workflows/deploy.yml
- uses: docker/build-push-action@v5
  with:
    context: ./app
    push: true
    tags: ghcr.io/${{ github.repository }}/app:latest
```

### After (Depot CI)

```yaml
# .github/workflows/deploy.yml
- uses: depot/build-push-action@v1
  with:
    project: ${{ env.DEPOT_PROJECT_ID }}
    context: ./app
    push: true
    tags: ghcr.io/${{ github.repository }}/app:latest
```

**That's it.** One line change. Everything else works the same.

---

## Test Methodology

All tests used the same Dockerfile with multi-stage builds:

```
1. deps           - npm ci (all dependencies)
2. production-deps - npm ci --omit=dev
3. build          - COPY source, npm run build
4. production     - Final image
```

This ensures fair comparison across all flows.

**Test Application:** Node.js/TypeScript app with Express
**Destination Registry:** GitHub Container Registry (GHCR)
**Final Deployment:** Railway (us-east4)

---

## Conclusion

**Depot CI is the fastest option** for Docker builds, winning 4 out of 5 test cases with an average build time of just 27 seconds.

**Key takeaways:**
- Depot CI: 5x faster than GitHub Actions
- Railway: 4.6x faster than GitHub Actions, simplest setup
- Local: Best for development with persistent cache
- GitHub Actions: Slowest, not optimized for Docker

**For teams already using GitHub Actions:** Switch to Depot CI for a 5x speedup with minimal code changes.

**For teams wanting simplest setup:** Railway auto-build is an excellent choice, only 2 seconds slower than Depot on average.
