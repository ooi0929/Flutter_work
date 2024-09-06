/*
 * flutter run -t lib/main.dart 
 * flutter build apk -t lib/main.dart 
 */

import 'core/environment.dart';

Future<void> main() async => Environment.newInstance(BuildType.instagram).run();
