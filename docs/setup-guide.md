# Depot + Railway Setup Guide

> **Note:** This guide is for the **simple sample app testing** (archived in `docs/performance-testing/simple-sample-app-testing/`). For OpenClaw AI performance testing, see [openclaw-quick-start.md](./openclaw-quick-start.md).

This guide walks you through setting up the complete Depot CI showcase demo.

## Prerequisites

| Tool | Minimum Version | Install Link |
|------|----------------|--------------|
| Node.js | 18.x | https://nodejs.org |
| npm | 9.x | Included with Node.js |
| Docker | 20.x | https://docker.com |
| Git | 2.x | https://git-scm.com |

## Quick Start

### 1. Clone and Install

```bash
git clone https://github.com/YOUR_ORG/depot-railway-build.git
cd depot-railway-build

# Run setup script
chmod +x scripts/setup.sh
./scripts/setup.sh
```

### 2. Create Depot Account

1. Go to [depot.dev](https://depot.dev)
2. Click "Get Started" or "Sign Up"
3. Create a new project: `openclaw-demo`
4. Choose GitHub authentication (recommended)
5. Authorize the Depot GitHub app

**Get your credentials:**
```bash
# After signup, get your token
depot login

# Create a project
depot project create openclaw-demo

# Note the project ID for GitHub secrets
depot project list
```

### 3. Create Railway Project

1. Go to [railway.app](https://railway.app)
2. Click "New Project"
3. Select "Deploy from Dockerfile"
4. Connect your GitHub repository
5. Add environment variables:
   - `NODE_ENV=production`
   - `PORT=3000`
   - `ANTHROPIC_API_KEY=your_key_here` (optional for demo)

**Get your credentials:**
```bash
# Install Railway CLI
npm install -g @railway/cli

# Login
railway login

# Initialize project
railway init

# Note the project and service IDs
railway status
```

### 4. Configure GitHub Secrets

Go to your GitHub repository → Settings → Secrets and Variables → Actions

Add the following secrets:

| Secret Name | Required | Description | How to Get |
|-------------|----------|-------------|------------|
| `DEPOT_PROJECT_ID` | ✅ Yes | Your Depot project ID | `depot project list` |
| `DEPOT_TOKEN` | ⚠️ Optional | Depot API token (fallback) | `depot token` or Depot dashboard |
| `RAILWAY_TOKEN` | ✅ Yes | Railway API token | `railway token` |
| `RAILWAY_PROJECT_ID` | ✅ Yes | Your Railway project ID | `railway link` |
| `RAILWAY_SERVICE_ID` | ✅ Yes | Your Railway service ID | Railway dashboard URL |

> **⚠️ Note on DEPOT_TOKEN:** This secret is **optional**. The workflow uses OIDC authentication by default (recommended). Add `DEPOT_TOKEN` only as a fallback if OIDC is not available or for edge cases like Dependabot workflows.

---

### 4.5. Set up OIDC Authentication (Recommended)

OIDC allows GitHub Actions to authenticate with Depot without storing a static token.

#### Step 1: Configure OIDC in Depot

1. Go to [depot.dev](https://depot.dev) and open your project
2. Go to **Settings** → **Trust Relationships**
3. Click **Add trust relationship**
4. Select **GitHub** as the provider
5. Enter your GitHub owner (username or organization)
6. Enter your repository name (exact match)
7. Click **Add trust relationship**

#### Step 2: Update Your Workflow

The workflow supports both OIDC (primary) and `DEPOT_TOKEN` (fallback):

```yaml
jobs:
  build:
    runs-on: depot-ubuntu-22.04
    permissions:
      contents: read
      id-token: write  # Required for OIDC
    steps:
      - uses: actions/checkout@v4
      - uses: depot/setup-action@v1
      - uses: depot/build-push-action@v1
        with:
          project: ${{ secrets.DEPOT_PROJECT_ID }}
          token: ${{ secrets.DEPOT_TOKEN }}  # Optional! Falls back to OIDC
          context: .
```

#### How Authentication Works

| Scenario | Authentication Method |
|----------|----------------------|
| OIDC configured + no `DEPOT_TOKEN` | Uses OIDC ✅ (recommended) |
| OIDC configured + `DEPOT_TOKEN` set | Uses `DEPOT_TOKEN` (token priority) |
| No OIDC + `DEPOT_TOKEN` set | Uses `DEPOT_TOKEN` ✅ |
| No OIDC + no `DEPOT_TOKEN` | Fails ❌ |

**Benefits:**

- No `DEPOT_TOKEN` secret to manage or rotate (with OIDC)
- Temporary token issued per workflow run
- Optional fallback for edge cases (Dependabot, forks, etc.)
- More secure — no static credentials to leak

For more details, see [depot-ci-auth-with-github.md](./depot-dev/depot-ci-auth-with-github.md).

---

### 5. Run Workflows

#### Baseline (GitHub Actions)

```bash
# Trigger the baseline workflow
git push origin main
# Or manually: GitHub → Actions → railway-direct.yml → Run workflow
```

#### Depot CI

```bash
# First, migrate your workflows to Depot CI
depot ci migrate

# Commit the generated .depot/ directory
git add .depot/
git commit -m "Add Depot CI configuration"
git push origin main
```

## Verification

### Check Depot Setup

```bash
# Verify Depot CLI
depot --version
depot status

# List projects
depot project list

# Test build
cd sample-app
depot build -t test .
```

### Check Railway Setup

```bash
# Verify Railway CLI
railway --version

# List projects
railway projects

# Check deployment
railway logs
```

### Test Sample App Locally

```bash
cd sample-app
npm install
npm run build
npm start

# Test with curl
curl http://localhost:3000/health
curl http://localhost:3000/skills
```

## Troubleshooting

### Depot Issues

**Problem**: `depot: command not found`
```bash
# Install Depot CLI
curl -L https://depot.dev/install.sh | sh

# Add to PATH
export PATH=$PATH:$HOME/.depot/bin

# Verify
depot --version
```

**Problem**: Authentication failed
```bash
# Re-authenticate
depot login --token YOUR_TOKEN

# Or use environment variable
export DEPOT_TOKEN=YOUR_TOKEN
```

### Railway Issues

**Problem**: `railway: command not found`
```bash
# Install via npm
npm install -g @railway/cli

# Or install script
curl -sSL https://railway.app/install.sh | sh
```

**Problem**: Deployment fails
```bash
# Check logs
railway logs

# Verify service is running
railway status

# Redeploy
railway up
```

### GitHub Actions Issues

**Problem**: Workflow fails immediately
- Check all secrets are configured correctly
- Verify secret names match exactly (case-sensitive)
- Check GitHub Actions runner has permissions

**Problem**: Depot CI workflow fails
- Verify Depot project ID is correct
- Check `depot ci migrate` was run
- Ensure `.depot/` directory is committed

## Next Steps

1. ✅ Run baseline workflow
2. ✅ Run Depot CI workflow
3. ⏳ Compare results
4. ⏳ Document findings
5. ⏳ Create demo video

---

For more help:
- [Depot Documentation](https://depot.dev/docs)
- [Railway Documentation](https://docs.railway.app)
- [GitHub Actions Documentation](https://docs.github.com/actions)
