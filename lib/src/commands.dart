import 'dart:async';

/// A marker interface for commands.
abstract class Command {}

/// Represents the result from a [Command].
///
/// Commands in CQRS shouldn't return anything, but a tradeoff was made to at
/// least return _something_ which indicates to the caller whether or not the
/// operation was successful.
class CommandResult {
  final bool isSuccessful;
  String message;

  CommandResult.succeeded({this.message}) : isSuccessful = true;
  CommandResult.failed({this.message}) : isSuccessful = false;

  /// Returns this [CommandResult] as a completed [Future].
  Future<CommandResult> asFuture() {
    return Future.value(this);
  }
}

/// Defines an abstract command handler
abstract class CommandHandler<C extends Command> {
  /// Handles the [command], and returns a [Future] that completes to a
  /// [CommandResult] indicating whether the operation was successful.
  ///
  /// Here we expect that the operation being performed is non-blocking because
  /// this fits with most use cases. If the operation is simple, just return a
  /// completed [Future] using `Future.value(result)` or with the
  /// [CommandResult.asFuture] helper method.
  Future<CommandResult> execute(C command);
}

typedef ExecuteCommand<C> = Future<CommandResult> Function(C);

/// A [CommandHandler] whose work to perform is defined via a function.
///
/// This is generally handy for testing or quick prototyping, but in production
/// should probably be replaced with a concrete [CommandHandler] subclass which
/// better expresses your intent.
class SimpleCommandHandler<C extends Command> implements CommandHandler<C> {
  final ExecuteCommand<C> _fn;

  SimpleCommandHandler(this._fn);

  @override
  Future<CommandResult> execute(C command) {
    return _fn(command);
  }
}
