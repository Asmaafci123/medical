import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/themes/app_colors.dart';
import '../models/medical_benefit_model.dart';
class MedicalBenefitsCard1 extends StatelessWidget {
  final  MedicalBenefitModel medicalBenefitModel;
  final void Function()? onTap;
  final double dividerWidth;
  final bool? history;
  const MedicalBenefitsCard1({super.key,required this.medicalBenefitModel,required this.onTap,required this.dividerWidth,required this.history});

  @override
  Widget build(BuildContext context) {
    return  GestureDetector(
      onTap:onTap ,
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          SizedBox(
            height: 190.h,
            width: 170.w,
          ),
          Positioned(
            top: 25.h,
            child: Card(
              elevation:2,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.r)
              ),
              color: AppColors.whiteColor,
              child: Padding(
                padding:EdgeInsets.fromLTRB(5.w,10.h,5.w, 0.h),
                child:Container(
                  height: 150.h,
                  width: 150.w,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30.r)
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        medicalBenefitModel.title,
                        style: TextStyle(
                          color: AppColors.mainColor,
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w600,
                            fontFamily: "Certa Sans"
                        ),
                      ),
                      Text(
                        medicalBenefitModel.description1,
                        style: TextStyle(
                          color: AppColors.greyDark,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400,
                            fontFamily: "Certa Sans"
                        ),
                        textAlign: TextAlign.center,
                        maxLines: 1,
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Container(
                        width: 110.w,
                       decoration: BoxDecoration(
                         color: Color(0xFFedf2f4),
                           borderRadius: BorderRadius.circular(15.r),
                       ),
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(20.w, 10.h, 20.w, 10.h),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Explore",
                                style: TextStyle(
                                  color: medicalBenefitModel.title=="Sick Leave"?AppColors.greyDark:AppColors.mainColor,
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w500,
                                    fontFamily: "Certa Sans"
                                ),
                              ),
                              Icon(
                                Icons.arrow_forward_ios_rounded,
                                color: medicalBenefitModel.title=="Sick Leave"?AppColors.greyDark:AppColors.mainColor,
                              size: 15.sp,)
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                    ],
                  ),
                )
              ),
            ),
          ),
          Card(
            elevation: 8,
            shadowColor: Color(0xFF2a64ff),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50.r),
            ),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50.r),
                  gradient:
                  LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      stops:[
                        0.0,
                        0.7,
                        1
                      ],
                      colors: [
                        Color(0xFF00a7ff),
                        Color(0xFF2a64ff),
                        Color(0xFF1980ff),
                      ])
              ),
                child: Padding(
                  padding: const EdgeInsets.all(14.0),
                  child: Image.asset(medicalBenefitModel.imagePath,width: 30.w,),
                )),
          )
        ],
      ),
    );
  }
}
