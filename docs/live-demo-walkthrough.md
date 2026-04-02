# Live Demo Walkthrough: Railway Build Costs vs Depot CI

## Overview

This is a **live presentation script** for demonstrating the Railway build cost problem and how Depot CI solves it. Designed for:
- Sales demos
- Conference presentations
- Customer meetings
- Internal training

**Duration**: 10-15 minutes
**Format**: Live screen share + narration
**Audience**: Technical decision-makers, developers, engineering managers

---

## Demo Setup Checklist

### Prerequisites

| Item | Status | Notes |
|------|--------|-------|
| Railway project with visible credits | ⬜ | Need ~$4-5 balance for impact |
| Sample app ready to push | ⬜ | Use the OpenClaw demo app |
| Depot account configured | ⬜ | Have project ID ready |
| Two terminal windows | ⬜ | Side-by-side comparison |
| Browser with Railway dashboard | ⬜ | Show cost meter |

### What You'll Show

| Step | What Happens | Time |
|------|--------------|------|
| 1. Railway dashboard | Show current credits, recent builds | 1 min |
| 2. Trigger Railway build | Watch cost meter run up | 3 min |
| 3. Explain the problem | Do the math on costs | 2 min |
| 4. Show Depot CI alternative | Fast build + deploy | 2 min |
| 5. Compare results | Side-by-side metrics | 1 min |
| 6. Q&A | Answer questions | 5 min |

---

## Complete Demo Script

### Part 1: Set the Stage (1 minute)

**[SPEAKER]**
"Today I want to show you something that most developers don't realize. Something that's costing you money every time you deploy."

**[ACTION]** Open Railway dashboard, show project

**[SPEAKER]**
"This is a Railway project. Like many of you, I love Railway for deployment. It's simple, it's fast, and it just works."

**[HIGHLIGHT]** Point to credit balance

**[SPEAKER]**
"But notice this — $5 monthly credits. This is your Hobby Plan. Great for running your app. But did you know Railway charges you to BUILD your app too?"

---

### Part 2: The Problem — Building on Railway (3 minutes)

**[ACTION]** Open the project settings/deployments

**[SPEAKER]**
"Let me show you what happens when I push code to Railway."

**[ACTION]** Trigger a deployment (or show a recent one)

**[SPEAKER]**
"Watch this carefully. When you push to Railway, they don't just deploy. They BUILD on their infrastructure."

**[HIGHLIGHT]** Point to build progress:
```
📦 Building
  ├─ Installing dependencies (npm install)  ← 45 seconds
  ├─ Building TypeScript (tsc)              ← 30 seconds
  ├─ Building Docker image                  ← 90 seconds
  └─ Deploying to service                   ← 30 seconds

Total time: 3 minutes 15 seconds
```

**[SPEAKER]**
"Three minutes. That's not terrible, right? But watch what happens to your credits."

**[ACTION]** Zoom in on Railway cost meter or billing

**[SPEAKER]**
"Every second of that build? Railway is charging you. This one build just cost you about $0.05."

**[PAUSE — let that sink in]**

---

### Part 3: Do the Math (2 minutes)

**[SPEAKER]**
"Now, $0.05 doesn't sound like much. But let's do some math."

**[WRITE ON SCREEN or SHOW SLIDE]**
```
The Math of Railway Builds:

1 deployment  = $0.05
10 deployments = $0.50
100 deployments = $5.00
─────────────────────────────────
Your entire monthly credit? GONE.
```

**[SPEAKER]**
"If you deploy 10 times a day — pretty typical for active development — that's $1.50 a day. $45 a month. Your $5 credit is gone in 3 days."

**[ASK AUDIENCE]**
"How many of you deploy more than 10 times a day?"

**[PAUSE for response/engagement]**

**[SPEAKER]**
"Exactly. For active teams, you're not just using your credits. You're paying real money for builds. Money that should be running your app, not building it."

---

### Part 4: The Solution — Depot CI + Railway (2 minutes)

**[SPEAKER]**
"Here's the thing: Railway is AMAZING for running applications. But for building? It's expensive. And slow."

**[TRANSITION]** Open Depot CI interface or terminal

**[SPEAKER]**
"Enter Depot CI. Here's what we do differently:"

**[ACTION]** Show Depot build process (live or recording)

```
🚀 Depot CI Build
  ├─ Dependencies (CACHED)   ← 5 seconds  ✓
  ├─ TypeScript (CACHED)     ← 3 seconds  ✓
  ├─ Docker build (CACHED)   ← 8 seconds  ✓
  └─ Push to registry        ← 2 seconds  ✓

Total time: 18 seconds
```

**[SPEAKER]**
"18 seconds. Same code. Same result. But 10x faster. Why? Because Depot is built for building. Intelligent caching, distributed compute, optimized infrastructure."

**[ACTION]** Show Railway deployment

```
📦 Deploy to Railway
  ├─ Pull pre-built image    ← 5 seconds
  ├─ Health check            ← 5 seconds
  └─ Live                    ← ✓

Total time: 10 seconds
```

**[SPEAKER]**
"Then we push the pre-built image to Railway. 10 seconds. That's it. Railway just deploys. No building. No expensive compute."

**[COMBINE]**
```
Depot CI Build:   18 seconds
Railway Deploy:   10 seconds
───────────────────────────
Total:            28 seconds (vs 3:15 on Railway alone)
```

---

### Part 5: The Comparison (1 minute)

**[SHOW SLIDE or SIDE-BY-SIDE]**

```
┌───────────────────┬───────────────────┐
│  BUILD ON RAILWAY │  DEPOT → RAILWAY  │
├───────────────────┼───────────────────┤
│                   │                   │
│  Time: 3:15       │  Time: 0:28       │
│  Cost: $0.05      │  Cost: $0.01      │
│                   │                   │
│  ✓ Same Result    │  ✓ Same Result    │
│                   │                   │
└───────────────────┴───────────────────┘

Savings: 88% cheaper, 7x faster
```

**[SPEAKER]**
"Let me be clear: both approaches get your code running on Railway. But one costs you 5 cents and takes 3 minutes. The other costs a penny and takes 30 seconds."

**[EMPHASIZE]**
"This isn't about optimizing. This is about not wasting money."

---

### Part 6: The Business Case (1 minute)

**[SHOW SLIDE]**

```
Annual Cost Comparison (100 builds/month)

Building on Railway:  $██████████████████ $60/year
Depot + Railway:      $██░░░░░░░░░░░░░░░░░ $7/year

Annual Savings: $53 per developer
For 10 developers: $530/year
```

**[SPEAKER]**
"For a team of 10, that's $500 a year. For an enterprise? Thousands. And that's just for one project."

---

### Part 7: How It Works (30 seconds)

**[SPEAKER]**
"Best part? It's dead simple to set up:"

**[SHOW CODE]**
```yaml
# .github/workflows/depot-ci.yml
- name: Build with Depot
  run: depot build -t myapp:${{ github.sha }} .

- name: Deploy to Railway
  run: railway up --image myapp:${{ github.sha }}
```

**[SPEAKER]**
"Two steps. Build with Depot. Deploy to Railway. That's it."

---

### Part 8: Call to Action (30 seconds)

**[SPEAKER]**
"Railway is fantastic for what it does: running your applications. Let Depot handle what we do best: building them fast and cheap."

**[SHOW]**
```
depot.dev

Join the free beta
No credit card required
```

**[SPEAKER]**
"Stop paying Railway to build your code. Start using Depot CI. Your wallet will thank you."

---

## Audience Engagement

### Questions to Ask During Demo

| Question | When | Why |
|----------|------|-----|
| "How many times do you deploy per day?" | During math section | Gets people thinking |
| "Does anyone know their Railway build costs?" | Beginning | Reveals knowledge gap |
| "What would you do with an extra 3 minutes per deploy?" | Comparison section | Personalizes value |
| "Who's watching their Railway credits closely?" | Setup section | Creates awareness |

### Handling Objections

| Objection | Response |
|-----------|----------|
| "Railway builds aren't that expensive" | "For a single build, no. But for 100 builds/month? That's $5. Your entire credit." |
| "Depot is just another service to manage" | "One CLI command. Your existing GitHub Actions just run faster. No code changes." |
| "We don't deploy that often" | "Great! But when you DO need to deploy, wouldn't you rather it be 30 seconds than 3 minutes?" |
| "Is Depot free?" | "Yes, during beta. After GA, $0.0001/second = ~$0.003 per build. Still cheaper than Railway." |

---

## Demo Variations

### For Executive Audience
- Skip technical details
- Focus on cost savings
- Emphasize ROI
- Keep to 5 minutes

### For Developer Audience
- Show actual code
- Demonstrate caching
- Show GitHub Actions integration
- Allow 15 minutes for Q&A

### For Sales Demo
- Use customer example
- Show before/after metrics
- Include testimonial
- Close with next steps

---

## Common Technical Questions

**Q: Does this work with all Railway services?**
A: Yes, any container-based service on Railway.

**Q: What about Railway's autobuild feature?**
A: That's exactly what we're replacing — and it's costing you money.

**Q: Can I use this with existing GitHub Actions?**
A: Yes! Just replace the build step with `depot build` and deploy the image.

**Q: What about my Railway environment variables?**
A: They stay in Railway. We're just building the image, not changing your config.

---

## Follow-Up Materials

After the demo, provide:

| Material | Link |
|----------|------|
| Setup guide | [docs/setup-guide.md](./setup-guide.md) |
| GitHub secrets | [docs/github-secrets.md](./github-secrets.md) |
| Pricing | [depot.dev/pricing](https://depot.dev/pricing) |
| Video demo | [video-script.md](./video-script.md) |

---

## Practice Tips

### Before the Demo

1. **Run through it twice** — Timing matters
2. **Have backups** — Screen recordings in case live demo fails
3. **Know your numbers** — Have cost examples ready
4. **Test everything** — Railway, Depot, deployments

### During the Demo

1. **Speak slowly** — Let information sink in
2. **Highlight costs** — Make the numbers visible
3. **Pause for effect** — Especially after the math
4. **Be confident** — This is a clear win

### After the Demo

1. **Provide next steps** — Clear path to try it
2. **Collect feedback** — What resonated?
3. **Follow up** — Email within 24 hours

---

## Key Phrases That Work

- *"Railway is amazing for RUNNING apps. Let Depot handle BUILDING them."*
- *"Your $5 credit. Gone in 100 builds."*
- *"Same result. 7x faster. 88% cheaper."*
- *"Stop paying Railway to build your code."*
- *"This isn't optimization. It's common sense."*

---

## Sample Close

**[SPEAKER]**
"Look, I love Railway. You love Railway. It's great for what it does. But let's be honest: building code on expensive infrastructure? That's just leaving money on the table."

**[PAUSE]**

**[SPEAKER]**
"Railway for running. Depot for building. Your app gets deployed faster, cheaper, and you keep your credits for what matters: running your code."

**[CTA]**

**[SPEAKER]**
"Try Depot CI free during beta. One command to set up. 30 seconds to deploy. 88% cost savings. depot.dev"

---

**End of Live Demo Guide**
