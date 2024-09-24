#!/bin/bash

exclude_patterns=$(find . -name "*.g.dart" | sed 's|^\./||' | tr '\n' ' ')
# shellcheck disable=SC2086
lcov --remove coverage/lcov.info $exclude_patterns -o coverage/lcov.info --ignore-errors unused,unused
