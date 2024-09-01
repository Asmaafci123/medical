import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:more4u/core/constants/app_strings.dart';

import '../../core/constants/constants.dart';
import '../../core/themes/app_colors.dart';
import '../../custom_icons.dart';
import '../../domain/entities/benefit.dart';
import '../benefit_details/beneifit_detailed_screen.dart';
import '../benefit_redeem/BenefitRedeemScreen.dart';
import '../more4u_home/cubits/more4u_home_cubit.dart';

class BenefitCard extends StatelessWidget {
  final Benefit benefit;

  const BenefitCard({Key? key, required this.benefit}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 20.h),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.r),
          boxShadow: [
            BoxShadow(
                offset: Offset(1, 2),
                color: Colors.black.withOpacity(0.12),
                blurRadius: 8.r),
          ],
        ),
        clipBehavior: Clip.antiAlias,
        child: GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, BenefitDetailedScreen.routeName,
                    arguments: benefit)
                .whenComplete(() => More4uHomeCubit.get(context).getHomeData());
          },
          child: Container(
            decoration: BoxDecoration(
              border: Border(
                left: context.locale.languageCode=='ar'? BorderSide.none:BorderSide(width: 7.0.w, color: Color(
                    0xFF1980ff)),
                right: context.locale.languageCode=='en'? BorderSide.none:BorderSide(width: 7.0.w, color: Color(
                    0xFF1980ff)),
              ),
              color: Colors.white,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10.r),
                      topRight: Radius.circular(10.r)),
                  child: Image.network(
                    benefit.benefitCardAPI.toString().trim(),
                    errorBuilder: (context, error, stackTrace) =>
                        Image.asset('assets/images/more4u_card.png'),
                  ),
                ),
                SizedBox(
                  height: 9.h,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 7.w, vertical: 0),
                  child: Row(
                    children: [
                      Text(
                        benefit.name,
                        style: TextStyle(
                            fontSize: 18.sp,
                            fontFamily: "Certa Sans",
                            fontWeight: FontWeight.w600,
                            color: AppColors.greyColor),
                      ),
                      Spacer(),
                      benefit.benefitType == AppStrings.group.tr()
                          ? Icon(
                              CustomIcons.users_alt,
                            )
                          : Icon(
                              CustomIcons.individual,
                            ),
                      SizedBox(
                        width: 5.w,
                      ),
                      Text(
                        benefit.benefitType,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: "Certa Sans",
                          color: Color(0xff6d6d6d),
                          fontSize: 14.sp,
                        ),
                      ),
                    ],
                  ),
                ),
                Divider(
                  indent: 16.w,
                  endIndent: 16.w,
                  color: Colors.black38,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 7.w, vertical: 0),
                  child: Row(
                    children: [
                      Icon(CustomIcons.ph_arrows_counter_clockwise_duotone),
                      SizedBox(
                        width: 4.w,
                      ),
                      Text(
                        '${benefit.timesUserReceiveThisBenefit}/${benefit.times}',
                        style: TextStyle(
                          fontSize: 16.sp,
                          color: AppColors.greyColor,
                          fontFamily: "Certa Sans",
                        ),
                      ),
                      const Spacer(),
                      Container(
                         // width: 187.w,
                          height: 50.h,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.r),
                            gradient:benefit.userCanRedeem
                                ?LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                stops: [
                                  0.0,
                                  0.7,
                                  1
                                ],
                                //  tileMode: TileMode.repeated,
                                colors: [
                                  Color(0xFF00a7ff),
                                  Color(0xFF2a64ff),
                                  Color(0xFF1980ff),
                                ]):null,
                            color: AppColors.greyText,),
                          child:Padding(
                            padding:EdgeInsets.symmetric(vertical: 8.h,horizontal: 10.w),
                            child: GestureDetector(
                              onTap:benefit.userCanRedeem
                                  ? () {
                                Navigator.pushNamed(context,
                                                            BenefitRedeemScreen.routeName,
                                                            arguments: benefit)
                                                        .whenComplete(() =>
                                                        More4uHomeCubit.get(context)
                                                                .getHomeData());
                              }
                                  : null,
                              child: Center(
                                  child:Text(
                                    AppStrings.redeem.tr(),
                                    style: TextStyle(
                                      color:benefit.userCanRedeem
                                          ?AppColors.whiteColor:AppColors.greyColor,
                                      fontSize: 16.sp,fontFamily: "Certa Sans",),
                                  )
                              ),
                            ),
                          )
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 11.h,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
