# Depot + Railway Integration

## Overview

This project showcases **Depot CI** — a programmable CI engine designed for the AI-augmented development era, using **OpenClaw** as the demonstration application.

### What is Depot CI?

Traditional CI systems (GitHub Actions, CircleCI, Buildkite) were designed for a world where engineers batch up code and wait. That world is gone. With AI agents, a team of 10 engineers can now produce output like 100 — and old CI architectures can't keep up.

### Depot CI Features

| Feature | Description |
|---------|-------------|
| **Fast orchestration** | Compute subsystem fine-tuned for performance |
| **Durable orchestrator** | Switchyard manages workloads reliably |
| **API-first design** | Works for engineers at terminals and autonomous agents |
| **GitHub Actions compatibility** | Bring your existing workflows, run them faster |
| **40x faster builds** | Via intelligent caching and distributed compute |
| **Multi-platform deployment** | Railway, AWS, GCP, Azure, Fly.io, and more |

### Demo Application: OpenClaw

We're using **OpenClaw** — a viral personal AI assistant created by @steipete — as our demo application.

- **24/7 AI assistant** that runs on your own hardware
- **Chat app integration** (WhatsApp, Telegram, Discord, iMessage)
- **Extensible skills system** for autonomous tasks
- **Endorsed by** Andrej Karpathy, Nat Eliason, and 100+ tech leaders

> *"OpenClaw is a game changer... The future of how normal people will use AI."* — @tysonhutchins_

## Project Structure

```
depot-railway-build/
├── sample-app/              # OpenClaw-inspired demo app
│   ├── src/                 # TypeScript source
│   │   ├── types.ts         # Type definitions
│   │   ├── skills/          # Extensible skills system
│   │   ├── ai/              # AI model integrations
│   │   └── index.ts         # Entry point
│   ├── Dockerfile           # Multi-stage build
│   ├── package.json         # Dependencies
│   └── railway.json         # Railway config
│
├── .github/workflows/       # CI/CD workflows
│   ├── railway-direct.yml   # Flow 3: Baseline (Railway)
│   ├── depot-ci.yml         # Flow 4: Depot CI (Railway)
│   ├── depot-ci-aws.yml     # Depot CI → AWS ECS
│   ├── depot-ci-gcp.yml     # Depot CI → Google Cloud Run
│   ├── depot-ci-azure.yml   # Depot CI → Azure ACI
│   └── depot-ci-fly.yml     # Depot CI → Fly.io
│
├── .github/workflows-openclaw/  # Real OpenClaw testing 🦞
│   ├── depot-ci-openclaw.yml    # Depot CI + OpenClaw
│   └── github-actions-baseline-openclaw.yml  # Baseline for comparison
│
├── scripts/                 # Automation scripts
│   ├── setup.sh             # Automated setup
│   └── benchmark.sh         # Local benchmarking
│
├── docs/                    # Documentation
│   ├── quick-start.md       # 10-minute setup guide
│   ├── setup-guide.md       # Complete walkthrough
│   ├── github-secrets.md    # Secrets configuration
│   ├── faq.md               # Common questions
│   ├── api-endpoints.md     # REST API reference
│   ├── openclaw-analysis.md # OpenClaw deep dive
│   ├── openclaw-performance-guide.md  # Real OpenClaw testing 🦞
│   ├── depot-summary.md     # Depot CI overview
│   ├── performance-test-guide.md  # Flow measurement guide
│   ├── live-demo-walkthrough.md   # Live presentation guide
│   ├── recording-checklist.md     # Video production checklist
│   ├── video-script.md      # Depot vs GitHub Actions video script
│   └── stakeholder-presentation.md # Executive deck
│   └── performance-testing/
│       ├── comparison-summary.md   # Complete test results ⭐
│       └── test-case-instructions.md  # Test case guide
│
└── README.md
```

## Design Flows

| Flow | Description | Time | Cost | Best For |
|------|-------------|------|------|----------|
| **1. Local → Railway** | Build locally, deploy via CLI | 2-4 min | Free | Quick testing, solo devs |
| **2. Commit → Railway** | Railway auto-build on push | 3-5 min | ~$0.05 | Zero config, low frequency |
| **3. GitHub Actions → Railway** | CI builds, then deploys | 3-5 min | ~$0.01 | Teams needing CI |
| **4. Depot CI → Railway** | Depot CI builds, then depots ⭐ | 30-60s | ~$0.01 | **Production** ⭐ |

**📊 Full comparison:** See [comparison-summary.md](./docs/performance-testing/comparison-summary.md)
| **5. Depot CI → AWS/GCP/Azure/Fly** | Multi-platform deployments | ✅ Implemented |

## Real OpenClaw Performance Testing 🦞

**NEW: Test with the actual OpenClaw application!**

OpenClaw is a production-grade personal AI assistant with a complex build pipeline:
- **13,301-line** pnpm-lock.yaml
- **Multi-stage** Docker build (265 lines)
- **Bun + pnpm** build system
- **50+ source** directories

### Why Test Real OpenClaw?

| Sample App | Real OpenClaw |
|------------|---------------|
| ~50 dependencies | 500+ dependencies |
| 20-60s build time | 2-15 min build time |
| Simplified for demo | Production-grade complexity |
| Good for basics | **Real-world results** |

### OpenClaw Performance Testing

| Test Case | Changes | Expected Cache |
|-----------|---------|----------------|
| **Baseline** | None | ~100% |
| **Comment** | README comment | ~90% |
| **Function** | New source file | ~70% |
| **Dependency** | New npm package | ~30% |
| **Major** | Multiple changes | ~10% |

**Expected Performance:**
- **GitHub Actions:** 3-15 minutes (depending on cache)
- **Depot CI:** 30-180 seconds (4-7x faster)

**Get Started:** [openclaw-performance-guide.md](./docs/openclaw-performance-guide.md)

## Quick Start

### Option A: Automated Setup (Recommended)

```bash
# Clone and run setup script
git clone https://github.com/YOUR_ORG/depot-railway-build.git
cd depot-railway-build
chmod +x scripts/setup.sh
./scripts/setup.sh
```

### Option B: Manual Setup

```bash
# Clone repository
git clone https://github.com/YOUR_ORG/depot-railway-build.git
cd depot-railway-build

# Run locally
cd sample-app
npm install
npm run build
npm start

# Or with Docker
docker build -t openclaw-demo .
docker run -p 3000:3000 openclaw-demo
```

**See also:** [Quick Start Guide](./docs/quick-start.md)

## Expected Results

### All 4 Flows Performance Comparison

| Flow | Total Time | Cost/Build | Monthly (100 builds) | Best For |
|------|------------|------------|---------------------|----------|
| **Flow 1: Local → Railway** | 2-4 min | $0.00 | $0 | Quick testing |
| **Flow 2: Git Push → Railway** | 3-5 min | ~$0.05 | ~$5 | Zero config |
| **Flow 3: GitHub Actions → Railway** | 3-5 min | ~$0.01 | ~$1 | Teams needing CI |
| **Flow 4: Depot CI → Railway** ⭐ | 30-60s | ~$0.01 | ~$1 | **Production** |

### Depot CI vs Traditional CI

| Metric | GitHub Actions | Depot CI | Improvement |
|--------|----------------|----------|-------------|
| Dependencies | 45s | 5s | **9x faster** |
| TypeScript Build | 30s | 3s | **10x faster** |
| Docker Build | 90s | 8s | **11x faster** |
| **Total Time** | **4-7 min** | **20-60s** | **5-10x faster** |

### Cost Savings

| Approach | Build Time | Cost/Build | Monthly (100 builds) |
|----------|------------|------------|----------------------|
| Railway Auto-Build | 3-5 min | ~$0.05 | ~$5 |
| GitHub Actions | 4-7 min | ~$0.01 | ~$1 |
| **Depot CI** | 20-60s | ~$0.01 | ~$1 |

**Savings**: ~80% on CI/CD compute costs vs Railway auto-build

**📊 Full comparison:** See [comparison-summary.md](./docs/performance-testing/comparison-summary.md)

## Deployment Options

Depot CI supports deployment to multiple platforms. Choose your target:

| Platform | Workflow | Setup Complexity | Best For |
|----------|----------|------------------|----------|
| **Railway** | `depot-ci.yml` | ⭐ Very Easy | Quick demos, small apps |
| **AWS ECS** | `depot-ci-aws.yml` | ⭐⭐⭐ Medium | Enterprise, AWS stack |
| **Google Cloud Run** | `depot-ci-gcp.yml` | ⭐⭐ Easy | Serverless, GCP users |
| **Azure ACI** | `depot-ci-azure.yml` | ⭐⭐⭐ Medium | Microsoft stack |
| **Fly.io** | `depot-ci-fly.yml` | ⭐⭐ Easy | Edge deployments |

**See also:** [Performance Test Guide](./docs/performance-test-guide.md) for flow measurements

## Documentation

### Getting Started

| Document | Description |
|----------|-------------|
| [Quick Start](./docs/quick-start.md) | Get running in 10 minutes |
| [Setup Guide](./docs/setup-guide.md) | Complete setup walkthrough |
| [GitHub Secrets](./docs/github-secrets.md) | Configure secrets step-by-step |
| [FAQ](./docs/faq.md) | Common questions answered |

### Reference

| Document | Description |
|----------|-------------|
| [Comparison Summary](./docs/performance-testing/comparison-summary.md) | Complete performance test results ⭐ |
| [OpenClaw Performance Guide](./docs/openclaw-performance-guide.md) | Real OpenClaw testing 🦞 |
| [API Endpoints](./docs/api-endpoints.md) | REST API reference |
| [OpenClaw Analysis](./docs/openclaw-analysis.md) | OpenClaw deep dive |
| [Depot Summary](./docs/depot-summary.md) | Depot CI overview and features |
| [Performance Test Guide](./docs/performance-test-guide.md) | Flow measurement guide |
| [Test Case Instructions](./docs/performance-testing/test-case-instructions.md) | Test case scenarios |

### Media & Presentations

| Document | Description |
|----------|-------------|
| [Video Script](./docs/video-script.md) | Depot vs GitHub Actions video ⭐ |
| [Live Demo Walkthrough](./docs/live-demo-walkthrough.md) | Live presentation guide ⭐ |
| [Recording Checklist](./docs/recording-checklist.md) | Video production checklist |
| [Stakeholder Presentation](./docs/stakeholder-presentation.md) | Executive presentation deck |

## Setup Instructions

### Prerequisites

1. **Depot Account** — Sign up at [depot.dev](https://depot.dev) (free during beta)
2. **Platform Account** — Railway, AWS, GCP, Azure, or Fly.io
3. **GitHub Repository** — Fork this repo

### GitHub Secrets Configuration

| Secret | Required For | Description |
|--------|--------------|-------------|
| `DEPOT_TOKEN` | All workflows | Depot API authentication |
| `DEPOT_PROJECT_ID` | All workflows | Your Depot project ID |
| `RAILWAY_TOKEN` | Railway | Railway API token |
| `RAILWAY_PROJECT_ID` | Railway | Railway project ID |
| `RAILWAY_SERVICE_ID` | Railway | Railway service ID |
| `AWS_ACCESS_KEY_ID` | AWS | AWS access key |
| `AWS_SECRET_ACCESS_KEY` | AWS | AWS secret key |
| `GCP_PROJECT_ID` | GCP | GCP project ID |
| `GCP_SA_KEY` | GCP | Service account key (JSON) |
| `AZURE_CREDENTIALS` | Azure | Azure credentials (JSON) |
| `ACR_REGISTRY` | Azure | Container Registry URL |
| `FLY_API_TOKEN` | Fly.io | Fly.io API token |

**Detailed instructions:** [GitHub Secrets Guide](./docs/github-secrets.md)

## Why This Integration Matters

### The Railway Build Cost Problem

Railway charges for build resources based on actual consumption. With:
- Frequent deployments
- Large, resource-intensive builds
- Long compilation times

**Fast builds = minimal cost impact, slow builds = higher charges**

### How Depot Helps

| Before | After |
|:---|:---|
| Slow builds on Railway consume expensive compute | Fast builds on Depot reduce Railway resource usage |
| Long build times = higher costs | 40x faster builds = lower costs |
| Build inefficiencies eat credits | Optimized builds preserve credits for runtime |

## Scripts

### Setup Script
```bash
./scripts/setup.sh
```
Automated setup with prerequisite checking and verification.

### Benchmark Script
```bash
./scripts/benchmark.sh
```
Run local benchmarks comparing build approaches.

## Next Steps

- [ ] Set up Depot account and project
- [ ] Choose deployment target (Railway/AWS/GCP/Azure/Fly)
- [ ] Configure GitHub secrets
- [ ] Run baseline workflow
- [ ] Run Depot CI workflow
- [ ] Document actual metrics
- [ ] Create demo video (use [video-script.md](./docs/video-script.md))
- [ ] Share with stakeholders (use [stakeholder-presentation.md](./docs/stakeholder-presentation.md))

## References

- [Depot Documentation](https://depot.dev/docs)
- [Depot CI Announcement](https://depot.dev/blog/depot-raises-series-a)
- [Depot API](https://depot.dev/docs/api/overview)
- [OpenClaw Website](https://openclaw.ai/)
- [Railway Documentation](https://docs.railway.app/)

## License

MIT

---

**Built to showcase Depot CI — 40x faster builds for the AI-augmented development era.**
