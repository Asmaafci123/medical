import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PoweredByCemex extends StatelessWidget {
  const PoweredByCemex({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          "Powered by",
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.black,
            fontSize: 20.sp,
              fontFamily: "Certa Sans",
            fontWeight: FontWeight.w500
          ),
        ),
        Image.asset(
          'assets/images/cemex_new_logo.png',
          width: 90.w,
          height: 40.h,
          fit: BoxFit.fitWidth,
        )
      ],
    );
  }
}
