import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:more4u/core/constants/app_strings.dart';
import 'package:more4u/core/constants/constants.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import '../../../core/themes/app_colors.dart';
import '../../medical_request_details_and_doctor_response/widgets/side_cut_clipper.dart';

class CurrentEmployeeInfo extends StatelessWidget {
  const CurrentEmployeeInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        ClipPath(
          clipper: SideCutClipper(),
          child: Container(
            height: 180.h,
          ),
        ),
        Positioned(
          bottom: 14.h,
          child: ClipPath(
            clipper: SideCutClipper(),
            child: Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.r),
              ),
              shadowColor: Color(0xFF446CFF),
              child: Container(
                width: 330.w,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.r),
                    gradient: LinearGradient(
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
                        ])),
                child: Padding(
                  padding: EdgeInsets.fromLTRB(16.w, 60.h, 16.w, 20.h),
                  child: Row(
                    mainAxisAlignment:languageId==2? MainAxisAlignment.end:MainAxisAlignment.start,
                    children: [
                      Image.asset(
                        "assets/images/man.png",
                        width: 30.w,
                      ),
                      SizedBox(
                        width: 10.w,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            userData?.sapNumber.toString() ?? "",
                            style: TextStyle(
                              color: AppColors.whiteColor,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w200,
                              //fontFamily: "Nunito",
                              fontFamily: "Certa Sans",
                            ),
                          ),
                          SizedBox(
                            height: 2.h,
                          ),
                          Text(
                            AppStrings.employeeNumber.tr(),
                            style: TextStyle(
                              color: AppColors.whiteColor,
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w200,
                              //fontFamily: "Nunito",
                              fontFamily: "Certa Sans",
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: 30.w,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            color: AppColors.whiteColor,
                            borderRadius: BorderRadius.circular(50.r)),
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Icon(
                            Icons.family_restroom,
                            color: Color(0xFF446CFF),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 8.w,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${relativeCount??"0"} ${AppStrings.members.tr()}",
                            style: TextStyle(
                              color: AppColors.whiteColor,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w200,
                              //fontFamily: "Nunito",
                              fontFamily: "Certa Sans",
                            ),
                          ),
                          SizedBox(
                            height: 2.h,
                          ),
                          Text(
                            AppStrings.medicalCoverage.tr(),
                            style: TextStyle(
                              color: AppColors.whiteColor,
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w200,
                              //fontFamily: "Nunito",
                              fontFamily: "Certa Sans",
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
        Card(
          elevation: 2,
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.r)),
          child: Container(
            width: 270.w,
            decoration:
            BoxDecoration(borderRadius: BorderRadius.circular(20.r)),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Card(
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50.r)),
                    shadowColor: const Color(0xFF446CFF),
                    // child: CircleAvatar(
                    //   radius: 30.r,
                    //   backgroundImage:
                    //   NetworkImage(
                    //     userData?.profilePictureAPI??"",
                    //   )
                    // )
                    child: Container(
                      height: 50.h,
                      width: 50.h,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50.r)),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(50.r),
                        child: Image.network(
                          userData?.profilePictureAPI ?? "",
                          fit: BoxFit.fill,
                          errorBuilder: (context, error, stackTrace) =>
                              Image.asset(
                                'assets/images/profile_avatar_placeholder.png',
                                fit: BoxFit.fill,
                              ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10.w,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 140.w,
                        child: Text(
                          userData?.userName ?? "",
                          style: TextStyle(
                            color: AppColors.blackColor,
                            fontSize: 20.sp,
                            fontWeight: FontWeight.w200,
                            //fontFamily: "Nunito",
                            fontFamily: "Certa Sans",
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      SizedBox(
                        width: 130.w,
                        child: Text(
                          userData?.departmentName ?? "",
                          style: TextStyle(
                            color: AppColors.greyColor,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w500,
                            //fontFamily: "Nunito",
                            fontFamily: "Certa Sans",
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
        Positioned(
            right: 25.w,
            bottom: 15.h,
            child: CircularPercentIndicator(
              radius: 30.0.r,
              lineWidth: 6.0.w,
              percent: 0.75 * 0.9,
              startAngle: 300,
              arcType: ArcType.FULL,
              circularStrokeCap: CircularStrokeCap.round,
              center: Stack(
                alignment: Alignment.center,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        medicalCoverage ?? "0%",
                        style: TextStyle(
                          color: AppColors.mainColor,
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w700,
                          fontFamily: "Certa Sans",
                        ),
                      ),
                      Text(
                        AppStrings.medical.tr(),
                        style: TextStyle(
                          color: AppColors.mainColor,
                          fontSize: 10.sp,
                          fontWeight: FontWeight.w600,
                          fontFamily: "Certa Sans",
                        ),
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
            )),
      ],
    );
  }
}