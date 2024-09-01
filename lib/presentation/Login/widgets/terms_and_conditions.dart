import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/constants/constants.dart';
import '../../terms_and_conditions/terms_and_conditions.dart';
class CustomTermsAndConditions extends StatelessWidget {
  const CustomTermsAndConditions({super.key});

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: () {
          languageId =
          context.locale.languageCode == 'en' ? 1 : 2;
          Navigator.pushNamed(
              context, TermsAndConditions.routeName,
              arguments: true);
        },
        child: Text(AppStrings.termsAndConditions.tr(),style:TextStyle(
            fontFamily: "Certa Sans",
            fontSize: 16.sp,
            fontWeight: FontWeight.w500
        ),));
  }
}
