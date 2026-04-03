# Frequently Asked Questions

## General Questions

### What is Depot CI?

Depot CI is a programmable CI engine built with performance as a first-class citizen. It's designed for the AI-augmented development era where teams using AI agents can produce 10x the code — and traditional CI systems can't keep up.

### Why did you choose OpenClaw for the demo?

OpenClaw is the perfect showcase because:
- It's a viral AI project with massive buzz
- It represents the future of personal AI agents
- It has a real-world tech stack (Node.js/TypeScript)
- It tells a compelling story about AI development velocity

### Is Depot CI a replacement for GitHub Actions?

Not necessarily — it's compatible with GitHub Actions. You can bring your existing GitHub Actions workflows and run them on Depot CI infrastructure for better performance.

## Technical Questions

### What are the system requirements?

- Node.js 18+
- Docker 20+
- Git 2.x+
- A Depot account (free during beta)

### How much does Depot CI cost?

During beta: **Free**

After GA: $0.0001 per second for base runners (approximately $0.36/hour)

### Does Depot CI work with other platforms?

Yes! Depot CI can deploy to:
- AWS (ECS, EKS, Lambda)
- Google Cloud (Run, GKE)
- Azure (Container Instances, AKS)
- Any Docker-compatible platform

### What caching mechanisms does Depot CI use?

Depot CI uses:
- **Distributed layer caching** across all builds
- **Dependency caching** for npm, yarn, pnpm, etc.
- **Incremental compilation** for TypeScript, Go, Rust
- **Global cache** shared across your organization

## Setup Questions

### Do I need to rewrite my workflows?

No! Depot CI is GitHub Actions compatible. Simply run:
```bash
depot ci migrate
```
This analyzes your workflows and creates Depot CI equivalents.

### What secrets do I need to configure?

| Secret | Purpose |
|--------|---------|
| `DEPOT_TOKEN` | Authenticate with Depot |
| `DEPOT_PROJECT_ID` | Identify your Depot project |

See [github-secrets.md](./github-secrets.md) for detailed instructions.

### Can I run this locally without Depot CI?

Yes! The sample app works locally:
```bash
cd sample-app
npm install
npm run build
npm start
```

You can also build and run with Docker:
```bash
docker build -t openclaw-demo .
docker run -p 3000:3000 openclaw-demo
```

## Performance Questions

### How much faster is Depot CI really?

Based on our comprehensive performance testing with OpenClaw AI (500+ dependencies):

**vs GitHub Actions:**
- **Average: 1.9x faster** (1m 59s vs 3m 43s)
- Baseline (cold): 1.7x faster
- Documentation change: 1.4x faster
- New source file: 1.4x faster
- UI component: 1.3x faster
- New dependency: 3.3x faster
- Major changes: 2.1x faster

See [OPENCLAW-FINAL-RESULTS.md](./performance-testing/openclaw-ai-testing/OPENCLAW-FINAL-RESULTS.md) for complete results.

### Will my results vary?

Yes, actual performance depends on:
- Your project's dependency tree
- Your geographic location
- Cache hit rates
- Concurrent workflows

However, most teams see **at least 1.5-2x improvement** vs GitHub Actions, with even greater gains for dependency-heavy builds.

### What about first-time builds?

First builds (cold cache) still benefit from:
- Optimized infrastructure (faster CPUs, better networking)
- Better layer caching than GitHub Actions
- Depot CI: 1m 51s cold build vs GitHub Actions: 3m 4s (1.7x faster)

Subsequent builds see the full benefit of distributed caching.

## Troubleshooting

### Workflow fails with "project not found"

- Verify `DEPOT_PROJECT_ID` is correct
- Check the project exists in your Depot dashboard
- Ensure you have permissions to access it

### Workflow fails with "authentication failed"

- Verify all tokens are valid and not expired
- Regenerate tokens if needed
- Check secret names match exactly (case-sensitive)

### Docker build is still slow

- First builds are slower (cache warming)
- Check if `DOCKER_BUILDKIT=1` is set
- Verify multi-stage build is being used
- Review Dockerfile for optimization opportunities

## Demo Questions

### Can I customize the demo app?

Yes! The sample app is open-source (MIT license). You can:
- Add new skills to the skills system
- Integrate different AI models
- Modify the REST API
- Add authentication
- Connect to real services

### How do I run performance tests?

Complete performance test results are available at:
**[OPENCLAW-FINAL-RESULTS.md](./performance-testing/openclaw-ai-testing/OPENCLAW-FINAL-RESULTS.md)**

For testing setup and instructions, see:
- **[OpenClaw Comparison Guide](./performance-testing/openclaw-ai-testing/OPENCLAW-COMPARISON-GUIDE.md)** — How to run CI tests
- **[COMPREHENSIVE-ANALYSIS.md](./performance-testing/openclaw-ai-testing/COMPREHENSIVE-ANALYSIS.md)** — Complete 30-test analysis

### Can I use this for my own projects?

Yes! The patterns demonstrated here apply to any Node.js/TypeScript project:
- Multi-stage Docker builds
- GitHub Actions workflows
- Depot CI integration
- Container registry deployment

## Support

### Where can I get help?

- **Depot Documentation**: [depot.dev/docs](https://depot.dev/docs)
- **Depot Discord**: [discord.gg/depot](https://discord.gg/depot)
- **GitHub Issues**: [github.com/depot/depot-ci](https://github.com/depot/depot-ci/issues)

### Is there a community forum?

Join the conversation:
- **Discord**: [discord.gg/depot](https://discord.gg/depot)
- **X/Twitter**: [@depotdev](https://x.com/depotdev)
- **GitHub Discussions**: [github.com/depot/depot-ci/discussions]

---

Still have questions? Feel free to open an issue or join our Discord!
