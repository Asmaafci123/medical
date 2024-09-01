import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import '../../../core/themes/app_colors.dart';
class RequestedByInfo extends StatelessWidget {
  final double employeeCoverage;
  final String? requestedByName;
  final String? requestedByDepartment;
  const RequestedByInfo({super.key,required this.employeeCoverage,required this.requestedByName,required this.requestedByDepartment});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircularPercentIndicator(
          radius: 40.0.r,
          lineWidth: 8.0.w,
          percent:employeeCoverage * 0.9,
          startAngle: 290,
          arcType: ArcType.FULL,
          circularStrokeCap: CircularStrokeCap.round,
          center: Stack(
            alignment: Alignment.center,
            children: [
              // Image.asset(
              //   "assets/images/circle_point.png",
              //   fit: BoxFit.fill,
              // ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        (employeeCoverage*100).toInt().toString() ??"",
                        style: TextStyle(
                            color: AppColors.mainColor,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w700,
                            fontFamily: "Cairo"),
                      ),
                      Text(
                        (employeeCoverage*100).toInt().toString().isNotEmpty?"%":"",
                        style: TextStyle(
                            color: AppColors.mainColor,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w700,
                            fontFamily: "Cairo"),
                      ),
                    ],
                  ),
                  Text(
                    "Medical",
                    style: TextStyle(
                        color: AppColors.mainColor,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w700,
                        fontFamily: "Cairo"),
                  ),
                ],
              ),
            ],
          ),
          linearGradient: LinearGradient(colors: [
            Color(0xFFC2C4D9),
            Color(0xFFD34657),
          ]),
          animation: true,
          animationDuration: 2000,
          animateFromLastPercent: true,
        ),
        SizedBox(
          width: 25.w,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              requestedByName ??
                  "",
              style: TextStyle(
                  color: AppColors.mainColor,
                  fontSize: 14.sp,
                  fontFamily: "Cairo",
                  fontWeight: FontWeight.w700),
            ),
            Row(
              children: [
                Image.asset(
                  "assets/images/deparment.png",
                  height: 16.h,
                ),
                SizedBox(
                  width: 5.w,
                ),
                Text(
                  requestedByDepartment??"",
                  style: TextStyle(
                      color: AppColors.mainColor,
                      fontSize: 14.sp,
                      fontFamily: "Cairo",
                      fontWeight: FontWeight.w500),
                ),
              ],
            ),
            SizedBox(
              height: 10.h,
            ),
            Row(
              children: [
                ClipRRect(
                    borderRadius:
                    BorderRadius.circular(12.0.r),
                    child: Image.asset(
                      "assets/images/user.png",
                      height: 40.h,
                    )),
                SizedBox(
                  width: 20.w,
                ),
                ClipRRect(
                    borderRadius:
                    BorderRadius.circular(14.0.r),
                    child: Image.asset(
                      "assets/images/mobile.png",
                      height: 40.h,
                    )),
              ],
            )
          ],
        )
      ],
    );
  }
}
