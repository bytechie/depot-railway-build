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
│   ├── deployment-workflows.md  # All deployment targets
│   ├── all-flows-comparison.md  # Complete 4-flows analysis ⭐
│   ├── openclaw-analysis.md    # OpenClaw deep dive
│   ├── comparison-results.md   # Performance comparison (all flows)
│   ├── railway-cost-video-script.md # Railway cost video ⭐
│   ├── live-demo-walkthrough.md # Live presentation guide ⭐
│   ├── demo-video-storyboard.md # Video production guide
│   ├── video-script.md      # Recording script with timestamps
│   └── stakeholder-presentation.md # Executive deck
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

**📊 Full comparison:** See [all-flows-comparison.md](./docs/all-flows-comparison.md)
| **5. Depot CI → AWS/GCP/Azure/Fly** | Multi-platform deployments | ✅ Implemented |

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

**📊 Full comparison:** See [all-flows-comparison.md](./docs/all-flows-comparison.md)

## Deployment Options

Depot CI supports deployment to multiple platforms. Choose your target:

| Platform | Workflow | Setup Complexity | Best For |
|----------|----------|------------------|----------|
| **Railway** | `depot-ci.yml` | ⭐ Very Easy | Quick demos, small apps |
| **AWS ECS** | `depot-ci-aws.yml` | ⭐⭐⭐ Medium | Enterprise, AWS stack |
| **Google Cloud Run** | `depot-ci-gcp.yml` | ⭐⭐ Easy | Serverless, GCP users |
| **Azure ACI** | `depot-ci-azure.yml` | ⭐⭐⭐ Medium | Microsoft stack |
| **Fly.io** | `depot-ci-fly.yml` | ⭐⭐ Easy | Edge deployments |

**See also:** [Deployment Workflows Guide](./docs/deployment-workflows.md)

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
| [All Flows Comparison](./docs/all-flows-comparison.md) | Complete 4-flows analysis ⭐ |
| [API Endpoints](./docs/api-endpoints.md) | REST API reference |
| [OpenClaw Analysis](./docs/openclaw-analysis.md) | OpenClaw deep dive |
| [Comparison Results](./docs/comparison-results.md) | Performance metrics (all flows) |
| [Deployment Workflows](./docs/deployment-workflows.md) | All platform deployments |

### Media & Presentations

| Document | Description |
|----------|-------------|
| [Railway Cost Video Script](./docs/railway-cost-video-script.md) | 90s Railway cost video ⭐ |
| [Live Demo Walkthrough](./docs/live-demo-walkthrough.md) | Live presentation script ⭐ |
| [Demo Video Storyboard](./docs/demo-video-storyboard.md) | Video production guide |
| [Video Script](./docs/video-script.md) | Recording script with timestamps |
| [Stakeholder Presentation](./docs/stakeholder-presentation.md) | 17-slide executive deck |

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
