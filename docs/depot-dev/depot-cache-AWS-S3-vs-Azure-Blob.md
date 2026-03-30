# AWS S3 vs Azure Blob: Enterprise Storage Decision Guide 2025

**Key Context:** The Broadcom VMware acquisition has forced enterprises to reconsider their entire infrastructure stack, with cloud storage choice becoming critical for avoiding vendor lock-in.

## Main Differences

| Aspect | AWS S3 | Azure Blob |
|--------|--------|------------|
| **Market Share** | 30% global workloads | 24% global workloads |
| **Scale** | 280T+ objects, 100M+ requests/sec | 1 quadrillion+ transactions/month |
| **Storage Classes** | 6 tiers (Standard, Intelligent-Tiering, Express One Zone, Standard-IA, Glacier, Deep Archive) | 4 tiers (Hot, Cool, Cold, Archive) |
| **Durability** | 11 nines (99.999999999%) | Up to 16 nines with GRS |
| **New Feature** | S3 Vectors for AI/ML vector embeddings | N/A |

## Cost Comparison (100TB dataset over 3 years)

- **AWS S3:** $187,440
- **Azure Blob:** $156,600 (16% lower)

**Hidden Costs:** Egress fees ($0.09/GB), API migration costs ($50K-$200K), and the "lock-in tax" (15-30% of annual cloud budget).

---

# GitHub Actions vs Depot Runners: Complete Performance Comparison

## How Depot Achieved 10x Faster Cache

Depot reverse-engineered GitHub's undocumented cache system. Key insights:

1. **GitHub's Cache Architecture:** GitHub Actions runners are hosted on Azure and use Azure Blob Storage for caching, limited to ~1 Gbps (125 MB/s) network throughput
2. **Depot's Solution:**
   - Built a Go proxy on every runner that intercepts GitHub Cache API calls
   - Replaced Azure Blob URLs with S3 URLs
   - Increased parallelism from 2 streams to 4 (upload) and 8 (download)
   - Hosted runners on EC2 close to S3 for maximum throughput

## Complete Performance Comparison

| Metric | GitHub Actions | Depot | Improvement |
|--------|----------------|-------|-------------|
| **CPU Speed (sysbench)** | 4,119.42 | 8,917.15 | ~2x faster |
| **Cache Throughput** | 100-150 MB/s | 1 GB/s | 10x faster |
| **Cache Size Limit** | 10 GB | Unlimited | No limit |
| **Cache Retention** | 7 days | 30 days | 4x longer |
| **Cost per Minute** | $0.008 | $0.004 | 50% cheaper |

## Architecture Differences

| Aspect | GitHub Actions | Depot |
|--------|----------------|-------|
| **Infrastructure** | Azure-hosted runners | AWS EC2 + S3 |
| **Cache Storage** | Azure Blob Storage | S3 |
| **Instance Reuse** | Reuses instances between builds | Fresh EC2 instance per build |
| **Billing** | Per minute, rounded up | Per-second billing |

## Real-World Build Times (Next.js)

| Scenario | GitHub Actions | Depot | Improvement |
|----------|----------------|-------|-------------|
| **Without cache** | 4m 49s ($0.04) | 3m 32s ($0.014) | 24% faster, 65% cheaper |
| **With cache** | 4m 6s ($0.04) | 3m 1s ($0.012) | 57% faster, 70% cheaper |

## Monthly Savings (100 builds/day)

- **Time saved:** 50+ hours per month
- **Cost saved:** $80+ per month
- GitHub's round-up billing adds ~45 hours of "phantom" time monthly

## Key Technical Insight

Depot's cache acceleration comes from:

1. EC2-to-S3 proximity (same region, private network)
2. Higher parallelism (8 streams vs 2)
3. No workflow changes required — drop-in replacement using same `actions/cache@v3`

---

## Sources

- [AWS S3 vs. Azure Blob: Enterprise Storage Decision Guide 2025 \| Everpure Blog](https://blog.purestorage.com/purely-educational/aws-s3-vs-azure-blob/)
- [Comparing GitHub Actions and Depot runners for 2x faster builds](https://depot.dev/blog/comparing-github-actions-and-depot-runners-for-2x-faster-builds)
- [We reverse-engineered the GitHub Actions cache so you don't have to](https://depot.dev/blog/github-actions-cache)
