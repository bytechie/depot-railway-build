# Local Docker Build Results

Baseline local build performance for the OpenClaw Demo sample app.

---

## Test Environment

| Setting | Value |
|---------|-------|
| **Platform** | WSL2 on Windows |
| **Date** | 2026-03-30 |
| **Docker** | Docker Desktop (default instance) |
| **Base Image** | node:18-alpine |
| **Build Command** | `docker build -t openclaw-demo:test .` |

---

## Build Times (Local)

### Clean Build (No Cache)

| Stage | Duration | Description |
|-------|----------|-------------|
| `deps` | ~164s | All dependencies (312 packages including devDependencies) |
| `production-deps` | ~157s | Production only (302 packages) |
| `build` | ~5s | TypeScript compilation (`tsc`) |
| `production` | ~2s | User creation, permissions |
| `export` | ~14s | Image assembly and export |

**Total Wall-Clock Time:** ~183 seconds (3:03)

> **Note:** `deps` and `production-deps` stages run in parallel, so the total time is not additive.

### Cached Build (No Changes) ⚡

> **IMPORTANT:** This cached build was run **immediately after the clean build with no code changes**. This represents the **best-case scenario** for Docker layer caching — when absolutely nothing has changed in the source code, package.json, or Dockerfile.

| Build Type | Time | Speedup |
|------------|------|---------|
| Clean (no cache) | 3:03 (183s) | baseline |
| **Cached (no changes)** | **0:01 (1.3s)** | **140x faster** |

**All stages were cached** — Docker reused all existing layers without rebuilding anything.

> **Why this matters:** In real CI/CD scenarios, most builds will have at least some changes (code, dependencies, or Dockerfile). This cached result shows the theoretical maximum caching benefit. Actual cached builds with changes will be slower as only unchanged layers are cached.

---

## Stage Details

### deps Stage
```dockerfile
FROM node:18-alpine AS base
WORKDIR /app
COPY package.json package-lock.json ./
RUN npm ci && npm cache clean --force
```
- **Purpose:** Install all dependencies including `@types/express` for TypeScript compilation
- **Packages:** 313 total (includes TypeScript, @types/*)
- **Time:** 115.2s

### production-deps Stage
```dockerfile
FROM base AS production-deps
COPY package.json package-lock.json ./
RUN npm ci --omit=dev && npm cache clean --force
```
- **Purpose:** Install only production dependencies for final image
- **Packages:** 303 total
- **Time:** 112.7s
- **Runs in parallel:** Yes, with `deps` stage

### build Stage
```dockerfile
FROM base AS build
COPY --from=deps /app/node_modules ./node_modules
COPY . .
RUN npm run build
```
- **Purpose:** Compile TypeScript to JavaScript
- **Command:** `tsc`
- **Time:** 5.2s
- **Output:** `dist/index.js` and declaration files

### production Stage
```dockerfile
FROM base AS production
ENV NODE_ENV=production
COPY --from=build /app/dist ./dist
COPY --from=production-deps /app/node_modules ./node_modules
COPY package.json ./
```
- **Purpose:** Final minimal production image
- **Time:** ~2s (user creation) + 9s (export)
- **Image Size:** TBD

---

## Key Observations

1. **npm ci dominates build time** - The dependency installation accounts for ~90% of total build time
2. **Parallel stages help** - Running `deps` and `production-deps` simultaneously saves ~113 seconds
3. **TypeScript is fast** - Compilation takes only 5 seconds once dependencies are installed
4. **Layer caching is critical** - With no changes, cached builds are 140x faster (1.3s vs 183s)
5. **Railway beats local** - Railway (29s) is 6.3x faster than local clean build (183s) due to better infrastructure

---

## Comparison: All Flows

| Flow | Build Time | vs Local Clean |
|------|------------|----------------|
| **Local Clean** | 3:03 (183s) | baseline |
| **Local Cached (no changes)** | 0:01 (1.3s) | 140x faster |
| **Railway Auto-Build** | 0:29 (29s) | 6.3x faster |
| **GitHub Actions** | TBD | - |
| **Depot CI** | TBD | - |

> **See also:** [railway-build-results.md](./railway-build-results.md) for detailed Railway build analysis.

---

## Re-running This Test

```bash
cd sample-app
```

Cached build (no changes):
```bash
docker build -t openclaw-demo:test .
```

Clean build (no cache):
```bash
docker build --no-cache -t openclaw-demo:test .
```

---

## Next Steps

1. [x] Push changes to trigger Railway build
2. [x] Run Flow 2 (Railway auto-build) and record time → **29s**
3. [ ] Run Flow 3 (GitHub Actions) and record time
4. [ ] Run Flow 4 (Depot CI) and record time
5. [ ] Update this document with all flow results
