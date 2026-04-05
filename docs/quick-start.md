# Quick Start Guide

Get the Depot CI demo running in under 10 minutes.

## Prerequisites Check

```bash
# Verify you have the basics
node --version  # Should be 18+
npm --version   # Should be 9+
docker --version # Should be 20+
```

## 5-Minute Setup

### Step 1: Install Dependencies (1 min)

```bash
cd sample-app
npm install
```

### Step 2: Build the App (1 min)

```bash
npm run build
```

### Step 3: Run Locally (1 min)

```bash
npm start
```

Test it:
```bash
curl http://localhost:3000/health
curl http://localhost:3000/skills
```

### Step 4: Test Docker Build (2 min)

```bash
docker build -t openclaw-demo .
docker run -p 3000:3000 openclaw-demo
```

## Full CI/CD Setup (10 min)

### 1. Create Accounts (3 min)

| Service | Link | Time |
|---------|------|------|
| Depot | [depot.dev](https://depot.dev) | 1 min |
| Railway | [railway.app](https://railway.app) | 2 min |

### 2. Install CLIs (2 min)

```bash
# Depot CLI (macOS)
brew install depot/tap/depot

# Depot CLI (Linux)
curl -L https://depot.dev/install-cli.sh | sh

# Railway CLI
npm install -g @railway/cli
```

### 3. Connect GitHub (1 min)

**For Depot CI migration:** Install the Depot Code Access GitHub App via the Depot dashboard at depot.dev. This is required for `depot ci migrate` to work.

### 4. Configure GitHub Secrets (3 min)

Add these to your repo's GitHub secrets:

```bash
# Get your tokens
depot login          # Get DEPOT_TOKEN
depot project list   # Get DEPOT_PROJECT_ID

railway login        # Get RAILWAY_TOKEN
railway init         # Get RAILWAY_PROJECT_ID and RAILWAY_SERVICE_ID
```

Add to GitHub: Settings → Secrets → New secret

### 5. Run Workflows (2 min)

Push to trigger:
```bash
git add .
git commit -m "Enable Depot CI demo"
git push origin main
```

Or trigger manually:
- GitHub → Actions → railway-direct.yml → Run workflow
- GitHub → Actions → depot-ci.yml → Run workflow

## What You'll See

| Workflow | Expected Time |
|----------|---------------|
| Local Docker | 9-16 minutes |
| GitHub Actions | 3-4 minutes |
| Depot CI | ~2-3 minutes |

## Troubleshooting

**Problem**: `npm install` fails
```bash
# Clear cache and retry
rm -rf node_modules package-lock.json
npm cache clean --force
npm install
```

**Problem**: Docker build fails
```bash
# Ensure Docker is running
docker ps

# Build with no cache
docker build --no-cache -t openclaw-demo .
```

**Problem**: Workflow fails immediately
```bash
# Check all secrets are set
# GitHub → Settings → Secrets → Actions
# All 5 secrets should be present
```

## Next Steps

1. Run baseline workflow
2. Run Depot CI workflow
3. Compare the timing
4. [Read full setup guide](./setup-guide.md)

---

**Need help?** See [setup-guide.md](./setup-guide.md) or [github-secrets.md](./github-secrets.md)
