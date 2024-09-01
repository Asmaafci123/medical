import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class CustomMore4uLogo extends StatelessWidget {
  const CustomMore4uLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Center(
        child: Hero(
          tag: 'logo',
          child: Image.asset(
            'assets/images/more4u_new.png',
            height: 170.h,
            width: 180.w,
          ),
        ),
      ),
    );
  }
}
