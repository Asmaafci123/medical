import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:more4u/core/constants/constants.dart';
import 'package:more4u/core/themes/app_colors.dart';
import 'package:more4u/presentation/medication/cubits/request_medication_cubit.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

import '../../../custom_icons.dart';
class EmployeeInfo extends StatelessWidget {
  const EmployeeInfo({super.key});

  @override
  Widget build(BuildContext context) {
    double yourPercentage = 0.9;
    var _cubit=RequestMedicationCubit.get(context);
   // DateTime submitDate=DateTime.parse(_cubit.currentEmployee1!.birthDate??"");
   // String formattedDate = DateFormat('dd MMMM yyyy',"en_SA").format(submitDate);
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
              // gradient: LinearGradient(
              //     tileMode: TileMode.repeated,
              //     colors: [ Color(0xFF446CFF),Color(0xFF1E9AFF),Color(0xFF99D1FF),]),
           // color: AppColors.mainColor,
              color: AppColors.whiteColor,
              borderRadius: BorderRadius.circular(17.r),
          border: Border.all(
            width: 0.2.w,
            color: AppColors.greyColor
          )),
          child: Padding(
            padding: EdgeInsets.fromLTRB(20.w, 10.h, 20.w, 10.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _cubit.currentEmployee?.employeeName??"",
                      style: TextStyle(
                         // color: AppColors.backgroundColor,
                          color: AppColors.mainColor,
                          fontWeight: FontWeight.w700,
                          fontSize: 18.sp,
                          fontFamily: "Cairo"
                      ),
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    Row(
                      children: [
                        Icon(CustomIcons.business_time,
                         // color: AppColors.greyWhiteColor,
                          color: Color(0xFFD34657),
                          size: 16.sp,),
                        SizedBox(width: 5.w,),
                        Text(
                          "Planing Department",
                          style: TextStyle(
                           //   color: AppColors.greyWhiteColor,
                              color: AppColors.mainColor,
                              fontWeight: FontWeight.w400,
                              fontSize: 14.sp,
                              fontFamily: "Cairo"),
                        ),
                      ],
                    ),
                    // Row(
                    //   children: [
                    //     Icon(CustomIcons.cake_birthday,
                    //       // color: AppColors.greyWhiteColor,
                    //       color: Color(0xFFD34657),
                    //       size: 16.sp,),
                    //     SizedBox(width: 5.w,),
                    //     Text(
                    //       formattedDate,
                    //       style: TextStyle(
                    //         //  color: AppColors.greyWhiteColor,
                    //           color: AppColors.mainColor,
                    //           fontWeight: FontWeight.w400,
                    //           fontSize: 14.sp,
                    //           fontFamily: "Cairo"),
                    //     ),
                    //   ],
                    // ),
                    Row(
                      children: [
                        Icon(CustomIcons.users_alt,
                          // color: AppColors.greyWhiteColor,
                          color: Color(0xFFD34657),size: 16.sp,),
                        SizedBox(width: 5.w,),
                        Text(
                          '${_cubit.currentEmployee?.relatives?.length??0} under coverage',
                          style: TextStyle(
                            //  color: AppColors.greyWhiteColor,
                              color: AppColors.mainColor,
                              fontWeight: FontWeight.w400,
                              fontSize: 14.sp,
                              fontFamily: "Cairo"),
                        ),
                      ],
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
                            "100%",
                            style: TextStyle(
                              //  color: AppColors.whiteColor,
                                color: AppColors.mainColor,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w700,
                                fontFamily: "Cairo"),
                          ),
                          Text(
                            "Medical",
                            style: TextStyle(
                              //  color: AppColors.whiteColor,
                                color: AppColors.mainColor,
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
        // Positioned(
        //     left: 0,
        //     top: 0,
        //     child: ClipImage(
        //       topLeftRadius: Radius.circular(17.r),
        //       bottomRightRadius: const Radius.circular(0),
        //       imagePath: "assets/images/gradient_circle.png",
        //     )),
        // Positioned(
        //     right: 0,
        //     bottom: 0,
        //     child: ClipImage(
        //       topLeftRadius: const Radius.circular(0),
        //       bottomRightRadius: Radius.circular(17.r),
        //       imagePath: "assets/images/gradient_circle_2.png",
        //     )),
      ],
    )
    //   Container(
    //   height: 100.h,
    //   color:Color(0xFFf2f2f2),
    //   child: Padding(
    //     padding:  EdgeInsets.fromLTRB(14.w, 8.h, 14.w, 8.h),
    //     child: Row(
    //       crossAxisAlignment: CrossAxisAlignment.center,
    //       children: [
    //         CircularPercentIndicator(
    //           radius: 35.0.r,
    //           lineWidth: 8.0.w,
    //           percent:  0.775 * yourPercentage,
    //           startAngle: 290,
    //           arcType: ArcType.FULL,
    //           //    progressColor: AppColors.mainColor,
    //           circularStrokeCap: CircularStrokeCap.round,
    //           center: Stack(
    //             alignment: Alignment.center,
    //             children: [
    //               Image.asset("assets/images/circle_point.png",fit: BoxFit.fill,),
    //               Column(
    //                 mainAxisAlignment: MainAxisAlignment.center,
    //                 children: [
    //                   Text(
    //                     "${_cubit.currentEmployee?.medicalCoverage}",
    //                     style: TextStyle(
    //                         color: AppColors.mainColor,
    //                         fontSize: 14.sp,
    //                         fontWeight: FontWeight.w700,
    //                         fontFamily: "Cairo"),
    //                   ),
    //                   Text(
    //                     "Medical",
    //                     style: TextStyle(
    //                         color: AppColors.mainColor,
    //                         fontSize:10.sp,
    //                         fontWeight: FontWeight.w400,
    //                         fontFamily: "Cairo"),
    //                   ),
    //                 ],
    //               ),
    //             ],
    //           ),
    //           linearGradient: LinearGradient(
    //               colors: [
    //                 Color(0xFFC2C4D9),
    //                 Color(0xFFD34657),
    //               ]),
    //           animation: true,
    //           animationDuration: 2000,
    //           animateFromLastPercent: true,
    //         ),
    //         SizedBox(
    //           width: 15.w,
    //         ),
    //         Column(
    //           crossAxisAlignment: CrossAxisAlignment.start,
    //           mainAxisAlignment: MainAxisAlignment.center,
    //           children: [
    //             Row(
    //               children: [
    //                 Icon(
    //                   CustomIcons.user,
    //                   size: 20.r,
    //                   color: AppColors.mainColor,
    //                 ),
    //                 SizedBox(
    //                   width: 10.w,
    //                 ),
    //                 Text( _cubit.currentEmployee?.employeeName??"",style: TextStyle(
    //                     fontSize: 14.sp,
    //                     fontWeight: FontWeight.w500,
    //                     fontFamily: "Cairo",
    //                     color: AppColors.whiteBlueColor
    //                 ),)
    //               ],
    //             ),
    //             Row(
    //               children: [
    //                 Icon(
    //                   CustomIcons.users_alt,
    //                   size: 20.r,
    //                   color: AppColors.mainColor,
    //                 ),
    //                 SizedBox(
    //                   width: 10.w,
    //                 ),
    //                 Text('${_cubit.currentEmployee?.relatives.length??0} under coverage',style: TextStyle(
    //                     fontSize: 14.sp,
    //                     fontWeight: FontWeight.w500,
    //                     fontFamily: "Cairo",
    //                     color: AppColors.whiteBlueColor
    //                 ),)
    //               ],
    //             ),
    //           ],
    //         ),
    //       ],
    //     ),
    //   ),
    // )
      ;
  }
}