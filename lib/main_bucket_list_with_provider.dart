import 'core/environment.dart';

Future<void> main() async =>
    await Environment.newInstance(BuildType.bucket_list_with_provider).run();
