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

| Metric | Value |
|--------|-------|
| **Total Build Time** | **29.06 seconds** |
| **Health Check** | Passed (1/1) |
| **Status** | ✅ Success |

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

## Comparison

| Flow | Build Time | Speedup |
|------|------------|---------|
| **Local Docker** | 2:09 (129s) | - |
| **Railway Auto-Build** | 0:29 (29s) | **4.4x faster** |
| **GitHub Actions** | TBD | - |
| **Depot CI** | TBD | - |

---

## Key Observations

1. **Railway is significantly faster** than local build (4.4x)
   - Railway has better network bandwidth to npm registry
   - Cached base images in Railway infrastructure
   - Optimized build servers

2. **TypeScript compilation is fast** (~1s vs 5s local)
   - Railway's build CPUs may be faster than local WSL2
   - Or the local measurement included overhead

3. **Health check passed immediately**
   - Service started successfully
   - `/health` endpoint responding

---

## Next Steps

1. [ ] Test Flow 3: GitHub Actions → Railway
2. [ ] Test Flow 4: Depot CI → Railway
3. [ ] Compare all 4 flows side-by-side
4. [ ] Create visual comparison chart
