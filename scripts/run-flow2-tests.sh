#!/bin/bash
# Automated Flow 2 (Railway) Test Runner
# Runs all test cases using temporary commits - no branch management needed

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(dirname "$SCRIPT_DIR")"
RESULTS_DIR="$PROJECT_ROOT/docs/performance-testing/results"

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

echo -e "${BLUE}========================================${NC}"
echo -e "${BLUE}  Flow 2: Railway Test Runner         ${NC}"
echo -e "${BLUE}========================================${NC}"
echo ""

# Ensure we start from clean state
echo -e "${YELLOW}Ensuring clean git state...${NC}"
cd "$PROJECT_ROOT"
if [ -n "$(git status --porcelain)" ]; then
  echo -e "${RED}ERROR: Working directory not clean${NC}"
  echo "Please stash or commit your changes first:"
  echo "  git stash save 'Temp save'"
  exit 1
fi

# Store current commit
ORIGINAL_COMMIT=$(git rev-parse HEAD)
echo -e "${GREEN}✓ Clean state: $ORIGINAL_COMMIT${NC}"
echo ""

# Function to reset to clean state
reset_state() {
  echo -e "${YELLOW}Resetting to clean state...${NC}"
  git reset --hard $ORIGINAL_COMMIT >/dev/null 2>&1
  git clean -fd sample-app/ >/dev/null 2>&1
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

  # Apply test case
  case $test_num in
    2) bash "$SCRIPT_DIR/apply-test-case-2.sh" ;;
    3) bash "$SCRIPT_DIR/apply-test-case-3.sh" ;;
    4) bash "$SCRIPT_DIR/apply-test-case-4.sh" ;;
    5) bash "$SCRIPT_DIR/apply-test-case-5.sh" ;;
  esac

  # Commit changes
  echo -e "${YELLOW}Committing test case changes...${NC}"
  git add -A sample-app/ >/dev/null 2>&1
  git commit -m "Test Case $test_num: $test_name" >/dev/null 2>&1

  # Push to trigger Railway
  echo -e "${YELLOW}Pushing to trigger Railway build...${NC}"
  git push >/dev/null 2>&1 &
  PUSH_PID=$!

  echo ""
  echo -e "${GREEN}✓ Changes pushed to Railway${NC}"
  echo ""
  echo -e "${YELLOW}Railway will now build automatically.${NC}"
  echo -e "${YELLOW}Go to Railway dashboard to watch the build:${NC}"
  echo -e "${BLUE}https://railway.app${NC}"
  echo ""
  echo -e "${YELLOW}When build completes, enter the time below.${NC}"
  echo ""

  # Wait for user to input time
  read -p "Build time (seconds): " BUILD_TIME

  # Record result
  if [ ! -z "$BUILD_TIME" ]; then
    mkdir -p "$RESULTS_DIR"
    echo "$test_num,flow2,$BUILD_TIME,$(date -u +%Y-%m-%dT%H:%M:%SZ)" >> "$RESULTS_DIR/performance-results.csv"
    echo -e "${GREEN}✓ Recorded: Test $test_num, Flow 2, ${BUILD_TIME}s${NC}"
  fi

  # Reset for next test
  reset_state
  echo ""
}

# Show test menu
echo "Which test case would you like to run?"
echo "1) Baseline - Already measured (29s / 3.8s)"
echo "2) Comment Change (~80% cache)"
echo "3) New Function (~60% cache)"
echo "4) New Dependency (~40% cache)"
echo "5) Major Changes (~10% cache)"
echo "6) Run ALL tests (2-5)"
echo "0) Exit"
echo ""
read -p "Enter choice (0-6): " CHOICE

case $CHOICE in
  0)
    echo "Exiting..."
    exit 0
    ;;
  1)
    echo -e "${YELLOW}Baseline already measured:${NC}"
    echo "  Initial build: 29.06 seconds"
    echo "  Cached rebuild: 3.81 seconds"
    echo ""
    echo "See: docs/performance-testing/railway-build-results.md"
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
