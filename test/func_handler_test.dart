import 'dart:async';

import 'package:skiff/skiff.dart';
import 'package:test/test.dart';

class FetchStrangerThingsCharacters extends Request {}

void main() {
  test('.execute() executes the given operation', () async {
    var sut =
        FuncHandler<FetchStrangerThingsCharacters, List<String>>((request) async {
      return Future.value(['Jim Hopper', 'Joyce Byers', 'Steve Harrington']);
    });

    var result = await sut.execute(FetchStrangerThingsCharacters());

    expect(result.length, equals(3));
  });
}
