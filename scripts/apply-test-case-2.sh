#!/bin/bash
# Test Case 2: Comment Change
# Adds a timestamp comment to src/index.ts

set -e

echo "📝 Applying Test Case 2: Comment Change"

# Get current timestamp
TIMESTAMP=$(date -u +"%Y-%m-%dT%H:%M:%SZ")

# Add timestamp comment to index.ts
sed -i "1i /**\n * Test Case 2: Comment Change - $TIMESTAMP\n * Performance test: Minimal source change\n */" sample-app/src/index.ts

echo "✅ Test Case 2 applied: Added timestamp comment to src/index.ts"
echo "📊 Expected: ~80% cache hit (only source copy + tsc rebuild)"
