# Depot CI Demo Video Script

**Title**: "Depot CI: 40x Faster Builds for AI Development"
**Duration**: 7:45 (updated)
**Format**: 16:9 (1920x1080)
**Style**: Screen recording + voiceover with motion graphics overlays

---

## Script Legend

| Symbol | Meaning |
|--------|---------|
| `[VISUAL]` | On-screen graphics/text |
| `[SCREEN]` | Screen recording action |
| `[CAMERA]` | Camera angle or movement |
| `[SOUND]` | Sound effect or music cue |
| `[PAUSE]` | Brief pause for emphasis |
| `( )` | Optional/directional notes |

---

## Section 1: The Problem (0:00 - 0:45)

### 0:00 - 0:15 | Opening Hook

**[VISUAL]** Dark screen, text fades in: *"In the AI-augmented development era..."*

**[SOUND]** Subtle, building tech ambient music starts

**[VOICEOVER]**
"In the AI-augmented development era... writing code is no longer the bottleneck."

**[VISUAL]** Text continues: *"...integrating it is."*

**[VOICEOVER]**
"Integrating it is."

---

### 0:15 - 0:30 | The Reality Check

**[VISUAL]** Montage:
- Developer typing furiously
- CI progress bar: "Building... 15 min remaining"
- Clock spinning, timestamps flying by

**[VOICEOVER]**
"With AI agents like Claude Code and Cursor, a team of 10 engineers can now produce output like 100."

**[VISUAL]** Chart: Code volume line going up sharply, CI performance line staying flat

**[VOICEOVER]**
"But traditional CI systems? They were built for a different world."

---

### 0:30 - 0:45 | The Pain

**[SCREEN]** GitHub Actions workflow running slowly:
- "Setup Node.js" (30s)
- "Install dependencies" (2m 15s)
- "Build" (1m 45s)
- Timer at 4:32 and still going

**[VOICEOVER]**
"GitHub Actions. CircleCI. Buildkite. Great tools, but they're architecturally wrong for this moment."

**[VISUAL]** Frustrated developer at desk, head in hands

**[VOICEOVER]**
"15-minute pipelines were annoying. Now? They're crippling."

---

## Section 2: The Solution (0:45 - 1:30)

### 0:45 - 1:00 | Introducing Depot CI

**[VISUAL]** Clean white screen, Depot logo animates in

**[SOUND]** Subtle "whoosh" logo sound, music becomes more optimistic

**[VISUAL]** Tagline appears: *"40x Faster Builds"*

**[VOICEOVER]**
"Meet Depot CI. A programmable CI engine built with performance as a first-class citizen."

---

### 1:00 - 1:15 | How It Works

**[VISUAL]** Animated diagram:
```
┌─────────┐    ┌──────────────┐    ┌─────────┐
│  Code   │───▶│  Depot CI    │───▶│ Deployed│
└─────────┘    └──────────────┘    └─────────┘
                    │
        ┌───────────┼───────────┐
        ▼           ▼           ▼
    ┌───────┐  ┌───────┐  ┌───────┐
    │ Cache │  │ Scale │  │ Fast  │
    └───────┘  └───────┘  └───────┘
```

**[VOICEOVER]**
"Depot CI isn't just faster — it's built differently. Intelligent caching that learns across every build. Distributed compute that scales when you need it. An orchestrator designed for modern workloads."

---

### 1:15 - 1:30 | Drop-in Replacement

**[VISUAL]** GitHub logo + Depot logo, connection line between them

**[VISUAL]** Animation showing:

```
.github/workflows/         .depot/workflows/
├── ci.yml        ──────▶  ├── ci.yml
├── build.yml     ──────▶  ├── build.yml
└── test.yml      ──────▶  └── test.yml
```

**[VOICEOVER]**
"Depot CI is a drop-in replacement for GitHub Actions. Simply copy your workflows from `.github/workflows` to `.depot/workflows`. Same YAML. Same syntax. Just copy and go."

**[VISUAL]** Text appears: *"No Rewrites. Just Copy."*

**[VOICEOVER]**
"No rewrite. No migration project. One command to migrate. Then copy, commit, and you're running on Depot CI infrastructure."

---

## Section 2.5: Why Depot CI Wins (1:30 - 3:00)

### 1:30 - 1:45 | It's Not Just Speed — It's Architecture

**[VISUAL]** Split diagram appears: LEFT = "GitHub Actions", RIGHT = "Depot CI"

**[SOUND]** Music shifts to more technical, driving beat

**[VOICEOVER]**
"The speed difference you're about to see? It's not magic. It's architecture."

**[VISUAL]** Text animates in between the two sides: *"FUNDAMENTALLY DIFFERENT APPROACHES"*

**[VOICEOVER]**
"GitHub Actions was built as an event-driven polling system. Depot CI is built as a distributed state machine. Let me show you what that actually means."

---

### 1:45 - 2:00 | The Three-Part Architecture

**[VISUAL]** A clean animated diagram appears showing Depot CI's three layers:

```
┌─────────────────────────────────────────────────────────────────┐
│                    DEPOT CI ARCHITECTURE                        │
├─────────────────────────────────────────────────────────────────┤
│                                                                 │
│  ┌──────────────────────────────────────────────────────────┐   │
│  │  FRONTEND LAYER                                           │   │
│  │  • GitHub Actions YAML Parser                            │   │
│  │  • Validates & converts workflows                        │   │
│  │  • Supports future formats (GitLab CI, etc.)             │   │
│  └────────────────────┬─────────────────────────────────────┘   │
│                       │                                         │
│  ┌────────────────────▼─────────────────────────────────────┐   │
│  │  ORCHESTRATOR LAYER (Switchyard)                          │   │
│  │  • Durable state machine                                  │   │
│  │  • Builds job dependency graphs (DAG)                     │   │
│  │  • Schedules tasks across compute fleet                  │   │
│  │  • Tracks state, handles failures & retries              │   │
│  └────────────────────┬─────────────────────────────────────┘   │
│                       │                                         │
│  ┌────────────────────▼─────────────────────────────────────┐   │
│  │  COMPUTE LAYER                                            │   │
│  │  • Standby pools (2-3 sec startup)                       │   │
│  │  • Sandboxes with BuildKit pre-installed                 │   │
│  │  • SSH debugging, metrics, logs                           │   │
│  │  • Per-second billing                                     │   │
│  └──────────────────────────────────────────────────────────┘   │
│                                                                 │
└─────────────────────────────────────────────────────────────────┘
```

**[SOUND]** Subtle "whoosh" as each layer animates in

**[VOICEOVER]**
"Depot CI has three layers. A frontend that parses your GitHub Actions YAML. An orchestrator called Switchyard that manages job dependencies and state. And a compute layer with pre-warmed sandboxes ready to execute."

**[VISUAL]** The diagram highlights the ORCHESTRATOR LAYER with a pulsing glow

**[VOICEOVER]**
"Each layer is independent. Swap the frontend, add new workflow formats. The orchestrator doesn't care. Upgrade compute, add new sandbox types. Your workflows keep running. This is modular, future-proof architecture."

---

### 2:00 - 2:15 | Switchyard: The Brain

**[VISUAL]** The ORCHESTRATOR LAYER expands into a detailed view:

```
┌─────────────────────────────────────────────────────────────────┐
│                    SWITCHYARD ORCHESTRATOR                        │
├─────────────────────────────────────────────────────────────────┤
│                                                                 │
│  ┌────────────────────────────────────────────────────────┐    │
│  │  1. WORKFLOW PARSER                                      │    │
│  │     • Reads GitHub Actions YAML                         │    │
│  │     • Extracts jobs, steps, dependencies                │    │
│  │     • Builds Dependency Graph (DAG)                     │    │
│  └────────────────────────────────────────────────────────┘    │
│                           │                                      │
│  ┌──────────────────────────▼──────────────────────────────┐   │
│  │  2. DEPENDENCY RESOLUTION                                │   │
│  │     Job A ─────► Job B ─────► Job D                     │   │
│  │         └──► Job C ─────► Job E                         │   │
│  │                                                           │   │
│  │     • Identifies parallelizable jobs                     │   │
│  │     • Calculates optimal execution order                 │   │
│  │     • Respects conditional logic (if/else)               │   │
│  └──────────────────────────┬──────────────────────────────┘   │
│                           │                                      │
│  ┌──────────────────────────▼──────────────────────────────┐   │
│  │  3. DURABLE STATE MACHINE                                │   │
│  │     ┌─────────────┐    ┌─────────────┐    ┌──────────┐  │   │
│  │     │  QUEUED     │───▶│  RUNNING    │───▶│ COMPLETE │  │   │
│  │     └─────────────┘    └─────────────┘    └──────────┘  │   │
│  │            │                                       │      │   │
│  │            └─────────────▶ FAILED ──▶ RETRY ───────┘      │   │
│  │                                                           │   │
│  │     • State persisted to durable storage                 │   │
│  │     • Survives infrastructure failures                  │   │
│  │     • Resume from exact point of failure                 │   │
│  └────────────────────────────────────────────────────────┘    │
│                                                                 │
└─────────────────────────────────────────────────────────────────┘
```

**[VOICEOVER]**
"Switchyard is the brain of Depot CI. First, it parses your workflow and builds a dependency graph — knowing exactly which jobs can run in parallel, and which must wait."

**[VISUAL]** Animation shows the DAG being built, with parallel jobs highlighting simultaneously

**[VOICEOVER]**
"Then it schedules everything optimally across our compute fleet. And it maintains durable state throughout. If something fails? Switchyard knows exactly where to resume. No starting over from scratch."

**[PAUSE - 1 second]**

**[VOICEOVER]**
"This is like having a project manager who never forgets, never loses context, and always knows the fastest path to completion."

---

### 2:30 - 2:45 | The Startup Problem

**[VISUAL]** Animation on LEFT side (GitHub Actions):

```
┌─────────────────────────────────┐
│     GITHUB ACTIONS              │
│  ┌─────────────────────────┐    │
│  │   Runner polls...       │    │
│  │   Waiting... waiting... │    │
│  │   (40+ seconds)         │    │
│  └─────────────────────────┘    │
│  ▲ Cold start every time        │
└─────────────────────────────────┘
```

**[VOICEOVER]**
"Every time GitHub Actions starts a job, the runner has to poll GitHub's servers. Wait for assignment. Spin up a fresh EC2 instance. Install dependencies. Forty seconds. Gone."

**[VISUAL]** Animation on RIGHT side (Depot CI):

```
┌─────────────────────────────────┐
│       DEPOT CI                  │
│  ┌─────────────────────────┐    │
│  │ Standby Pool            │    │
│  │ Stopped → Running       │    │
│  │ (2-3 seconds)           │    │
│  └─────────────────────────┘    │
│  ▲ Pre-warmed, ready instantly  │
└─────────────────────────────────┘
```

**[SOUND]** Subtle "click" when Depot CI instance activates

**[VOICEOVER]**
"Depot CI keeps standby pools of compute resources — stopped, but ready. When a job comes in? Two seconds. Running. The difference between waiting and working."

---

### 2:45 - 3:00 | The State Problem

**[VISUAL]** Diagram morphs to show "State Management" comparison

**[LEFT - GitHub Actions]**: A "Stateless" box with a question mark, showing a broken connection when a crash occurs

**[RIGHT - Depot CI]**: A "Durable State Machine" with persistent connections, showing automatic recovery

**[VOICEOVER]**
"GitHub Actions runners are stateless. If something crashes mid-job? You start over from scratch."

**[VISUAL]** Animation on Depot CI side shows a job failing, then automatically resuming from where it left off

**[VOICEOVER]**
"Depot CI uses Switchyard — a durable orchestrator that tracks every job, every dependency, every state. Failures don't mean starting over. They mean resuming."

---

### 3:00 - 3:10 | The Scheduling Problem

**[VISUAL]** Split screen shows the same workflow scheduled differently:

```
GITHUB ACTIONS                    DEPOT CI
┌──────────────────┐             ┌──────────────────┐
│ "Got any jobs?"  │             │    PARALLEL       │
│ "Here's ONE."    │             │  ┌────┐  ┌────┐   │
│ (runs job)       │             │  │test│  │lint│   │
│                  │             │  └────┘  └────┘   │
│ "Got any more?"  │             │       ↓          │
│ "Here's ONE."    │             │    ┌────┐        │
│ (runs next)      │             │    │build│       │
│                  │             │    └────┘        │
│ "Got any more?"  │             │       ↓          │
│ "Here's ONE."    │             │    ┌────┐        │
│ One. At. A. Time.│             │    │deploy│      │
└──────────────────┘             │    └────┘        │
    Pull Model                  └──────────────────┘
                               Builds DAG → Schedules
                               all jobs optimally
```

**[VOICEOVER]**
"GitHub Actions? The runner polls for jobs one at a time. No awareness of what else is coming. It can't plan ahead."

**[VISUAL]** Animation highlights the DEPOT CI side showing the DAG being built

**[VOICEOVER]**
"Depot CI parses your workflow and builds a dependency graph — a DAG. It sees EVERY job upfront. It knows which jobs can run in parallel — like test and lint — and which must wait — like build needing test, or deploy needing everything else."

**[VISUAL]** Animation shows parallel jobs (test + lint) running simultaneously in green boxes

**[VOICEOVER]**
"GitHub: 'Got any jobs?' 'Here's ONE.' Depot CI: 'Here's your workflow, here's your optimal schedule, go.'"

**[PAUSE - 1 second]**

**[VOICEOVER]**
"Polling versus orchestrating. Guessing versus knowing. Waiting versus executing."

---

### 3:10 - 3:20 | The Security Bonus

**[VISUAL]** Diagram showing isolated sandboxes:

```text
┌─────────────────────────────────────────────────────────────────┐
│                    ISOLATED SANDBOXES                          │
├─────────────────────────────────────────────────────────────────┤
│                                                                 │
│  ┌─────────────┐    ┌─────────────┐    ┌─────────────┐        │
│  │   Job A     │    │   Job B     │    │   Job C     │        │
│  │   Sandbox   │    │   Sandbox   │    │   Sandbox   │        │
│  │             │    │             │    │             │        │
│  │  • Secrets  │    │  • Secrets  │    │  • Secrets  │        │
│  │  • Isolated │    │  • Isolated │    │  • Isolated │        │
│  │  • Destroyed│    │  • Destroyed│    │  • Destroyed│        │
│  └─────────────┘    └─────────────┘    └─────────────┘        │
│                                                                 │
│  Never shared. Always secure.                                  │
└─────────────────────────────────────────────────────────────────┘
```

**[VOICEOVER]**
"Every job runs in a dedicated sandbox. Never shared. Always destroyed after use. Your secrets stay yours. Your builds stay isolated."

**[VISUAL]** Lock icon animation, shield appears around each sandbox

**[VOICEOVER]**
"Security isn't an afterthought — it's built in."

---

## Section 3: The Demo (3:20 - 4:50)

### 3:20 - 3:35 | Introducing OpenClaw

**[SCREEN]** OpenClaw website (openclaw.ai)

**[VOICEOVER]**
"To show you what this architecture actually delivers, we're using OpenClaw."

**[VISUAL]** Scroll through testimonials:
- Andrej Karpathy
- Nat Eliason
- "iPhone moment"
- "Early AGI"

**[VOICEOVER]**
"OpenClaw is a personal AI assistant that's taking the tech world by storm. It runs on your own hardware. It works through WhatsApp, Telegram, Discord. It's the future of personal AI."

---

### 3:35 - 3:50 | The Tech Stack

**[SCREEN]** VS Code showing the sample app:
- TypeScript files
- Dependencies in package.json
- Dockerfile

**[VOICEOVER]**
"And it's exactly the kind of application that benefits from Depot CI. Node.js, TypeScript, dozens of dependencies, complex Docker builds."

**[VISUAL]** File count animation: "15 dependencies", "Multi-stage Docker", "TypeScript compilation"

**[VOICEOVER]**
"The kind of build that makes traditional CI sweat."

---

### 3:50 - 4:30 | The Comparison ⭐

**[VISUAL]** Split screen appears:

```
┌─────────────────────┬─────────────────────┐
│   GITHUB ACTIONS     │      DEPOT CI        │
│    (Baseline)        │      (Showcase)      │
├─────────────────────┼─────────────────────┤
│  [SCREEN RECORDING]  │  [SCREEN RECORDING]  │
│                     │                     │
│  Starting...        │  Starting...        │
└─────────────────────┴─────────────────────┘
```

**[VOICEOVER]**
"Let's compare. On the left: traditional GitHub Actions. On the right: Depot CI. Same code, same destination, different infrastructure."

**[SCREEN]** Both workflows start simultaneously

**[TIMERS APPEAR]**
```
GitHub Actions: 0:00 ───────────────────
Depot CI:       0:00 ───────────────────
```

**[VOICEOVER]**
"Both workflows start now..."

**[TIME LAPSE - 5 seconds real-time)**

**[SCREEN UPDATE]**
```
GitHub Actions: 0:45 ▓▓░░░░░░░░░░░ Installing dependencies...
Depot CI:       0:08 ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓ COMPLETE
```

**[VOICEOVER]**
"Watch this. GitHub Actions is still installing dependencies. Depot CI? Already done."

**[SOUND]** Subtle "ding" when Depot CI completes

---

### 4:30 - 4:45 | The Results

**[VISUAL]** Both screens show green checkmarks

**[VISUAL]** Final times animate in:

```
┌─────────────────────┬─────────────────────┐
│   GITHUB ACTIONS     │      DEPOT CI        │
├─────────────────────┼─────────────────────┤
│                     │                     │
│      ✓ SUCCESS      │      ✓ SUCCESS      │
│                     │                     │
│   Time: 4:32        │   Time: 0:28        │
│                     │                     │
└─────────────────────┴─────────────────────┘
```

**[SOUND]** Success chime

**[VOICEOVER]**
"The result? GitHub Actions: 4 minutes and 32 seconds. Depot CI: 28 seconds."

**[PAUSE - 2 seconds]**

**[VOICEOVER]**
"That's not just faster — that's fundamentally different."

---

### 4:45 - 4:55 | Debugging Superpower ⭐

**[VISUAL]** Quick animation showing Depot CI dashboard:

```text
┌─────────────────────────────────────────────────────────────┐
│  DEPOT CI DASHBOARD                                          │
├─────────────────────────────────────────────────────────────┤
│  Job: ci.yml #42                                            │
│  Steps:                                                     │
│    ✓ Checkout           2s                                 │
│    ✓ Setup Node         8s                                 │
│    ✓ Install deps       12s                                │
│    ✗ Build              FAILED 45s                         │
│                                                             │
│  [🔄 Replay from "Install deps"]  [🔍 SSH Debug]            │
└─────────────────────────────────────────────────────────────┘
```

**[VOICEOVER]**
"And when something does fail? Depot CI has debugging superpowers. Replay from any step — skip everything that worked and jump straight to debugging the problem."

**[VISUAL]** Animation shows "Replay from step" button being clicked, job restarting from that step

**[VISUAL]** Dashboard showing CPU/memory graphs, step timing metrics:

```text
┌─────────────────────────────────────────────────────────────┐
│  JOB METRICS                                                 │
├─────────────────────────────────────────────────────────────┤
│  CPU Usage    ┌─────────────────────────────────────┐       │
│  100% ─       │▓▓▓▓░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░│       │
│   50% ─       └─────────────────────────────────────┘       │
│    0% ─                                              45s    │
│                                                             │
│  Memory      ┌─────────────────────────────────────┐       │
│  8GB  ─       │▓▓▓▓▓▓▓▓▓▓▓▓░░░░░░░░░░░░░░░░░░░░░░░░░│       │
│  4GB  ─       └─────────────────────────────────────┘       │
│  0GB  ─                                              45s    │
│                                                             │
│  Step Timing: Checkout 2s │ Setup 8s │ Install 12s │ Build 45s │
└─────────────────────────────────────────────────────────────┘
```

**[VOICEOVER]**
"Full observability. CPU usage, memory metrics, step-by-step timing. You don't just see that it failed — you see exactly why, exactly where, and exactly how to fix it."

**[VISUAL]** Animation shows "Replay from step" button being clicked, job restarting from that step

**[VOICEOVER]**
"Or SSH directly into the running sandbox. Full observability, full control."

**[PAUSE - 1 second]**

**[VOICEOVER]**
"Traditional CI? Restart from the beginning and hope. Depot CI? Debug smarter."

---

### 4:55 - 5:00 | The Impact Statement

**[VISUAL]** Both deployments show "Service live at..." URLs

**[VOICEOVER]**
"Both deployed successfully. The difference? With Depot CI, you've already moved on to your next feature."

---

## Section 3.5: AI-Native CI (5:00 - 5:35)

### 5:00 - 5:10 | AI Failure Diagnosis

**[VISUAL]** Depot CI dashboard showing a failed job:

```text
┌─────────────────────────────────────────────────────────────┐
│  DEPOT CI DASHBOARD — FAILED JOB                            │
├─────────────────────────────────────────────────────────────┤
│  Job: ci.yml #42                                            │
│  Status: ✗ FAILED                                           │
│                                                             │
│  ╔═════════════════════════════════════════════════════════╗│
│  ║  AI FAILURE DIAGNOSIS                                   ║│
│  ╠═════════════════════════════════════════════════════════╣│
│  ║  🔍 What went wrong:                                    ║│
│  ║     The build failed because the TypeScript            ║│
│  ║     compiler found type errors in src/auth.ts.         ║│
│  ║     Specifically, the UserSession type is missing     ║│
│  ║     the 'expiresAt' property.                          ║│
│  ║                                                          ║│
│  ║  💡 Suggested fix:                                      ║│
│  ║     Add the missing property to the UserSession        ║│
│  ║     interface: expiresAt: Date                         ║│
│  ╚═════════════════════════════════════════════════════════╝│
└─────────────────────────────────────────────────────────────┘
```

**[SOUND]** Subtle "bling" animation when AI diagnosis appears

**[VOICEOVER]**
"But Depot CI isn't just fast — it's intelligent. When a job fails, you get an AI-generated failure diagnosis. It explains what went wrong and suggests exactly how to fix it."

**[VISUAL]** The diagnosis panel highlights the fix suggestion

**[VOICEOVER]**
"No more digging through thousands of lines of logs. No more guessing at the root cause. Depot CI's AI analyzes the failure and gives you the answer."

---

### 5:10 - 5:20 | Built for Coding Agents

**[VISUAL]** Animation showing Claude Code / Cursor logo alongside Depot CI logo

**[SOUND]** Music shifts to more modern, AI-focused sound

**[VOICEOVER]**
"Depot CI is built for the AI-augmented development era. It integrates seamlessly with coding agents like Claude Code and Cursor."

**[VISUAL]** Animated loop diagram showing the agent workflow:

![The Agent Fix-CI Loop](depot-dev/agent-loop.png)

**[VOICEOVER]**
"With traditional CI, agents have to push commits, wait for external CI, then guess what went wrong. With Depot CI, agents run CI locally against their changes, read failures instantly, and iterate in a tight feedback loop."

**[VISUAL]** Split comparison:
- LEFT: "Push → Wait → Guess → Fix → Push → Wait"
- RIGHT: "Fix → Run → Fix → Run → Fix → Green"

**[VOICEOVER]**
"Push-wait-guess versus fix-run-green. This is what development was supposed to feel like."

---

### 5:20 - 5:35 | The End of Push-Wait-Guess

**[VISUAL]** Terminal showing rapid agent iteration:

```bash
$ depot ci run --job test
✗ FAILED: TypeError in auth.ts

$ # Agent reads AI diagnosis, adds missing property

$ depot ci run --job test
✗ FAILED: Missing import

$ # Agent fixes import, reruns

$ depot ci run --job test
✓ PASSED: All tests passing
```

**[VOICEOVER]**
"Coding agents can now fix CI failures without polluting your git history. No more 'fix ci' commits. No more waiting for external systems. Just rapid iteration until everything passes."

**[VISUAL]** Text appears: *"The End of Push-Wait-Guess CI"*

**[VOICEOVER]**
"This is CI built for AI development. Fast failure diagnosis. Tight agent loops. Zero friction."

---

## Section 4: The Value (5:35 - 6:25)

### 5:35 - 5:45 | Time Savings

**[VISUAL]** Animated calculation:

```
10 builds/day × 4 min saved = 40 min/day
40 min/day × 5 days = 200 min/week
```

**[VISUAL]** Text: *"That's an extra morning every week."*

**[VOICEOVER]**
"What does this mean for your team? If you do 10 builds a day, that's nearly an hour saved. Every single day."

**[VISUAL]** Calendar animation showing extra time appearing

**[VOICEOVER]**
"An extra morning, every week. What would your team do with that time?"

---

### 5:45 - 5:55 | Cost Savings

**[VISUAL]** Cost comparison chart:

```
Traditional CI:  $██████████ ($100/month)
Depot CI:        $██░░░░░░░░░ ($20/month)

Savings: 80%
```

**[VOICEOVER]**
"And it's not just time — it's money. 80% reduction in CI compute costs. That's real dollars back in your budget."

**[VISUAL]** Per-second billing comparison:

```
┌─────────────────────────────────────────────────────────────────┐
│                   PER-SECOND BILLING                            │
├─────────────────────────────────────────────────────────────────┤
│                                                                 │
│  TRADITIONAL CI:           DEPOT CI:                            │
│  31 seconds =               31 seconds =                        │
│  ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓░     ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓░░░░░░░░░░░░░░░░░░░░░░│
│  You pay for 1 minute       You pay for 31 seconds             │
│  (rounded up)               (exact usage)                       │
│                                                                 │
│  Fair. Transparent. Honest.                                      │
└─────────────────────────────────────────────────────────────────┘
```

**[VOICEOVER]**
"Traditional CI rounds up. Thirty-one seconds? You pay for a full minute. Depot CI bills per second. Fair. Transparent. Honest."

**[VISUAL]** Money animation (coins falling into piggy bank)

**[VOICEOVER]**
"Dollars you can spend on... anything else."

---

### 5:55 - 6:05 | The Bigger Picture

**[VISUAL]** Happy developer, multiple deployments flying by

**[VOICEOVER]**
"Fast builds mean more iterations. More iterations mean better products. Better products mean happier customers and more successful teams."

**[VISUAL]** Team celebrating, shipping confetti

**[VOICEOVER]**
"This is what development was supposed to feel like."

---

### 6:05 - 6:15 | Trusted by Teams

**[VISUAL]** Company logos or testimonials scrolling

**[VOICEOVER]**
"Teams across the industry are already shipping faster with Depot CI. From startups to enterprises, developers are reclaiming their time and focusing on what matters — building great software."

**[VISUAL]** Text appears: *"Join the teams building at the speed of AI."*

**[VOICEOVER]**
"The future of CI isn't just faster. It's smarter. It's built for AI. And it's here."

---

## Section 5: Call to Action (6:15 - 7:45)

### 6:15 - 6:30 | Get Started Today

**[VISUAL]** Depot CI interface, beautiful and clean

**[VOICEOVER]**
"Depot CI is now generally available, and ready for teams who want to build at the speed of AI."

**[VISUAL]** "Try it free" badge appears

**[VOICEOVER]**
"Start with a free 7-day trial. Full access, no credit card required. Then plans start at just $20 per month with 2,000 build minutes included. And per-second billing means you only pay for what you actually use."

---

### 6:30 - 6:40 | One Command to Migrate

**[SCREEN]** Terminal showing:

```bash
$ depot ci migrate
✓ Discovered 5 workflows
✓ Analyzed compatibility
✓ Created .depot/ directory
✓ Ready to commit
```

**[VOICEOVER]**
"Migrating is one command. `depot ci migrate`. We copy your workflows, check compatibility, and you're ready. Your existing GitHub Actions keep running in parallel until you're ready to switch."

---

### 6:40 - 7:45 | Final CTA

**[VISUAL]** Large URL: **depot.dev**

**[VISUAL]** Social handles:
- X: @depotdev
- Discord: discord.gg/depot
- GitHub: github.com/depot

**[VOICEOVER]**
"Visit depot.dev to start building faster today. Follow us @depotdev for updates."

**[VISUAL]** Final tagline appears:

**[SOUND]** Music swells briefly then fades

> *"Stop waiting for your builds."*
> *"Start shipping."*
> *"Depot CI"*

**[SOUND]** Clean closing chord

---

## Recording Notes

### Screen Recording Tips

| Tip | Details |
|-----|---------|
| **Resolution** | Record at 1080p or higher |
| **Mouse movement** | Smooth, deliberate motions |
| **Highlighting** | Use subtle highlights for key areas |
| **Timing** | The comparison section needs to feel real — don't fake it |
| **Pacing** | Allow slight pauses after key statements |

### Voiceover Guidelines

| Element | Guidance |
|---------|----------|
| **Tone** | Professional but approachable |
| **Pace** | 140-150 words per minute |
| **Emphasis** | Bold words should be emphasized |
| **Pauses** | Marked [PAUSE] are ~1 second |
| **Energy** | Increase slightly during the demo section |

### Post-Production Checklist

- [ ] Sync voiceover perfectly with visuals
- [ ] Add subtle sound effects at key moments
- [ ] Ensure music doesn't compete with voiceover
- [ ] Color grade for consistency
- [ ] Add closed captions
- [ ] Export in multiple formats
- [ ] Create eye-catching thumbnail

---

### Production Notes

**OpenClaw Demo:**

OpenClaw is a fictional example app used for demonstration purposes. During recording, either:

- Use a real-world sample app with similar tech stack (Node.js, TypeScript, Docker)
- Replace OpenClaw references with actual customer/product names if available
- Create a simple demo app that showcases the CI features

**Social Proof Section:**

The "Trusted by Teams" section (6:05-6:15) currently shows placeholder content. Options for production:

- Add real company logos of Depot CI customers
- Include testimonial quotes from real users
- Use metrics like "X teams already using Depot CI"
- Replace with depersonalized "teams like yours" messaging if specific logos aren't available

---

## Alternative Closings

### Option A: Direct
*"Visit depot.dev and start building faster today."*

### Option B: Vision
*"The future of CI is here. Don't get left behind."*

### Option C: Challenge
*"What would you build with an extra hour every day?"*

---

## Quick Reference for Recording

| Section | Time | Key Visual | Key Line |
|---------|------|------------|----------|
| Problem | 0:00 | Slow CI, frustrated dev | "Integrating is the bottleneck" |
| Solution | 0:45 | Depot logo, diagram | "40x faster builds" |
| **Why It Wins** | **1:30** | **3-part architecture + Switchyard** | **"It's not magic. It's architecture."** |
| **Security** | **3:10** | **Isolated sandboxes diagram** | **"Security built in"** |
| Demo | 3:20 | Split screen comparison | "4:32 vs 0:28" |
| **Debugging** | **4:45** | **Replay from step + Metrics UI** | **"Debug smarter"** |
| **AI-Native CI** | **5:00** | **AI failure diagnosis + Agent loops** | **"Built for AI development"** |
| Value | 5:35 | Time/money savings | "Extra morning every week" |
| **Social Proof** | **6:05** | **Teams/building faster** | **"Join the teams"** |
| CTA | 6:15 | depot.dev URL | "Stop waiting. Start shipping." |

---

## Technical Advantages Summary (for graphics team)

The "Why It Wins" section (1:30-3:10) showcases these key technical differentiators:

**New Content Added:**

- **Drop-in Replacement Visual** (1:15-1:30): Shows .github/workflows → .depot/workflows copy animation
- **3-Part Architecture Diagram** (1:45-2:00): Visual showing Frontend, Orchestrator (Switchyard), and Compute layers
- **Switchyard Deep Dive** (2:00-2:15): Detailed view of workflow parsing, dependency resolution (DAG), and durable state machine
- **Security Bonus** (3:10-3:20): Isolated sandboxes diagram showing security built-in
- **Debugging Superpower** (4:45-4:55): Dashboard UI showing "Replay from step", SSH debug, and CPU/memory metrics
- **AI Failure Diagnosis** (5:00-5:10): Dashboard showing AI-generated failure analysis and suggested fixes
- **Coding Agent Integration** (5:10-5:35): Agent loop diagram showing push-wait-guess vs fix-run-green comparison
- **Per-Second Billing Visual** (5:45-5:55): Comparison showing traditional CI rounding vs Depot CI exact billing
- **Social Proof** (6:05-6:15): Trusted by teams section (placeholder for real testimonials)

**Overall Technical Comparison:**

| Advantage | GitHub Actions | Depot CI | Impact |
| :--- | :--- | :--- | :--- |
| **Startup** | 40+ seconds cold start | 2-3 seconds standby pools | 10-20x faster |
| **State** | Stateless (crash = restart) | Durable (crash = resume) | Reliable recovery |
| **Scheduling** | Pull model (one job at a time) | Push model (DAG-aware) | Optimal parallelization |
| **Security** | Shared runners | Isolated sandboxes | Never shared, always secure |
| **Billing** | Per-minute (rounded up) | Per-second (exact) | Fair pricing |
| **Debugging** | Restart from beginning | Replay from any step + SSH + Metrics | Faster iteration |
| **AI Features** | None | AI failure diagnosis + Agent loops | Built for AI development |

---

## Brand Assets (for graphics team)

**Official Brand Resources:**

- [Brand Assets](https://depot.dev/about/brand-assets)
- [Brand Guidelines](https://drive.google.com/file/d/1dIIvZiRsxeol2flEthiKes0046IPtdXx/view?usp=sharing)

**Key Brand Notes:**

- Use official Depot logo from brand assets
- Follow brand guidelines for color palette and typography
- Depot logo and product names should be used consistently
- GitHub Actions compatibility should be shown as "drop-in replacement" messaging

---

## End of Script
