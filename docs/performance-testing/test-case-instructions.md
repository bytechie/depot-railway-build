# OpenClaw Docker Build Performance Test Cases

Instructions for running performance test cases to compare GitHub Actions vs Depot CI build processes using the real OpenClaw application.

---

## Test Subject

All test cases build the **real OpenClaw** application (`openclaw/openclaw` on `main`), a production-grade personal AI assistant with a complex multi-stage Docker build (~500+ dependencies, pnpm + Bun build system, 50+ source directories).

---

## Test Case Overview

| # | Name | Mutation | Expected Cache | Invalidated Layers |
|---|------|----------|---------------|-------------------|
| 1 | `baseline` | No changes | ~100% | None |
| 2 | `test-2-docs` | HTML comment in README | ~95% | `COPY . .` only |
| 3 | `test-3-source` | New file in `src/` | ~75% | `COPY . .` + build |
| 4 | `test-4-ui` | New file in `ui/` | ~50% | `COPY . .` + UI build stages |
| 5 | `test-5-dependency` | New npm dependency | ~25% | `package.json` layer + full install |
| 6 | `test-6-major` | Multiple changes combined | ~10% | All layers |

---

## Test Case Details

### Test 1: Baseline

**Purpose:** Measure fully cached build performance with zero changes.

**What happens:** No files are modified. The OpenClaw source is checked out and built as-is.

**What it tests:** How fast each CI system rebuilds when all Docker layers are cached. This is the best-case scenario and reveals the CI system's raw orchestration overhead (runner startup, cache lookup, build scheduling).

**Docker cache impact:** All layers should be cache hits. Any time spent is purely CI overhead.

---

### Test 2: Documentation Change (`test-2-docs`)

**Purpose:** Measure build performance with a trivial, non-functional change.

**What happens:** Appends an HTML comment to `README.md`:
```html
<!-- Performance test: Thu Apr  4 12:34:56 UTC 2026 -->
```

**What it tests:** The smallest possible cache invalidation. Only the final `COPY . .` Docker layer is invalidated (since README content changed). All previous layers — base image, system packages, dependency installation, compilation — remain cached.

**Docker cache impact:** ~95% cache hit. Only the final copy layer and any layers after it are rebuilt. Build should complete in seconds since no recompilation occurs.

**Real-world equivalent:** Updating documentation, changelog entries, or inline comments.

---

### Test 3: Source File Addition (`test-3-source`)

**Purpose:** Measure build performance when a new source file is added.

**What happens:** Creates a new TypeScript file `src/perf-test.ts` with a simple performance measurement utility (interface + function).

**What it tests:** Adding source code changes the content hash of the `COPY . .` layer, which invalidates it and all subsequent layers including the TypeScript compilation step. However, dependency installation layers remain cached since `package.json` is unchanged.

**Docker cache impact:** ~75% cache hit. Dependency layers are cached, but source copy and build layers are rebuilt.

**Real-world equivalent:** Adding a new module, utility, or feature file to the project.

---

### Test 4: UI File Addition (`test-4-ui`)

**Purpose:** Measure build performance when a UI component is added.

**What happens:** Creates a new Lit component at `ui/src/components/test/PerfTest.tsx` using `LitElement` with CSS styles and a render method.

**What it tests:** Adding files to the `ui/` directory invalidates the `COPY . .` layer and triggers rebuild of the UI build stages (`pnpm ui:build`). This is more expensive than test-3 because UI builds typically involve bundling, transpilation, and asset optimization.

**Docker cache impact:** ~50% cache hit. Dependency and early build layers are cached, but source copy, UI build, and final layers are rebuilt.

**Real-world equivalent:** Adding a new frontend component, page, or UI feature.

---

### Test 5: New Dependency (`test-5-dependency`)

**Purpose:** Measure build performance when a new npm package is added.

**What happens:** Adds `perf-test-benchmark@^1.0.0` to `devDependencies` in `package.json` using `npm pkg set`.

**What it tests:** Changing `package.json` invalidates one of the earliest Docker layers (`COPY package.json`), which cascades to invalidate the `pnpm install` layer. This forces a full dependency reinstallation — the most expensive single-layer invalidation since OpenClaw has 500+ dependencies.

**Docker cache impact:** ~25% cache hit. Only base image and system package layers remain cached. Dependency installation, build, UI build, and all subsequent layers are rebuilt.

**Real-world equivalent:** Adding a new npm/pnpm package to the project (the most common reason for slow CI builds).

---

### Test 6: Major Changes (`test-6-major`)

**Purpose:** Measure build performance with multiple simultaneous changes.

**What happens:** Applies all three types of changes at once:
1. Adds `perf-test-benchmark@^1.0.0` to `devDependencies`
2. Creates a new source file `src/major-test.ts`
3. Creates a new UI file `ui/src/components/major/MajorTest.tsx`
4. Appends an HTML comment to `README.md`

**What it tests:** The worst-case scenario for incremental builds. Multiple file types across different directories change, invalidating nearly all cacheable layers. This simulates a large feature branch with changes across the entire codebase.

**Docker cache impact:** ~10% cache hit. Only base image and system package layers survive. Nearly the entire build must run from scratch.

**Real-world equivalent:** A large feature branch with dependency additions, new modules, UI changes, and documentation updates merged together.

---

## How to Run

### Local Testing

Run test cases locally against a clone of the OpenClaw repository.

**Prerequisites:**
- Docker installed and running
- Git
- The OpenClaw repo cloned locally

**Setup:**

```bash
# Clone OpenClaw (if not already cloned)
git clone https://github.com/openclaw/openclaw.git ~/openclaw
cd ~/openclaw
```

**Run a single test case:**

```bash
# 1. Reset to clean state
cd ~/openclaw
git reset --hard HEAD
git clean -fd

# 2. Apply a test case using the shared script
/path/to/depot-railway-build/scripts/apply-openclaw-test-case.sh baseline

# 3. Build and time it
time docker build -t openclaw:test-baseline .

# 4. Record the time, then clean up
docker rmi openclaw:test-baseline
```

**Run all test cases sequentially:**

```bash
# Automated script (runs all 6 cases with timing)
cd /path/to/depot-railway-build
./scripts/run-openclaw-local-tests.sh
```

This script:
- Clones/resets OpenClaw to a clean state before each test
- Applies each test case mutation
- Runs `docker build` and records timing
- Saves logs to `docs/performance-testing/openclaw-ai-testing/run3-local-openclaw-ai-testing-20260404/`
- Generates a summary in `summary.md`

**Run a specific test case locally:**

```bash
cd ~/openclaw
git reset --hard HEAD && git clean -fd

# Apply the test case (pick one)
/path/to/depot-railway-build/scripts/apply-openclaw-test-case.sh test-5-dependency

# Build
time docker build -t openclaw:test .

# Record the "real" time from the output
```

### GitHub Actions Baseline

1. Go to the repository on GitHub
2. Navigate to **Actions** → **GitHub Actions Baseline - OpenClaw Performance Test**
3. Click **Run workflow**
4. Select a test case from the dropdown
5. Click **Run workflow** to start
6. Look for `Build Timing: Xs` in the logs

### Depot CI (after migration)

1. Go to the Depot dashboard
2. Navigate to the CI page
3. Trigger the workflow with the desired test case
4. Or use CLI: `depot ci run --workflow .depot/workflows/github-actions-baseline-openclaw.yml`
5. Look for `Build Timing: Xs` in the logs

---

## Recommended Run Order

For a valid comparison, run test cases in this order:

1. **Clear all caches** — `gh cache delete --all`
2. **Run `baseline` first** — This populates the Docker layer cache from scratch (cold build)
3. **Run tests 2–6 in order** — Each subsequent test measures cache retention as changes increase

This ensures both platforms start from the same cache state.

---

## Timing Results

Each workflow records build timing automatically. Look for this output in the logs:

```
==========================================
Build Timing: 42s
Test Case: test-3-source
Description: New source file - perf-test.ts in src/
Expected Cache: 75%
==========================================
```

### Results Template

| Test Case | GitHub Actions | Depot CI | Speedup |
|-----------|---------------|----------|---------|
| `baseline` | ___s | ___s | __x |
| `test-2-docs` | ___s | ___s | __x |
| `test-3-source` | ___s | ___s | __x |
| `test-4-ui` | ___s | ___s | __x |
| `test-5-dependency` | ___s | ___s | __x |
| `test-6-major` | ___s | ___s | __x |

---

## Tips

1. **Clear caches before each full test cycle** — ensures consistent starting state
2. **Run each test case once per cycle** — avoid running the same test twice, which would show artificially better cache hits
3. **Record exact times** — use the `Build Timing: Xs` output from the logs
4. **Compare across platforms** — the same test case on GitHub Actions vs Depot CI shows the true performance difference
5. **Note the cache backend** — GitHub Actions uses GHA cache (`type=gha`), Depot CI uses its own remote cache
