abstract class MediatorException implements Exception {
  final String message;

  const MediatorException(this.message);

  @override
  String toString() {
    return '$runtimeType: $message';
  }
}

/// Exception thrown when attempting to add a handler without supplying a
/// request type that the handler is associated with.
class RequestTypeMissingException extends MediatorException {
  RequestTypeMissingException() : super('Missing required request type');
}

/// Exception thrown when attempting to add a handler for a request where one
/// already exists.
class AlreadyRegisteredException extends MediatorException {
  AlreadyRegisteredException(Type requestType)
      : super('A handler already exists for $requestType');
}

/// Exception thrown when a handler doesn't exist for a request, indicating that
/// it can't be handled.
class MissingHandlerException extends MediatorException {
  MissingHandlerException(Type requestType)
      : super('Handler missing for $requestType');
}
