import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/themes/app_colors.dart';
class InfoField extends StatelessWidget {
  final String title;
  final String value;
  const InfoField({super.key,required this.title,required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          title,
          style:TextStyle(
            color: AppColors
                .mainColor,
            fontFamily:
            "Certa Sans",
            fontSize: 14.sp,
            fontWeight:
            FontWeight
                .w600,
          ),
          overflow: TextOverflow.ellipsis,
        ),
         Spacer(),
        SizedBox(
          width: 200.w,
          child: Text(
            value,
            style: TextStyle(
              color: Color(0xFFafafaf),
              fontFamily: "Certa Sans",
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.right,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
