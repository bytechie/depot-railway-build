#!/bin/bash
# Automated Flow 1 (Local Docker) Test Runner
# Runs all test cases with automatic timing - no manual steps needed

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(dirname "$SCRIPT_DIR")"
RESULTS_DIR="$PROJECT_ROOT/docs/performance-testing/results"

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m'

echo -e "${BLUE}========================================${NC}"
echo -e "${BLUE}  Flow 1: Local Docker Test Runner    ${NC}"
echo -e "${BLUE}========================================${NC}"
echo ""

cd "$PROJECT_ROOT/sample-app"

# Function to reset state
reset_state() {
  echo -e "${YELLOW}Resetting to clean state...${NC}"
  cd "$PROJECT_ROOT"
  git checkout sample-app/package.json \
              sample-app/package-lock.json \
              sample-app/src/ >/dev/null 2>&1 || true
  rm -f sample-app/src/utils.ts \
     sample-app/src/database.ts \
     sample-app/src/cache.ts \
     sample-app/.eslintrc.js \
     sample-app/src/index.ts~ 2>/dev/null || true
  cd "$PROJECT_ROOT/sample-app"
  echo -e "${GREEN}✓ Reset complete${NC}"
}

# Function to run a test case
run_test_case() {
  local test_num=$1
  local test_name=$2
  local expected_cache=$3

  echo -e "${BLUE}======================================${NC}"
  echo -e "${BLUE}Test Case $test_num: $test_name${NC}"
  echo -e "${BLUE}Expected cache: $expected_cache${NC}"
  echo -e "${BLUE}======================================${NC}"

  cd "$PROJECT_ROOT"

  # Apply test case
  case $test_num in
    2) bash "$SCRIPT_DIR/apply-test-case-2.sh" ;;
    3) bash "$SCRIPT_DIR/apply-test-case-3.sh" ;;
    4) bash "$SCRIPT_DIR/apply-test-case-4.sh" ;;
    5) bash "$SCRIPT_DIR/apply-test-case-5.sh" ;;
  esac

  # Build and measure time
  cd "$PROJECT_ROOT/sample-app"
  echo -e "${CYAN}Building Docker image...${NC}"
  echo ""

  START_TIME=$(date +%s.%N)
  docker build -t openclaw-demo:test . > /tmp/build-log.txt 2>&1
  END_TIME=$(date +%s.%N)

  # Calculate duration
  DURATION=$(echo "$END_TIME - $START_TIME" | bc)
  DURATION_INT=${DURATION%.*}

  echo ""
  echo -e "${GREEN}✓ Build completed in ${DURATION_INT}s${NC}"

  # Show cache stats from build log
  CACHED_STEPS=$(grep -c "CACHED" /tmp/build-log.txt || echo "0")
  TOTAL_STEPS=$(grep -c "^#" /tmp/build-log.txt || echo "0")
  echo -e "${CYAN}Cache hits: $CACHED_STEPS / $TOTAL_STEPS steps${NC}"

  # Record result
  mkdir -p "$RESULTS_DIR"
  echo "$test_num,flow1,$DURATION_INT,$(date -u +%Y-%m-%dT%H:%M:%SZ)" >> "$RESULTS_DIR/performance-results.csv"
  echo -e "${GREEN}✓ Recorded: Test $test_num, Flow 1, ${DURATION_INT}s${NC}"

  # Reset for next test
  reset_state
  echo ""
}

# Function for baseline (no changes)
run_baseline() {
  echo -e "${BLUE}======================================${NC}"
  echo -e "${BLUE}Test Case 1: Baseline (No Changes)${NC}"
  echo -e "${BLUE}Expected: Fully cached if run twice${NC}"
  echo -e "${BLUE}======================================${NC}"

  cd "$PROJECT_ROOT/sample-app"
  echo -e "${CYAN}Building Docker image (baseline)...${NC}"
  echo ""

  # First build (may not be cached)
  echo -e "${YELLOW}First build (may not be cached)...${NC}"
  START_TIME=$(date +%s.%N)
  docker build -t openclaw-demo:test . > /tmp/build-log1.txt 2>&1
  END_TIME=$(date +%s.%N)
  DURATION1=$(echo "$END_TIME - $START_TIME" | bc)
  DURATION1_INT=${DURATION1%.*}

  echo ""
  echo -e "${GREEN}✓ First build: ${DURATION1_INT}s${NC}"

  # Second build (should be cached)
  echo ""
  echo -e "${YELLOW}Second build (should be fully cached)...${NC}"
  START_TIME=$(date +%s.%N)
  docker build -t openclaw-demo:test . > /tmp/build-log2.txt 2>&1
  END_TIME=$(date +%s.%N)
  DURATION2=$(echo "$END_TIME - $START_TIME" | bc)
  DURATION2_INT=${DURATION2%.*}

  echo ""
  echo -e "${GREEN}✓ Second build: ${DURATION2_INT}s${NC}"

  CACHED_STEPS=$(grep -c "CACHED" /tmp/build-log2.txt || echo "0")
  echo -e "${CYAN}Cache hits: $CACHED_STEPS / $(grep -c "^#" /tmp/build-log2.txt) steps${NC}"

  # Record both
  mkdir -p "$RESULTS_DIR"
  echo "1,flow1-first,$DURATION1_INT,$(date -u +%Y-%m-%dT%H:%M:%SZ)" >> "$RESULTS_DIR/performance-results.csv"
  echo "1,flow1-cached,$DURATION2_INT,$(date -u +%Y-%m-%dT%H:%M:%SZ)" >> "$RESULTS_DIR/performance-results.csv"
  echo -e "${GREEN}✓ Recorded baseline times${NC}"
  echo ""
}

# Show test menu
echo "Which test case would you like to run?"
echo "1) Baseline - First build + cached build"
echo "2) Comment Change (~80% cache)"
echo "3) New Function (~60% cache)"
echo "4) New Dependency (~40% cache)"
echo "5) Major Changes (~10% cache)"
echo "6) Run ALL tests"
echo "0) Exit"
echo ""
read -p "Enter choice (0-6): " CHOICE

case $CHOICE in
  0)
    echo "Exiting..."
    exit 0
    ;;
  1)
    run_baseline
    ;;
  2)
    run_test_case "2" "Comment Change" "~80%"
    ;;
  3)
    run_test_case "3" "New Function" "~60%"
    ;;
  4)
    run_test_case "4" "New Dependency" "~40%"
    ;;
  5)
    run_test_case "5" "Major Changes" "~10%"
    ;;
  6)
    echo -e "${BLUE}Running all test cases sequentially...${NC}"
    echo ""
    run_baseline
    echo ""
    echo -e "${GREEN}======================================${NC}"
    echo ""

    for TEST in 2 3 4 5; do
      case $TEST in
        2) run_test_case "2" "Comment Change" "~80%" ;;
        3) run_test_case "3" "New Function" "~60%" ;;
        4) run_test_case "4" "New Dependency" "~40%" ;;
        5) run_test_case "5" "Major Changes" "~10%" ;;
      esac
      echo ""
      echo -e "${GREEN}======================================${NC}"
      echo ""
    done
    ;;
  *)
    echo -e "${RED}Invalid choice${NC}"
    exit 1
    ;;
esac

echo ""
echo -e "${GREEN}========================================${NC}"
echo -e "${GREEN}  Test Complete!                        ${NC}"
echo -e "${GREEN}========================================${NC}"
echo ""
echo "Results saved to: docs/performance-testing/results/performance-results.csv"
echo ""
echo "View results:"
echo "cat docs/performance-testing/results/performance-results.csv"
