import 'dart:async';
import 'dart:ui';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:badges/badges.dart' as bg;
import 'package:easy_localization/easy_localization.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:more4u/core/constants/app_strings.dart';
import 'package:more4u/custom_icons.dart';
import 'package:more4u/presentation/manage_requests/manage_requests_screen.dart';
import 'package:more4u/presentation/my_benefits/my_benefits_screen.dart';
import 'package:more4u/presentation/profile/profile_screen.dart';
import 'package:more4u/presentation/terms_and_conditions/terms_and_conditions.dart';
import 'package:simple_shadow/simple_shadow.dart';

import '../../core/constants/constants.dart';
import '../../core/themes/app_colors.dart';
import '../home/cubits/home_cubit.dart';
import '../home/cubits/home_states.dart';
import '../home/home_screen.dart';
import '../medical_requests_history/medical_requests_history_screen.dart';

import '../more4u_home/more4u_home_screen.dart';
import '../my_gifts/my_gifts_screen.dart';
import '../notification/notification_screen.dart';
import '../our_paretners/our_partners_screen.dart';
import '../pending_requests/pending_requests_screen.dart';
import 'helpers.dart';
import 'powered_by_cemex.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var _cubit = HomeCubit.get(context);
    final completer = Completer();
    return SafeArea(
      child: SizedBox(
        width: 273.w,
        //height: 600.h,
        child: Drawer(
          backgroundColor: Colors.transparent,
          elevation: 0,
          child: ClipRect(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 8.0, sigmaY: 8.0),
              child: Container(
                color: Colors.white.withOpacity(0.8),
                padding:
                EdgeInsets.symmetric(horizontal: 16.0.w, vertical: 16.h),
                child: ListView(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Spacer(flex: 3),
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: AppColors.mainColor, width: 2),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          height: 130.h,
                          width: 132.h,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(6),
                            child: Image.network(
                              userData!.profilePictureAPI!,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) =>
                                  Image.asset(
                                      cacheHeight: 181,
                                      cacheWidth: 184,
                                      'assets/images/profile_avatar_placeholder.png',
                                      fit: BoxFit.cover),
                            ),
                          ),
                        ),
                        const Spacer(flex: 2,),
                        Container(
                          height: 35.h,
                          width: 35.h,
                          padding: EdgeInsets.zero,
                          child: IconButton(
                            padding: EdgeInsets.zero,
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: SvgPicture.asset(
                              'assets/images/close.svg',
                              height: 30.h,
                              width: 30.h,
                              color: AppColors.mainColor,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 8.h,
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Stack(
                        alignment: Alignment.topCenter,
                        children: [
                          Image.asset('assets/images/banner1.png', height: 66.h),
                          Container(
                            alignment: Alignment.center,
                            width: 170.w,
                            height: 53.h,
                            child: AutoSizeText(
                              userData!.userName ?? '',
                              textAlign: TextAlign.center,
                              maxLines: 1,
                              wrapWords: false,
                              style: TextStyle(
                                  fontFamily: "Certa Sans",
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 22.0.sp),
                            ),
                          ),
                        ],
                      ),
                    ),
                    buildListTile(
                      context,
                      title: 'Home'.tr(),
                      leading: CustomIcons.home__2_,
                      onTap: () {
                        Navigator.pop(context);
                       Navigator.pushNamedAndRemoveUntil(context, HomeScreen.routeName, (route) => false);
                      },
                      isMedical: true
                    ),
                    Theme(
                      data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
                      child: ExpansionTile(
                        tilePadding: EdgeInsets.only(left: 12.w),
                        title:Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            BlocBuilder<HomeCubit, HomeState>(
                              builder: (context, state) {
                                return bg.Badge(
                                  showBadge:pendingRequestsCountMore4u != 0,
                                  ignorePointer: true,
                                  position: bg.BadgePosition.bottomEnd(),
                                  badgeColor: AppColors.redColor,
                                  padding: const EdgeInsets.all(0),
                                  badgeContent: Container(
                                      decoration: BoxDecoration(shape: BoxShape.circle),
                                      height: 20.h,
                                      width: 20.w,
                                      child:
                                      AutoSizeText(
                                       pendingRequestsCountMore4u ! > 99
                                            ? '+99'
                                            : pendingRequestsCountMore4u
                                            .toString(),
                                        maxLines: 1,
                                        wrapWords: false,
                                        textAlign: TextAlign.center,
                                        minFontSize: 9,
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.bold),
                                      )
                                  ),
                                  child: SimpleShadow(
                                    offset: const Offset(0, 4),
                                    color: Colors.black,
                                    child: Icon(CustomIcons.apps, color: AppColors.mainColor, size: 20.r),
                                  ),
                                );
                              },
                            ),
                            SizedBox(
                              width: 15.w,
                            ),
                            Text(
                            "More4u",
                            style: TextStyle(
                              fontFamily: "Certa Sans",
                              color: AppColors.greyColor,
                              fontWeight: FontWeight.w600,
                              fontSize: 18.0.sp,
                            ),
                      ),
                          ],
                        ),
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                            left: 30.w
                          ),
                          child: buildListTile(
                            context,
                            title: 'My Requests'.tr(),
                            leading: CustomIcons.ticket,
                              isMedical: false,
                            onTap: () async {
                              Navigator.pop(context);
                              if (ModalRoute //send argument to widget
                                  .of(context)
                                  ?.settings
                                  .name ==
                                  HomeScreen.routeName) {
                                final completer = Completer();
                                final result = await Navigator.pushNamed(
                                    context, MyBenefitsScreen.routeName)
                                    .whenComplete(() {
                                  _cubit.getCurrentUser();
                                });
                                completer.complete(result);
                              } else {
                                final result = await Navigator.pushReplacementNamed(
                                    context, MyBenefitsScreen.routeName,
                                    result: completer.future);
                                completer.complete(result);
                              }
                            },
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              left: 30.w
                          ),
                          child: buildListTile(
                            context,
                            title: AppStrings.myGifts.tr(),
                            leading: CustomIcons.balloons,
                              isMedical: false,
                            onTap: () async {
                              Navigator.pop(context);
                              if (ModalRoute.of(context)?.settings.name ==
                                  HomeScreen.routeName) {
                                final completer = Completer();
                                final result = await Navigator.pushNamed(
                                    context, MyGiftsScreen.routeName)
                                    .whenComplete(() {
                                  _cubit.getCurrentUser();
                                });
                                completer.complete(result);
                              } else {
                                final result = await Navigator.pushReplacementNamed(
                                    context, MyGiftsScreen.routeName,
                                    result: completer.future);
                                completer.complete(result);
                              }
                            },
                          ),
                        ),
                        if (userData!.hasRoles! || userData!.hasRequests!)
                          Padding(
                            padding: EdgeInsets.only(
                                left: 30.w
                            ),
                            child: buildListTile(
                              context,
                              title: AppStrings.manageRequests.tr(),
                              leading: CustomIcons.business_time,
                                isMedical:false,
                              onTap: () async {
                                Navigator.pop(context);
                                if (ModalRoute.of(context)?.settings.name ==
                                    HomeScreen.routeName) {
                                  Navigator.pushNamed(
                                      context, ManageRequestsScreen.routeName)
                                      .whenComplete(() => _cubit.getCurrentUser());
                                } else {
                                  final result = await Navigator.pushReplacementNamed(
                                      context, ManageRequestsScreen.routeName,
                                      result: completer.future);
                                  completer.complete(result);
                                }
                              },
                            ),
                          ),
                      ],),
                    ),
                    Theme(
                      data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
                      child: ExpansionTile(
                        tilePadding: EdgeInsets.only(left: 12.w),
                        title:Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            userData!.isDoctor==true? BlocBuilder<HomeCubit, HomeState>(
                              builder: (context, state) {
                                return bg.Badge(
                                  showBadge:pendingRequestMedicalCount != 0,
                                  ignorePointer: true,
                                  position: bg.BadgePosition.bottomEnd(),
                                  badgeColor: AppColors.redColor,
                                  padding: EdgeInsets.all(0),
                                  badgeContent: Container(
                                      decoration: BoxDecoration(shape: BoxShape.circle),
                                      height: 20.h,
                                      width: 20.w,
                                      child:
                                      AutoSizeText(
                                        pendingRequestMedicalCount! > 99
                                            ? '+99'
                                            : pendingRequestMedicalCount
                                            .toString(),
                                        maxLines: 1,
                                        wrapWords: false,
                                        textAlign: TextAlign.center,
                                        minFontSize: 9,
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.bold),
                                      )
                                  ),
                                  child: SimpleShadow(
                                    offset: const Offset(0, 4),
                                    color: Colors.black,
                                    child: Icon(CustomIcons.apps, color: AppColors.mainColor, size: 20.r),
                                  ),
                                );
                              },
                            ): SimpleShadow(
                              offset: const Offset(0, 4),
                              color: Colors.black,
                              child: Icon(CustomIcons.apps, color: AppColors.mainColor, size: 20.r),
                            ),
                            SizedBox(
                              width: 15.w,
                            ),
                            Text(
                              "Medical",
                              style: TextStyle(
                                fontFamily: "Certa Sans",
                                color: AppColors.greyColor,
                                fontWeight: FontWeight.w600,
                                fontSize: 18.0.sp,
                              ),
                            ),
                          ],
                        ),
                        children: [
                          (userData!.isMedicalAdmin==false && userData!.isDoctor==false)?
                          Padding(
                            padding: EdgeInsets.only(
                                left: 30.w
                            ),
                            child: buildListTile(
                              context,
                              title: 'My Requests'.tr(),
                              leading: CustomIcons.ticket,
                              isMedical:true,
                              onTap: () async {
                                Navigator.pop(context);
                                if (ModalRoute //send argument to widget
                                    .of(context)
                                    ?.settings
                                    .name ==
                                    HomeScreen.routeName) {
                                  final completer = Completer();
                                  final result = await Navigator.pushNamed(
                                      context, MedicalRequestsHistoryScreen.routeName)
                                      .whenComplete(() {
                                    //_cubit.getHomeData();
                                  });
                                  completer.complete(result);
                                } else {
                                  final result = await Navigator.pushReplacementNamed(
                                      context, MedicalRequestsHistoryScreen.routeName);
                                  completer.complete(result);
                                }
                              },
                            ),
                          ):const SizedBox(),
                          (userData!.isMedicalAdmin==true && userData!.isDoctor==false)?
                          Padding(
                            padding: EdgeInsets.only(
                                left: 30.w
                            ),
                            child: buildListTile(
                              context,
                              title: "Request",
                              leading: CustomIcons.balloons,
                              isMedical:true,
                              onTap: () async {
                                Navigator.pop(context);

                                if (ModalRoute.of(context)?.settings.name ==
                                    More4uHomeScreen.routeName) {
                                  final completer = Completer();
                                  final result = await Navigator.pushNamed(
                                      context, MyGiftsScreen.routeName)
                                      .whenComplete(() {
                                    _cubit.getCurrentUser();
                                  });
                                  completer.complete(result);
                                } else {
                                  final result = await Navigator.pushReplacementNamed(
                                      context, MyGiftsScreen.routeName,
                                      result: completer.future);
                                  completer.complete(result);
                                }
                              },
                            ),
                          ):const SizedBox(),
                          Padding(
                            padding: EdgeInsets.only(
                                left: 30.w
                            ),
                            child: buildListTile(
                              context,
                              title: 'Partnerships'.tr(),
                              leading: CustomIcons.ticket,
                              isMedical:true,
                              onTap: () async {
                                Navigator.pop(context);
                                if (ModalRoute //send argument to widget
                                    .of(context)
                                    ?.settings
                                    .name ==
                                    More4uHomeScreen.routeName) {
                                  final completer = Completer();
                                  final result = await Navigator.pushNamed(
                                      context, OurPartnersScreen.routeName)
                                      .whenComplete(() {
                                   // _cubit.getHomeData();
                                  });
                                  completer.complete(result);
                                } else {
                                  final result = await Navigator.pushReplacementNamed(
                                      context,OurPartnersScreen.routeName,
                                      result: completer.future);
                                  completer.complete(result);
                                }
                              },
                            ),
                          ),
                          userData!.isDoctor==true?
                          Padding(
                            padding: EdgeInsets.only(
                                left: 30.w
                            ),
                            child: buildListTile(
                              context,
                              title: AppStrings.manageRequests.tr(),
                              leading: CustomIcons.business_time,
                              isMedical:true,
                              onTap: () async {
                                Navigator.pop(context);
                                if (ModalRoute.of(context)?.settings.name ==
                                    More4uHomeScreen.routeName) {
                                  final completer = Completer();
                                  final result = await Navigator.pushNamed(
                                      context, PendingRequestsScreen.routeName)
                                      .whenComplete(() {
                                    _cubit.getCurrentUser();
                                  });
                                  completer.complete(result);
                                } else {
                                  final result = await Navigator.pushReplacementNamed(
                                      context, PendingRequestsScreen.routeName,
                                      result: completer.future);
                                  completer.complete(result);
                                }
                              },
                            ),
                          ):const SizedBox(),
                        ],),
                    ),
                    buildListTile(
                      context,
                      title: AppStrings.notifications.tr(),
                      leading: CustomIcons.bell,
                      isMedical:true,
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.pushNamedAndRemoveUntil(
                            context,
                            NotificationScreen.routeName,
                            ModalRoute.withName(More4uHomeScreen.routeName))
                            .whenComplete(() => _cubit.getCurrentUser());
                      },
                    ),
                    buildListTile(
                      context,
                      title:AppStrings.profile.tr(),
                      leading: CustomIcons.user,
                      isMedical:false,
                      onTap: () async {
                        Navigator.pop(context);
                        if (ModalRoute.of(context)?.settings.name ==
                            More4uHomeScreen.routeName) {
                          Navigator.pushNamed(context, ProfileScreen.routeName,
                              arguments: {
                                'user': userData,
                                'isProfile': true
                              }).whenComplete(() => _cubit.getCurrentUser());
                        } else {
                          final result = await Navigator.pushReplacementNamed(
                              context, ProfileScreen.routeName,
                              arguments: {
                                'user': userData,
                                'isProfile': true,
                              },
                              result: completer.future);
                          completer.complete(result);
                        }
                      },
                    ),
                    buildListTile(
                      context,
                      title: AppStrings.termsAndConditions.tr(),
                        isMedical:false,
                      leading: CustomIcons.document,
                        onTap: () async {
                          Navigator.pop(context);
                          if (ModalRoute.of(context)?.settings.name ==
                              More4uHomeScreen.routeName) {
                            final completer = Completer();
                            final result = await Navigator.pushNamed(
                                context, TermsAndConditions.routeName,arguments: false)
                                .whenComplete(() {
                              _cubit.getCurrentUser();
                            });
                            completer.complete(result);
                          } else {
                            final result = await Navigator.pushReplacementNamed(
                                context, TermsAndConditions.routeName,arguments: false,
                                result: completer.future);
                            completer.complete(result);
                          }
                        }
                    ),
                    Divider(),
                    buildListTile(
                      context,
                      title: 'Logout'.tr(),
                      isMedical:false,
                      leading: CustomIcons.sign_out_alt,
                      onTap: () {
                        Navigator.pop(context);
                        logOut(context);
                      },
                    ),
                   SizedBox(
                     height: 50.h,
                   ),
                    Align(
                        alignment: Alignment.bottomCenter,
                        child: PoweredByCemex()),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildListTile(BuildContext context,
      {required IconData leading,
        required String title,
        void Function()? onTap,
        required bool isMedical
      }) {
    return SizedBox(
      height: 50.h,
      child: Material(
        color: Colors.transparent,
        elevation: 0,
        child: ListTile(
          dense: true,
          minLeadingWidth: 0,
          minVerticalPadding: 0,
          contentPadding: EdgeInsets.symmetric(vertical: 0.h, horizontal: 12.w),
          leading: title == AppStrings.manageRequests.tr()
              ? BlocBuilder<HomeCubit, HomeState>(
            builder: (context, state) {
              return bg.Badge(
                showBadge:isMedical?pendingRequestMedicalCount != 0:
                pendingRequestsCountMore4u != 0,
                ignorePointer: true,
                position: bg.BadgePosition.bottomEnd(),
                badgeColor: AppColors.redColor,
                padding: EdgeInsets.all(0),
                badgeContent: Container(
                  decoration: BoxDecoration(shape: BoxShape.circle),
                  height: 20.h,
                  width: 20.w,
                  child: isMedical?
                  AutoSizeText(
                   pendingRequestMedicalCount! > 99
                        ? '+99'
                        : pendingRequestMedicalCount
                        .toString(),
                    maxLines: 1,
                    wrapWords: false,
                    textAlign: TextAlign.center,
                    minFontSize: 9,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.bold),
                  ):
                  AutoSizeText(
                   pendingRequestsCountMore4u! > 99
                        ? '+99'
                        : pendingRequestsCountMore4u
                        .toString(),
                    maxLines: 1,
                    wrapWords: false,
                    textAlign: TextAlign.center,
                    minFontSize: 9,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                child: SimpleShadow(
                  offset: const Offset(0, 4),
                  color: Colors.black,
                  child: Icon(leading, color: AppColors.mainColor, size: 20.r),
                ),
              );
            },
          ) : SimpleShadow(
            offset: const Offset(0, 4),
            color: Colors.black,
            child: Icon(leading, color: AppColors.mainColor, size: 20.r),
          ),
          title: Text(
            title,
            style: TextStyle(
              fontFamily: "Certa Sans",
              color: AppColors.greyColor,
              fontWeight: FontWeight.w600,
              fontSize: 18.0.sp,
            ),
          ),
          onTap: onTap,
        ),
      ),
    );
  }
}
