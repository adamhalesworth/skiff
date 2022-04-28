#!/usr/bin/env bash
dart test --coverage="coverage"
format_coverage --verbose --lcov --in=coverage --out=coverage/coverage.lcov --packages=.packages --report-on=lib
genhtml coverage/coverage.lcov -o coverage/html