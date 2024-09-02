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

import '../../core/constants/app_strings.dart';
import '../../core/themes/app_colors.dart';
import '../../custom_icons.dart';
import '../../injection_container.dart';
import '../home/widgets/app_bar.dart';
import '../medical_request_details_and_doctor_response/medical_doctor_response_screen.dart';
import '../widgets/drawer_widget.dart';

class PendingRequestsScreen extends StatefulWidget {
  static const routeName = 'PendingRequestsScreen';
  const PendingRequestsScreen({super.key});

  @override
  State<PendingRequestsScreen> createState() => _PendingRequestsScreenState();
}

class _PendingRequestsScreenState extends State<PendingRequestsScreen>
    with TickerProviderStateMixin {
  late TabController _tabController;
  @override
  void initState()
  {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async{
      await PendingRequestsCubit.get(context).getPendingRequests();
    });
    _tabController = TabController(length: 3, vsync: this);
    int tabControllerIndex=0;
    _tabController.addListener(() {
      if(_tabController.index==0)
        {
          tabControllerIndex=1;
        }
      else if(_tabController.index==1)
        {
          tabControllerIndex=2;
        }
      else
        {
          tabControllerIndex=3;
        }
      PendingRequestsCubit.get(context).changeRequestTypeID(tabControllerIndex.toString());
    });
  }
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PendingRequestsCubit, PendingRequestsState>(
      listener: (context, state) {
        if(state is ChangeRequestTypeSuccessState)
          {
            PendingRequestsCubit.get(context).getPendingRequests();
          }
        if(state is GetPendingRequestsLoadingState)
        {
          loadingAlertDialog(context);
        }
        if(state is GetPendingRequestsSuccessState)
        {
          Navigator.of(context).pop();
        }
        if(state is GetMedicalRequestDetailsLoadingState)
        {
          loadingAlertDialog(context);
        }
        if (state is GetMedicalRequestDetailsSuccessState) {
          Navigator.of(context).pop();
          Navigator.pushNamedAndRemoveUntil(
              context, MedicalDoctorResponseScreen.routeName, (route) => false);
        }
      },
      builder:(context,state)
      {
        var _cubit=PendingRequestsCubit.get(context);
        return  Scaffold(
          drawer: const DrawerWidget(),
          body: SafeArea(
            child: Padding(
              padding: EdgeInsets.fromLTRB(16.w,20.h, 16.w, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  HomeAppBar(
                    title: "Pending Requests",
                    onTap:  () {
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  HomeScreen()),
                              (route) => false);
                    },
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
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
                                fontSize: 12.sp, fontFamily: "Certa Sans"),
                            controller: _cubit.searchInPendingRequestsController,
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                              hintText: AppStrings.searchByUserNumber.tr(),
                              isDense: true,
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 8.h, horizontal: 11.w),
                              fillColor: Colors.white,
                              filled: true,
                              labelStyle: TextStyle(
                                  fontSize: 16.sp, fontFamily: "Certa Sans"),
                              hintStyle: TextStyle(
                                  color: Color(0xFFB5B9B9),
                                  fontSize: 16.sp,
                                  fontFamily: "Certa Sans",
                                  fontWeight: FontWeight.w500),
                              suffixIcon: IconButton(

                                icon: Icon(Icons.clear,size: 17.r,),
                                onPressed: () {
                                  _cubit.clearSearchResult();
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
                      //This is for background color
                      //  color: Colors.white.withOpacity(0.0),
                    //  color: Color(0xFFe8f2ff),
                        //This is for bottom border that is needed
                        borderRadius: BorderRadius.circular(10.r)),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.r),
                      //  color:  Color(0xFFe8f2ff),
                      ),
                      height: 50.h,
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(4.w, 8.h, 4.w,8.h),
                        child: TabBar(
                          physics: ScrollPhysics(),
                            controller: _tabController,
                            unselectedLabelColor: AppColors.greyColor,
                            labelColor:AppColors.whiteColor ,
                            indicator: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.r),
                               // color:  Color(0xFF2c93e7),
                                gradient: LinearGradient(
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                    stops:[
                                      0.0,
                                      0.7,
                                      1
                                    ],
                                    colors: [
                                      Color(0xFF00a7ff),
                                      Color(0xFF2a64ff),
                                      Color(0xFF1980ff),
                                    ])
                            ),
                            onTap: (index) {
                              if (index == 0) {
                                _cubit.changeRequestTypeID("1");
                              }
                              else if (index == 1) {
                                _cubit.changeRequestTypeID("2");
                              }
                              else
                              {
                                _cubit.changeRequestTypeID("3");
                              }
                            },
                            tabs:
                            [
                              Tab(
                               // height: 30.h,
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10.r)),
                                  margin: EdgeInsets.zero,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("Medication",style: TextStyle(
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w600,
                                          fontFamily: "Certa Sans"
                                      ),),
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
                                          _cubit.medicationPendingRequestCount!,
                                          //  "2222",
                                            style: TextStyle(
                                                color: AppColors.whiteColor,fontSize: 12.sp,fontFamily: "Certa Sans"),
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
                                      borderRadius: BorderRadius.circular(15.r)),
                                  child: Align(
                                      alignment: Alignment.center,
                                      child: Row(
                                        children: [
                                          Text("Checkups",style: TextStyle(
                                              fontSize: 14.sp,
                                              fontWeight: FontWeight.w600,
                                              fontFamily: "Certa Sans"
                                          )),
                                          SizedBox(
                                            width: 5.w,
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
                                                _cubit.checkUpsPendingRequestCount!,
                                                style: TextStyle(
                                                    color: AppColors.whiteColor,fontSize: 12.sp,fontFamily: "Certa Sans"),
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
                                      borderRadius: BorderRadius.circular(15.r)),
                                  child: Align(
                                      alignment: Alignment.center,
                                      child: Row(
                                        children: [
                                          Text("Sick leave",style: TextStyle(
                                              fontSize: 14.sp,
                                              fontWeight: FontWeight.w600,
                                              fontFamily: "Certa Sans"
                                          )),
                                          SizedBox(
                                            width: 5.w,
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
                                                _cubit.sickLeavePendingRequestCount!,
                                                style: TextStyle(
                                                    color: AppColors.whiteColor,fontSize: 10.sp,fontFamily: "Certa Sans"),
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
                         state is ClearSearchResultSuccessState?
                          Padding(
                            padding: EdgeInsets.fromLTRB(10.w, 20.h, 10.w, 10.h),
                            child: ListView.separated(
                                itemCount:_cubit.medicationPendingRequests.length,
                                separatorBuilder: (context, index) => SizedBox(
                                  height: 10.h,
                                ),
                                itemBuilder: (context, index) =>
                                    RequestCard(request:_cubit.medicationPendingRequests[index],)),
                          ):
                          Padding(
                            padding: EdgeInsets.fromLTRB(10.w, 20.h, 10.w, 10.h),
                            child: ListView.separated(
                                itemCount:_cubit.searchedResult.isNotEmpty?
                                _cubit.searchedResult.length
                                :_cubit.medicationPendingRequests.length,
                                separatorBuilder: (context, index) => SizedBox(
                                  height: 0.h,
                                ),
                                itemBuilder: (context, index) =>
                                    RequestCard(request: _cubit.searchedResult.isNotEmpty?
                                    _cubit.searchedResult[index]:_cubit.medicationPendingRequests[index],)),
                          ),
                          state is ClearSearchResultSuccessState?
                          Padding(
                            padding: EdgeInsets.fromLTRB(10.w, 20.h, 10.w, 0),
                            child: ListView.separated(
                                itemCount: _cubit.checkUpsPendingRequests.length,
                                separatorBuilder: (context, index) => SizedBox(
                                  height: 10.h,
                                ),
                                itemBuilder: (context, index) =>
                                    RequestCard(request: _cubit.checkUpsPendingRequests[index],)),
                          ):
                          Padding(
                            padding: EdgeInsets.fromLTRB(10.w, 20.h, 10.w, 0),
                            child: ListView.separated(
                                itemCount: _cubit.searchedResult.isNotEmpty?
                                _cubit.searchedResult.length: _cubit.checkUpsPendingRequests.length,
                                separatorBuilder: (context, index) => SizedBox(
                                  height: 10.h,
                                ),
                                itemBuilder: (context, index) =>
                                    RequestCard(request:_cubit.searchedResult.isNotEmpty?
                                    _cubit.searchedResult[index]: _cubit.checkUpsPendingRequests[index],)),
                          ),
                          state is ClearSearchResultSuccessState?
                          Padding(
                            padding: EdgeInsets.fromLTRB(10.w, 20.h, 10.w, 0),
                            child: ListView.separated(
                                itemCount: _cubit.sickLeavePendingRequests.length,
                                separatorBuilder: (context, index) => SizedBox(
                                  height: 10.h,
                                ),
                                itemBuilder: (context, index) =>
                                    RequestCard(request: _cubit.sickLeavePendingRequests[index],)),
                          ):
                          Padding(
                            padding: EdgeInsets.fromLTRB(10.w, 20.h, 10.w, 0),
                            child: ListView.separated(
                                itemCount: _cubit.searchedResult.isNotEmpty?
                                _cubit.searchedResult.length: _cubit.sickLeavePendingRequests.length,
                                separatorBuilder: (context, index) => SizedBox(
                                  height: 10.h,
                                ),
                                itemBuilder: (context, index) =>
                                    RequestCard(request:_cubit.searchedResult.isNotEmpty?
                                    _cubit.searchedResult[index]: _cubit.sickLeavePendingRequests[index],)),
                          ),
                        ]),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
