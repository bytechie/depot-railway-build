#!/bin/bash
# Test Case 3: New Function
# Adds a new utility function and endpoint

set -e

echo "📝 Applying Test Case 3: New Function"

# Create utils.ts file
cat > sample-app/src/utils.ts << 'EOF'
/**
 * Utility Functions
 * Test Case 3: New Function Addition
 */

export function getTestMetric(name: string): number {
  const timestamp = Date.now();
  const hash = name.split('').reduce((acc, char) => {
    return acc + char.charCodeAt(0);
  }, 0);
  return (timestamp + hash) % 1000;
}

export function calculateScore(metrics: number[]): number {
  return metrics.reduce((sum, val) => sum + val, 0) / metrics.length;
}

export function formatBytes(bytes: number): string {
  if (bytes === 0) return '0 Bytes';
  const k = 1024;
  const sizes = ['Bytes', 'KB', 'MB', 'GB'];
  const i = Math.floor(Math.log(bytes) / Math.log(k));
  return Math.round(bytes / Math.pow(k, i) * 100) / 100 + ' ' + sizes[i];
}
EOF

# Add metric endpoint to index.ts
if ! grep -q "/metric" sample-app/src/index.ts; then
  # Add import
  sed -i "7i import { getTestMetric, calculateScore, formatBytes } from './utils.js';" sample-app/src/index.ts

  # Add endpoint before server start
  sed -i "/app.listen(PORT/a\\
\\
// Test Case 3: Metric endpoint\
app.get('/metric', (_req, res) => {\
  res.json({\
    metric: getTestMetric('test-case-3'),\
    score: calculateScore([1, 2, 3, 4, 5]),\
    formatted: formatBytes(1024)\
  });\
});" sample-app/src/index.ts
fi

echo "✅ Test Case 3 applied: Added utils.ts with new functions"
echo "📊 Expected: ~60% cache hit (source + compilation rebuild)"
