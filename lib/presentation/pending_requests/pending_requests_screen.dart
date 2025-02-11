import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:more4u/presentation/home/home_screen.dart';
import 'package:more4u/presentation/medical_benefits/medical_benefits_screen.dart';
import 'package:more4u/presentation/pending_requests/cubits/pending_requests_cubit.dart';
import 'package:more4u/presentation/pending_requests/cubits/pending_requests_state.dart';
import 'package:more4u/presentation/pending_requests/widgets/pending_request.dart';
import 'package:more4u/presentation/widgets/utils/loading_dialog.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../core/constants/app_strings.dart';
import '../../core/themes/app_colors.dart';
import '../../custom_icons.dart';
import '../../domain/entities/response_medical_request.dart';
import '../../injection_container.dart';
import '../home/widgets/app_bar.dart';
import '../medical_request_details_and_doctor_response/medical_doctor_response_screen.dart';
import '../widgets/drawer_widget.dart';
import '../widgets/helpers.dart';
import '../widgets/utils/message_dialog.dart';

class PendingRequestsScreen extends StatefulWidget {
  static const routeName = 'PendingRequestsScreen';
  const PendingRequestsScreen({super.key});

  @override
  State<PendingRequestsScreen> createState() => _PendingRequestsScreenState();
}

class _PendingRequestsScreenState extends State<PendingRequestsScreen>
    with TickerProviderStateMixin {
  late TabController _tabController;
  bool loadingSkeletonizer = true;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await PendingRequestsCubit.get(context).getPendingRequests();
    });
    _tabController = TabController(length: 3, vsync: this);
    int tabControllerIndex = 0;
    _tabController.addListener(() {
      if (_tabController.index == 0) {
        tabControllerIndex = 1;
      } else if (_tabController.index == 1) {
        tabControllerIndex = 2;
      } else {
        tabControllerIndex = 3;
      }
      PendingRequestsCubit.get(context)
          .changeRequestTypeID(tabControllerIndex.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PendingRequestsCubit, PendingRequestsState>(
      listener: (context, state) {
        if (state is ChangeRequestTypeSuccessState) {
          loadingSkeletonizer = true;
          PendingRequestsCubit.get(context).getPendingRequests();
        }
        // if (state is GetPendingRequestsLoadingState) {
        //   loadingAlertDialog(context);
        // }
        if (state is GetPendingRequestsSuccessState) {
          loadingSkeletonizer = false;
          // if (Navigator.canPop(context)) {
          //   Navigator.pop(context);
          // }
        }
        if (state is GetPendingRequestsErrorState) {
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
                onPressedOk: () {
                  Navigator.pop(context);
                });
          }
        }
        if (state is GetMedicalRequestDetailsLoadingState) {
          loadingAlertDialog(context);
        }
        if (state is GetMedicalRequestDetailsSuccessState) {
          Navigator.of(context).pop();
          Navigator.pushNamedAndRemoveUntil(
              context, MedicalDoctorResponseScreen.routeName, (route) => false);
        }
        if (state is GetMedicalRequestDetailsErrorState) {
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
                onPressedOk: () {
                  Navigator.pop(context);
                });
          }
        }
        if (state is SearchInPendingRequestsLoadingState) {
          loadingAlertDialog(context);
        }
        if (state is SearchInPendingRequestsSuccessState) {
          if (Navigator.canPop(context)) {
            Navigator.pop(context);
          }
        }
        if (state is SearchInPendingRequestsErrorState) {
          if (Navigator.canPop(context)) {
            Navigator.pop(context);
          }
        }
      },
      builder: (context, state) {
        var _cubit = PendingRequestsCubit.get(context);
        return Scaffold(
          drawer: const DrawerWidget(),
          body: SafeArea(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(16.w, 14.h, 16.w, 10.h),
                  child: HomeAppBar(
                    title: AppStrings.manageRequests.tr(),
                    onTap: () {
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (context) => HomeScreen()),
                          (route) => false);
                    },
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(16.w, 20.h, 16.w, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50.r),
                                    boxShadow: [
                                      BoxShadow(
                                          blurRadius: 10,
                                          offset: Offset(0, 4),
                                          color: Colors.black26)
                                    ]),
                                child: TextField(
                                  style: TextStyle(
                                      fontSize: 12.sp,
                                      fontFamily: "Certa Sans"),
                                  controller:
                                      _cubit.searchInPendingRequestsController,
                                  keyboardType: TextInputType.text,
                                  decoration: InputDecoration(
                                    hintText:
                                        AppStrings.searchByUserNumber.tr(),
                                    isDense: true,
                                    contentPadding: EdgeInsets.symmetric(
                                        vertical: 8.h, horizontal: 11.w),
                                    fillColor: Colors.white,
                                    filled: true,
                                    labelStyle: TextStyle(
                                        fontSize: 16.sp,
                                        fontFamily: "Certa Sans"),
                                    hintStyle: TextStyle(
                                        color: Color(0xFFB5B9B9),
                                        fontSize: 16.sp,
                                        fontFamily: "Certa Sans",
                                        fontWeight: FontWeight.w500),
                                    suffixIcon: IconButton(
                                      icon: Icon(
                                        Icons.clear,
                                        size: 17.r,
                                      ),
                                      onPressed: () {
                                        _cubit.getPendingRequests();
                                      },
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: AppColors.whiteGreyColor),
                                      borderRadius: BorderRadius.circular(15.r),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: AppColors.whiteGreyColor),
                                      borderRadius: BorderRadius.circular(15.r),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 8.w,
                            ),
                            InkWell(
                              borderRadius: BorderRadius.circular(15.r),
                              onTap: () {
                                _cubit.searchInPendingRequests();
                              },
                              child: Ink(
                                width: 38.w,
                                height: 40.w,
                                decoration: BoxDecoration(
                                    color: Color(0xFFe8f2ff),
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.black26, blurRadius: 10)
                                    ],
                                    borderRadius: BorderRadius.circular(15.r),
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
                                          Color(0xFF00a7ff),
                                          Color(0xFF2a64ff),
                                          Color(0xFF1980ff),
                                        ])),
                                child: Center(
                                    child: Icon(
                                  // Icons.filter_list_alt,
                                  CustomIcons.search__1_,
                                  size: 17.r,
                                  // color: Color(0xFF2c93e7),
                                  color: AppColors.whiteColor,
                                )),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        DecoratedBox(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.r)),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.r),
                              //  color:  Color(0xFFe8f2ff),
                            ),
                            height: 50.h,
                            child: Padding(
                              padding: EdgeInsets.fromLTRB(0.w, 8.h, 0.w, 8.h),
                              child: TabBar(
                                  physics: ScrollPhysics(),
                                  controller: _tabController,
                                  unselectedLabelColor: AppColors.greyColor,
                                  labelColor: AppColors.whiteColor,
                                  indicator: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10.r),
                                      // color:  Color(0xFF2c93e7),
                                      gradient: LinearGradient(
                                          begin: Alignment.topLeft,
                                          end: Alignment.bottomRight,
                                          stops: [
                                            0.0,
                                            0.7,
                                            1
                                          ],
                                          colors: [
                                            Color(0xFF00a7ff),
                                            Color(0xFF2a64ff),
                                            Color(0xFF1980ff),
                                          ])),
                                  onTap: (index) {
                                    if (index == 0) {
                                      _cubit.changeRequestTypeID("1");
                                    } else if (index == 1) {
                                      _cubit.changeRequestTypeID("2");
                                    } else {
                                      _cubit.changeRequestTypeID("3");
                                    }
                                  },
                                  tabs: [
                                    Tab(
                                      // height: 30.h,
                                      child: Container(
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10.r)),
                                        margin: EdgeInsets.zero,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              AppStrings.medications.tr(),
                                              style: TextStyle(
                                                  fontSize: 14.sp,
                                                  fontWeight: FontWeight.w600,
                                                  fontFamily: "Certa Sans"),
                                            ),
                                            SizedBox(
                                              width: 2.w,
                                            ),
                                            Stack(
                                              alignment: Alignment.center,
                                              children: [
                                                CircleAvatar(
                                                  radius: 10.r,
                                                  backgroundColor:
                                                      AppColors.redColor,
                                                ),
                                                Text(
                                                  _cubit
                                                      .medicationPendingRequestCount!,
                                                  //  "2222",
                                                  style: TextStyle(
                                                      color:
                                                          AppColors.whiteColor,
                                                      fontSize: 12.sp,
                                                      fontFamily: "Certa Sans"),
                                                )
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Tab(
                                      height: 30.h,
                                      child: Container(
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(15.r)),
                                        child: Align(
                                            alignment: Alignment.center,
                                            child: Row(
                                              children: [
                                                Text(AppStrings.checkUps.tr(),
                                                    style: TextStyle(
                                                        fontSize: 14.sp,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontFamily:
                                                            "Certa Sans")),
                                                SizedBox(
                                                  width: 2.w,
                                                ),
                                                Stack(
                                                  alignment: Alignment.center,
                                                  children: [
                                                    CircleAvatar(
                                                      radius: 10.r,
                                                      backgroundColor:
                                                          AppColors.redColor,
                                                    ),
                                                    Text(
                                                      _cubit
                                                          .checkUpsPendingRequestCount!,
                                                      style: TextStyle(
                                                          color: AppColors
                                                              .whiteColor,
                                                          fontSize: 12.sp,
                                                          fontFamily:
                                                              "Certa Sans"),
                                                    )
                                                  ],
                                                ),
                                              ],
                                            )),
                                      ),
                                    ),
                                    Tab(
                                      height: 30.h,
                                      child: Container(
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(15.r)),
                                        child: Align(
                                            alignment: Alignment.center,
                                            child: Row(
                                              children: [
                                                Text(AppStrings.sickLeave.tr(),
                                                    style: TextStyle(
                                                        fontSize: 14.sp,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontFamily:
                                                            "Certa Sans")),
                                                SizedBox(
                                                  width: 2.w,
                                                ),
                                                Stack(
                                                  alignment: Alignment.center,
                                                  children: [
                                                    CircleAvatar(
                                                      radius: 10.r,
                                                      backgroundColor:
                                                          AppColors.redColor,
                                                    ),
                                                    Text(
                                                      _cubit
                                                          .sickLeavePendingRequestCount!,
                                                      style: TextStyle(
                                                          color: AppColors
                                                              .whiteColor,
                                                          fontSize: 10.sp,
                                                          fontFamily:
                                                              "Certa Sans"),
                                                    )
                                                  ],
                                                ),
                                              ],
                                            )),
                                      ),
                                    ),
                                  ]),
                            ),
                          ),
                        ),
                        Expanded(
                          child: TabBarView(
                              physics: ScrollPhysics(),
                              controller: _tabController,
                              children: [
                                state is SearchInPendingRequestsErrorState
                                    ? Image.asset(
                                        "assets/images/couldnot_find.jpg")
                                    : state
                                            is SearchInPendingRequestsSuccessState
                                        ? Padding(
                                            padding: EdgeInsets.fromLTRB(
                                                10.w, 20.h, 10.w, 10.h),
                                            child: ListView.separated(
                                                itemCount: _cubit.searchedResult
                                                        .isNotEmpty
                                                    ? _cubit
                                                        .searchedResult.length
                                                    : _cubit
                                                        .medicationPendingRequests
                                                        .length,
                                                separatorBuilder:
                                                    (context, index) =>
                                                        SizedBox(
                                                          height: 0.h,
                                                        ),
                                                itemBuilder: (context, index) =>
                                                    Skeletonizer(
                                                      enabled:
                                                          loadingSkeletonizer,
                                                      child: RequestCard(
                                                        request: _cubit
                                                                .searchedResult
                                                                .isNotEmpty
                                                            ? _cubit.searchedResult[
                                                                index]
                                                            : _cubit.medicationPendingRequests[
                                                                index],
                                                      ),
                                                    )),
                                          )
                                        : state
                                                is GetPendingRequestsLoadingState
                                            ? Padding(
                                                padding: EdgeInsets.fromLTRB(
                                                    10.w, 20.h, 10.w, 10.h),
                                                child: ListView.separated(
                                                    itemCount: 2,
                                                    separatorBuilder:
                                                        (context, index) =>
                                                            SizedBox(
                                                              height: 10.h,
                                                            ),
                                                    itemBuilder: (context,
                                                            index) =>
                                                        Skeletonizer(
                                                            enabled:
                                                                loadingSkeletonizer,
                                                            child: RequestCard(
                                                              request: Request(
                                                                  requestID: '',
                                                                  employeeName:
                                                                      '',
                                                                  employeeNumber:
                                                                      '',
                                                                  employeeImageUrl:
                                                                      '',
                                                                  requestDate:
                                                                      DateTime
                                                                          .now(),
                                                                  createdBy: '',
                                                                  requestTypeID:
                                                                      '',
                                                                  selfRequest:
                                                                      false,
                                                                  requestStatus:
                                                                      ''),
                                                            ))),
                                              )
                                            : (state
                                                    is GetPendingRequestsSuccessState && _cubit.medicationPendingRequests.isNotEmpty)
                                                ? Padding(
                                                    padding:
                                                        EdgeInsets.fromLTRB(
                                                            10.w,
                                                            20.h,
                                                            10.w,
                                                            10.h),
                                                    child: ListView.separated(
                                                        itemCount: _cubit
                                                            .medicationPendingRequests
                                                            .length,
                                                        separatorBuilder:
                                                            (context, index) =>
                                                                SizedBox(
                                                                  height: 10.h,
                                                                ),
                                                        itemBuilder: (context,
                                                                index) =>
                                                            Skeletonizer(
                                                                enabled:
                                                                    loadingSkeletonizer,
                                                                child:
                                                                    RequestCard(
                                                                  request: _cubit
                                                                          .medicationPendingRequests[
                                                                      index],
                                                                ))),
                                                  )
                                                : Image.asset(
                                                    "assets/images/couldnot_find.jpg"),
                                state is SearchInPendingRequestsErrorState
                                    ? Image.asset(
                                        "assets/images/couldnot_find.jpg")
                                    : state
                                            is SearchInPendingRequestsSuccessState
                                        ? Padding(
                                            padding: EdgeInsets.fromLTRB(
                                                10.w, 20.h, 10.w, 0),
                                            child: ListView.separated(
                                                itemCount: _cubit.searchedResult
                                                        .isNotEmpty
                                                    ? _cubit
                                                        .searchedResult.length
                                                    : _cubit
                                                        .checkUpsPendingRequests
                                                        .length,
                                                separatorBuilder:
                                                    (context, index) =>
                                                        SizedBox(
                                                          height: 10.h,
                                                        ),
                                                itemBuilder: (context, index) =>
                                                    Skeletonizer(
                                                      enabled:
                                                          loadingSkeletonizer,
                                                      child: RequestCard(
                                                        request: _cubit
                                                                .searchedResult
                                                                .isNotEmpty
                                                            ? _cubit.searchedResult[
                                                                index]
                                                            : _cubit.checkUpsPendingRequests[
                                                                index],
                                                      ),
                                                    )),
                                          )
                                        : state
                                                is GetPendingRequestsLoadingState
                                            ? Padding(
                                                padding: EdgeInsets.fromLTRB(
                                                    10.w, 20.h, 10.w, 10.h),
                                                child: ListView.separated(
                                                    itemCount: 2,
                                                    separatorBuilder:
                                                        (context, index) =>
                                                            SizedBox(
                                                              height: 10.h,
                                                            ),
                                                    itemBuilder: (context,
                                                            index) =>
                                                        Skeletonizer(
                                                            enabled:
                                                                loadingSkeletonizer,
                                                            child: RequestCard(
                                                              request: Request(
                                                                  requestID: '',
                                                                  employeeName:
                                                                      '',
                                                                  employeeNumber:
                                                                      '',
                                                                  employeeImageUrl:
                                                                      '',
                                                                  requestDate:
                                                                      DateTime
                                                                          .now(),
                                                                  createdBy: '',
                                                                  requestTypeID:
                                                                      '',
                                                                  selfRequest:
                                                                      false,
                                                                  requestStatus:
                                                                      ''),
                                                            ))),
                                              )
                                            : (state
                                                    is GetPendingRequestsSuccessState && _cubit.checkUpsPendingRequests.isNotEmpty)
                                                ? Padding(
                                                    padding:
                                                        EdgeInsets.fromLTRB(
                                                            10.w,
                                                            20.h,
                                                            10.w,
                                                            0),
                                                    child: ListView.separated(
                                                        itemCount: _cubit
                                                            .checkUpsPendingRequests
                                                            .length,
                                                        separatorBuilder:
                                                            (context, index) =>
                                                                SizedBox(
                                                                  height: 10.h,
                                                                ),
                                                        itemBuilder: (context,
                                                                index) =>
                                                            Skeletonizer(
                                                                enabled:
                                                                    loadingSkeletonizer,
                                                                child:
                                                                    RequestCard(
                                                                  request: _cubit
                                                                          .checkUpsPendingRequests[
                                                                      index],
                                                                ))),
                                                  )
                                                : Image.asset(
                                                    "assets/images/couldnot_find.jpg"),


                                state is SearchInPendingRequestsErrorState
                                    ? Image.asset(
                                        "assets/images/couldnot_find.jpg")
                                    : state
                                            is SearchInPendingRequestsSuccessState
                                        ? Padding(
                                            padding: EdgeInsets.fromLTRB(
                                                10.w, 20.h, 10.w, 0),
                                            child: ListView.separated(
                                                itemCount: _cubit.searchedResult
                                                        .isNotEmpty
                                                    ? _cubit
                                                        .searchedResult.length
                                                    : _cubit
                                                        .sickLeavePendingRequests
                                                        .length,
                                                separatorBuilder:
                                                    (context, index) =>
                                                        SizedBox(
                                                          height: 10.h,
                                                        ),
                                                itemBuilder: (context, index) =>
                                                    Skeletonizer(
                                                      enabled:
                                                          loadingSkeletonizer,
                                                      child: RequestCard(
                                                        request: _cubit
                                                                .searchedResult
                                                                .isNotEmpty
                                                            ? _cubit.searchedResult[
                                                                index]
                                                            : _cubit.sickLeavePendingRequests[
                                                                index],
                                                      ),
                                                    )),
                                          ):
                                state
                                is GetPendingRequestsLoadingState
                                    ? Padding(
                                  padding: EdgeInsets.fromLTRB(
                                      10.w, 20.h, 10.w, 10.h),
                                  child: ListView.separated(
                                      itemCount: 2,
                                      separatorBuilder:
                                          (context, index) =>
                                          SizedBox(
                                            height: 10.h,
                                          ),
                                      itemBuilder: (context,
                                          index) =>
                                          Skeletonizer(
                                              enabled:
                                              loadingSkeletonizer,
                                              child: RequestCard(
                                                request: Request(
                                                    requestID: '',
                                                    employeeName:
                                                    '',
                                                    employeeNumber:
                                                    '',
                                                    employeeImageUrl:
                                                    '',
                                                    requestDate:
                                                    DateTime
                                                        .now(),
                                                    createdBy: '',
                                                    requestTypeID:
                                                    '',
                                                    selfRequest:
                                                    false,
                                                    requestStatus:
                                                    ''),
                                              ))),
                                )

                                        :( state
                                is GetPendingRequestsSuccessState && _cubit.sickLeavePendingRequests.isNotEmpty)
                                            ? Padding(
                                                padding: EdgeInsets.fromLTRB(
                                                    10.w, 20.h, 10.w, 0),
                                                child: ListView.separated(
                                                    itemCount: _cubit
                                                        .sickLeavePendingRequests
                                                        .length,
                                                    separatorBuilder:
                                                        (context, index) =>
                                                            SizedBox(
                                                              height: 10.h,
                                                            ),
                                                    itemBuilder: (context,
                                                            index) =>
                                                        Skeletonizer(
                                                            enabled:
                                                                loadingSkeletonizer,
                                                            child: RequestCard(
                                                              request: _cubit
                                                                      .sickLeavePendingRequests[
                                                                  index],
                                                            ))),
                                              )
                                            : Image.asset(
                                                "assets/images/couldnot_find.jpg"),
                              ]),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
