#!/bin/bash

HOMEBREW_NO_AUTO_UPDATE=1 brew install lcov
if [ ! -f coverage/lcov.info ]; then
  echo "Coverage file not found. Check if the tests ran correctly."
  exit 1
fi

exclude_patterns=$(find . -name "*.g.dart" | sed 's|^\./||' | tr '\n' ' ')
# shellcheck disable=SC2086
lcov --remove coverage/lcov.info $exclude_patterns lib/lang/* -o coverage/lcov.info --ignore-errors unused,unused

total_lines=$(grep -o "LF:[0-9]*" coverage/lcov.info | awk -F: '{sum += $2} END {print sum}')
covered_lines=$(grep -o "LH:[0-9]*" coverage/lcov.info | awk -F: '{sum += $2} END {print sum}')

if [ -z "$total_lines" ] || [ -z "$covered_lines" ]; then
  echo "Failed to extract total or covered lines."
  exit 1
fi
if [ "$total_lines" -eq 0 ]; then
  echo "No lines found in coverage report."
  exit 1
fi

echo "Total Lines: $total_lines"
echo "Covered Lines: $covered_lines"

code_coverage=$(echo "scale=4; ($covered_lines / $total_lines) * 100" | bc)
formatted_coverage=$(printf "%.2f" "$code_coverage")

if [ -z "$formatted_coverage" ]; then
  echo "Failed to calculate code coverage percentage."
  exit 1
fi
echo "Code Coverage: ${formatted_coverage}%"
if (( $(echo "$formatted_coverage < $CODE_COVERAGE_TARGET" | bc) )); then
  echo "Code coverage is less than $CODE_COVERAGE_TARGET%"
  exit 1
fi
echo "Code coverage is sufficient."
