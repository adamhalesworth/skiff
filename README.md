# Skiff

A lightweight, Future-based library for expressing CQRS principles in Dart
projects.

This package allows you to write smaller, more robust and testable code by
turning data access (or anything else you can think of) logic into first-class
objects with sound typing.

## Tasks

This package utilises the excellent `grinder` package to define workflows.

Just install the executable `pub global activate grinder` and run `grind -h` to discover all available tasks.

## CQRS+ES

CQRS fits very nicely with Event Sourcing, which is not covered by this package.