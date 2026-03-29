# Depot CI Additional Notes

## Durable Storage vs Persistent Storage

Are they the same thing?

They're very similar and often used interchangeably, but there's a subtle distinction:

| Term | Emphasis | Example |
| :--- | :--- | :--- |
| **Persistent** | Data survives power cycles / reboots | Hard drive, SSD, database |
| **Durable** | Data survives failures / crashes | Distributed consensus (etcd), write-ahead logs |

### In Practice

- **Persistent** = "writes to disk, not RAM"
- **Durable** = "writes survive failures, can be recovered"

### For Depot CI's Switchyard

"Durable state machine" means both: state is persisted to storage **and** designed to recover from infrastructure failures. The term "durable" emphasizes that even if a component crashes, the workflow state isn't lost and can resume exactly where it left off.

---

## What is a Sandbox in Depot CI? Is That the Build Agent?

Based on the [Depot documentation](https://depot.dev/docs/ci/how-to-guides/debug-with-ssh), a sandbox is the compute environment where your job runs — think of it as an isolated virtual machine. It's not quite the build agent itself, but rather the provisioned infrastructure that executes the job.

### Key Points

- **Sandbox = The Execution Environment**: When a Depot CI job runs, Depot provisions a sandbox (isolated compute resource) where your workflow steps execute. This is what actually runs your GitHub Actions workflow.

- **Not the Same as the Build Agent**: In traditional GitHub Actions, a "runner" or "agent" is the system that executes workflows. In Depot, the sandbox is the compute instance provisioned for that job, and it plays a similar role.

- **You Can Debug It**: You can SSH directly into a running sandbox to inspect the environment, check files, run commands manually, and debug issues. This is useful for low-level troubleshooting.

- **Pre-Warmed for Performance**: Depot uses pre-warmed sandboxes to reduce startup time, so jobs start in 2-3 seconds versus 40+ seconds on traditional CI systems.

### In Summary

Think of "sandbox" as the isolated cloud compute instance that Depot creates to run each of your CI jobs. It's essentially the build/execution environment.

---

## Clarifying the Relationship

### The Architecture

```
┌─────────────────────────────────────────────────────────────┐
│                    DEPOT CI ARCHITECTURE                    │
├─────────────────────────────────────────────────────────────┤
│                                                             │
│  SWITCHYARD (Orchestrator)                                  │
│         │                                                   │
│         │ Assigns job to sandbox                            │
│         ▼                                                   │
│  ┌─────────────────────────────────────┐                   │
│  │  SANDBOX (Compute Environment)      │                   │
│  │  • Isolated EC2 instance            │                   │
│  │  • BuildKit pre-installed           │                   │
│  │  • Your workflow runs here          │                   │
│  │  • SSH access for debugging         │                   │
│  └─────────────────────────────────────┘                   │
│                                                             │
└─────────────────────────────────────────────────────────────┘
```

### How It Relates to Traditional CI

| Concept | GitHub Actions | Depot CI |
|---------|---------------|----------|
| **Execution Unit** | Runner | Sandbox |
| **What It Does** | Executes workflow steps | Executes workflow steps |
| **Isolation** | Can be shared or self-hosted | Always isolated, never shared |
| **Lifecycle** | Polls for jobs | Assigned job by orchestrator |
| **Startup Time** | 40+ seconds (cold start) | 2-3 seconds (pre-warmed) |

### The Bottom Line

- **Sandbox ≠ Agent**: The sandbox is the compute environment. The agent (or orchestrator) is what manages the sandboxes.
- **Switchyard = The "Agent"**: Switchyard is Depot's orchestrator that schedules jobs and assigns them to sandboxes.
- **Sandbox = Where Work Happens**: Each sandbox is an isolated compute instance that executes your workflow.
