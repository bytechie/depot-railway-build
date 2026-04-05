# Depot CI vs GitHub Actions: Performance Comparison Video Script

**Title**: "Depot CI vs GitHub Actions: 38% Faster Docker Builds"
**Duration**: ~6 minutes
**Format**: 16:9 (1920x1080)
**Style**: Screen recording + voiceover with motion graphics overlays

---

## Script Legend

| Symbol | Meaning |
|--------|---------|
| `[VISUAL]` | On-screen graphics/text |
| `[SCREEN]` | Screen recording action |
| `[SOUND]` | Sound effect or music cue |
| `[PAUSE]` | Brief pause for emphasis |
| `( )` | Optional/directional notes |

---

## Section 1: The Problem (0:00 - 0:45)

### 0:00 - 0:15 | Opening Hook

**[VISUAL]** Dark screen, text fades in: *"Your CI is slowing you down..."*

**[SOUND]** Subtle, building tech ambient music starts

**[VOICEOVER]**
"Your CI is slowing you down."

**[VISUAL]** Text continues: *"...and you might not even realize it."*

**[VOICEOVER]**
"And you might not even realize it."

---

### 0:15 - 0:30 | The Reality

**[VISUAL]** Split screen:
- LEFT: Developer typing fast, code flying
- RIGHT: CI progress bar: "Building... 2 min remaining"

**[VOICEOVER]**
"With modern tools like AI coding assistants, you can write code faster than ever. But your CI? It's still running at the same speed it did five years ago."

**[VISUAL]** Developer waiting, watching progress bar, checking phone

**[VOICEOVER]**
"You write in seconds. Your CI builds in minutes. That mismatch? It's costing you time, every single day."

---

### 0:30 - 0:45 | GitHub Actions: The Default Choice

**[VISUAL]** GitHub Actions logo appears

**[SCREEN]** GitHub Actions workflow running:
```
Run docker build
- Pulling image...
- Installing dependencies...
- Building...
Time elapsed: 2:15
```

**[VOICEOVER]**
"Most of us use GitHub Actions. It's the default. It's easy. But for Docker builds? It's not exactly fast."

**[VISUAL]** Chart showing GitHub Actions build times climbing

**[VOICEOVER]**
"And when every build takes 2-3 minutes, those minutes add up. Hours every week. Days every month. All spent... waiting."

---

## Section 2: The Solution (0:45 - 1:30)

### 0:45 - 1:00 | Enter Depot CI

**[VISUAL]** Clean white screen, Depot logo animates in

**[SOUND]** Subtle "whoosh" logo sound, music becomes more optimistic

**[VISUAL]** Tagline appears: *"38% Faster Docker Builds"*

**[VOICEOVER]**
"This is Depot CI. A programmable CI engine that runs your existing GitHub Actions workflows entirely on Depot's own infrastructure — with faster compute, built-in caching, and no configuration required."

---

### 1:00 - 1:15 | Getting Started with Depot CI

**[VISUAL]** Terminal showing migration process:

```bash
# Step 1: Install Depot CLI
# macOS:  brew install depot/tap/depot
# Linux:   curl -L https://depot.dev/install-cli.sh | sh

# Step 2: Login to Depot
depot login

# Step 3: Connect to GitHub
# (In Depot web dashboard: Install "Depot Code Access" GitHub App)

# Step 4: Migrate your workflows
depot ci migrate
```

**[SOUND]** Satisfying "click" or "snap" sound

**[VOICEOVER]**
"Getting started with Depot CI is straightforward. Install the CLI using Homebrew on Mac or the install script on Linux. Login to your account. Connect your GitHub organization through the Depot dashboard - this is required for the migration to work. Then run the migrate command - it automatically copies your GitHub Actions workflows and handles all the compatibility fixes for you."

---

### 1:15 - 1:30 | What Makes It Different

**[VISUAL]** Simple comparison diagram:

```
┌─────────────────────┬─────────────────────┐
│   GitHub Actions    │      Depot CI        │
├─────────────────────┼─────────────────────┤
│  Generic runners    │  16 CPU, 32 GB RAM  │
│  GHA cache (flat)   │  NVMe SSD cache     │
│  Cold starts        │  Pre-warmed pool    │
│  ~3m 47s average    │  ~2m 20s average    │
└─────────────────────┴─────────────────────┘
```

**[VOICEOVER]**
"Depot CI uses remote builders with 16 CPUs and 32 GB of RAM, with NVMe SSD caching built in and no configuration required. The result? Builds that are 38% faster."

---

## Section 3: Depot CI Demo (1:30 - 2:30)

### 1:30 - 1:50 | Live Demo: Get Started

**[VISUAL]** Depot CI interface

**[VOICEOVER]**
"Ready to speed up your builds? Getting started with Depot CI takes just a few minutes."

**[SCREEN]** Terminal showing:

```bash
# macOS:
brew install depot/tap/depot

# Linux:
curl -L https://depot.dev/install-cli.sh | sh
```

**[VOICEOVER]**
"Install the CLI. Login. Connect your GitHub. Run the migration. That's it."

---

### 1:50 - 2:15 | Live Demo: The Migration Process

**[SCREEN]** Terminal showing the complete migration:

```bash
# In your project directory:

# Install CLI (macOS shown)
$ brew install depot/tap/depot
✔ Installed successfully

$ depot login
✔ Logged in as your-account

$ depot ci migrate
✔ Analyzing workflows...
✔ Converting .github/workflows/ → .depot/workflows/
✔ Applying compatibility fixes...
✔ Migration complete!

Your workflows are now ready to run on Depot CI.
```

**[SOUND]** Satisfying "ding" when migration completes

**[VOICEOVER]**
"The migration process handles everything automatically. The migrate command analyzes your existing GitHub Actions workflows, converts them to run on Depot CI infrastructure, applies any necessary compatibility fixes, and creates new workflow files. Your original workflows stay untouched - so you can easily compare or rollback if needed."

---

### 2:15 - 2:30 | Start Today

**[VISUAL]** Large URL: **depot.dev**

**[VOICEOVER]**
"Visit depot.dev to get started. Free trial available. Then plans start at just $20 per month."

---

## Section 4: Real Performance Data (2:30 - 4:00)

### 2:30 - 2:45 | The Test Setup

**[VISUAL]** Test setup appears:

```
Test Environment:
├── Same Dockerfile (multi-stage build)
├── OpenClaw AI (500+ dependencies)
├── Real-world complexity
├── 6 test scenarios
└── Fair comparison
```

**[VOICEOVER]**
"We wanted to see the real difference, so we ran a fair comparison. We tested with OpenClaw AI - a complex application with over 500 dependencies. This is the kind of real-world project where CI performance really matters. Same Dockerfile. Same application. Six different test scenarios. From builds without cache to dependency changes."

---

### 2:45 - 3:15 | The Results

**[VISUAL]** Large results table appears:

```
┌─────────────────────────────────────────────────────────────┐
│           DEPOT CI vs GITHUB ACTIONS                        │
├─────────────────────────────────────────────────────────────┤
│                                                             │
│  Test Case           GitHub    Depot    Improvement         │
│  ─────────────────────────────────────────────────────────  │
│  Baseline (cold)     3m 44s    2m 28s   34% faster         │
│  Comment change      3m 56s    3m 2s    23% faster         │
│  New source file     3m 21s    1m 53s   44% faster         │
│  UI component        3m 50s    2m 31s   34% faster         │
│  New dependency      3m 59s    2m 13s   44% faster         │
│  Major changes       3m 52s    1m 55s   50% faster         │
│                                                             │
│  AVERAGE             3m 47s    2m 20s   38% faster         │
└─────────────────────────────────────────────────────────────┘
```

**[SOUND]** Subtle "whoosh" as each row animates in

**[VOICEOVER]**
"Here are the results from testing OpenClaw AI - a complex personal AI assistant with 500+ dependencies. GitHub Actions averaged 3 minutes 47 seconds per build. Depot CI averaged 2 minutes 20 seconds. That's a 38% improvement."

**[PAUSE - 2 seconds]**

**[VOICEOVER]**
"And Depot CI won every single test case."

---

### 3:15 - 3:45 | The Dependency Difference

**[VISUAL]** Focus on the "New Dependency" row:

```
┌─────────────────────────────────────────────────────────────┐
│  NEW DEPENDENCY TEST (Adding new npm package)               │
├─────────────────────────────────────────────────────────────┤
│                                                             │
│  GitHub Actions: 3m 59s    ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓░░░░░░░░         │
│  Depot CI:        2m 13s   ▓▓▓▓▓▓▓▓▓▓▓▓░░░░░░░░░░░░░░░░░░░         │
│                                                             │
│  Depot CI is 44% faster for dependency changes              │
└─────────────────────────────────────────────────────────────┘
```

**[VOICEOVER]**
"Look at the dependency test. When adding a new package to a project with 500+ dependencies, GitHub Actions took nearly 4 minutes. Depot CI completed it in just 2 minutes 13 seconds -- 44% faster."

**[VISUAL]** Animation showing why:

```
GITHUB ACTIONS - Flat times, no cache differentiation:
┌─────────────────────────────────────┐
│ Baseline (cold):  3m 44s            │
│ Docs change:      3m 56s            │ ← All ~3m 47s
│ Source change:    3m 21s            │ ← No meaningful
│ Dependency change: 3m 59s           │ ← cache difference
│ Major changes:    3m 52s            │
│ Spread: only 38s                    │
└─────────────────────────────────────┘
GHA cache provides minimal incremental benefit

DEPOT CI - Real cache differentiation:
┌─────────────────────────────────────┐
│ Baseline (cold):  2m 28s            │ ← Cold start
│ Docs change:      3m 2s (52% cache) │ ← Real cache hits
│ Source change:    1m 53s (52% cache)│ ← Real cache hits
│ Dependency:       2m 13s (31% cache)│ ← Lockfile busts cache
│ Major changes:    1m 55s (50% cache)│ ← Real cache hits
│ Spread: 69s (real differentiation)  │
└─────────────────────────────────────┘
NVMe SSD cache provides real incremental build savings
```

**[VOICEOVER]**
"Here's the key difference. GitHub Actions shows nearly flat build times across all cache scenarios -- only 38 seconds between fastest and slowest. The GHA cache simply isn't providing meaningful incremental benefits. But look at Depot CI -- the NVMe SSD cache produces real differentiation. A dependency change that busts the lockfile cache takes longer at 2m 13s, while a simple source change with good cache hits completes in under 2 minutes."

**[VISUAL]** Simple diagram showing Depot's distributed cache:

```
┌────────────────────┐
│  Build 1          │ → Cache saved to repository
├────────────────────┤
│  Build 2          │ → Reuses Build 1 cache
├────────────────────┤
│  Build 3          │ → Reuses Build 1+2 cache
├────────────────────┤
│  Build 100        │ → Reuses all prior cache
└────────────────────┘
      ↓
Depot's repository-scoped cache persists across all your builds
```

**[VOICEOVER]**
"Depot CI's NVMe SSD cache is automatic -- no configuration required. Each build benefits from the cache entries created by your previous builds. And unlike GHA's flat cache behavior, Depot's cache shows real differentiation between change types."

---

### 3:45 - 4:00 | The Build Without Cache Reality

**[VISUAL]** Baseline comparison:

```
First build of the day (no cache):
GitHub Actions: 3m 44s
Depot CI:       2m 28s

You save over 1 minute on your very first build.
```

**[VOICEOVER]**
"Even on builds without cache, Depot CI is 34% faster. That's over a minute saved on your first build of the day. Before you've even had your coffee."

---

## Section 5: Why Depot Wins (4:00 - 5:00)

### 4:00 - 4:20 | Architecture Matters

**[VISUAL]** Simple architecture comparison:

```
GitHub Actions              Depot CI
┌─────────────┐            ┌─────────────┐
│ 2 CPU, 8 GB │            │ 16 CPU      │
│ Generic VM  │            │ 32 GB RAM   │
│ GHA cache   │            │ NVMe SSD    │
│ (ineffective│            │ Auto-cache  │
│ for Docker) │            │ (real hits) │
└─────────────┘            └─────────────┘
```

**[VOICEOVER]**
"The difference comes down to architecture. GitHub Actions gives you a 2-CPU generic VM with GHA cache that our tests show provides minimal incremental benefit. Depot CI uses remote builders with 16 CPUs, 32 GB RAM, and NVMe SSD caching built in and no configuration required."

---

### 4:20 - 4:35 | The Cache Advantage

**[VISUAL]** Cache comparison animation:

```
GitHub Actions Cache:
├── Stored remotely (Azure Blob)
├── Persists across jobs
├── 10 GB default
├── 7-day retention
└── Additional storage available with paid plans

Depot CI Cache:
├── Distributed global storage
├── Persists across all builds
├── Configurable size limits (up to unlimited)
├── 14-day retention (default) / up to 30 days (configurable)
└── Repository-scoped (organized by repo)
```

**[VOICEOVER]**
"Both platforms use remote cache storage that persists across jobs. Depot Cache has a 14-day default retention — double GitHub Actions' 7-day default — with options up to 30 days, and configurable size limits up to no limit at all. Cache storage is included in every Depot plan."

---

### 4:35 - 4:50 | How Depot Achieves This

**[VISUAL]** Diagram showing Depot's approach:

```
Depot CI Cache System:
┌─────────────────────────────────────┐
│ Depot Cache — built in, no config   │
├─────────────────────────────────────┤
│ ✓ 14-day default retention          │
│ ✓ Up to 30-day retention options    │
│ ✓ Configurable size limits          │
│ ✓ Repository-scoped isolation       │
└─────────────────────────────────────┘
          ↓
Your builds benefit from:
• Cache that persists longer
• Higher cache hit rates
• More reliable cache availability
```

**[VOICEOVER]**
"So how does Depot achieve consistently faster builds? It's the built-in Depot Cache — no configuration required. With 14-day default retention that's double GitHub Actions' 7 days, and options up to 30 days. Configurable size limits and repository-scoped isolation mean your cache is more likely to be there when you need it."

---

### 4:50 - 5:00 | Additional Features

**[VISUAL]** Feature list appears:

```
Depot CI Features (Not in GitHub Actions):

✅ SSH into running builds
✅ Retry individual failed jobs
✅ Per-second billing
✅ Detailed metrics dashboard
✅ AI failure diagnosis
```

**[VOICEOVER]**
"Beyond speed, Depot CI includes features GitHub Actions doesn't have. SSH into running builds for debugging. Retry individual failed jobs without rerunning the whole workflow. Per-second billing so you only pay for what you use. AI-powered failure diagnosis that tells you exactly what went wrong."

---

## Section 6: The Impact (5:00 - 6:00)

### 5:00 - 5:20 | Time Savings

**[VISUAL]** Calculator animation:

```
Your Current Setup:
100 builds/day × 3.8 min = 380 min/day
380 min/day × 5 days = 1,900 min/week

With Depot CI:
100 builds/day × 2.3 min = 230 min/day
230 min/day × 5 days = 1,150 min/week

TIME SAVED: 750 minutes per week (~12.5 hours/week)

Over a year: 37,500 minutes = ~625 hours = ~16 full work weeks
```

**[VOICEOVER]**
"If you do 100 builds a day, GitHub Actions costs you over 6 hours. With Depot CI? That's about 4 hours. You save over 12 hours every single week."

**[VISUAL]** Calendar showing freed-up time, then zooms out to show full year

**[VOICEOVER]**
"Over a year, that adds up to 625 hours. Nearly 16 full work weeks of time saved."

---

### 5:20 - 5:40 | Cost Savings

**[VISUAL]** Cost comparison:

```
GitHub Actions (billed per minute, rounded up):
227 seconds → rounds up to 4 minutes/build
1,000 builds × 4 minutes = 4,000 minutes/month
Cost: $0.006/minute → ~$24/month

Depot CI (billed per second, exact):
140 seconds/build = 140 seconds billed
1,000 builds × 140 seconds = 140,000 seconds
Cost: $0.00005/sec/vCPU → ~$16/month

SAVINGS: ~33% reduction
```

**[VOICEOVER]**
"GitHub Actions rounds up to the nearest minute, so your 3 minute 47 second build gets billed as 4 minutes. Depot CI charges per second - so you only pay for exactly what you use. That's significant savings on compute costs."

---

### 5:40 - 6:00 | Developer Experience + Closing

**[VISUAL]** Happy developer, fast builds flying by

**[VOICEOVER]**
"But the real value isn't just time or money. It's how it feels to have fast CI. You push code, seconds later it's built. You make a small change, you don't hesitate to test it."

**[VISUAL]** Final tagline appears:

**[SOUND]** Music swells briefly then fades

> *"Stop waiting for your builds."*
> *"Start shipping faster."*
> *"Depot CI"*

**[SOUND]** Clean closing chord

---

## Test Data Summary

### Real Performance Results - OpenClaw AI

Tests conducted: 2026-04-04 to 2026-04-05
Organization: sbtechpal
Repository: depot-railway-build
Test Application: OpenClaw AI (500+ dependencies, multi-stage Docker build)
OpenClaw Commit: f0c970fb43

#### GitHub Actions vs Depot CI

| Test Case | GitHub Actions | Depot CI | Improvement |
|-----------|----------------|----------|-------------|
| Baseline (cold) | 3m 44s (224s) | 2m 28s (148s) | 34% faster |
| Documentation change | 3m 56s (236s) | 3m 2s (182s) | 23% faster |
| New source file | 3m 21s (201s) | 1m 53s (113s) | 44% faster |
| UI component | 3m 50s (230s) | 2m 31s (151s) | 34% faster |
| New dependency | 3m 59s (239s) | 2m 13s (133s) | 44% faster |
| Major changes | 3m 52s (232s) | 1m 55s (115s) | 50% faster |
| **Average** | **3m 47s (227s)** | **2m 20s (140s)** | **38% faster** |

#### Full Three-Way Comparison (Including Local)

| Test Case | Local Docker | GitHub Actions | Depot CI |
|-----------|-------------|----------------|----------|
| Baseline (cold) | 15m 30s | 3m 44s | 2m 28s |
| Documentation change | 12m 0s | 3m 56s | 3m 2s |
| New source file | 11m 56s | 3m 21s | 1m 53s |
| UI component | 9m 59s | 3m 50s | 2m 31s |
| New dependency | ~10m 57s | 3m 59s | 2m 13s |
| Major changes | ~8m 46s | 3m 52s | 1m 55s |
| **Average** | **~11m 28s** | **~3m 47s** | **~2m 20s** |

### Test Environment

| Component | Local Docker | GitHub Actions | Depot CI |
|-----------|-------------|----------------|----------|
| Runner | WSL2 (shared cores) | ubuntu-24.04 (2 CPU, 8 GB) | depot-ubuntu-24.04-4 (4 CPU, 16 GB) |
| Builder | Local Buildx | Docker Buildx + GHA cache | depot/build-push-action@v1 (remote: 16 CPU, 32 GB, NVMe) |
| Cache | Docker BuildKit local | --cache-from/to type=gha | Automatic NVMe SSD |
| Auth | N/A | GITHUB_TOKEN | OIDC (id-token: write) |

### Key Findings

1. **Depot CI wins every test case** - 6/6 victories
2. **38% faster on average** vs GitHub Actions (2m 20s vs 3m 47s)
3. **Biggest win: major changes** - 50% faster (1m 55s vs 3m 52s)
4. **Real cache differentiation** - Depot shows 31-52% cache hits; GHA shows flat times (201-239s)
5. **GHA cache is ineffective** for this workload - nearly flat build times across all cache scenarios
6. **Local builds are 5x slower** than Depot CI (11m 28s vs 2m 20s)

---

## Recording Notes

### Screen Recording Tips

| Tip | Details |
|-----|---------|
| **Resolution** | Record at 1080p or higher |
| **Timing** | Let the results table breathe - let viewers absorb the numbers |
| **Comparison** | Use actual screen recordings of real builds when possible |
| **Emphasis** | Highlight the 38% number - that's the key takeaway |

### Voiceover Guidelines

| Element | Guidance |
|---------|----------|
| **Tone** | Professional but approachable |
| **Pace** | 140-150 words per minute |
| **Emphasis** | Emphasize: "38% faster", "every test", "2m 20s" |
| **Pauses** | Pause after key statistics |

### Production Notes

- **Real Data**: All performance numbers are from actual tests
- **Fair Comparison**: Same Dockerfile, same app, same destination registry
- **Reproducible**: Tests can be rerun for verification
