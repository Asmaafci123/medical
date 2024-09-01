import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/themes/app_colors.dart';
class ViewProfileButton extends StatelessWidget {
  const ViewProfileButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color:Color(0xFFe8f2ff),
          borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: EdgeInsets.fromLTRB(
            14.w, 5.h, 14.w, 5.h),
        child: Text(
          "View Profile",
          style: TextStyle(
             // color: AppColors.mainColor,
            color: Color(0xFF2c93e7),
              fontSize: 14.sp,
              fontFamily: "Cairo",
              fontWeight: FontWeight.w700),
        ),
      ),
    );
  }
}
