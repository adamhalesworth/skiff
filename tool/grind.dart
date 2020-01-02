import 'package:grinder/grinder.dart';

void main(args) => grind(args);

@Task()
void test() {
  log('Running test suite...');
  PubApp.local('test').run([]);
}

@Task()
void analyze() {
  log('Performing static analysis...');
  Analyzer.analyze('.');
}

@Task()
@Depends(test, analyze)
void lint() {
  log('Applying formatting...');
  DartFmt.format('.');
}

@Task()
@Depends(analyze, lint)
void doc() {
  log('Generating documentation...');
  DartDoc.docAsync();
}

@DefaultTask()
@Depends(test, analyze, lint, doc)
void build() => null;
