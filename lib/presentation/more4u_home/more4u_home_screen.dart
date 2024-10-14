import 'dart:async';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:more4u/core/constants/app_strings.dart';
import 'package:more4u/presentation/home/home_screen.dart';
import 'package:timeago/timeago.dart';

import '../../core/constants/constants.dart';
import '../../core/firebase/push_notification_service.dart';
import '../../core/themes/app_colors.dart';
import '../home/widgets/app_bar.dart';
import '../widgets/benifit_card.dart';
import '../widgets/drawer_widget.dart';
import '../widgets/helpers.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../widgets/utils/loading_dialog.dart';
import '../widgets/utils/message_dialog.dart';
import 'cubits/more4u_home_cubit.dart';

class More4uHomeScreen extends StatefulWidget {
  static const routeName = 'HomeScreen';

  const More4uHomeScreen({Key? key}) : super(key: key);

  @override
  State<More4uHomeScreen> createState() => _More4uHomeScreenState();
}

class _More4uHomeScreenState extends State<More4uHomeScreen>
    with WidgetsBindingObserver, TickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async{
      await More4uHomeCubit.get(context).getHomeData();
    });
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      if (mounted) {
        More4uHomeCubit.get(context);
      }
    }
  }

  @override
  void didChangeDependencies() {
    SystemChannels.lifecycle.setMessageHandler((msg) async{
      if(msg == AppLifecycleState.resumed.toString()) {
        await More4uHomeCubit.get(context).getHomeData();
      }
      return Future.delayed(Duration.zero);
    });
    PushNotificationService.init(context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    TabController _tabController = TabController(length: 2, vsync: this);
    var _cubit = More4uHomeCubit.get(context);
    _cubit.getMedical();
    if (context.locale.languageCode == 'ar') {
      timeago.setLocaleMessages('ar', ArMessages());
    }
    return BlocConsumer<More4uHomeCubit, More4uHomeState>(
      listener: (context, state) {
        if(state is GetHomeDataLoadingState)
        {
          loadingAlertDialog(context);
        }
        if (state is GetHomeDataSuccessState) {
          Navigator.pop(context);
        }
        if(state is GetHomeDataErrorState)
        {
          if(state.message==AppStrings.sessionHasBeenExpired.tr())
          {
            showMessageDialog(
                context: context, isSucceeded: false, message: state.message,
                onPressedOk: ()
                {
                  logOut(context);
                });
          }
          else
          {
            showMessageDialog(
              context: context,
              isSucceeded: false,
              message: state.message,
              onPressedOk: () => Navigator.pop(context),
            );
          }
        }
        if(state is GetPrivilegesErrorState)
          {
            if(state.message==AppStrings.sessionHasBeenExpired.tr())
            {
              showMessageDialog(
                  context: context, isSucceeded: false, message: state.message,
                  onPressedOk: ()
                  {
                    logOut(context);
                  });
            }
            else
            {
              showMessageDialog(
                context: context,
                isSucceeded: false,
                message: state.message,
                onPressedOk: () => Navigator.pop(context),
              );
            }
          }

      },
      builder: (context, state) {
        return Scaffold(
          drawer: const DrawerWidget(),
          body: SafeArea(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(16.w, 14.h, 16.w, 14.h),
                  child: HomeAppBar(
                    title: "More4u Benefits",
                    onTap: () {
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) => HomeScreen()),
                              (route) => false);
                    },
                  ),
                ),
               Expanded(child:  Padding(
                 padding: EdgeInsets.symmetric(horizontal: 16.w),
                 child: Column(
                   crossAxisAlignment: CrossAxisAlignment.start,
                   children: [
                     Text(
                       AppStrings.chooseYourBenefitCard.tr(),
                       style: TextStyle(
                         fontSize: 18.sp,
                         fontFamily: "Certa Sans",
                         fontWeight: FontWeight.w200,
                         color: AppColors.greyColor,
                       ),
                     ),
                     SizedBox(height: 20.h),
                     Theme(
                       data: ThemeData(
                         highlightColor: Colors.transparent,
                         splashColor: Colors.transparent,
                       ),
                       child: TabBar(
                           controller: _tabController,
                           isScrollable: true,
                           unselectedLabelColor: Color(0xFF6D6D6D),
                           indicatorSize: TabBarIndicatorSize.label,
                           indicatorPadding: EdgeInsets.symmetric(vertical: 20.h),
                           indicator: BoxDecoration(
                               borderRadius: BorderRadius.circular(8.r),
                               color: AppColors.redColor),
                           padding: EdgeInsets.zero,
                           labelPadding: EdgeInsets.symmetric(vertical: 0.h),
                           onTap: (index) {
                             // if (index == 2) {
                             //   _cubit.getMedical();
                             // }
                           },
                           tabs: [
                             Tab(
                               height: 75.h,
                               child: Container(
                                 padding: EdgeInsets.symmetric(horizontal: 8.w),
                                 child: Align(
                                   alignment: Alignment.center,
                                   child: Text(
                                     "${AppStrings.allCards.tr()} (${_cubit.benefitModels.length})",
                                     style: TextStyle(fontSize: 16.sp, fontFamily: "Certa Sans",fontWeight: FontWeight.w200),
                                   ),
                                 ),
                               ),
                             ),
                             Tab(
                               height: 75.h,
                               child: Container(
                                 padding: EdgeInsets.symmetric(horizontal: 8.w),
                                 child: Align(
                                   alignment: Alignment.center,
                                   child: Text(
                                       style: TextStyle(fontSize: 16.sp, fontFamily: "Certa Sans",fontWeight: FontWeight.w200),
                                       "${"Available".tr()} (${_cubit.availableBenefitModels?.length ?? '0'})"),
                                 ),
                               ),
                             ),
                             // Tab(
                             //   height: 75.h,
                             //   child: Container(
                             //     padding: EdgeInsets.symmetric(horizontal: 8.w),
                             //     child: Align(
                             //       alignment: Alignment.center,
                             //       child: Text(
                             //           style: TextStyle(fontSize: 12.sp),
                             //           "${"Medical".tr()} (${_cubit.cat.length})"),
                             //     ),
                             //   ),
                             // ),
                           ]),
                     ),
                     Padding(
                       padding: EdgeInsets.only(
                           top: 0.h, bottom: 16.h, left: 8.w, right: 8.w),
                       child: Center(
                         child: state is GetHomeDataLoadingState
                             ? LinearProgressIndicator(
                           minHeight: 2.h,
                           backgroundColor: AppColors.mainColor.withOpacity(0.4),
                         )
                             : SizedBox(
                           height: 2.h,
                         ),
                       ),
                     ),
                     Expanded(
                       child: TabBarView(
                           physics: NeverScrollableScrollPhysics(),
                           controller: _tabController,
                           children: [
                             RefreshIndicator(
                               triggerMode: RefreshIndicatorTriggerMode.anywhere,
                               onRefresh: () async {
                                 More4uHomeCubit.get(context).getHomeData();
                               },
                               child: ListView.builder(
                                 padding: EdgeInsets.zero,
                                 itemBuilder: (context, index) {
                                   return BenefitCard(
                                       benefit: _cubit.benefitModels[index]);
                                 },
                                 itemCount: _cubit.benefitModels.length,
                               ),
                             ),
                             _cubit.availableBenefitModels != null &&
                                 _cubit.availableBenefitModels?.length != 0
                                 ? RefreshIndicator(
                               triggerMode:
                               RefreshIndicatorTriggerMode.anywhere,
                               onRefresh: () async {
                                 More4uHomeCubit.get(context).getHomeData();
                               },
                               child: ListView.builder(
                                 padding: EdgeInsets.zero,
                                 itemBuilder: (context, index) =>
                                     BenefitCard(
                                         benefit:
                                         _cubit.availableBenefitModels![
                                         index]),
                                 itemCount:
                                 _cubit.availableBenefitModels?.length,
                               ),
                             )
                                 : Center(
                                 child: Text(
                                   AppStrings.noBenefitAvailable.tr(),
                                   style: TextStyle(fontSize: 12.sp),
                                 )),
                             // _cubit.privileges.isNotEmpty
                             //     ? RefreshIndicator(
                             //         triggerMode:
                             //             RefreshIndicatorTriggerMode.anywhere,
                             //         onRefresh: () async {
                             //           HomeCubit.get(context).getHomeData();
                             //         },
                             //         child: ListView.builder(
                             //           padding: EdgeInsets.zero,
                             //           itemBuilder: (context, index) =>
                             //               PrivilegeCard(
                             //                   privilege:
                             //                       _cubit.privileges[index]),
                             //           itemCount: _cubit.privileges.length,
                             //         ),
                             //       )
                             //     : BlocBuilder<HomeCubit, HomeState>(
                             //         builder: (context, state) {
                             //           return Container(
                             //             child: state is GetPrivilegesLoadingState
                             //                 ? Center(
                             //                     child:
                             //                         CircularProgressIndicator())
                             //                 : RefreshIndicator(
                             //                     triggerMode:
                             //                         RefreshIndicatorTriggerMode
                             //                             .anywhere,
                             //                     onRefresh: () async {
                             //                       HomeCubit.get(context)
                             //                           .getHomeData();
                             //                     },
                             //                     child: LayoutBuilder(builder:
                             //                         (context, constraints) {
                             //                       return SingleChildScrollView(
                             //                         physics:
                             //                             AlwaysScrollableScrollPhysics(),
                             //                         child: Container(
                             //                             alignment:
                             //                                 Alignment.center,
                             //                             height:
                             //                                 constraints.maxHeight,
                             //                             child: Text(
                             //                                 style: TextStyle(
                             //                                     fontSize: 13.sp),
                             //                                 AppStrings
                             //                                     .noPrivilegesAvailable
                             //                                     .tr())),
                             //                       );
                             //                     }),
                             //                   ),
                             //           );
                             //         },
                             //       ),

                             //
                             // _cubit.cat.isNotEmpty
                             //     ? RefreshIndicator(
                             //         triggerMode:
                             //             RefreshIndicatorTriggerMode.anywhere,
                             //         onRefresh: () async {
                             //           More4uHomeCubit.get(context).getMedical();
                             //         },
                             //         child: const MedicalWidget(),
                             //       )
                             //     : BlocBuilder<More4uHomeCubit, More4uHomeState>(
                             //         builder: (context, state) {
                             //           return Container(
                             //             child: state is GetMedicalLoadingState
                             //                 ? const Center(
                             //                     child:
                             //                         CircularProgressIndicator())
                             //                 : RefreshIndicator(
                             //                     triggerMode:
                             //                         RefreshIndicatorTriggerMode
                             //                             .anywhere,
                             //                     onRefresh: () async {
                             //                       More4uHomeCubit.get(context)
                             //                           .getMedical();
                             //                     },
                             //                     child: LayoutBuilder(builder:
                             //                         (context, constraints) {
                             //                       return SingleChildScrollView(
                             //                         physics:
                             //                             AlwaysScrollableScrollPhysics(),
                             //                         child: Container(
                             //                             alignment:
                             //                                 Alignment.center,
                             //                             height:
                             //                                 constraints.maxHeight,
                             //                             child: Text(
                             //                                 style: TextStyle(
                             //                                     fontSize: 13.sp),
                             //                                 AppStrings
                             //                                     .thereIsNoMedicalServices
                             //                                     .tr())),
                             //                       );
                             //                     }),
                             //                   ),
                             //           );
                             //         },
                             //       ),
                           ]),
                     ),
                   ],
                 ),
               ),)
              ],
            ),
          ),
        );
      },
    );
  }
}
