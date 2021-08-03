import 'dart:async';

/// Represents the result from a [Command].
///
/// Commands in CQRS shouldn't return anything, but a tradeoff was made to at
/// least return _something_ which indicates to the caller whether or not the
/// operation was successful.
class CommandResult {
  final bool isSuccessful;
  final String message;

  CommandResult.succeeded({this.message}) : isSuccessful = true;
  CommandResult.failed({this.message}) : isSuccessful = false;

  /// Returns this [CommandResult] as a completed [Future].
  Future<CommandResult> asFuture() {
    return Future.value(this);
  }
}
