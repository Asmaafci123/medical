import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:more4u/domain/entities/category.dart';

import '../../../core/constants/app_strings.dart';
import '../../../core/themes/app_colors.dart';
import '../../../custom_icons.dart';
import '../../../domain/entities/details-of-medical.dart';
import '../../../domain/entities/relative.dart';
import '../cubits/request_medication_cubit.dart';

class SelectMedicalSubCategory extends StatelessWidget {
  final List<Category> medicalSubCategories;
  final String hintTitle;
  final Category? selectedSubCategory;
  final void Function(Category?)? onChangeMedicalSubCategory;

  const SelectMedicalSubCategory(
      {
      super.key,
      required this.medicalSubCategories,
      required this.hintTitle,
      this.selectedSubCategory,
      this.onChangeMedicalSubCategory});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Text(
        //   "Choose $hintTitle",
        //   style: TextStyle(
        //       color: AppColors.blackColor,
        //       fontWeight: FontWeight.w600,
        //       fontSize: 18.sp,
        //       fontFamily: "Cairo"),
        //
        // ),
        // SizedBox(
        //   height: 5.h,
        // ),
        DropdownButtonFormField<Category?>(
          style: TextStyle(color: AppColors.mainColor, fontSize: 12.sp),
          validator: (Category? value) {
            if (value == null) return AppStrings.required.tr();
            return null;
          },
          value: selectedSubCategory,
          decoration: InputDecoration(
            prefixIcon: Icon(
              CustomIcons.home__2_,
              color: AppColors.greyColor,
              size: 16.sp,
            ),
            isDense: false,
            contentPadding:
                EdgeInsets.symmetric(vertical: 10.h, horizontal: 8.w),
            suffixIconConstraints:
                BoxConstraints(minHeight: 50.h, minWidth: 50.w),
            prefixIconConstraints:
                BoxConstraints(minHeight: 20.h, minWidth: 40.w),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15.0.r),
                borderSide:
                    BorderSide(width: 0.5.w, color: AppColors.mainColor)),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15.0.r),
                borderSide:
                    BorderSide(width: 0.5.w, color: AppColors.mainColor)),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15.0.r),
                borderSide:
                    BorderSide(width: 0.5.w, color: AppColors.mainColor)),
            hintText: "choose your $hintTitle",
            labelStyle: TextStyle(fontSize: 14.sp),
            hintStyle: TextStyle(color: Color(0xffc1c1c1), fontSize: 12.sp),
            errorStyle: TextStyle(fontSize: 12.sp),
            floatingLabelBehavior: FloatingLabelBehavior.always,
          ),
          items: medicalSubCategories.map((Category value) {
            return DropdownMenuItem<Category>(
              value: value,
              child: Text(value.subCategoryName!),
            );
          }).toList(),
          onChanged: onChangeMedicalSubCategory,
          iconSize: 20.r,
        ),
      ],
    );
  }
}

/*

 */
