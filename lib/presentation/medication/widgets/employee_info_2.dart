import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/themes/app_colors.dart';
import '../cubits/request_medication_cubit.dart';

class EmployeeInfo2 extends StatelessWidget {
  const EmployeeInfo2({super.key});

  @override
  Widget build(BuildContext context) {
    var _cubit = RequestMedicationCubit.get(context);
    return Stack(
      children: [
        Container(
          height: 140.h,
        ),
        Positioned(
          bottom: 0.h,
          child: Card(
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.r),
            ),
            shadowColor: Color(0xFF446CFF),
            child: Container(
              width: 340.w,
              height: 110.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.r),
              ),
            ),
          ),
        ),
        Positioned.directional(
            textDirection:Directionality.of(context) ,
            start: 105.w,
            top: 40.h,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FittedBox(
                  child: SizedBox(
                    width:210.w,
                    child: Text(
                      _cubit.currentEmployee?.employeeName ?? "",
                      style: TextStyle(
                          // color: AppColors.backgroundColor,
                          color: AppColors.mainColor,
                          fontWeight: FontWeight.w600,
                          fontSize: 18.sp,
                          fontFamily: "Certa Sans"),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
                Text(
                  "${_cubit.currentEmployee?.employeeDepartment??""} Department",
                  style: TextStyle(
                      color: AppColors.greyDark,
                      fontWeight: FontWeight.w400,
                      fontSize: 16.sp,
                      fontFamily: "Certa Sans"),
                ),
                SizedBox(
                  height: 10.h,
                ),
                Row(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ShaderMask(
                          blendMode: BlendMode.srcIn,
                          shaderCallback: (Rect bounds) => RadialGradient(
                            center: Alignment.topCenter,
                            stops: [0.0, 0.7, 1],
                            colors: [
                              Color(0xFF00a7ff),
                              Color(0xFF2a64ff),
                              Color(0xFF1980ff),
                            ],
                          ).createShader(bounds),
                          child: Icon(
                            Icons.family_restroom,
                            // color: Color(0xFF446CFF),
                            size: 18.sp,
                          ),
                        ),
                        SizedBox(
                          width: 4.w,
                        ),
                        Text(
                          "${_cubit.currentEmployee?.relatives?.length??"0"} ${AppStrings.members.tr()}",
                          style: TextStyle(
                              color: AppColors.greyDark,
                              fontWeight: FontWeight.w400,
                              fontSize: 16.sp,
                              fontFamily: "Certa Sans"),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: 10.w,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ShaderMask(
                          blendMode: BlendMode.srcIn,
                          shaderCallback: (Rect bounds) => RadialGradient(
                            center: Alignment.topCenter,
                            stops: [0.0, 0.7, 1],
                            colors: [
                              Color(0xFF00a7ff),
                              Color(0xFF2a64ff),
                              Color(0xFF1980ff),
                            ],
                          ).createShader(bounds),
                          child: Icon(
                            Icons.percent,
                            // color: Color(0xFF446CFF),
                            size: 18.sp,
                          ),
                        ),
                        Text(
                          "${_cubit.currentEmployee?.medicalCoverage?.split("%")[0]??"0"} ${AppStrings.medicalCoverage.tr()}",
                          style: TextStyle(
                              color: AppColors.greyDark,
                              fontWeight: FontWeight.w400,
                              fontSize: 16.sp,
                              fontFamily: "Certa Sans"),
                        ),
                      ],
                    ),
                  ],
                )
              ],
            )),
        Positioned.directional(
          textDirection:Directionality.of(context) ,
          start: 10.w,
          child: Card(
              elevation: 0,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.r)),
              shadowColor: Color(0xFF446CFF),
              child: Container(
                height: 120.h,
                width: 80.w,
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(20.r)),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20.0),
                  child: Image.network(
                    _cubit.currentEmployee?.profilePicture??"",
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Image.asset(
                      'assets/images/profile_pricture_default.png',
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              )),
        ),
      ],
    );
  }
}
