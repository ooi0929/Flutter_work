import '../core/environment.dart';

Future<void> main() async =>
    await Environment.newInstance(BuildType.numberQuiz).run();
