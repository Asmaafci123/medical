import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:more4u/presentation/medication/cubits/request_medication_cubit.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/themes/app_colors.dart';
import '../../../custom_icons.dart';

class SearchTextFormField extends StatelessWidget {
  final Icon prefixIcon;
  final String hintText;
  final TextInputType keyboardType;
  final TextEditingController controller;
  final List<TextInputFormatter>? textInputFormatter;
  final BoxConstraints? suffixIconConstraints;
  final BoxConstraints? prefixIconConstraints;
  const SearchTextFormField({
    super.key,
    required this.prefixIcon,
    required this.hintText,
    required this.keyboardType,
    required this.controller,
    this.textInputFormatter,
    this.suffixIconConstraints,
    this.prefixIconConstraints,
  });

  @override
  Widget build(BuildContext context) {
    return
        SizedBox(
          width: 280.w,
          child: TextFormField(
            style: TextStyle(
                fontWeight: FontWeight.w400,
                color: AppColors.mainColor,
                fontSize: 12.sp,
                fontFamily: "Certa Sans"
            ),
            decoration: InputDecoration(
              isDense: true,
              filled: true,
              fillColor:Color(0xFFf2f2f2),
              contentPadding: EdgeInsets.symmetric(vertical: 10.h),
              suffixIconConstraints: suffixIconConstraints,
              prefixIconConstraints: prefixIconConstraints,
              prefixIcon: prefixIcon,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(80.0.r),
                borderSide: BorderSide(
                  width: 0.1.w,
                  color: Color(0xFFEEEEEE)
                )
              ),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(80.0.r),
                  borderSide: BorderSide(
                      width: 0.1.w,
                      color: Color(0xFFEEEEEE)
                  )
              ) ,
              focusedBorder:  OutlineInputBorder(
                  borderRadius: BorderRadius.circular(80.0.r),
                  borderSide: BorderSide(
                      width: 0.1.w,
                      color: Color(0xFFEEEEEE)
                  )
              ),
              labelStyle: TextStyle(fontSize: 14.sp,fontFamily: "Certa Sans"),
              hintText: hintText,
              hintStyle: TextStyle(color: Color(0xFFB5B9B9), fontSize: 14.sp, fontFamily: "Certa Sans",fontWeight: FontWeight.w500),
              errorStyle: TextStyle(fontSize: 12.sp,  fontFamily: "Certa Sans",),
              floatingLabelBehavior: FloatingLabelBehavior.always,
            ),
            keyboardType: keyboardType,
            controller: controller,
            inputFormatters: textInputFormatter,
            validator: (String? value) {
              if (value!.isEmpty) return AppStrings.required.tr();
              return null;
            },
          ),
        );
  }
}
