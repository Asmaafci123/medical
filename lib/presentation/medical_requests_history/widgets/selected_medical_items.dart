import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/themes/app_colors.dart';
import '../../../domain/entities/medical_item.dart';
class SelectedMedicalItems extends StatelessWidget {
  final List<MedicalItem> medicalItems;
  const SelectedMedicalItems({Key? key,required this.medicalItems}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      scrollDirection: Axis.horizontal,
      itemBuilder:(context,index)=>Container(
        decoration: BoxDecoration(
            color: AppColors.whiteColor,
            borderRadius: BorderRadius.circular(15.r),
            border: Border.all(
                width: 0.1.w,
                color: AppColors.greyDark
            )
        ),
        child: Padding(
          padding:EdgeInsets.symmetric(horizontal: 16.w),
          child: Row(
            children: [
              //    Image.asset("assets/images/capsules_10895948.png",width: 40.w,),
              Image.network(medicalItems[index].itemImage??"",width: 40.w,),
              SizedBox(
                width: 15.w,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    medicalItems[index].itemName??"",
                    style: TextStyle(
                      color: AppColors.blackColor,
                      fontFamily: "Certa Sans",
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  Text(
                    "${medicalItems[index].itemQuantity??""} Items",
                    style: TextStyle(
                      color: AppColors.greyDark,
                      fontFamily: "Certa Sans",
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w600,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              )
            ],
          ),
        ),
      ),
      itemCount:medicalItems.length,
      separatorBuilder: (BuildContext context, int index)=>SizedBox(width: 15.w,),
    );
  }
}
