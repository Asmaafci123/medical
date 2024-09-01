import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/themes/app_colors.dart';

class BenefitCard extends StatelessWidget {
  final String imagePath;
  final Color gradientColor1;
  final Color gradientColor2;
  final String title;
  final String iconPath;
  final String description;
  final void Function()? onTap;
  const BenefitCard ({super.key,required this.imagePath,required this.gradientColor1,required this.gradientColor2,required this.title,required this.iconPath,required this.description,this.onTap});


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        children: [
          Container(
              height: 130.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15.r),
                image: DecorationImage(
                  colorFilter: new ColorFilter.mode(Color(0xFF1F2B44), BlendMode.softLight),
                  image: AssetImage(imagePath),
                  fit: BoxFit.cover,
                ),
              )
          ),
          Container(
            height: 130.h,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15.r),
                gradient:LinearGradient(
                    colors: [
                      gradientColor1,
                      gradientColor2,
                     gradientColor1
                    ]
                )
            ),
            child:Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w,vertical: 10.h),
              child: Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(iconPath),
                      Text(
                       title,
                        style: TextStyle(
                            color: AppColors.whiteColor,
                            fontSize: 20.sp,
                            fontWeight: FontWeight.w600,
                            fontFamily: "Cairo"),
                      ),
                      Text(
                        description,
                        style: TextStyle(
                            color: AppColors.greyText,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w400,
                            fontFamily: "Cairo"),
                      ),
                    ],
                  ),
                  Spacer(),
                  Icon(Icons.arrow_forward_sharp,color: AppColors.whiteColor,)
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
