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

### OpenClaw Dockerfile Stages

```
Stage 1: ext-deps
  └── Extract extension dependencies

Stage 2: build
  ├── Install Bun (for build scripts)
  ├── COPY package.json, pnpm-lock.yaml ← Cache Layer 1
  ├── pnpm install --frozen-lockfile  ← Cache Layer 2 (CRITICAL)
  ├── COPY . . ← Cache Layer 3
  ├── pnpm build:docker ← TypeScript compilation
  └── pnpm ui:build ← UI bundling

Stage 3: runtime-assets
  ├── pnpm prune --prod
  └── Strip .d.ts, .map files

Stage 4: Runtime
  ├── Install system packages
  ├── Copy production artifacts
  └── Setup non-root user
```

### Cache Layer Analysis

| Layer | What Changes Affect It | Rebuild Time |
|-------|------------------------|--------------|
| **L1: package.json copy** | package.json, pnpm-lock.yaml changes | 30-60s (pnpm install) |
| **L2: pnpm install** | Dependency changes | 45-90s |
| **L3: Source copy** | Any file in src/, ui/, etc. | 10-30s |
| **L4: build:docker** | TypeScript source files | 60-120s |
| **L5: ui:build** | UI source files | 30-90s |

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

**Purpose:** Measure fully cached build performance

**What changes:** Nothing - clean baseline

**Docker layers affected:** None (all cached)

**Expected Cache:** ~100%

**Expected Times:**
- Depot CI: 1m 51s
- GitHub Actions: 3m 4s

**Why this tests:** Full cache hit scenario - best case for both systems

---

### Test 2: Documentation Change

**Purpose:** Measure performance with trivial documentation change

**What changes:** Add HTML comment to README.md

**Docker layers affected:**
- `COPY . .` layer only

**Expected Cache:** ~95%

**Code change:**
```markdown
<!-- Performance test: [timestamp] -->
```

**Expected Times:**
- Depot CI: 1m 50s
- GitHub Actions: 2m 39s

**Why this tests:** Minimal change - README doesn't affect build output, so most layers stay cached. Tests how efficiently each system handles "no-op" changes.

---

### Test 3: Source File Addition

**Purpose:** Measure performance with new TypeScript source file

**What changes:** Create `src/perf-test.ts` with utility functions

**Docker layers affected:**
- `COPY . .` layer
- `pnpm build:docker` step

**Expected Cache:** ~75%

**Code change:**
```typescript
// src/perf-test.ts
export interface PerfMetrics {
  startTime: number;
  endTime: number;
  duration: number;
}

export function measurePerf(label: string): PerfMetrics {
  const startTime = Date.now();
  const result = { startTime, endTime: startTime, duration: 0 };
  result.endTime = Date.now();
  result.duration = result.endTime - result.startTime;
  return result;
}
```

**Expected Times:**
- Depot CI: 1m 51s
- GitHub Actions: 2m 37s

**Why this tests:** Typical development change - adding new source code. Invalidates source cache but keeps dependency cache. Tests TypeScript compilation performance.

---

### Test 4: UI File Change

**Purpose:** Measure performance with UI component changes

**What changes:** Create new component in `ui/src/components/test/`

**Docker layers affected:**
- `COPY . .` layer
- `pnpm build:docker` step
- `pnpm ui:build` step

**Expected Cache:** ~50%

**Code change:**
```typescript
// ui/src/components/test/PerfTest.tsx
import { css } from 'lit';

export class PerfTestComponent extends HTMLElement {
  static styles = css`
    :host {
      display: block;
      padding: 1rem;
    }
  `;

  connectedCallback(): void {
    super.connectedCallback();
    this.innerHTML = '<p>Performance Test Component</p>';
  }
}
```

**Expected Times:**
- Depot CI: 1m 52s
- GitHub Actions: 2m 30s

**Why this tests:** Frontend development change - affects both main build and UI build. Tests bundling performance for UI assets.

---

### Test 5: New Dependency

**Purpose:** Measure performance with package.json change

**What changes:** Add `@types/node@^20.0.0` to devDependencies

**Docker layers affected:**
- `COPY package.json` layer
- Full `pnpm install` step
- All subsequent steps

**Expected Cache:** ~25%

**Code change:**
```bash
npm pkg set devDependencies.@types-node="^20.0.0"
```

**Expected Times:**
- Depot CI: 1m 53s
- GitHub Actions: 6m 3s

**Why this tests:** Dependency addition - common when adding new libraries. pnpm must fetch and install new package, but existing packages remain cached. Tests dependency resolution and download performance.

---

### Test 6: Major Changes

**Purpose:** Measure performance with significant changes across multiple areas

**What changes:**
- New dependency (@types/node)
- New source file (src/major-test.ts)
- New UI component (ui/src/components/major/)
- Documentation change (README.md)

**Docker layers affected:**
- All layers (near-full rebuild)

**Expected Cache:** ~10%

**Code changes:**
```bash
# Dependency
npm pkg set devDependencies.@types-node="^20.0.0"

# Source
cat > src/major-test.ts << 'EOF'
export function majorTest(): string {
  return "Major performance test";
}
EOF

# UI
mkdir -p ui/src/components/major
cat > ui/src/components/major/MajorTest.tsx << 'EOF'
export const MajorTest = () => 'Major Test';
EOF

# Docs
echo "<!-- Major test -->" >> README.md
```

**Expected Times:**
- Depot CI: 2m 36s
- GitHub Actions: 5m 25s

**Why this tests:** Worst-case scenario - full rebuild. Shows maximum performance difference between Depot CI and GitHub Actions.

---

## Test Case Comparison

| Test | Description | Layers Affected | Cache Hit | Depot CI | GitHub Actions | Speedup |
|------|-------------|-----------------|-----------|----------|----------------|---------|
| **1. Baseline** | Build without cache | None (cold) | ~0% | 1m 51s | 3m 4s | **1.7x** |
| **2. Docs** | README comment | COPY . . | ~95% | 1m 50s | 2m 39s | **1.4x** |
| **3. Source** | New TS file | COPY, build | ~75% | 1m 51s | 2m 37s | **1.4x** |
| **4. UI** | New component | COPY, build, UI | ~50% | 1m 52s | 2m 30s | **1.3x** |
| **5. Dependency** | New package | package, install, all | ~25% | 1m 53s | 6m 3s | **3.3x** |
| **6. Major** | All changes | All layers | ~10% | 2m 36s | 5m 25s | **2.1x** |

> **Average Speedup:** 1.9x faster (Depot CI: 1m 59s vs GitHub Actions: 3m 43s)

## Why Depot CI is Faster

### 1. Distributed Layer Caching

```
GitHub Actions:
├── Cache per workflow run
├── Limited to runner's local storage
└── Cold start on new runners

Depot CI:
├── Global cache shared across all builds
├── Pre-fetches layers in parallel
└── Persistent across runs
```

### 2. Optimized Infrastructure

| Resource | GitHub Actions | Depot CI |
|----------|----------------|----------|
| **CPU** | 2-core shared | 4-8 core dedicated |
| **Network** | Standard | Optimized for package downloads |
| **Storage** | EBS backed | SSD with optimized I/O |
| **Parallelism** | Limited per runner | Distributed build stages |

### 3. Smart Build Orchestration

```
OpenClaw build with Depot CI:
├── pnpm install (cached layers)      ← 20-30s (vs 45-90s)
├── TypeScript compilation            ← 30-45s (vs 60-120s)
├── UI bundling                       ← 20-30s (vs 30-60s)
└── Image assembly                    ← 10-15s (vs 15-30s)
```

## Setup Instructions

### 1. Clone This Repository

```bash
git clone https://github.com/YOUR_ORG/depot-railway-build.git
cd depot-railway-build
```

### 2. Configure GitHub Secrets

In your repository settings, add these secrets:

| Secret | Required | Value | How to Get |
|--------|----------|-------|------------|
| `DEPOT_PROJECT_ID` | ✅ Yes | Your Depot project ID | depot.dev/dashboard |
| `DEPOT_TOKEN` | ⚠️ Optional | Your Depot API token | depot.dev/settings/tokens |

> **Note:** `DEPOT_TOKEN` is optional when using OIDC authentication (recommended). Configure OIDC trust relationship in your Depot project settings.

### 3. Copy Workflows

```bash
# Copy workflows to active directory
cp .github/workflows-openclaw/*.yml .github/workflows/

# Commit and push
git add .github/workflows/
git commit -m "Enable OpenClaw performance workflows"
git push
```

### 4. Run Tests

#### Depot CI Build:
1. Go to **Actions** → **Depot CI - OpenClaw**
2. Click **Run workflow**
3. Select test case from dropdown:
   - `baseline` - No changes
   - `test-2-docs` - Documentation change
   - `test-3-source` - New source file
   - `test-4-ui` - New UI component
   - `test-5-dependency` - New dependency
   - `test-6-major` - Multiple changes
4. Click **Run workflow**
5. Wait for completion
6. Note total time from workflow run summary

#### GitHub Actions Baseline:
1. Go to **Actions** → **GitHub Actions Baseline - OpenClaw**
2. Click **Run workflow**
3. Select the same test case
4. Click **Run workflow**
5. Wait for completion
6. Note total time

## Recording Results

Use this template to record your results:

```
OpenClaw Performance Test Results
==================================

Test 1 - Baseline (100% cache):
  GitHub Actions: ___ minutes ___ seconds
  Depot CI:       ___ minutes ___ seconds
  Speedup:        ___x

Test 2 - Documentation (~95% cache):
  GitHub Actions: ___ minutes ___ seconds
  Depot CI:       ___ minutes ___ seconds
  Speedup:        ___x

Test 3 - Source File (~75% cache):
  GitHub Actions: ___ minutes ___ seconds
  Depot CI:       ___ minutes ___ seconds
  Speedup:        ___x

Test 4 - UI Change (~50% cache):
  GitHub Actions: ___ minutes ___ seconds
  Depot CI:       ___ minutes ___ seconds
  Speedup:        ___x

Test 5 - New Dependency (~25% cache):
  GitHub Actions: ___ minutes ___ seconds
  Depot CI:       ___ minutes ___ seconds
  Speedup:        ___x

Test 6 - Major Changes (~10% cache):
  GitHub Actions: ___ minutes ___ seconds
  Depot CI:       ___ minutes ___ seconds
  Speedup:        ___x

─────────────────────────────────────
Average Speedup: ___x
```

## Key Differences from Sample App

| Aspect | Sample App | Real OpenClaw |
|--------|-----------|---------------|
| Dependencies | ~50 packages | 500+ packages |
| pnpm-lock.yaml | ~300 lines | 13,301 lines |
| Build Time | 20-60 seconds | 2-20 minutes |
| Cache Impact | Moderate | **Significant** |
| Build Stages | 3 stages | 4+ stages |
| UI Build | None | Separate ui:build step |
| Test Relevance | Educational | Production-accurate |

## Troubleshooting

### Workflow fails with "project not found"
- Verify `DEPOT_PROJECT_ID` is correct in secrets
- Check project exists in your Depot dashboard
- Ensure you have permissions to access it

### Workflow fails with "authentication failed"
- Verify `DEPOT_TOKEN` is valid and not expired
- Regenerate token if needed
- Check secret names match exactly (case-sensitive)

### First run is slow
- First builds are always slower (cache warming)
- Run baseline test twice for accurate results
- Subsequent runs show full caching benefit

### pnpm install fails
- OpenClaw uses pnpm 9.x - workflow handles this
- Check pnpm-lock.yaml is intact
- Verify network connectivity for package downloads

### UI build fails
- OpenClaw's UI build uses Lit and Web Components
- May fail under QEMU cross-compilation (non-fatal)
- Workflow creates stub in this case

### Out of memory during build
- OpenClaw build is resource-intensive
- GitHub Actions runners may be constrained
- Depot CI has more resources available

## Next Steps

1. **Run all 6 test cases** for both workflows
2. **Record actual times** from workflow logs
3. **Calculate speedup** for each test case
4. **Create comparison chart** for presentation
5. **Document findings** in comparison-summary.md

## References

- [OpenClaw Repository](https://github.com/openclaw/openclaw)
- [OpenClaw Documentation](https://docs.openclaw.ai)
- [Depot Documentation](https://depot.dev/docs)
- [Depot CI Overview](./depot-summary.md)
- [Quick Start Guide](./openclaw-quick-start.md)

---

**Note:** OpenClaw is a production-grade application with a complex build pipeline. Performance results will vary based on:
- Geographic location
- Time of day (CI load)
- Network conditions
- Cache state

For consistent results, run each test case 2-3 times and use the average.
