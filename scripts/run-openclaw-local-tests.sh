#!/bin/bash
# OpenClaw Local Performance Testing Script
# Runs all test cases locally and records results

set -e

# Configuration
OPENCLAW_DIR="/home/techie/devtools/github-repos/openclaw"
RESULTS_DIR="/home/techie/devtools/github-repos/depot-railway-build/docs/performance-testing/openclaw-ai-testing/local-openclaw-ai-testing"
DOCS_DIR="/home/techie/devtools/github-repos/depot-railway-build/docs/performance-testing/openclaw-ai-testing"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Test results array
declare -a TEST_RESULTS
declare -a TEST_NAMES

# Function to print section header
print_header() {
    echo -e "\n${BLUE}==========================================${NC}"
    echo -e "${BLUE}$1${NC}"
    echo -e "${BLUE}==========================================${NC}\n"
}

# Function to print test info
print_test_info() {
    local test_name="$1"
    local description="$2"
    local expected_cache="$3"
    echo -e "${YELLOW}Test Case: ${test_name}${NC}"
    echo -e "${YELLOW}Description: ${description}${NC}"
    echo -e "${YELLOW}Expected Cache: ${expected_cache}${NC}"
}

# Function to reset OpenClaw to clean state
reset_openclaw() {
    print_header "Resetting OpenClaw to clean state"
    cd "$OPENCLAW_DIR"

    # Reset any changes
    git reset --hard HEAD > /dev/null 2>&1 || true
    git clean -fd > /dev/null 2>&1 || true

    # Remove any modified package.json
    if [ -f package.json.orig ]; then
        mv package.json.orig package.json
    fi

    echo "OpenClaw reset to clean state"
}

# Function to save backup and apply changes
apply_test_case() {
    local test_case="$1"
    cd "$OPENCLAW_DIR"

    # Backup package.json if needed
    if [ ! -f package.json.orig ]; then
        cp package.json package.json.orig
    fi

    case "$test_case" in
        baseline)
            # No changes
            ;;
        test-2-docs)
            echo "" >> README.md
            echo "<!-- Performance test: $(date) -->" >> README.md
            ;;
        test-3-source)
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
  const result = { startTime, endTime: startTime, duration: 0 };
  result.endTime = Date.now();
  result.duration = result.endTime - result.startTime;
  return result;
}
EOF
            ;;
        test-4-ui)
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
            # Add a new dependency that doesn't already exist in OpenClaw
            npm pkg set devDependencies.left-pad="^1.3.0"
            pnpm install --lockfile-only
            ;;
        test-6-major)
            # Multiple changes
            # Dependency
            npm pkg set devDependencies.left-pad="^1.3.0"
            pnpm install --lockfile-only
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
    esac
}

# Function to run Docker build and time it
run_docker_build() {
    local test_name="$1"
    local log_file="$RESULTS_DIR/${test_name}.log"

    print_header "Building Docker image: $test_name"

    cd "$OPENCLAW_DIR"

    # Start timing
    local start_time=$(date +%s)

    # Build with progress, capture output
    echo "Build started at: $(date)" > "$log_file"
    echo "========================================" >> "$log_file"

    if docker build -t openclaw:$test_name . >> "$log_file" 2>&1; then
        local end_time=$(date +%s)
        local duration=$((end_time - start_time))
        local minutes=$((duration / 60))
        local seconds=$((duration % 60))

        echo "Build completed at: $(date)" >> "$log_file"
        echo "Total time: ${minutes}m ${seconds}s" >> "$log_file"

        echo -e "${GREEN}Build successful!${NC}"
        echo -e "${GREEN}Time: ${minutes}m ${seconds}s${NC}"

        # Clean up the image to save space
        docker rmi openclaw:$test_name > /dev/null 2>&1 || true

        echo "${minutes}:${seconds}"
    else
        local end_time=$(date +%s)
        local duration=$((end_time - start_time))

        echo "Build FAILED at: $(date)" >> "$log_file"
        echo "Time before failure: ${duration}s" >> "$log_file"

        echo -e "${RED}Build FAILED after ${duration}s${NC}"
        echo "FAILED"
    fi
}

# Main testing function
run_all_tests() {
    print_header "OpenClaw Local Performance Testing"

    echo "OpenClaw directory: $OPENCLAW_DIR"
    echo "Results directory: $RESULTS_DIR"
    echo ""
    echo "This will run 6 test cases. Each test builds OpenClaw from scratch."
    echo "Estimated total time: 30-60 minutes"
    echo ""
    echo "Starting tests automatically..."

    # Create results header
    cat > "$RESULTS_DIR/summary.md" << 'EOF'
# OpenClaw Local Performance Test Results

Test Date: INSERT_DATE

## Test Environment

- **Host**: WSL2 on Windows
- **Docker Version**: INSERT_DOCKER_VERSION
- **OpenClaw Commit**: INSERT_COMMIT
- **Test Type**: Local Docker Build (GitHub Actions baseline comparison)

## Test Cases

EOF

    # Get Docker version and OpenClaw commit
    docker_version=$(docker --version)
    openclaw_commit=$(cd "$OPENCLAW_DIR" && git rev-parse --short HEAD)
    test_date=$(date '+%Y-%m-%d %H:%M:%S')

    # Update summary with metadata
    sed -i "s/INSERT_DATE/$test_date/" "$RESULTS_DIR/summary.md"
    sed -i "s/INSERT_DOCKER_VERSION/$docker_version/" "$RESULTS_DIR/summary.md"
    sed -i "s/INSERT_COMMIT/$openclaw_commit/" "$RESULTS_DIR/summary.md"

    # Define test cases
    declare -a tests=(
        "baseline:Baseline:No changes:100%"
        "test-2-docs:Documentation:README comment:95%"
        "test-3-source:Source File:New perf-test.ts in src/:75%"
        "test-4-ui:UI Component:New component in ui/:50%"
        "test-5-dependency:New Dependency:Add @types/node:25%"
        "test-6-major:Major Changes:Multiple changes:10%"
    )

    # Run each test
    for test in "${tests[@]}"; do
        IFS=':' read -r test_id test_name test_desc test_cache <<< "$test"

        print_header "Test: $test_name"
        print_test_info "$test_name" "$test_desc" "$test_cache"

        # Reset to clean state
        reset_openclaw

        # Apply test case
        echo "Applying test case changes..."
        apply_test_case "$test_id"

        # Run build
        result=$(run_docker_build "$test_id")

        # Record result
        if [ "$result" != "FAILED" ]; then
            TEST_RESULTS+=("$test_id:$test_name:$result")
            echo -e "${GREEN}✓ $test_name: $result${NC}"
        else
            TEST_RESULTS+=("$test_id:$test_name:FAILED")
            echo -e "${RED}✗ $test_name: FAILED${NC}"
        fi

        # Small delay between tests
        sleep 2
    done

    # Generate final summary
    print_header "Generating Summary"

    cat >> "$RESULTS_DIR/summary.md" << 'EOF'

## Results Summary

| Test Case | Description | Time | Expected Cache |
|-----------|-------------|------|----------------|
EOF

    for result in "${TEST_RESULTS[@]}"; do
        IFS=':' read -r test_id test_name time <<< "$result"
        if [ "$time" = "FAILED" ]; then
            echo "| $test_name | See description | **FAILED** | - |" >> "$RESULTS_DIR/summary.md"
        else
            IFS=':' read -r min sec <<< "$time"
            echo "| $test_name | See description | ${min}m ${sec}s | See above |" >> "$RESULTS_DIR/summary.md"
        fi
    done

    cat >> "$RESULTS_DIR/summary.md" << 'EOF'

## Log Files

Detailed logs for each test case:
- `baseline.log`
- `test-2-docs.log`
- `test-3-source.log`
- `test-4-ui.log`
- `test-5-dependency.log`
- `test-6-major.log`

## Notes

- These tests represent **local Docker build** times
- GitHub Actions times may vary due to:
  - Runner performance differences
  - Network conditions
  - Cache state
  - Concurrent workflows

- Depot CI is expected to be **4-8x faster** than these local baseline times.

## Comparison with Depot CI

Once Depot CI tests are run, compare:

| Test | Local Docker | Depot CI | Speedup |
|------|--------------|----------|---------|
| Baseline | ? min | ? sec | ?x |
| Docs | ? min | ? sec | ?x |
| Source | ? min | ? sec | ?x |
| UI | ? min | ? sec | ?x |
| Dependency | ? min | ? sec | ?x |
| Major | ? min | ? sec | ?x |

EOF

    # Final cleanup
    reset_openclaw

    print_header "Testing Complete!"
    echo "Results saved to: $RESULTS_DIR"
    echo "Summary: $RESULTS_DIR/summary.md"
    echo ""
    echo "Test Results:"
    for result in "${TEST_RESULTS[@]}"; do
        IFS=':' read -r test_id test_name time <<< "$result"
        if [ "$time" = "FAILED" ]; then
            echo -e "  ${RED}✗${NC} $test_name: FAILED"
        else
            IFS=':' read -r min sec <<< "$time"
            echo -e "  ${GREEN}✓${NC} $test_name: ${min}m ${sec}s"
        fi
    done
}

# Run the tests
run_all_tests
