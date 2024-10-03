import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:more4u/core/constants/app_strings.dart';
import 'package:more4u/core/themes/app_colors.dart';

showWarningDialog({
  required BuildContext context,
  String? message,
  required bool isSucceeded,
  VoidCallback? onPressedOk,
}) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.r)),
          child: Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.topCenter,
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.r),
                    gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        stops: [
                          0.2,
                          1,
                        ],
                        //  tileMode: TileMode.repeated,
                        colors: [
                         // Color(0xFFffb545),
                          Color(0xFFf2cc93),
                          Color(0xFFfef6ee),
                        ])
                ),
                height: 100.h,
                width: 372.w,
                child: Padding(
                  padding: EdgeInsets.fromLTRB(10.w, 20.h, 10.w, 20.h),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50.r)),
                        shadowColor:Color(0xFFf2cc93),
                        elevation: 5,
                        child: Container(
                          height: 50.h,
                          width: 50.h,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50.r),
                            color: Color(0xFFfefbfa)
                          ),
                          child: SizedBox(
                              height: 20.h,
                              width: 20.h,
                              child: Image.asset("assets/images/warning_icon.png",width: 20.w,fit: BoxFit.contain,))
                        ),
                      ),
                      SizedBox(
                        width: 10.w,
                      ),
                      Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Warning !",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 25.sp,
                                fontFamily: "Certa Sans",
                                color:AppColors.blackColor,
                              ),
                            ),
                            SizedBox(
                              height: 10.h,
                            ),
                            Text(
                              message??'',
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 16.sp, fontFamily: "Certa Sans",color: AppColors.greyDark),
                              overflow: TextOverflow.ellipsis,
                              softWrap: true,
                              maxLines: 3,
                            ),
                          ]),
                    ],
                  ),
                ),
              ),
            ],
          ));
    },
  );
}
