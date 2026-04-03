# Performance Test Guide: All 4 Flows

> **Note:** This guide is for the **simple sample app testing** (archived in `docs/performance-testing/simple-sample-app-testing/`). For OpenClaw AI performance testing (GitHub Actions vs Depot CI), see [openclaw-quick-start.md](../openclaw-quick-start.md).

This guide walks through running and measuring all 4 deployment flows with actual timing data.

---

## 📋 Before You Begin

**IMPORTANT:** Complete the initial setup first before running performance tests.

👉 **Follow [setup-guide.md](../setup-guide.md) to:**

1. Create Depot account and project
2. Create Railway project and service
3. Install Depot and Railway CLIs
4. Get all required tokens and IDs

The setup guide provides step-by-step instructions for:
- Creating your Depot project (get `DEPOT_PROJECT_ID`)
- Setting up OIDC authentication
- Creating Railway service (get `RAILWAY_PROJECT_ID` and `RAILWAY_SERVICE_ID`)
- Generating API tokens (`RAILWAY_TOKEN`)

**Once setup is complete, return here to run the performance tests.**

---

## Prerequisites

| Account | What You Need |
|---------|---------------|
| **GitHub** | Repository with workflows |
| **Railway** | Project + Service ID + Token |
| **Depot** | Project ID + Token |

---

## GitHub Secrets Configuration

Add these secrets to your GitHub repository (Settings → Secrets and variables → Actions):

> **Note:** You should have obtained these values from completing [setup-guide.md](../setup-guide.md).

| Secret | Required | Description | Source |
|--------|----------|-------------|--------|
| `DEPOT_PROJECT_ID` | ✅ Yes | Your Depot project ID | From Depot dashboard or `depot project list` |
| `DEPOT_TOKEN` | ⚠️ Optional | Depot API token (fallback) | From Depot dashboard |
| `RAILWAY_TOKEN` | ✅ Yes | Railway API token | Railway Settings → API Tokens |
| `RAILWAY_PROJECT_ID` | ✅ Yes | Your Railway project ID | Railway project page URL |
| `RAILWAY_SERVICE_ID` | ✅ Yes | Your Railway service ID | Railway service page URL |

> **OIDC Authentication:** The workflows use OIDC for Depot authentication by default (no `DEPOT_TOKEN` secret needed). The `DEPOT_TOKEN` is an optional fallback if OIDC is not configured. Ensure the OIDC trust relationship is configured in your Depot project settings as described in [setup-guide.md](../setup-guide.md).

---

## Flow 1: Local Build → Railway

**Purpose:** Baseline local build time + manual deploy

```bash
# Navigate to sample app
cd sample-app

# Clean build (for fair comparison)
rm -rf node_modules dist

# Time the build
time npm install
time npm run build
time docker build -t openclaw-demo:local .

# Deploy via Railway CLI
time railway up
```

**What to Measure:**
| Stage | Command | Record |
|-------|---------|--------|
| Dependencies | `npm install` | ___ seconds |
| TypeScript | `npm run build` | ___ seconds |
| Docker | `docker build` | ___ seconds |
| Deploy | `railway up` | ___ seconds |
| **TOTAL** | | ___ seconds |

---

## Flow 2: Git Push → Railway (Auto-Build)

**Purpose:** Measure Railway's built-in build process

### Setup

1. In Railway, enable **GitHub integration** for your project
2. Connect the repository
3. Enable **Automatic Deployments**

### Run Test

```bash
# Make a trivial change
echo "# Test $(date)" >> sample-app/README.md

# Commit and push
git add sample-app/README.md
git commit -m "Test Flow 2: Railway auto-build"
git push origin main

# Start timer immediately
date

# Watch Railway dashboard for build progress
# Record: Start time → Build complete → Deploy complete
```

**What to Measure:**
| Stage | Record |
|-------|--------|
| Queue time | ___ seconds |
| Build time | ___ seconds |
| Deploy time | ___ seconds |
| **TOTAL** | ___ seconds |

**Expected:** 3-5 minutes | **Cost:** ~$0.05/build

---

## Flow 3: GitHub Actions → Railway

**Purpose:** Traditional CI/CD baseline

### Trigger the Workflow

```bash
# Make a trivial change
echo "# Test $(date)" >> sample-app/README.md

# Commit and push
git add sample-app/README.md
git commit -m "Test Flow 3: GitHub Actions baseline"
git push origin main

# Go to GitHub Actions tab to watch progress
# Record times from workflow run
```

### What to Measure in GitHub Actions

| Job | Step | Record from GitHub UI |
|-----|------|----------------------|
| **build** | Checkout + Setup | ___ seconds |
| | Install dependencies | ___ seconds |
| | Run linter | ___ seconds |
| | Run tests | ___ seconds |
| | Build application | ___ seconds |
| **deploy** | Download artifacts | ___ seconds |
| | Deploy to Railway | ___ seconds |
| **TOTAL** | | ___ seconds |

**Expected:** 3-5 minutes | **Cost:** ~$0.01/build

---

## Flow 4: Depot CI → Railway ⭐

**Purpose:** Measure Depot's performance improvement

### Trigger the Workflow

```bash
# Make a trivial change
echo "# Test $(date)" >> sample-app/README.md

# Commit and push to trigger Depot workflow
git add sample-app/README.md
git commit -m "Test Flow 4: Depot CI"
git push origin main

# Go to GitHub Actions tab to watch progress
```

### What to Measure

| Job | Step | Record from GitHub UI |
|-----|------|----------------------|
| **depot-build** | Checkout + Setup | ___ seconds |
| | Install dependencies | ___ seconds |
| | Depot Docker build | ___ seconds |
| | Tests | ___ seconds |
| | TypeScript build | ___ seconds |
| **deploy** | Deploy to Railway | ___ seconds |
| **TOTAL** | | ___ seconds |

**Expected:** 30-60 seconds | **Cost:** ~$0.01/build

---

## Results

Comprehensive performance test results are available at:

**[comparison-summary.md](./performance-testing/comparison-summary.md)**

This includes:
- Complete results table with all 4 flows and 5 test cases
- Head-to-head comparisons (Depot vs GitHub, Depot vs Railway, etc.)
- Detailed breakdowns of each test case
- Recommendations and migration guide

---

## Testing Tips

1. **Run each flow 3+ times** — Cache hits vary on first run
2. **Test on clean builds** — Delete `node_modules` before Flow 1
3. **Record queue times** — GitHub Actions queue during peak hours
4. **Check Railway dashboard** — Build times are visible there
5. **Use workflow_dispatch** — Manually trigger to avoid queue variance

---

## Troubleshooting

### Flow 4 fails with "depot: command not found"
- Depot CLI is pre-installed on `depot-ubuntu-22.04` runners
- Remove the manual install step if present

### Railway deployment fails
- Verify `RAILWAY_SERVICE_ID` matches your service URL
- Check Railway token has project access

### No timing data in GitHub Actions
- Each step shows duration in the UI
- Click into the workflow run for detailed timing

---

## Quick Reference: Trigger All Flows

```bash
# Flow 1: Local (manual)
cd sample-app && time npm ci && time npm run build

# Flow 2: Railway auto-build
git commit --allow-empty -m "Trigger Railway" && git push

# Flow 3: GitHub Actions
# (triggered automatically on push to main)

# Flow 4: Depot CI
# (triggered automatically on push to main)
```

After each flow, record times from the respective platform's dashboard.

---

## Need Help with Setup?

If you haven't completed the initial setup yet, refer to:

- **[setup-guide.md](../setup-guide.md)** — Complete setup walkthrough (Depot, Railway, GitHub)
- **[quick-start.md](../quick-start.md)** — Quick reference for common commands
- **[github-secrets.md](../github-secrets.md)** — Detailed secrets configuration guide
