import 'package:dropdown_search/dropdown_search.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/constants/app_strings.dart';
import '../../../core/themes/app_colors.dart';
import '../../../custom_icons.dart';
import '../../../domain/entities/details-of-medical.dart';
import '../cubits/request_medication_cubit.dart';
class SelectMedicalDetails extends StatelessWidget {
  final  List<DetailsOfMedical> medicalDetails;
  final String hintTitle;
  final String? requestType;
  const SelectMedicalDetails({super.key,required this.medicalDetails,required this.hintTitle,this.requestType});

  @override
  Widget build(BuildContext context) {
    return DropdownSearch<DetailsOfMedical>(
      popupProps:PopupProps.dialog(
          showSearchBox: true,
          fit: FlexFit.loose,
        searchFieldProps: TextFieldProps(
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 10.w),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.r)
            ),
            labelText: hintTitle,
          ),
        ),
      ),
      items: medicalDetails,
      itemAsString: (DetailsOfMedical u) => u.medicalDetailsName??"",
      dropdownButtonProps: DropdownButtonProps(
        icon:Icon(Icons.keyboard_arrow_down_outlined,color:Color(0xff697480),size: 16.sp,)  ,
      ),
      dropdownDecoratorProps: DropDownDecoratorProps(
        dropdownSearchDecoration: InputDecoration(
          hintStyle:  TextStyle(
              color:AppColors.greyDark,
              fontSize: 12.sp,
            fontFamily: "Certa Sans",),
          labelStyle: TextStyle(
              color: AppColors.greyDark,
              fontSize: 14.sp,
            fontFamily: "Certa Sans",),
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
      onChanged:(DetailsOfMedical? newValue) {
        requestType=="medication"?
        RequestMedicationCubit.get(context).selectPharmacy(newValue!):
        RequestMedicationCubit.get(context).selectDetailsOfMedical(newValue!);
      },
      validator: (DetailsOfMedical? value) {
        if (value==null) return AppStrings.required.tr();
        return null;
      },
      //selectedItem: medicalCategories[0],
    );
  }
}