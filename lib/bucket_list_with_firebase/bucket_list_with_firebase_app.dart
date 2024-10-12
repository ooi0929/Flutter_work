import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'auth_service.dart';
import 'bucket_list_with_firebase.dart';
import 'login_page.dart';

class BucketListWithFirebaseApp extends StatelessWidget {
  const BucketListWithFirebaseApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Consumer를 사용하지 않을 때 위젯트리 상위에서 가져오는 방법.
    final user = context.read<AuthService>().currentUser();

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: user == null ? LoginPage() : BucketListWithFirebase(),
    );
  }
}
