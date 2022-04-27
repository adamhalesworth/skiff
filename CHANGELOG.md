# Changelog

## 0.3.0

This version signals a change in the direction of this package. The CQRS nomenclature
and classes have been removed in favour of a cleaner API that doesn't model a specific
pattern.

### Added

- `Mediator` can now broadcast events to listeners.
- `Bus` and `Relay` classes.
- `RequestResult`

### Removed

- `Command`, `CommandHandler`, `CommandResult`
- `Query` and `QueryHandler`

### Changed

- `Mediator` can now be disposed to prevent further interaction.

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

