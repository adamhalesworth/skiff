# Changelog

## 0.2.0

### Added

- New `Mediator` that handles dispatch of commands and queries.
- New base `Request` that `Command` and `Query` implement.

### Removed

- `SimpleQueryHandler` and `SimpleCommandHandler` have been replaced with `FuncHandler`.

## 0.1.1

### Changed

- Small example amends

## 0.1.0

- Includes all major interfaces required for working with CQRS including commands, queries and their handlers.
- Includes `SimpleQueryHandler` and `SimpleCommandHandler` classes that receive functions to execute. These can be used for fast prototyping.

