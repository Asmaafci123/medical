import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:more4u/presentation/pending_requests/pending_requests_screen.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import '../../../core/themes/app_colors.dart';
import 'clip_image.dart';

class TotalBenefits extends StatelessWidget {
  const TotalBenefits({super.key});

  @override
  Widget build(BuildContext context) {
    double yourPercentage = 0.9;
    return GestureDetector(
      onTap: ()
      {
        Navigator.of(context).pushNamed(
            PendingRequestsScreen.routeName);
      },
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                tileMode: TileMode.repeated,
                  colors: [ Color(0xFF446CFF),Color(0xFF1E9AFF),Color(0xFF99D1FF),]),
                borderRadius: BorderRadius.circular(17.r)),
            child: Padding(
              padding: EdgeInsets.fromLTRB(20.w, 16.h, 20.w, 16.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Mange Pending Requests",
                        style: TextStyle(
                            color: AppColors.backgroundColor,
                            fontWeight: FontWeight.w600,
                            fontSize: 16.sp,
                            fontFamily: "Cairo"
                        ),
                      ),
                      Text(
                        "keep on Requests",
                        style: TextStyle(
                            color: AppColors.greyWhiteColor,
                            fontWeight: FontWeight.w400,
                            fontSize: 14.sp,
                            fontFamily: "Cairo"),
                      ),
                    ],
                  ),
                  CircularPercentIndicator(
                    radius: 35.0.r,
                    lineWidth: 8.0.w,
                    percent:  0.775 * yourPercentage,
                    startAngle: 290,
                    arcType: ArcType.FULL,
                //    progressColor: AppColors.mainColor,
                    circularStrokeCap: CircularStrokeCap.round,
                    center: Stack(
                      alignment: Alignment.center,
                      children: [
                        Image.asset("assets/images/circle_point.png",fit: BoxFit.fill,),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "156",
                              style: TextStyle(
                                  color: AppColors.whiteColor,
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w700,
                                  fontFamily: "Cairo"),
                            ),
                            Text(
                              "benefits",
                              style: TextStyle(
                                  color: AppColors.whiteColor,
                                  fontSize:10.sp,
                                  fontWeight: FontWeight.w400,
                                  fontFamily: "Cairo"),
                            ),
                          ],
                        ),
                      ],
                    ),
                    linearGradient: LinearGradient(
                        colors: [
                      Color(0xFFC2C4D9),
                      Color(0xFFD34657),
                    ]),
                    animation: true,
                    animationDuration: 2000,
                    animateFromLastPercent: true,
                  )
                ],
              ),
            ),
          ),
          Positioned(
              left: 0,
              top: 0,
              child: ClipImage(
                topLeftRadius: Radius.circular(17.r),
                bottomRightRadius: const Radius.circular(0),
                imagePath: "assets/images/gradient_circle.png",
              )),
          Positioned(
              right: 0,
              bottom: 0,
              child: ClipImage(
                topLeftRadius: const Radius.circular(0),
                bottomRightRadius: Radius.circular(17.r),
                imagePath: "assets/images/gradient_circle_2.png",
              )),
        ],
      ),
    );
  }
}
