import 'dart:async';

import 'package:skiff/skiff.dart';

class Authenticate extends Command {
  final String username;
  final String password;

  Authenticate(this.username, this.password);
}

void main() async {
  var command = Authenticate('alexei@starcourtmall.com', 'pa55w0rd');

  var authenticationHandler = SimpleCommandHandler<Authenticate>((command) {
    return Future.value(CommandResult.succeeded());
  });

  var result = await authenticationHandler.execute(command);
  print(result.isSuccessful ? 'Success' : 'Failed');
}
