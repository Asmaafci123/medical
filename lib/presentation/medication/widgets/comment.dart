import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:more4u/presentation/medication/cubits/request_medication_cubit.dart';

import '../../../core/constants/app_strings.dart';
import '../../../core/themes/app_colors.dart';
class Comment extends StatelessWidget {
  final TextEditingController controller;
  const Comment({super.key,required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: TextStyle(
          color: AppColors.greyDark,
          fontSize: 16.sp,
          fontWeight: FontWeight.w300,
          fontFamily: "Certa Sans"),
      //maxLength: 5,
      decoration: InputDecoration(
        isDense: true,
        contentPadding: EdgeInsets.symmetric(vertical: 30.h,horizontal: 10.w),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.0.r),
            borderSide: BorderSide(
                width: 0.7.w,
                color: AppColors.greyDark
            )
        ),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.0.r),
            borderSide: BorderSide(
                width: 0.7.w,
                color: AppColors.greyDark
            )
        ) ,
        focusedBorder:  OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.0.r),
            borderSide: BorderSide(
                width: 0.7.w,
                color: AppColors.greyDark
            )
        ),
        labelStyle: TextStyle(
            color: AppColors.greyDark,
            fontSize: 16.sp,
            fontWeight: FontWeight.w300,
            fontFamily: "Certa Sans"),
        hintText: "say anything extra you want the doctor to know",
        hintStyle: TextStyle(
            color: AppColors.greyDark,
            fontSize: 16.sp,
            fontWeight: FontWeight.w300,
            fontFamily: "Certa Sans"),
        errorStyle: TextStyle(fontSize: 12.sp,fontFamily: "Certa Sans"),
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
      keyboardType: TextInputType.text,
      controller: controller,
      validator: (String? value) {
        if (value!.isEmpty)
          {
            if(RequestMedicationCubit.get(context).imagesFiles.isEmpty)
              {
                return AppStrings.required.tr();
              }
          }
        return null;
      },
    );
  }
}
