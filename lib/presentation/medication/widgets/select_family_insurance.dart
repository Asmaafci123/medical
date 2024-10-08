import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:more4u/domain/entities/relative.dart';
import 'package:more4u/presentation/medication/cubits/request_medication_cubit.dart';

import '../../../core/constants/app_strings.dart';
import '../../../core/themes/app_colors.dart';
import '../../../custom_icons.dart';

class SelectFamilyInsurance extends StatelessWidget {
  const SelectFamilyInsurance({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15.0.r),
        border: Border.all(
            width: 1.w,
            color: Color(0xffe7e7e7)
        ),
      ),
      margin: EdgeInsets.symmetric(vertical: 10.h),
      padding:EdgeInsets.symmetric(vertical:2.h),
      child: DropdownButtonHideUnderline(
        child: DropdownButton2<Relative>(
          isExpanded: true,
          isDense: true,
          value: RequestMedicationCubit.get(context).selectedRelative,
          hint: Text(
            AppStrings.select.tr(),
            style: TextStyle(
              fontSize: 14,
              color: Theme.of(context).hintColor,
            ),
          ),
          items: RequestMedicationCubit.get(context).currentEmployee!.relatives!.map((Relative value) {
            return DropdownMenuItem<Relative>(
              value: value,
              child: Text("${value.relativeName} (${value.relation})"),
            );
          }).toList(),
          onChanged: (Relative? newValue) {
            RequestMedicationCubit.get(context).selectRelative(newValue!);
          },
          buttonStyleData: const ButtonStyleData(
            padding: EdgeInsets.symmetric(horizontal: 16),
            height: 40,
            width: 140,
          ),
          iconStyleData: IconStyleData(
            icon:  const Icon(Icons.keyboard_arrow_down_outlined),
            iconSize:  16.sp,
            iconDisabledColor:Color(0xff697480),
            iconEnabledColor: Color(0xff697480),
            // iconEnabledColor: iconEnabledColor,
            // iconDisabledColor: iconDisabledColor,
          ),
          menuItemStyleData: const MenuItemStyleData(
            height: 40,
          ),

          dropdownStyleData: DropdownStyleData(
            offset: Offset(0, -10),
    decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(14),
    )
          )
          ,
        ),
      ),
    )




     ;
  }
}
