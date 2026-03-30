# Railway Build Results

Flow 2: Railway Auto-Build performance results.

---

## Test Environment

| Setting | Value |
|---------|-------|
| **Platform** | Railway (us-east4) |
| **Date** | 2026-03-30 |
| **Build Type** | Dockerfile (auto-build on push) |
| **Trigger** | Git push to main branch |

---

## Build Time Summary

### Initial Build (Cold)

| Metric | Value |
|--------|-------|
| **Total Build Time** | **29.06 seconds** |
| **Health Check** | Passed (1/1) |
| **Status** | ✅ Success |

### Rebuild (Cached) ⚡

> **Test:** Rebuild triggered with no code changes to measure Railway's layer caching.

| Metric | Value |
|--------|-------|
| **Total Build Time** | **3.81 seconds** |
| **Health Check** | Passed (1/1) |
| **Status** | ✅ Success |
| **Speedup vs Initial** | **7.6x faster** |

**All layers were cached** — Railway reused all previously built layers.

---

## Stage Breakdown

| Stage | Duration | Details |
|-------|----------|---------|
| **Image Pull** | ~2s | `node:18-alpine` base image |
| **deps** (npm ci) | ~11s | 312 packages (all dependencies) |
| **production-deps** (npm ci) | ~11s | 302 packages (prod only) |
| **build** (tsc) | ~1s | TypeScript compilation |
| **production** | <1s | Copy layers, create user |
| **Push to registry** | ~5s | Upload to Railway registry |

> **Note:** `deps` and `production-deps` ran in parallel.

---

## Log Analysis

### Build Start
```
2026-03-30T11:50:26.039089987Z Using Detected Dockerfile
2026-03-30T11:50:27.207854381Z [Region: us-east4]
```

### Dependency Installation
```
2026-03-30T11:50:29.419029050Z [deps 2/2] RUN npm ci && npm cache clean --force
...
2026-03-30T11:50:40.493039709Z added 312 packages, and audited 313 packages in 11s

2026-03-30T11:50:29.418998311Z [production-deps 2/2] RUN npm ci --omit=dev
...
2026-03-30T11:50:40.637941732Z added 302 packages, and audited 303 packages in 11s
```

### TypeScript Build
```
2026-03-30T11:50:43.925766943Z [build 3/3] RUN npm run build
> openclaw-demo@1.0.0 build
> tsc
2026-03-30T11:50:45.644138478Z [build 3/3] RUN npm run build
```

### Build Complete
```
2026-03-30T11:50:56.271201688Z Build time: 29.06 seconds
```

### Health Check
```
2026-03-30T11:51:01.129675194Z Path: /health
2026-03-30T11:51:01.330854584Z [1/1] Healthcheck succeeded!
```

---

## Rebuild Analysis (Cached)

### Build Start
```
2026-03-30T12:29:55.018383612Z Using Detected Dockerfile
2026-03-30T12:29:55.011256450Z [Region: us-east4]
```

### Build Complete (All Cached)
```
2026-03-30T12:29:58.831370741Z Build time: 3.81 seconds
```

### Health Check
```
2026-03-30T12:30:09.591148984Z [1/1] Healthcheck succeeded!
```

---

## Comparison

| Flow | Build Time | Speedup |
|------|------------|---------|
| **Local Clean** | 3:03 (183s) | baseline |
| **Local Cached (no changes)** | 0:01 (1.3s) | 140x faster |
| **Local Cached (code change)** | 0:17 (17s) | 10.8x faster |
| **Railway Initial Build** | 0:29 (29s) | 6.3x faster |
| **Railway Rebuild (cached)** | **0:04 (3.8s)** | **48x faster** |
| **GitHub Actions** | TBD | - |
| **Depot CI** | TBD | - |

---

## Key Observations

1. **Railway is significantly faster** than local build (6.3x for clean build)
   - Railway has better network bandwidth to npm registry
   - Cached base images in Railway infrastructure
   - Optimized build servers

2. **Railway caching is excellent** — Rebuild with cache took only 3.81s
   - 48x faster than local clean build
   - 7.6x faster than Railway's own initial build
   - All layers cached and reused

3. **TypeScript compilation is fast** (~1s vs 5s local)
   - Railway's build CPUs may be faster than local WSL2
   - Or the local measurement included overhead

4. **Health check passed immediately**
   - Service started successfully
   - `/health` endpoint responding

---

## Next Steps

1. [ ] Test Flow 3: GitHub Actions → Railway
2. [ ] Test Flow 4: Depot CI → Railway
3. [ ] Compare all 4 flows side-by-side
4. [ ] Create visual comparison chart
