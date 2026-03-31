# Docker Build Performance Test Cases

5 progressive test cases to measure Docker build performance across all 4 flows.

---

## Test Cases Overview

| Test | Complexity | Changes | Layers Affected | Expected Cache Hit |
|------|------------|---------|-----------------|-------------------|
| **1. Baseline** | None | No changes | All layers cached | ~100% |
| **2. Comment** | Minimal | Source comment | build stage only | ~80% |
| **3. Function** | Low | New function | build stage only | ~60% |
| **4. Dependency** | Medium | New npm package | deps + build | ~40% |
| **5. Major** | High | New deps + files | deps + build + production | ~10% |

---

## Test Case 1: Baseline (No Changes)

**Purpose:** Measure fully cached build performance

**What changes:** Nothing - clean baseline

**Steps:**
```bash
# Just trigger the build without any changes
# Flow 1: docker build -t test .
# Flow 2-4: Trigger respective workflow
```

**Expected:** All layers cached, minimal rebuild time

---

## Test Case 2: Comment Change

**Purpose:** Measure performance with trivial source change

**What changes:** Add a comment to `src/index.ts`

**Steps:**
```bash
# Apply test case 2
./scripts/apply-test-case-2.sh
```

**What gets modified:**
```typescript
// src/index.ts - Add timestamp comment
/**
 * OpenClaw Demo - Main Entry Point
 * Test Case 2: Comment Change - 2026-03-31T12:00:00Z
 * Personal AI Assistant with Skills System
 */
```

**Layers affected:**
- ✅ deps: CACHED
- ✅ production-deps: CACHED
- ❌ build (COPY source): REBUILT
- ❌ build (tsc): REBUILT
- ✅ production: CACHED

**Expected:** ~80% cache hit, only source copy + tsc rebuild

---

## Test Case 3: New Function

**Purpose:** Measure performance with small code addition

**What changes:** Add a new utility function

**Steps:**
```bash
# Apply test case 3
./scripts/apply-test-case-3.sh
```

**What gets modified:**
```typescript
// src/utils.ts - New file
export function getTestMetric(name: string): number {
  return Math.floor(Math.random() * 1000);
}

// src/index.ts - Import and use
import { getTestMetric } from './utils.js';

app.get('/metric', (_req, res) => {
  res.json({ metric: getTestMetric('test-case-3') });
});
```

**Layers affected:**
- ✅ deps: CACHED
- ✅ production-deps: CACHED
- ❌ build (COPY source): REBUILT
- ❌ build (tsc): REBUILT
- ✅ production: CACHED

**Expected:** ~60% cache hit, source + compilation rebuild

---

## Test Case 4: New Dependency

**Purpose:** Measure performance with package.json change

**What changes:** Add a new npm package

**Steps:**
```bash
# Apply test case 4
./scripts/apply-test-case-4.sh
```

**What gets modified:**
```json
// package.json - Add new dependency
{
  "devDependencies": {
    "@types/express": "^5.0.0",
    "typescript": "^5.7.3",
    "eslint": "^9.0.0"  // NEW
  }
}
```

**Layers affected:**
- ❌ deps: REBUILT (npm ci)
- ❌ production-deps: REBUILT
- ✅ build (COPY source): CACHED
- ❌ build (tsc): REBUILT
- ❌ production: REBUILT

**Expected:** ~40% cache hit, dependency layers rebuild

---

## Test Case 5: Major Changes

**Purpose:** Measure performance with significant changes

**What changes:** Multiple new packages + new files

**Steps:**
```bash
# Apply test case 5
./scripts/apply-test-case-5.sh
```

**What gets modified:**
```json
// package.json - Add multiple new packages
{
  "dependencies": {
    "express": "^4.21.2",
    "axios": "^1.7.9",
    "zod": "^3.24.1",
    "lodash": "^4.17.21",  // NEW
    "moment": "^2.30.1"    // NEW
  }
}
```

```typescript
// src/database.ts - New file
import { MongoClient } from 'mongodb';

export class Database {
  private client: MongoClient;

  constructor(uri: string) {
    this.client = new MongoClient(uri);
  }

  async connect() {
    await this.client.connect();
  }

  async disconnect() {
    await this.client.close();
  }
}

// src/cache.ts - New file
import Redis from 'ioredis';

export class Cache {
  private client: Redis;

  constructor(host: string, port: number) {
    this.client = new Redis(host, port);
  }

  async get(key: string): Promise<string | null> {
    return await this.client.get(key);
  }

  async set(key: string, value: string, ttl?: number) {
    if (ttl) {
      await this.client.setex(key, ttl, value);
    } else {
      await this.client.set(key, value);
    }
  }
}

// src/index.ts - Use new modules
import { Database } from './database.js';
import { Cache } from './cache.js';

const db = new Database(process.env.MONGODB_URI || 'mongodb://localhost:27017');
const cache = new Cache('localhost', 6379);

app.get('/db-health', async (_req, res) => {
  try {
    await db.connect();
    res.json({ status: 'connected', database: 'mongodb' });
  } catch (error) {
    res.status(500).json({ error: 'Database connection failed' });
  }
});
```

**Layers affected:**
- ❌ deps: FULL REBUILD (many new packages)
- ❌ production-deps: FULL REBUILD
- ❌ build (COPY source): REBUILT
- ❌ build (tsc): REBUILT
- ❌ production: REBUILT

**Expected:** ~10% cache hit, near-full rebuild

---

## Testing Procedure

For each flow, run all 5 test cases and record the build times:

### Pre-Test Setup

```bash
# Start from clean state
cd sample-app
git stash save "Pre-test cleanup"

# Run Test Case 1 (baseline)
# [Trigger build for your flow]
# Record time: ___ seconds
```

### Test Loop

```bash
for TEST in {2..5}; do
  echo "Running Test Case $TEST..."

  # Apply test case changes
  ./scripts/apply-test-case-$TEST.sh

  # Trigger build for your flow
  # Flow 1: docker build -t test .
  # Flow 2: git push (Railway auto-build)
  # Flow 3: Trigger railway-direct.yml
  # Flow 4: Trigger depot-ci.yml

  # Record time: ___ seconds

  # Optional: Revert for next test
  git checkout package.json package-lock.json src/
done
```

---

## Expected Results Template

| Test | Flow 1 (Local) | Flow 2 (Railway) | Flow 3 (GitHub) | Flow 4 (Depot) |
|------|----------------|------------------|-----------------|----------------|
| 1. Baseline | ___ s | ___ s | ___ s | ___ s |
| 2. Comment | ___ s | ___ s | ___ s | ___ s |
| 3. Function | ___ s | ___ s | ___ s | ___ s |
| 4. Dependency | ___ s | ___ s | ___ s | ___ s |
| 5. Major | ___ s | ___ s | ___ s | ___ s |

---

## Cache Efficiency Analysis

After running all tests, calculate cache efficiency:

```bash
# Cache Efficiency = (Test 1 Time / Test N Time) × 100%

# Example:
# Test 1: 10s (fully cached)
# Test 5: 100s (major rebuild)
# Cache Efficiency for Test 5 = (10/100) × 100% = 10%
```

| Flow | Test 1 | Test 2 | Test 3 | Test 4 | Test 5 |
|------|--------|--------|--------|--------|--------|
| **Flow 1** | 100% | ___% | ___% | ___% | ___% |
| **Flow 2** | 100% | ___% | ___% | ___% | ___% |
| **Flow 3** | 100% | ___% | ___% | ___% | ___% |
| **Flow 4** | 100% | ___% | ___% | ___% | ___% |

---

## Key Metrics to Compare

1. **Baseline Speed** - Test 1 time (fully cached)
2. **Incremental Build Speed** - Tests 2-3 times
3. **Dependency Rebuild Speed** - Test 4 time
4. **Full Rebuild Speed** - Test 5 time
5. **Cache Efficiency** - Percentage of layers reused
6. **Network Overhead** - Time spent downloading/uploading layers
