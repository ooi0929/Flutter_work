/*
 * flutter run -t lib/main.dart
 * flutter build apk -t lib/main.dart
 */

import '../core/environment.dart';

Future<void> main() async =>
    await Environment.newInstance(BuildType.hello).run();
