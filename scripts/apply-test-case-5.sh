#!/bin/bash
# Test Case 5: Major Changes
# Adds multiple new packages and new files

set -e

echo "📝 Applying Test Case 5: Major Changes"

cd sample-app

# Add multiple new dependencies
echo "Installing new packages..."
npm install --save lodash moment dotenv uuid --silent
npm install --save-dev @types/lodash @types/moment --silent

# Create new database.ts file
cat > src/database.ts << 'EOF'
/**
 * Database Module
 * Test Case 5: Major Changes - New Database Integration
 */

export interface DatabaseConfig {
  host: string;
  port: number;
  database: string;
}

export class Database {
  private connected: boolean = false;
  private config: DatabaseConfig;

  constructor(config: DatabaseConfig) {
    this.config = config;
  }

  connect(): Promise<void> {
    return new Promise((resolve) => {
      // Simulated connection
      setTimeout(() => {
        this.connected = true;
        console.log(`Connected to ${this.config.host}:${this.config.port}`);
        resolve();
      }, 100);
    });
  }

  disconnect(): Promise<void> {
    return new Promise((resolve) => {
      this.connected = false;
      console.log('Disconnected from database');
      resolve();
    });
  }

  isConnected(): boolean {
    return this.connected;
  }

  async query(sql: string): Promise<any[]> {
    if (!this.connected) {
      throw new Error('Database not connected');
    }
    // Simulated query
    return [{ id: 1, result: 'simulated' }];
  }
}
EOF

# Create new cache.ts file
cat > src/cache.ts << 'EOF'
/**
 * Cache Module
 * Test Case 5: Major Changes - New Cache Integration
 */

export interface CacheEntry {
  key: string;
  value: any;
  expiry: number;
}

export class Cache {
  private store: Map<string, CacheEntry> = new Map();
  private defaultTTL: number = 3600000; // 1 hour

  get(key: string): any | null {
    const entry = this.store.get(key);
    if (!entry) return null;

    if (Date.now() > entry.expiry) {
      this.store.delete(key);
      return null;
    }

    return entry.value;
  }

  set(key: string, value: any, ttl?: number): void {
    const expiry = Date.now() + (ttl || this.defaultTTL);
    this.store.set(key, { key, value, expiry });
  }

  delete(key: string): boolean {
    return this.store.delete(key);
  }

  clear(): void {
    this.store.clear();
  }

  size(): number {
    return this.store.size;
  }
}
EOF

# Update index.ts with new endpoints
if ! grep -q "Database" src/index.ts; then
  # Create a temporary file with the new imports at the top
  # Find the first 'import' line and add our imports before it
  awk '
    /^import express/ {
      print "import { Database } from '\"'\"'./database.js'\"'\"';"
      print "import { Cache } from '\"'\"'./cache.js'\"'\"';"
    }
    { print }
  ' src/index.ts > src/index.ts.tmp && mv src/index.ts.tmp src/index.ts

  # Add initialization after PORT declaration
  sed -i "/const PORT =/a\\
\\
// Test Case 5: Initialize new modules\\
const db = new Database({\\
  host: process.env.DB_HOST || 'localhost',\\
  port: parseInt(process.env.DB_PORT || '27017'),\\
  database: process.env.DB_NAME || 'test'\\
});\\
\\
const cache = new Cache();" src/index.ts

  # Add endpoints before server start
  sed -i "/app.listen(PORT/a\\
\\
// Test Case 5: Database endpoint\\
app.get('/db-health', async (_req, res) => {\\
  try {\\
    await db.connect();\\
    res.json({\\
      status: 'connected',\\
      host: db['config'].host,\\
      port: db['config'].port\\
    });\\
  } catch (error) {\\
    res.status(500).json({ error: 'Database connection failed' });\\
  }\\
});\\
\\
// Test Case 5: Cache endpoint\\
app.get('/cache-stats', (_req, res) => {\\
  cache.set('test', { timestamp: Date.now() });\\
  const value = cache.get('test');\\
  res.json({\\
    size: cache.size(),\\
    testValue: value\\
  });\\
});" src/index.ts
fi

cd ..

echo "✅ Test Case 5 applied: Added major changes (lodash, moment, database.ts, cache.ts)"
echo "📊 Expected: ~10% cache hit (near-full rebuild)"
