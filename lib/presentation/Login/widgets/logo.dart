import 'package:flutter/material.dart';
class CustomLogo extends StatelessWidget {
  const CustomLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
          width: double.infinity,
          child: Image.asset(
            'assets/images/decoration.png',
            fit: BoxFit.fitWidth,
          )),
    );
  }
}
