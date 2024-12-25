import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../component/custom_elevated_button.dart';
import '../layout/default_layout.dart';
import '../route/router.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      body: ListView(
        children: [
          Text('Login State : $authState'),
          CustomElevatedButton(
            onPressed: () {
              setState(() {
                authState = !authState;
              });
            },
            data: authState ? 'logout' : 'login',
          ),
          CustomElevatedButton(
            onPressed: () {
              if (GoRouterState.of(context).matchedLocation == '/login') {
                context.go('/login/private');
              } else {
                context.go('/login2/private');
              }
            },
            data: 'Go to Private Route',
          ),
        ],
      ),
    );
  }
}
