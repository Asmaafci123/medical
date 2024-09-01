import 'package:dropdown_search/dropdown_search.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:more4u/custom_icons.dart';
import 'package:more4u/domain/entities/category.dart';

import '../../../core/constants/app_strings.dart';
import '../../../core/themes/app_colors.dart';
import '../../../domain/entities/details-of-medical.dart';
import '../../../domain/entities/relative.dart';
import '../cubits/request_medication_cubit.dart';
class SelectMedicalCategory extends StatelessWidget {
  final  List<Category> medicalCategories;
  final String hintTitle;
  final void Function(Category?)? onChangeMedicalCategory;
  final Category? selectedCategory;
  const SelectMedicalCategory({
    super.key,
    required this.medicalCategories,
    required this.hintTitle,
  this.onChangeMedicalCategory,
  this.selectedCategory});

  @override
  Widget build(BuildContext context) {
    return DropdownSearch<Category>(
      dropdownBuilder: (context, selectedItem) {
        return Text(
          selectedCategory?.categoryName?? hintTitle,
          style:TextStyle(
              color: AppColors.greyDark,
              fontSize: 14.sp,
              fontWeight: FontWeight.w200,
              fontFamily: "Certa Sans"
          )
        );
      },
      popupProps:PopupProps.dialog(
        showSearchBox: true,
        fit: FlexFit.loose,
        searchFieldProps: TextFieldProps(
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.r)
            ),
            labelStyle:TextStyle(
                color: AppColors.greyDark,
                fontSize: 16.sp,
                fontWeight: FontWeight.w300,
                fontFamily: "Certa Sans"
            ),
            labelText: hintTitle,
          ),
        ),
      ),
      items: medicalCategories,
      itemAsString: (Category u) => u.categoryName??"",
    dropdownButtonProps: DropdownButtonProps(
      icon:Icon(Icons.keyboard_arrow_down_outlined,color:Color(0xff697480),size: 16.sp,)  ,
    ),
      dropdownDecoratorProps: DropDownDecoratorProps(
        dropdownSearchDecoration: InputDecoration(
          hintStyle:  TextStyle(
              color:AppColors.greyDark,
              fontSize: 18.sp,
              fontFamily: "Certa Sans"
          ),
          labelStyle: TextStyle(
              color: AppColors.greyDark,
              fontSize: 18.sp,
              fontFamily: "Certa Sans"
          ),
          labelText: hintTitle,
          hintText:"choose your $hintTitle",
          contentPadding: EdgeInsets.symmetric(
              vertical: 10.h, horizontal: 8.w),
          prefixIcon: Icon(CustomIcons.home__2_,color: AppColors.greyColor,size: 16.sp,),
         // suffixIcon: Icon(Icons.keyboard_arrow_down_outlined,color:Color(0xff697480),size: 16.sp,) ,
          border: OutlineInputBorder(
             borderRadius: BorderRadius.circular(15.0.r),
              borderSide: BorderSide(
                  width: 0.5.w,
                  color: Color(0xffbec0ca)
              )
          ) ,
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15.0.r),
              borderSide: BorderSide(
                  width: 0.5.w,
                  color: Color(0xffbec0ca)
              )
          ),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15.0.r),
              borderSide: BorderSide(
                  width: 0.5.w,
                  color: Color(0xffbec0ca)
              )
          )
        ),
      ),
      onChanged:onChangeMedicalCategory,
     selectedItem: selectedCategory
    );
  }
}