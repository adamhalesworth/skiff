import 'dart:async';

import 'package:skiff/skiff.dart';

class FetchCharacters extends Query {}

class FetchCharactersResult {
  final List<String> characters;

  FetchCharactersResult(this.characters);
}

class Authenticate extends Command {
  final String username;
  final String password;

  Authenticate(this.username, this.password);
}

void main() async {
  var query = FetchCharacters();

  var charactersHandler =
      SimpleQueryHandler<FetchCharacters, FetchCharactersResult>((command) {
    return Future.value(FetchCharactersResult([
      'Eleven',
      'Mike Wheeler',
      'Dustin Henderson',
      'Jim Hopper',
      'Jonathan Byers',
      'Murray Bauman'
    ]));
  });

  var characters = await charactersHandler.get(query);

  characters.characters.forEach((element) {
    print(element);
  });

  var command = Authenticate('alexei@starcourtmall.com', 'pa55w0rd');

  var authenticationHandler = SimpleCommandHandler<Authenticate>((command) {
    return Future.value(CommandResult.succeeded());
  });

  var result = await authenticationHandler.execute(command);
  print('Login ${result.isSuccessful ? 'successful' : 'failed'}');
}
