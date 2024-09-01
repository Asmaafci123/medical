import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/constants/app_strings.dart';

loadingAlertDialog(BuildContext context,{bool isDismissible=false}) {
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        content: Row(
          children: [
           CircularProgressIndicator(
              // color:  LinearGradient(
              //     begin: Alignment.topLeft,
              //     end: Alignment.bottomRight,
              //     stops: [
              //       0.0,
              //       0.7,
              //       1
              //     ],
              //     //  tileMode: TileMode.repeated,
              //     colors: [
              //       Color(0xFF00a7ff),
              //       Color(0xFF2a64ff),
              //       Color(0xFF1980ff),
              //     ]),
             color: Color(0xFF1980ff),
            ),
            SizedBox(
              width: 4.w,
            ),
            Container(
              margin: EdgeInsets.only(left: 16.w),
              child: Text(AppStrings.loading.tr(),style: TextStyle(
                fontSize: 16.sp,
                fontFamily: "Certa Sans",
              ),),
            ),
          ],
        ),
      );
    },
  );
}
