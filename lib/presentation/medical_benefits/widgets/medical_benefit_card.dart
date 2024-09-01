import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/themes/app_colors.dart';
import '../models/medical_benefit_model.dart';
class MedicalBenefitsCard extends StatelessWidget {
  final  MedicalBenefitModel medicalBenefitModel;
  final void Function()? onTap;
  final double dividerWidth;
  const MedicalBenefitsCard({super.key,required this.medicalBenefitModel,required this.onTap,required this.dividerWidth});

  @override
  Widget build(BuildContext context) {
    return  GestureDetector(
      onTap:onTap ,
      child: Card(
        elevation: 6,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.r)
        )
        ,
        child: Container(
         // width: 160.w,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.r)
          ),
          child: Padding(
            padding:EdgeInsets.fromLTRB(5.w,10.h,5.w, 0.h),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(medicalBenefitModel.imagePath),
                Text(
                  medicalBenefitModel.title,
                  style: TextStyle(
                    color: AppColors.mainColor,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                    fontFamily: "Cairo",
                  ),
                ),
                Text(
                  medicalBenefitModel.description1,
                  style: TextStyle(
                    color: AppColors.greyDark,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w400,
                    fontFamily: "Cairo",
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 2,
                ),
                medicalBenefitModel.description2.isNotEmpty? Text(
                  medicalBenefitModel.description2,
                  style: TextStyle(
                    color: AppColors.greyDark,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w400,
                    fontFamily: "Cairo",
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 2,
                ):SizedBox(),
                SizedBox(
                  height: 10.h,
                ),
                Container(
                  color: AppColors.greyText,
                  height: 1.h,
                  width:dividerWidth,
                ),
                // SizedBox(
                //   height: 20.h,
                // ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      "Explore More",
                      style: TextStyle(
                        color: AppColors.mainColor,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                        fontFamily: "Cairo",
                      ),
                    ),
                    Icon(Icons.arrow_forward_ios_rounded,color: AppColors.mainColor,)
                  ],
                ),
                SizedBox(
                  height: 10.h,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
