import 'package:carousel_slider/carousel_slider.dart';
import 'package:carousel_slider/carousel_state.dart';
import 'package:flutter/material.dart';
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
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:shimmer/shimmer.dart';
import '../../injection_container.dart';
import '../more4u_home/more4u_home_screen.dart';
import '../pending_requests/pending_requests_screen.dart';
import '../widgets/drawer_widget.dart';
import '../widgets/helpers.dart';
import '../widgets/utils/loading_dialog.dart';
import '../widgets/utils/message_dialog.dart';
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
  @override
  void initState() {
    _carouselController = CustomCarouselController();
    super.initState();
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
          if (state is GetCurrentUserErrorState) {
            //  Navigator.pop(context);
            showMessageDialog(
                context: context,
                message: state.message,
                isSucceeded: false,
                onPressedOk: () {
                  logOut(context);
                });
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
                      padding: EdgeInsets.fromLTRB(16.w, 20.h, 16.w, 14.h),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                         const HomeAppBar(),
                          SizedBox(
                            height: 10.h,
                          ),
                          Text(
                            "Welcome Back !",
                            style: TextStyle(
                              color: AppColors.blackColor,
                              fontSize: 20.sp,
                              fontWeight: FontWeight.w500,
                              fontFamily: "Certa Sans",
                            ),
                          ),
                        ],
                      ),
                    ),
                    CurrentEmployeeInfo(),
                    SizedBox(
                      height: 5.h,
                    ),
                    userData?.isDoctor == true?
                    Padding(
                      padding: EdgeInsets.only(left: 20.w,bottom: 20.h),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                          "Mange Requests",
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
                            child: MedicalFeature(
                              imagePath: "assets/images/pending.png",
                              title:"Pending Requests",
                              description:"Mange Pending Medical Requests",
                              onTap:() {
                            Navigator.of(context).pushNamed(
                            PendingRequestsScreen.routeName);
                            }),
                          ),
                        ],
                      ),
                    ):
                    SizedBox(),
                    Padding(
                      padding: EdgeInsets.only(left: 20.w),
                      child: Text(
                        (userData?.isDoctor == true ||
                            userData?.isMedicalAdmin == true)
                            ? "Medical Features"
                            : "Features",
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
                      padding: EdgeInsets.fromLTRB(16.w,15.h, 16.w,10.h),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            (userData?.isDoctor == true ||
                                userData?.isMedicalAdmin == true)? "Features":"Coming Soon",
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
                          (userData?.isDoctor == true ||
                              userData?.isMedicalAdmin == true)?
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context)
                                  .pushNamed(More4uHomeScreen.routeName);
                            },
                            child: Card(
                              elevation: 5,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.r),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(15.r),
                                child: Container(
                                    height: 110.h,
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      color: AppColors.whiteColor,
                                      border: Border(
                                          left: BorderSide(
                                        color: Color(0xFF446CFF),
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
                                            "assets/images/more4u_icon.png",
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
                                                "More4u",
                                                style: TextStyle(
                                                  color: AppColors.blackColor,
                                                  fontSize:20.sp,
                                                  fontWeight: FontWeight.w500,
                                                  fontFamily: "Certa Sans",
                                                ),
                                              ),
                                              Row(
                                                children: [
                                                  SizedBox(
                                                    width: 190.w,
                                                    child: Text(
                                                      "Enjoy a variety of different benefits",
                                                      style: TextStyle(
                                                        color:
                                                            AppColors.greyColor,
                                                        fontSize: 14.sp,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        fontFamily: "Certa Sans",
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
                                                        decoration: BoxDecoration(
                                                            shape: BoxShape.circle,
                                                            gradient: LinearGradient(
                                                                begin: Alignment.topLeft,
                                                                end: Alignment.bottomRight,
                                                                stops: [
                                                                  0.0,
                                                                  0.7,
                                                                  1
                                                                ],
                                                                //  tileMode: TileMode.repeated,
                                                                colors: [
                                                                  Color(
                                                                      0xFF00a7ff),
                                                                  Color(
                                                                      0xFF2a64ff),
                                                                  Color(
                                                                      0xFF1980ff),
                                                                ])
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
                          ):SizedBox(),
                          SizedBox(
                            height: 10.h,
                          ),
                          GestureDetector(
                            onTap: ()
                            {
// show popup
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
                                                "Privileges",
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
                                                      "Lorem ipsum dolores sit amet is the ",
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
