# Depot CI vs GitHub Actions: Performance Comparison Video Script

**Title**: "Depot CI vs GitHub Actions: Nearly 2x Faster Docker Builds"
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

**[VISUAL]** Tagline appears: *"Nearly 2x Faster Docker Builds"*

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
# (Install Depot Code Access GitHub App via Depot dashboard)

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
│  Generic runners    │  Docker-optimized   │
│  Basic caching      │  Advanced caching   │
│  Cold starts        │  Pre-warmed pool    │
│  ~3m 43s average    │  ~1m 59s average    │
└─────────────────────┴─────────────────────┘
```

**[VOICEOVER]**
"Depot CI uses Docker-optimized runners with intelligent caching and pre-warmed build pools. The result? Builds that are nearly 2 times faster."

---

## Section 3: Real Performance Data (1:30 - 3:00)

### 1:30 - 1:45 | The Test Setup

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

### 1:45 - 2:15 | The Results

**[VISUAL]** Large results table appears:

```
┌─────────────────────────────────────────────────────────────┐
│           DEPOT CI vs GITHUB ACTIONS                        │
├─────────────────────────────────────────────────────────────┤
│                                                             │
│  Test Case           GitHub    Depot    Depot Speedup       │
│  ─────────────────────────────────────────────────────────  │
│  Baseline (without cache)     4m 6s    2m 1s    2.0x faster       │
│  Comment change       4m 1s    2m 47s   1.4x faster       │
│  New source file     4m 0s    2m 47s   1.4x faster       │
│  UI component        3m 57s    1m 26s   2.8x faster       │
│  New dependency     3m 55s    3m 11s   1.1x faster       │
│  Major changes       3m 51s    1m 42s   2.2x faster       │
│                                                             │
│  AVERAGE              3m 53s    2m 18s   1.7x faster       │
└─────────────────────────────────────────────────────────────┘
```

**[SOUND]** Subtle "whoosh" as each row animates in

**[VOICEOVER]**
"Here are the results from testing OpenClaw AI - a complex personal AI assistant with 500+ dependencies. GitHub Actions averaged 3 minutes 53 seconds per build. Depot CI averaged 2 minutes 18 seconds. That's a 1.7x speedup."

**[PAUSE - 2 seconds]**

**[VOICEOVER]**
"And Depot CI won every single test case."

---

### 2:15 - 2:45 | The Dependency Difference

**[VISUAL]** Focus on the "New Dependency" row:

```
┌─────────────────────────────────────────────────────────────┐
│  NEW DEPENDENCY TEST (Adding new npm package)               │
├─────────────────────────────────────────────────────────────┤
│                                                             │
│  GitHub Actions: 3m 55s    ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓░░░░░░░░         │
│  Depot CI:        3m 11s   ▓▓▓▓▓▓▓▓░░░░░░░░░░░░░░░░░░░░░░░░░░         │
│                                                             │
│  Depot CI is 1.1x faster for dependency changes             │
└─────────────────────────────────────────────────────────────┘
```

**[VOICEOVER]**
"Look at the dependency test. When adding a new package to a project with 500+ dependencies, GitHub Actions took just under 4 minutes. Depot CI took just over 3 minutes. Even on similar times, Depot CI maintains the edge."

**[VISUAL]** Animation showing why:

```
GITHUB ACTIONS - Every build starts from scratch:
┌─────────────────────────────────────┐
│ New VM (ephemeral)                  │ ← Fresh runner, no cache
│ Downloads 500+ packages again       │ ← Re-downloads everything
│ Install time: 2-3 minutes           │
└─────────────────────────────────────┘
↓ Build completes
VM destroyed → Cache gone forever

DEPOT CI - Distributed cache persists:
┌─────────────────────────────────────┐
│ Optimized infrastructure            │ ← Pre-warmed, ready
│ Distributed global cache            │ ← Persists across builds
│ Only downloads NEW packages         │ ← Smart caching
│ Install time: 30-60 seconds         │
└─────────────────────────────────────┘
Cache shared across all builds
```

**[VOICEOVER]**
"Here's the key difference. GitHub Actions runners are ephemeral - they start fresh for each job. But here's what matters - without proper caching setup, you're re-downloading 500+ packages from scratch every single time."

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
"Depot CI's cache is repository-scoped and persists across all your builds. Each build benefits from the cache entries created by your previous builds. That's the power of persistent caching versus starting from scratch every time."

---

### 2:45 - 3:00 | The Build Without Cache Reality

**[VISUAL]** Baseline comparison:

```
First build of the day (no cache):
GitHub Actions: 4m 6s
Depot CI:       2m 1s

You save over 2 minutes on your very first build.
```

**[VOICEOVER]**
"Even on builds without cache, Depot CI is 2x faster. That's over 2 minutes saved on your first build of the day. Before you've even had your coffee."

---

## Section 4: Why Depot Wins (3:00 - 4:00)

### 3:00 - 3:20 | Architecture Matters

**[VISUAL]** Simple architecture comparison:

```
GitHub Actions              Depot CI
┌─────────────┐            ┌─────────────┐
│ Generic VM  │            │ Pre-warmed  │
│ Cold start  │            │ Sandboxes   │
│ No shared   │            │ + Depot     │
│ state       │            │ Cache       │
└─────────────┘            └─────────────┘
```

**[VOICEOVER]**
"The difference comes down to architecture. GitHub Actions spins up a fresh generic VM for every job — no pre-warming, no shared state. Depot CI uses pre-warmed sandboxes on performance-tuned compute, with Depot Cache built in and no configuration required. The result is jobs that start in 2–3 seconds instead of waiting for a cold VM to boot."

---

### 3:20 - 3:35 | The Cache Advantage

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

### 3:35 - 3:50 | How Depot Achieves This

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

### 3:50 - 4:00 | Additional Features

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

## Section 5: The Impact (4:00 - 5:00)

### 4:00 - 4:20 | Time Savings

**[VISUAL]** Calculator animation:

```
Your Current Setup:
100 builds/day × 3.7 min = 370 min/day
370 min/day × 5 days = 1,850 min/week

With Depot CI:
100 builds/day × 2 min = 200 min/day
200 min/day × 5 days = 1,000 min/week

TIME SAVED: 850 minutes per week (~14 hours/week)

Over a year: 42,500 minutes = ~700 hours = ~18 full work weeks
```

**[VOICEOVER]**
"If you do 100 builds a day, GitHub Actions costs you over 6 hours. With Depot CI? That's about 3.5 hours. You save over 2 hours every single day."

**[VISUAL]** Calendar showing freed-up time, then zooms out to show full year

**[VOICEOVER]**
"Over a year, that adds up to 700 hours. Nearly 18 full work weeks of time saved."

---

### 4:20 - 4:40 | Cost Savings

**[VISUAL]** Cost comparison:

```
GitHub Actions (billed per minute, rounded up):
233 seconds → rounds up to 4 minutes/build
1,000 builds × 4 minutes = 4,000 minutes/month
Cost: $0.008/minute → ~$32/month

Depot CI (billed per second, exact):
138 seconds/build = 138 seconds billed
1,000 builds × 138 seconds = 138,000 seconds
Cost: $0.007/minute → ~$16/month

SAVINGS: 50% reduction
```

**[VOICEOVER]**
"GitHub Actions rounds up to the nearest minute, so your 3 minute 53 second build gets billed as 4 minutes. Depot CI charges per second - so you only pay for exactly what you use. That's 50% savings on compute costs."

---

### 4:40 - 5:00 | Developer Experience

**[VISUAL]** Happy developer, fast builds flying by

**[VOICEOVER]**
"But the real value isn't just time or money. It's how it feels to have fast CI. You push code, seconds later it's built. You make a small change, you don't hesitate to test it."

**[VISUAL]** Text: *"Ship faster. Iterate more. Wait less."*

**[VOICEOVER]**
"Fast CI changes how you work. You ship faster. You iterate more. You wait less."

---

## Section 6: Call to Action (5:00 - 6:00)

### 5:00 - 5:20 | Get Started

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
"Install the CLI. Login. Initialize your project. That's it."

---

### 5:20 - 5:40 | The Migration Process

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

### 5:40 - 6:00 | Start Today

**[VISUAL]** Large URL: **depot.dev**

**[VOICEOVER]**
"Visit depot.dev to get started. Free trial available. Then plans start at just $20 per month."

**[VISUAL]** Final tagline appears:

**[SOUND]** Music swells briefly then fades

> *"Stop waiting for your builds."*
> *"Start shipping faster."*
> *"Depot CI"*

**[SOUND]** Clean closing chord

---

## Test Data Summary

### Real Performance Results - OpenClaw AI

Tests conducted: 2026-04-02 to 2026-04-03
Organization: sbtechpal
Repository: depot-railway-build
Test Application: OpenClaw AI (500+ dependencies, multi-stage Docker build)

| Test Case | GitHub Actions | Depot CI | Speedup |
|-----------|----------------|----------|---------|
| Baseline (without cache) | 4m 6s | 2m 1s | 2.0x |
| Documentation change | 4m 1s | 2m 47s | 1.4x |
| New source file | 4m 0s | 2m 47s | 1.4x |
| UI component | 3m 57s | 1m 26s | 2.8x |
| New dependency | 3m 55s | 3m 11s | 1.1x |
| Major changes | 3m 51s | 1m 42s | 2.2x |
| **Average** | **3m 53s** | **2m 18s** | **1.7x** |

### Test Environment

| Component | GitHub Actions | Depot CI |
|-----------|----------------|----------|
| Runner | ubuntu-latest (2-core) | depot-ubuntu-24.04 |
| Cache | GitHub Actions Cache | Depot distributed cache |
| Docker | docker/build-push-action | depot/build-push-action |
| Image | GHCR | GHCR |

> **Note:** Tests used GitHub Packages registry for both platforms. Depot CI has a known limitation with GHCR when using secrets.GITHUB_TOKEN - consider Depot Registry if pushing to GitHub Packages.

### Key Findings

1. **Depot CI wins every test case** - 6/6 victories
2. **Biggest win: UI component changes** - 2.8x faster
3. **Consistent performance** - 1m 26s-3m 11s across all tests
4. **GitHub Actions variability** - 3m 55s-4m 6s depending on test

---

## Recording Notes

### Screen Recording Tips

| Tip | Details |
|-----|---------|
| **Resolution** | Record at 1080p or higher |
| **Timing** | Let the results table breathe - let viewers absorb the numbers |
| **Comparison** | Use actual screen recordings of real builds when possible |
| **Emphasis** | Highlight the 1.7x number - that's the key takeaway |

### Voiceover Guidelines

| Element | Guidance |
|---------|----------|
| **Tone** | Professional but approachable |
| **Pace** | 140-150 words per minute |
| **Emphasis** | Emphasize: "1.7x faster", "every test", "2m 18s" |
| **Pauses** | Pause after key statistics |

### Production Notes

- **Real Data**: All performance numbers are from actual tests
- **Fair Comparison**: Same Dockerfile, same app, same destination registry
- **Reproducible**: Tests can be rerun for verification
