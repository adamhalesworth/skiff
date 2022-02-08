import 'package:skiff/skiff.dart';

class StubRequest implements Request<RequestResult> {
  final String username;
  final String password;

  StubRequest(this.username, this.password);

  @override
  String toString() => '$username, ${"*" * password.length}';
}

class StubHandler implements Handler<StubRequest, RequestResult> {
  bool _shouldFail = false;

  void fail() => _shouldFail = true;

  @override
  Future<RequestResult> execute(StubRequest r) {
    return _shouldFail
        ? Future.value(RequestResult.failed(message: 'Something went wrong'))
        : Future.value(RequestResult.succeeded());
  }
}