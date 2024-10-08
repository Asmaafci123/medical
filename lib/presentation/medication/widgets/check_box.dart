import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/themes/app_colors.dart';
class CheckBoxInsurance extends StatelessWidget {
  final String title;
  final bool value;
  final void Function(bool?)? onChanged;
  const CheckBoxInsurance({Key? key,required this.title,required this.value,this.onChanged}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 30,
      child: Row(
        children: [
          Text(
            title,
            style: TextStyle(
                color: AppColors.blackColor,
                fontWeight: FontWeight.w600,
                fontSize: 18.sp,
                fontFamily: "Certa Sans"),
          ),
          const Spacer(),
          Transform.scale(
            scale: 1.0,
            child: Checkbox(
                activeColor: Color(0xFF00a7ff),
                shape: RoundedRectangleBorder(
                    borderRadius:
                    BorderRadius.circular(10.r)),
                value:value,
                onChanged:onChanged),
          ),
        ],
      ),
    );
  }
}
