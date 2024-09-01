import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:more4u/core/constants/constants.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import '../../../core/themes/app_colors.dart';

class MedicalFeature extends StatelessWidget {
  final String imagePath;
  final String title;
  final String description;
  final void Function()? onTap;
  const MedicalFeature(
      {super.key,
      required this.imagePath,
      required this.title,
      required this.description,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.r),
        ),
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Container(
                height: 200.h,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.r),
                  color: Color(0xFFfbfbfb),
                  //  gradient: LinearGradient(colors: [ Color(0xFF446CFF), Color(0xFF1E9AFF),]),
                ),
                child: Padding(
                  padding:  EdgeInsets.all(20.w),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      title == "Pending Requests"
                          ? CircularPercentIndicator(
                        radius: 30.0.r,
                        lineWidth: 8.0.w,
                        percent:0.75 * 0.9,
                        startAngle: 290,
                        arcType: ArcType.FULL,
                        circularStrokeCap: CircularStrokeCap.round,
                        center: Stack(
                          alignment: Alignment.center,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  pendingRequestMedicalCount.toString()??"0",
                                  style: TextStyle(
                                    //  color: Color(0xff1980ff),
                                    color: AppColors.redColor,
                                      fontSize: 18.sp,
                                      fontWeight: FontWeight.w700,
                                    fontFamily: "Certa Sans",),
                                ),
                              ],
                            ),
                          ],
                        ),
                        linearGradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      stops: [
                        0.0,
                        0.7,
                        1
                      ],
                      //  tileMode: TileMode.repeated,
                      colors: [
                        Color(0xFF00a7ff),
                        Color(0xFF2a64ff),
                        Color(0xFF1980ff),
                      ]),
                        animation: true,
                        animationDuration: 2000,
                        animateFromLastPercent: true,
                      )
                          : SizedBox(
                              height: title=="History"?55.h: 60.h,
                              child: Image.asset(imagePath),
                            ),
                    ],
                  ),
                )),
            Container(
              height: 100.h,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15.r),
                color: AppColors.whiteColor,
                //  gradient: LinearGradient(colors: [ Color(0xFF446CFF), Color(0xFF1E9AFF),]),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        color: AppColors.blackColor,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                        fontFamily: "Certa Sans",
                      ),
                    ),
                    SizedBox(
                      height:5.h,
                    ),
                    Text(
                      description,
                      style: TextStyle(
                        color: AppColors.greyDark,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                        fontFamily: "Certa Sans",
                      ),
                    ),
                    Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        CircleAvatar(
                          radius: 10.r,
                          backgroundColor: Colors.transparent,
                          child: Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                gradient: LinearGradient(
                                  colors: [
                                    Color(0xFF446CFF),
                                    Color(0xFF1E9AFF),
                                  ],
                                ),
                              ),
                              child: Center(
                                  child: Icon(
                                Icons.arrow_forward_ios_outlined,
                                size: 12.sp,
                                color: AppColors.whiteColor,
                              ))),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
