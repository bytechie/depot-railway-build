#!/bin/bash
# Master script to run all Docker build performance test cases

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(dirname "$SCRIPT_DIR")"
RESULTS_DIR="$PROJECT_ROOT/docs/performance-testing/results"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo -e "${BLUE}========================================${NC}"
echo -e "${BLUE}  Docker Build Performance Test Suite  ${NC}"
echo -e "${BLUE}========================================${NC}"
echo ""

# Create results directory
mkdir -p "$RESULTS_DIR"

# Function to show test info
show_test_info() {
  local test_num=$1
  local description=$2
  local expected_cache=$3

  echo -e "${YELLOW}Test Case $test_num: $description${NC}"
  echo -e "Expected cache hit: ${GREEN}$expected_cache${NC}"
  echo ""
}

# Function to trigger flow
trigger_flow() {
  local flow=$1

  case $flow in
    1)
      echo -e "${BLUE}Triggering Flow 1: Local Docker build${NC}"
      cd "$PROJECT_ROOT/sample-app"
      time docker build -t openclaw-demo:test .
      cd "$PROJECT_ROOT"
      ;;
    2)
      echo -e "${BLUE}Triggering Flow 2: Railway auto-build${NC}"
      echo "Commit and push changes to trigger Railway build..."
      read -p "Press Enter when ready to commit and push..."
      ;;
    3)
      echo -e "${BLUE}Triggering Flow 3: GitHub Actions${NC}"
      echo "Go to: https://github.com/bytechie/depot-railway-build/actions/workflows/railway-direct.yml"
      echo "Click 'Run workflow'"
      read -p "Press Enter when workflow starts..."
      ;;
    4)
      echo -e "${BLUE}Triggering Flow 4: Depot CI${NC}"
      echo "Go to: https://github.com/bytechie/depot-railway-build/actions/workflows/depot-ci.yml"
      echo "Click 'Run workflow'"
      read -p "Press Enter when workflow starts..."
      ;;
    *)
      echo -e "${RED}Invalid flow number${NC}"
      exit 1
      ;;
  esac
}

# Function to record time
record_time() {
  local test_num=$1
  local flow=$2
  local time=$3

  echo "$test_num,$flow,$time,$(date -u +%Y-%m-%dT%H:%M:%SZ)" >> "$RESULTS_DIR/performance-results.csv"
  echo -e "${GREEN}✓ Recorded: Test $test_num, Flow $flow, ${time}s${NC}"
}

# Check if user wants to run specific test
if [ ! -z "$1" ]; then
  TEST_NUM=$1
else
  echo "Which test case would you like to run?"
  echo "1) Baseline (no changes)"
  echo "2) Comment Change"
  echo "3) New Function"
  echo "4) New Dependency"
  echo "5) Major Changes"
  echo "6) Run ALL tests"
  read -p "Enter choice (1-6): " TEST_NUM
fi

# Check which flow to test
echo ""
echo "Which flow do you want to test?"
echo "1) Local → Railway"
echo "2) Commit → Railway (auto-build)"
echo "3) GitHub Actions → Railway"
echo "4) Depot CI → Railway"
read -p "Enter choice (1-4): " FLOW

echo ""

# Create CSV header if it doesn't exist
if [ ! -f "$RESULTS_DIR/performance-results.csv" ]; then
  echo "test_case,flow,time_seconds,timestamp" > "$RESULTS_DIR/performance-results.csv"
fi

# Run the selected test(s)
case $TEST_NUM in
  1)
    show_test_info "1" "Baseline (No Changes)" "~100%"
    echo "Skipping build - baseline assumes clean cached state"
    ;;
  2)
    show_test_info "2" "Comment Change" "~80%"
    bash "$SCRIPT_DIR/apply-test-case-2.sh"
    trigger_flow $FLOW
    read -p "Enter build time in seconds: " TIME
    record_time "2" "$FLOW" "$TIME"
    ;;
  3)
    show_test_info "3" "New Function" "~60%"
    bash "$SCRIPT_DIR/apply-test-case-3.sh"
    trigger_flow $FLOW
    read -p "Enter build time in seconds: " TIME
    record_time "3" "$FLOW" "$TIME"
    ;;
  4)
    show_test_info "4" "New Dependency" "~40%"
    bash "$SCRIPT_DIR/apply-test-case-4.sh"
    trigger_flow $FLOW
    read -p "Enter build time in seconds: " TIME
    record_time "4" "$FLOW" "$TIME"
    ;;
  5)
    show_test_info "5" "Major Changes" "~10%"
    bash "$SCRIPT_DIR/apply-test-case-5.sh"
    trigger_flow $FLOW
    read -p "Enter build time in seconds: " TIME
    record_time "5" "$FLOW" "$TIME"
    ;;
  6)
    echo -e "${BLUE}Running all test cases sequentially...${NC}"
    echo ""

    for TEST in 2 3 4 5; do
      case $TEST in
        2) show_test_info "2" "Comment Change" "~80%" ;;
        3) show_test_info "3" "New Function" "~60%" ;;
        4) show_test_info "4" "New Dependency" "~40%" ;;
        5) show_test_info "5" "Major Changes" "~10%" ;;
      esac

      bash "$SCRIPT_DIR/apply-test-case-$TEST.sh"
      trigger_flow $FLOW
      read -p "Enter build time in seconds: " TIME
      record_time "$TEST" "$FLOW" "$TIME"
      echo ""
      echo -e "${BLUE}-----------------------------------${NC}"
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
