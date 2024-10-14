import 'dart:async';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:more4u/core/constants/constants.dart';
import 'package:more4u/custom_icons.dart';
import 'package:simple_shadow/simple_shadow.dart';
import '../../../core/themes/app_colors.dart';
import '../../notification/notification_screen.dart';
import '../cubits/home_cubit.dart';
import '../cubits/home_states.dart';
import '../home_screen.dart';
import 'package:badges/badges.dart' as bg;
class HomeAppBar extends StatelessWidget {
  final String? title;
  final void Function()? onTap;
  const HomeAppBar({super.key, this.title,this.onTap});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          onPressed: (){Scaffold.of(context).openDrawer();},
          icon:Icon(Icons.menu_outlined,) ,
          color: AppColors.mainColor,
          iconSize: 30.sp,
        //  padding: EdgeInsets.zero,
          alignment: Alignment.centerLeft,
        ),
        Spacer(),
        title!=null?
        FittedBox(
          child: SizedBox(
            width: 220.w,
            child: Text(
              title!,
              style: TextStyle(
                  color: AppColors.blackColor,
                  fontSize: 22.sp,
                  fontWeight: FontWeight.w200,
                fontFamily: "Certa Sans",),
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
            ),
          ),
        ):const SizedBox(),
        Spacer(),
        title!="More4u"?
            IconButton(onPressed:onTap, icon: Icon(
              Icons.arrow_back_ios_new_outlined ,
              color: AppColors.blackColor,
              size: 22.sp,
            ),
            ) :
        BlocBuilder<HomeCubit,HomeState>(
          builder: (context, state) {
            return bg.Badge(
              showBadge: userUnSeenNotificationCount!=0,
         //     showBadge:true,
              ignorePointer: true,
              position: BadgePosition.bottomEnd(bottom: 0,end: 0),
              badgeColor: AppColors.redColor,
              padding: EdgeInsets.all(0),
              badgeContent: Container(
                decoration: BoxDecoration(
                    shape: BoxShape.circle
                ),
                width: 25.w,
                height: 25.h,
                child: AutoSizeText(
                 // userUnSeenNotificationCount??0>99?'+99':
                  userUnSeenNotificationCount.toString(),
                  maxLines: 1,
                  wrapWords: false,
                  textAlign: TextAlign.center,
                  minFontSize: 9,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 22.sp,
                      fontWeight: FontWeight.bold),
                ),
              ),
              child: Material(
                borderRadius: BorderRadius.circular(150.r),
                clipBehavior: Clip.antiAlias,
                color: Colors.transparent,
                child: IconButton(
                  onPressed: () {
                    if (ModalRoute.of(context)?.settings.name ==
                        HomeScreen.routeName) {
                      final completer = Completer();
                      final result = Navigator.pushNamedAndRemoveUntil(
                          context, NotificationScreen.routeName,
                          ModalRoute.withName(HomeScreen.routeName)).whenComplete(() =>
                          HomeCubit.get(context).getCurrentUser());
                      completer.complete(result);
                    } else{
                      final completer = Completer();
                      final result = Navigator.pushReplacementNamed(
                          context, NotificationScreen.routeName,
                          result: completer.future);
                      completer.complete(result);
                    }
                  },
                  iconSize: 30.w,
                  icon: SimpleShadow(
                      offset: Offset(0, 4),
                      color: Colors.black.withOpacity(0.25),
                      child: Icon(
                        CustomIcons.bell,
                        color: AppColors.blackColor,
                        size: 25.sp,
                      )),
                ),
              ),
            );
          },
        ),
        // GestureDetector(
        //   onTap: () {},
        //   child: Icon(
        //     CustomIcons.bell,
        //     color: AppColors.blackColor,
        //     size: 22.sp,
        //   ),
        // ),
      ],
    );
  }
}
