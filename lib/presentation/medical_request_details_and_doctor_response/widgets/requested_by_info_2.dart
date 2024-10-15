
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:more4u/core/constants/app_strings.dart';
import 'package:more4u/core/constants/constants.dart';
import 'package:more4u/core/themes/app_colors.dart';
import 'package:more4u/presentation/medical_request_details_and_doctor_response/widgets/side_cut_clipper.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import '../../pending_requests/cubits/pending_requests_cubit.dart';
import 'call_icon.dart';

class RequestedByInfo1 extends StatelessWidget {
  final String? requestDate;
  final double employeeCoverage;
  final String? requestedByName;
  final String? requestedByDepartment;
  final String? phoneNumber;
  const RequestedByInfo1(
      {super.key,
      required this.employeeCoverage,
      required this.requestedByName,
      required this.requestedByDepartment,
        required this.requestDate,
        required this.phoneNumber
      });

  @override
  Widget build(BuildContext context) {
    var outputFormat = DateFormat('dd MMM, yyyy hh:mm a',languageId==2?"ar":"en");
    var convertedRequestDate=DateTime.parse(requestDate??"");
    var outputDate = outputFormat.format(convertedRequestDate);
    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        Transform.flip(
         flipX:languageId==2? true:false,
          child: ClipPath(
            clipper: SideCutClipper(),
            child: Card(
              elevation: 1,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.r)),
              child: Container(
                  height: 130.h,
                  width: 500.w,
                  decoration: BoxDecoration(
                   //   color:Color(0xFFf8f4f0),
                    color: AppColors.whiteColor,
                      borderRadius: BorderRadius.circular(15.r)),
              ),
            ),
          ),
        ),
        Positioned(
            child:  Padding(
          padding: EdgeInsets.fromLTRB(10.w, 10.h, 10.w, 0.h),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    outputDate,
                    style: TextStyle(
                        color: AppColors.greyColor,
                        fontSize: 14.sp,
                        fontFamily: "Certa Sans",
                        fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    width: 10.w,
                  ),
                  Expanded(
                    child: Container(
                      color: Color(0xFFE7E7E8),
                      height: 0.9.h,
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 90.h,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CircularPercentIndicator(
                      radius: 35.0.r,
                      lineWidth: 8.0.w,
                      percent: 0.9,
                      startAngle: 290,
                      arcType: ArcType.FULL,
                      circularStrokeCap: CircularStrokeCap.round,
                      center: Stack(
                        alignment: Alignment.center,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Row(
                                mainAxisAlignment:
                                MainAxisAlignment.center,
                                children: [
                                  Text(
                                    (employeeCoverage * 100)
                                        .toInt()
                                        .toString() ??
                                        "",
                                    style: TextStyle(
                                      color: AppColors.mainColor,
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w600,
                                      fontFamily: "Certa Sans",),
                                  ),
                                  Text(
                                    (employeeCoverage * 100)
                                        .toInt()
                                        .toString()
                                        .isNotEmpty
                                        ? "%"
                                        : "",
                                    style: TextStyle(
                                      color: AppColors.mainColor,
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w600,
                                      fontFamily: "Certa Sans",),
                                  ),
                                ],
                              ),
                              Text(
                                AppStrings.medical.tr(),
                                style: TextStyle(
                                  height: 1.5,
                                  color: AppColors.mainColor,
                                  fontSize: 10.sp,
                                  fontWeight: FontWeight.w300,
                                  fontFamily: "Certa Sans",),
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
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        FittedBox(
                          fit: BoxFit.scaleDown,
                          child: SizedBox(
                            width: 170.w,
                            child: Text(
                              requestedByName ?? "",
                              style: TextStyle(
                                  color: AppColors.mainColor,
                                  fontSize: 18.sp,
                                  fontFamily: "Certa Sans",
                                  fontWeight: FontWeight.w500),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        Text(
                          requestedByDepartment ?? "",
                          style: TextStyle(
                              color: AppColors.greyDark,
                              fontSize: 14.sp,
                              fontFamily: "Certa Sans",
                              fontWeight: FontWeight.w500),
                        ),
                        PendingRequestsCubit.get(context)
                            .medicalRequestDetails
                            ?.medicalRequest
                            ?.monthlyMedication==true?
                        Column(
                          children: [
                            SizedBox(
                              height: 10.h,
                            ),
                            Container(
                              height: 40.h,
                              decoration: BoxDecoration(
                                  color:Color(0xFFe8f2ff),
                                  borderRadius: BorderRadius.circular(15)),
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal:10.w),
                                child: Center(
                                  child: Row(
                                    children: [
                                      Icon(Icons.repeat,color: Color(0xFF2c93e7),),
                                      SizedBox(
                                        width: 5.w,
                                      ),
                                      Text(
                                        AppStrings.monthlyMedication.tr(),
                                        style: TextStyle(
                                          // color: AppColors.mainColor,
                                            color: Color(0xFF2c93e7),
                                            fontSize: 14.sp,
                                            fontFamily: "Cairo",
                                            fontWeight: FontWeight.w700),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ): SizedBox()
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),

        )),
        Positioned.directional(
          textDirection:Directionality.of(context) ,
          end: 10.w,
          child:CallIcon(phoneNumber: phoneNumber,),
        )
      ],
    );
  }
}


