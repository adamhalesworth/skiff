import 'dart:async';

import 'package:skiff/skiff.dart';

class FetchCharacters implements Request<FetchCharactersResult> {}

class FetchCharactersResult {
  final List<String> characters;

  FetchCharactersResult(this.characters);
}

class Authenticate implements Request<RequestResult> {
  final String username;
  final String password;

  Authenticate(this.username, this.password);
}

void main() async {
  var mediator = Mediator();

  var query = FetchCharacters();

  var charactersHandler =
      FuncHandler<FetchCharacters, FetchCharactersResult>((command) {
    return Future.value(FetchCharactersResult([
      'Eleven',
      'Mike Wheeler',
      'Dustin Henderson',
      'Jim Hopper',
      'Jonathan Byers',
      'Murray Bauman'
    ]));
  });

  mediator.addHandler(charactersHandler);

  var characters = await mediator.dispatch(query);
  characters.characters.forEach(print);

  var command = Authenticate('alexei@starcourtmall.com', 'pa55w0rd');

  var authenticationHandler =
      FuncHandler<Authenticate, RequestResult>((command) {
    return Future.value(RequestResult.succeeded());
  });

  mediator.addHandler(authenticationHandler);

  var result = await mediator.dispatch<RequestResult>(command);
  print('Login ${result.isSuccessful ? 'successful' : 'failed'}');
}
