import '../core/environment.dart';

Future<void> main() async =>
    await Environment.newInstance(BuildType.goRouteV7).run();
