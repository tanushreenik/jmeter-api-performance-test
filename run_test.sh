#!/bin/bash
# run_test.sh - run JMeter headless and produce CSV results + dashboard

JMETER_CMD=${JMETER_CMD:-jmeter}   # Use JMETER_CMD if you want custom path

# files
TEST_PLAN="test_plan.jmx"
RESULTS_CSV="results.csv"
DASHBOARD_DIR="jmeter-report"

# remove old artifacts
rm -rf "$RESULTS_CSV" "$DASHBOARD_DIR"

# run JMeter in non-GUI mode, produce results CSV
$JMETER_CMD -n -t "$TEST_PLAN" -l "$RESULTS_CSV"

# generate dashboard (requires JMeter >= 3.0)
if [ -f "$RESULTS_CSV" ]; then
  $JMETER_CMD -g "$RESULTS_CSV" -o "$DASHBOARD_DIR"
  echo "Dashboard generated at: $DASHBOARD_DIR/index.html"
else
  echo "Results CSV not found. Skipping dashboard generation."
fi
