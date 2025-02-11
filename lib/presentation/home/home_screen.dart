import 'package:carousel_slider/carousel_slider.dart';
import 'package:carousel_slider/carousel_state.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:more4u/core/constants/constants.dart';
import 'package:more4u/core/themes/app_colors.dart';
import 'package:more4u/presentation/home/widgets/admin_medical_features.dart';
import 'package:more4u/presentation/home/widgets/app_bar.dart';
import 'package:more4u/presentation/home/widgets/current_emp_info.dart';
import 'package:more4u/presentation/home/widgets/doctor_medical_features.dart';
import 'package:more4u/presentation/home/widgets/employee_medical_feature.dart';
import 'package:more4u/presentation/home/widgets/medical_feature.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../../core/constants/app_strings.dart';
import '../../core/firebase/push_notification_service.dart';
import '../../injection_container.dart';
import '../medical_requests_history/medical_requests_history_screen.dart';
import '../pending_requests/pending_requests_screen.dart';
import '../widgets/drawer_widget.dart';
import '../widgets/helpers.dart';
import '../widgets/utils/loading_dialog.dart';
import '../widgets/utils/message_dialog.dart';
import '../widgets/utils/warning_diaglog.dart';
import 'cubits/home_cubit.dart';
import 'cubits/home_states.dart';

class CustomCarouselController extends CarouselControllerImpl {
  CarouselState? _state;
  CarouselState? get state => _state;

  @override
  set state(CarouselState? state) {
    _state = state;
    super.state = state;
  }
}

class HomeScreen extends StatefulWidget {
  static const routeName = ' AppRoutScreen';
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late CustomCarouselController _carouselController;
  bool loadingSkeletonizer=true;
  @override
  void initState() {
    _carouselController = CustomCarouselController();
    super.initState();
  }


  @override
  void didChangeDependencies() {
    SystemChannels.lifecycle.setMessageHandler((msg) async{
      if(msg == AppLifecycleState.resumed.toString()) {
        await HomeCubit.get(context).getCurrentUser();
      }
      return Future.delayed(Duration.zero);
    });
    PushNotificationService.init(context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<HomeCubit>(
      create: (context) => sl<HomeCubit>()..getCurrentUser(),
  child: BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {
        if (state is GetCurrentUserLoadingState) {
          loadingAlertDialog(context);
        }
        if (state is GetCurrentUserSuccessState) {
          loadingSkeletonizer=false;
          if (Navigator.canPop(context)) {
            Navigator.pop(context);
          }
        }
        if (state is GetCurrentUserErrorState) {
          if (state.message == AppStrings.sessionHasBeenExpired.tr()) {
            showMessageDialog(
                context: context,
                isSucceeded: false,
                message: state.message,
                onPressedOk: () {
                  logOut(context);
                });
          } else {
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
        //  backgroundColor: Color(0xFFF8F8F8),
          drawer: const DrawerWidget(),
          body: SingleChildScrollView(
            child: SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(16.w, 14.h, 16.w, 0.h),
                    child: HomeAppBar(title: "More4u",),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(22.w, 10.h, 22.w, 10.h),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                         AppStrings.welcomeBack.tr(),
                          style: TextStyle(
                            color: AppColors.blackColor,
                            fontSize: 20.sp,
                            fontWeight: FontWeight.w500,
                            fontFamily: "Certa Sans",
                          ),
                        ),
                        SizedBox(
                          height: 5.h,
                        ),
                      ],
                    ),
                  ),

                  Skeletonizer(
                      enabled: loadingSkeletonizer,
                      child: CurrentEmployeeInfo()),
                  (userData?.isDoctor == true ||  userData?.isMedicalAdmin== true )?
                  Padding(
                    padding: EdgeInsets.only(left:22.w,bottom: 20.h,right:22.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                        AppStrings.mangeRequests.tr(),
                          style: TextStyle(
                            color: AppColors.blackColor,
                            fontSize: 20.sp,
                            fontWeight: FontWeight.w500,
                            fontFamily: "Certa Sans",
                          ),
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        SizedBox(
                          width: 180.w,
                          child:  userData?.isDoctor== true ?MedicalFeature(
                            imagePath: "assets/images/pending.png",
                            title:AppStrings.pendingRequests.tr(),
                            enabled: true,
                            description:AppStrings.mangePendingMedicalRequests.tr(),
                            onTap:() {
                          Navigator.of(context).pushNamed(
                          PendingRequestsScreen.routeName);
                          }):userData?.isMedicalAdmin== true?MedicalFeature(
                              imagePath: "assets/images/pending.png",
                              title:AppStrings.pendingRequests.tr(),
                              description:AppStrings.followPendingMedicalRequests.tr(),
                              enabled: true,
                              onTap:() {
                                Navigator.of(context)
                                    .pushNamed(MedicalRequestsHistoryScreen.routeName);
                              }):SizedBox(),
                        ),
                      ],
                    ),
                  ):
                  SizedBox(),
                  Padding(
                    padding: EdgeInsets.only(left: 22.w,right: 22.w),
                    child: Text(
                       AppStrings.features.tr(),
                      style: TextStyle(
                        color: AppColors.blackColor,
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w500,
                        fontFamily: "Certa Sans",
                      ),
                    ),
                  ),
                  (userData?.isDoctor == true ||
                      userData?.isMedicalAdmin == true)
                      ? SizedBox(
                    height: 10.h,
                  )
                      : const SizedBox(),
                  userData?.isDoctor == true
                      ? DoctorMedicalFeatures(
                    carouselController: _carouselController,
                  )
                      : userData?.isMedicalAdmin == true
                      ? AdminMedicalFeatures(
                    carouselController: _carouselController,
                  )
                      : EmployeeMedicalFeature(
                    carouselController: _carouselController,
                  ),
                  (userData?.isDoctor == true ||
                      userData?.isMedicalAdmin == true)
                      ? SizedBox(
                    height: 10.h,
                  )
                      : const SizedBox(),

                  Padding(
                    padding: EdgeInsets.fromLTRB(22.w,15.h, 22.w,10.h),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                         AppStrings.comingSoon.tr(),
                          style: TextStyle(
                            color: AppColors.blackColor,
                            fontSize: 20.sp,
                            fontWeight: FontWeight.w500,
                            fontFamily: "Certa Sans",
                          ),
                        ),
                        (userData?.isDoctor == true ||
                            userData?.isMedicalAdmin == true)?SizedBox(
                          height: 10.h,
                        ):SizedBox(),
                        SizedBox(
                          height: 10.h,
                        ),
                        GestureDetector(
                          onTap: ()
                          {
                            showWarningDialog(
                                context: context,
                                message: AppStrings.comingSoon.tr(),
                                isSucceeded: false,
                            );
                          },
                          child: Card(
                            elevation: 5,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.r),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(15.r),
                              child: Container(
                                  height: 100.h,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    color: AppColors.whiteColor,
                                    border: Border(
                                        left: BorderSide(
                                    // color: Color(0xFF446CFF),
                                          color: AppColors.greyText,
                                      width: 5.w,
                                    )),
                                    //  gradient: LinearGradient(colors: [ Color(0xFF446CFF), Color(0xFF1E9AFF),]),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 15.w),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Image.asset(
                                          "assets/images/privilages_icon.png",
                                          height: 40.h,
                                        ),
                                        SizedBox(
                                          width: 15.w,
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                          AppStrings.privileges.tr(),
                                              style: TextStyle(
                                                color: AppColors.blackColor,
                                                fontSize: 16.sp,
                                                fontWeight: FontWeight.w500,
                                                fontFamily: "Certa Sans",
                                              ),
                                            ),
                                            Row(
                                              children: [
                                                SizedBox(
                                                  width: 190.w,
                                                  child: Text(
                                                    AppStrings.followOurPrivilegesBenefits.tr(),
                                                    style: TextStyle(
                                                      color:
                                                          AppColors.greyColor,
                                                      fontSize: 14.sp,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      fontFamily: "Nunito",
                                                    ),
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 15.w,
                                                ),
                                                CircleAvatar(
                                                  radius: 12.r,
                                                  backgroundColor:
                                                      Colors.transparent,
                                                  child: Container(
                                                      decoration:
                                                          BoxDecoration(
                                                        shape:
                                                            BoxShape.circle,
                                                        // gradient:
                                                        //     LinearGradient(
                                                        //   colors: [
                                                        //     Color(0xFF446CFF),
                                                        //     Color(0xFF1E9AFF),
                                                        //   ],
                                                       color: AppColors.greyText,
                                                        ),
                                                      child: Center(
                                                          child: Icon(
                                                        Icons
                                                            .arrow_forward_ios_outlined,
                                                        size: 18.sp,
                                                        color: AppColors
                                                            .whiteColor,
                                                      ))),
                                                )
                                              ],
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  )),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    ),
);
  }
}
