import 'package:flutter_workspace/core/environment.dart';

Future<void> main() async =>
    await Environment.newInstance(BuildType.randomCat).run();
