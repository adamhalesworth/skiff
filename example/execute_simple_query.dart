import 'dart:async';

import 'package:skiff/skiff.dart';

class FetchCharacters extends Query {}

class FetchCharactersResult {
  final List<String> characters;

  FetchCharactersResult(this.characters);
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

  var result = await charactersHandler.get(query);

  result.characters.forEach((element) {
    print(element);
  });
}
