# Depot & Depot CI: Summary

## What is Depot?

Depot is a modern developer platform built for the AI-augmented development era. It started by making container builds **40x faster** and is now building a complete software delivery platform.

### The Problem Depot Solves

The bottleneck in software development has shifted:

- **Old world**: Writing code was the bottleneck
- **New world**: Integrating code is the bottleneck

With AI coding agents like Claude Code and Cursor, a team of 10 engineers can now produce output like 100. Traditional CI systems (GitHub Actions, CircleCI, Buildkite) were designed for a world where humans batch up code, push it, and wait. A 15-minute pipeline was annoying but survivable.

**That world is gone.**

---

## What is Depot CI?

Depot CI is a **programmable CI engine** with performance as a first-class citizen. It's designed as a faster, more reliable alternative to traditional CI systems, built specifically for modern software engineering workflows.

### Current Status

| Aspect | Details |
|--------|---------|
| **Status** | Generally Available (GA) |
| **Pricing** | Per-second billing: $0.0001–$0.0032/second depending on sandbox size (2-CPU to 64-CPU) |
| **Free Trial** | 7 days, full access, no credit card required |
| **Plans** | Start at $20/month with 2,000 build minutes included |

---

## Key Features

### GitHub Actions Compatible

Run your existing GitHub Actions workflows on Depot CI:

```bash
depot ci migrate  # Copy workflows from .github/workflows to .depot/workflows
```

- Same YAML syntax
- Automated migration handles compatibility fixes
- Run both systems in parallel during testing

### Performance-First Architecture

| Feature | GitHub Actions | Depot CI | Improvement |
|---------|---------------|----------|-------------|
| **Startup** | Variable cold start | 2-3 seconds standby pools | 10-20x faster |
| **State** | Stateless (crash = restart) | Durable state machine with retry support | Reliable recovery |
| **Scheduling** | Job-based scheduling | DAG-aware orchestration | Optimal parallelization |
| **Billing** | Per-minute (rounded up) | Per-second (exact) | Fair pricing |
| **Debugging** | Restart from beginning | Retry failed jobs + SSH debugging | Faster iteration |
| **AI Features** | None | AI failure diagnosis + Agent loops | Built for AI development |

### AI-Native Features

#### AI Failure Diagnosis

When a job fails, Depot CI automatically analyzes the failure and displays:

- **What went wrong**: AI-generated explanation of the root cause
- **Suggested fix**: Actionable steps to resolve the issue

No more digging through thousands of lines of logs or guessing at the root cause.

#### Coding Agent Integration

Depot CI is built for AI coding agents (Claude Code, Cursor, etc.):

![The Agent Fix-CI Loop](depot-dev/agent-loop.png)

**Traditional CI**: `push → wait → guess → fix → push → wait → guess`

**Depot CI with agents**: `fix → run → fix → run → fix → green`

---

## Depot CI Architecture

Depot CI has a **three-part modular architecture**:

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
│  │  • Sandboxes with pre-warmed environment                 │   │
│  │  • SSH debugging, metrics, logs                           │   │
│  │  • Per-second billing                                     │   │
│  └──────────────────────────────────────────────────────────┘   │
│                                                                 │
└─────────────────────────────────────────────────────────────────┘
```

### Frontend Layer

- Parses GitHub Actions YAML
- Validates and converts workflows
- **Extensible**: Future support for GitLab CI, Jenkins, etc.

### Orchestrator Layer (Switchyard)

The "brain" of Depot CI:

- **Workflow Parser**: Extracts jobs, steps, and dependencies
- **Dependency Resolution**: Builds a DAG (Directed Acyclic Graph) to identify parallelizable jobs
- **Durable State Machine**: Like AWS SWF or Temporal — state persists throughout job lifecycle
- **Task Scheduler**: Explicitly schedules tasks based on optimal ordering

### Compute Layer

- **Standby Pools**: Pre-warmed environments ready for instant startup
- **Fast Startup**: Jobs start in 2-3 seconds
- **Isolated Sandboxes**: Each job runs in a dedicated environment
- **SSH Access**: Debug directly into running sandboxes

---

## DAG Resolution: How Depot CI Schedules Jobs

Depot CI's Switchyard orchestrator uses DAG (Directed Acyclic Graph) resolution to optimize workflow execution:

- **Workflow Parser**: Extracts jobs, steps, and dependencies from your workflow
- **Dependency Resolution**: Builds a DAG to identify which jobs can run in parallel
- **Durable State Machine**: Tracks state throughout job lifecycle and handles failures & retries
- **Task Scheduler**: Optimally schedules tasks based on dependency ordering

---

## Key CLI Commands

```bash
# Run workflow against local changes
depot ci run --workflow .depot/workflows/ci.yml

# Scope to specific job for faster iteration
depot ci run --job test

# Check full run status
depot ci status

# Get logs for a failed job
depot ci logs <run-id> --job <job-key>

# SSH into running sandbox
depot ci ssh <run-id>

# Run with SSH pause after specific step
depot ci run --ssh-after-step 3

# Migrate from GitHub Actions
depot ci migrate
```

---

## Value Proposition

### Time Savings

Based on Run 3 testing (Depot CI 2m 20s avg vs GitHub Actions 3m 47s avg):

- 100 builds/day × 1.5 min saved = 150 min/day
- 150 min/day × 5 days = 750 min/week
- 750 min/week × 50 weeks = 37,500 min/year
- **That's ~625 hours per year, or ~16 full work weeks**

### Cost Savings

- Per-second billing means you only pay for what you actually use
- No rounding up to the nearest minute

### Developer Experience

- Fast builds mean more iterations
- More iterations mean better products
- Better products mean happier customers

---

## Getting Started

1. **Sign up**: [depot.dev/sign-up](https://depot.dev/sign-up) — 7-day free trial
2. **Install CLI**:
   - macOS: `brew install depot/tap/depot`
   - Linux: `curl -L https://depot.dev/install-cli.sh | sh`
3. **Login**: `depot login`
4. **Connect GitHub**: Install Depot Code Access GitHub App via Depot dashboard
5. **Migrate workflows**: `depot ci migrate`

---

## References

- [Depot CI Overview](https://depot.dev/docs/ci/overview)
- [Depot CI Metrics - AI Failure Diagnosis](https://depot.dev/docs/ci/observability/depot-ci-metrics)
- [Coding Agent Integration](https://depot.dev/docs/ci/how-to-guides/coding-agents)
- [Brand Assets](https://depot.dev/about/brand-assets)
- [Depot Blog](https://depot.dev/blog)

---

**Tagline**: *"Stop waiting for your builds. Start shipping."*
