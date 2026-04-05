#!/usr/bin/env bash
# Shared test case logic for OpenClaw performance testing
# Usage: ./apply-openclaw-test-case.sh <test_case>
#   test_case: baseline | test-2-docs | test-3-source | test-4-ui | test-5-dependency | test-6-major

set -euo pipefail

TEST_CASE="${1:?Usage: $0 <test_case>}"

case "$TEST_CASE" in
  baseline)
    echo "=========================================="
    echo "Test Case: Baseline (no changes)"
    echo "Expected Cache Hit: ~100%"
    echo "All Docker layers should be cached"
    echo "=========================================="
    echo "expected_cache=100%" >> "$GITHUB_ENV"
    echo "test_description=Baseline - Fully cached build" >> "$GITHUB_ENV"
    ;;
  test-2-docs)
    echo "=========================================="
    echo "Test Case: Documentation Change"
    echo "Expected Cache Hit: ~95%"
    echo "Changes: README.md comment"
    echo "Invalidates: COPY . . layer only"
    echo "=========================================="
    echo "expected_cache=95%" >> "$GITHUB_ENV"
    echo "test_description=Documentation change - README comment" >> "$GITHUB_ENV"
    echo "" >> README.md
    echo "<!-- Performance test: $(date) -->" >> README.md
    ;;
  test-3-source)
    echo "=========================================="
    echo "Test Case: Source File Addition"
    echo "Expected Cache Hit: ~75%"
    echo "Changes: New TypeScript file in src/"
    echo "Invalidates: COPY . ., rebuilds build:docker"
    echo "=========================================="
    echo "expected_cache=75%" >> "$GITHUB_ENV"
    echo "test_description=New source file - perf-test.ts in src/" >> "$GITHUB_ENV"
    cat > src/perf-test.ts << 'EOF'
/**
 * Performance test utility
 * Added for Depot CI testing
 */
export interface PerfMetrics {
  startTime: number;
  endTime: number;
  duration: number;
}

export function measurePerf(label: string): PerfMetrics {
  const startTime = Date.now();
  // Simulated work
  const result = { startTime, endTime: startTime, duration: 0 };
  result.endTime = Date.now();
  result.duration = result.endTime - result.startTime;
  return result;
}
EOF
    ;;
  test-4-ui)
    echo "=========================================="
    echo "Test Case: UI File Change"
    echo "Expected Cache Hit: ~50%"
    echo "Changes: New file in ui/ directory"
    echo "Invalidates: COPY . ., rebuilds build:docker + ui:build"
    echo "=========================================="
    echo "expected_cache=50%" >> "$GITHUB_ENV"
    echo "test_description=UI change - New component in ui/" >> "$GITHUB_ENV"
    mkdir -p ui/src/components/test
    cat > ui/src/components/test/PerfTest.tsx << 'EOF'
/**
 * Performance test component
 * Added for Depot CI testing
 */
import { css, html, LitElement } from 'lit';

export class PerfTestComponent extends LitElement {
  static styles = css`
    :host {
      display: block;
      padding: 1rem;
    }
  `;

  render() {
    return html`<p>Performance Test Component</p>`;
  }
}

customElements.define('perf-test', PerfTestComponent);
EOF
    ;;
  test-5-dependency)
    echo "=========================================="
    echo "Test Case: New Dependency"
    echo "Expected Cache Hit: ~25%"
    echo "Changes: Add @types/node to devDependencies"
    echo "Invalidates: package.json layer, full pnpm install"
    echo "=========================================="
    echo "expected_cache=25%" >> "$GITHUB_ENV"
    echo "test_description=New dependency - Add left-pad" >> "$GITHUB_ENV"
    npm pkg set devDependencies.left-pad="^1.3.0"
    npx pnpm install --lockfile-only
    ;;
  test-6-major)
    echo "=========================================="
    echo "Test Case: Major Changes"
    echo "Expected Cache Hit: ~10%"
    echo "Changes: New dependency + source + UI + docs"
    echo "Invalidates: All layers, near-full rebuild"
    echo "=========================================="
    echo "expected_cache=10%" >> "$GITHUB_ENV"
    echo "test_description=Major changes - Multiple file types + dependency" >> "$GITHUB_ENV"
    # New dependency
    npm pkg set devDependencies.left-pad="^1.3.0"
    npx pnpm install --lockfile-only
    # Source file
    cat > src/major-test.ts << 'EOF'
export function majorTest(): string {
  return "Major performance test";
}
EOF
    # UI file
    mkdir -p ui/src/components/major
    cat > ui/src/components/major/MajorTest.tsx << 'EOF'
export const MajorTest = () => 'Major Test';
EOF
    # Docs change
    echo "<!-- Major test $(date) -->" >> README.md
    ;;
  *)
    echo "ERROR: Unknown test case: $TEST_CASE"
    exit 1
    ;;
esac
