import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/constants/constants.dart';
import '../../../core/themes/app_colors.dart';

myAppBarMedical(String title) {
  if(defaultTargetPlatform==TargetPlatform.android) {
    return AppBar(
    title: Text(title, style: TextStyle(
      color: AppColors.redColor,
      fontSize: 20.sp,
      fontWeight: FontWeight.bold,
      fontFamily: 'Joti',
    )),
    backgroundColor: Colors.grey.shade50,
      elevation: 0,
      leadingWidth: 5.w,
      leading: SizedBox(),
  );
  } else
  {
    return CupertinoNavigationBar(
      middle: Text(title, style: const TextStyle(color: AppColors.mainColor)),
      backgroundColor: Colors.grey.shade50,
    );
  }

}
