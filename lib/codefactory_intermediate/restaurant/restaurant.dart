import 'package:flutter/material.dart';
import 'package:flutter_workspace/codefactory_intermediate/restaurant/common/component/custom_text_form_field.dart';

class Restaurant extends StatelessWidget {
  const Restaurant({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: CustomTextFormField(),
    );
  }
}
