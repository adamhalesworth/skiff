import 'dart:async';

/// Represents the result from a [Request].
class RequestResult {
  final bool isSuccessful;
  final String message;

  RequestResult.succeeded({this.message = ''}) : isSuccessful = true;
  RequestResult.failed({this.message = ''}) : isSuccessful = false;

  /// Returns this [RequestResult] as a completed [Future].
  Future<RequestResult> asFuture() {
    return Future.value(this);
  }
}
