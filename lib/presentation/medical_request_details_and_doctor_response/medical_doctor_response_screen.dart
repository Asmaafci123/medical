import 'package:auto_size_text/auto_size_text.dart';
import 'package:badges/badges.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:more4u/custom_icons.dart';
import 'package:badges/badges.dart' as bg;
import 'package:more4u/presentation/medical_request_details_and_doctor_response/widgets/gallery_strings.dart';
import 'package:more4u/presentation/medical_request_details_and_doctor_response/widgets/requested_by_info_2.dart';
import 'package:more4u/presentation/medical_request_details_and_doctor_response/widgets/resone_and_comment_widget.dart';
import 'package:more4u/presentation/pending_requests/pending_requests_screen.dart';
import 'package:more4u/presentation/widgets/utils/loading_dialog.dart';
import 'package:simple_shadow/simple_shadow.dart';
import 'package:toast/toast.dart';
import '../../core/constants/app_strings.dart';
import '../../core/themes/app_colors.dart';
import '../../core/utils/flutter_chips/src/chips_input.dart';
import '../../domain/entities/details-of-medical.dart';
import '../home/widgets/app_bar.dart';
import '../pending_requests/cubits/pending_requests_cubit.dart';
import '../pending_requests/cubits/pending_requests_state.dart';
import '../widgets/drawer_widget.dart';
import '../widgets/utils/message_dialog.dart';

class MedicalDoctorResponseScreen extends StatefulWidget {
  static const routeName = 'MedicalDoctorResponseScreen';
  const MedicalDoctorResponseScreen({super.key});

  @override
  State<MedicalDoctorResponseScreen> createState() =>
      _MedicalDoctorResponseScreenState();
}

class _MedicalDoctorResponseScreenState
    extends State<MedicalDoctorResponseScreen> with TickerProviderStateMixin {
  late double _keyboardSize;
  late TabController _tabController;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    setState(() {
      _keyboardSize = MediaQuery.of(context).viewInsets.bottom;
    });
  }

  @override
  void dispose() {
    PendingRequestsCubit.get(context).clearCurrentRequestData();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    PendingRequestsCubit.get(context).clearCurrentRequestData();
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _chipKey1 = GlobalKey<ChipsInputState>();
  final _chipKey2 = GlobalKey<ChipsInputState>();
  @override
  Widget build(BuildContext context) {
    var _cubit = PendingRequestsCubit.get(context);
    ToastContext().init(context);
    return BlocConsumer<PendingRequestsCubit, PendingRequestsState>(
      listener: (context, state) {
        if (state is SendDoctorResponseLoadingState) {
          loadingAlertDialog(context);
        }
        if (state is SendDoctorResponseSuccessState) {
          Navigator.pop(context);
          showMessageDialog(
              context: context,
              isSucceeded: true,
              message:
                  "${AppStrings.receivedYourResponse.tr()} ${_cubit.medicalRequestDetails?.medicalRequestId ?? 0}.",
              onPressedOk: () {
                Navigator.pushNamedAndRemoveUntil(
                    context, PendingRequestsScreen.routeName, (route) => false);
              });
        }
        if (state is SendDoctorResponseErrorState) {
          Navigator.pop(context);
          Toast.show(" ${state.message}",
              duration: Toast.lengthLong, gravity: Toast.top);
        }

        if (state is SearchInMedicalItemsLoadingState) {
          loadingAlertDialog(context);
        }
        if (state is GetMedicalRequestDetailsSuccessState) {
          Navigator.pop(context);
        }
        if (state is SearchInMedicalItemsErrorState) {}
        if (state is AddMedicalItemSuccessState) {}
        if (state is ClearSearchResultMedicalItemsSuccessState) {}
      },
      builder: (context, state) {
        var employeeCoverage = double.parse(_cubit
                    .medicalRequestDetails?.medicalRequest?.employeeCoverage
                    ?.split("%")[0] ??
                "0") /
            100;
        return Scaffold(
          backgroundColor: Color(0xFFf2f2f2),
          resizeToAvoidBottomInset: true,
          drawer: const DrawerWidget(),
          body: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(16.w, 20.h, 16.w, 0),
                  child: Column(
                    children: [
                      HomeAppBar(
                        title: AppStrings.mangeRequest.tr(),
                        onTap: () {
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      PendingRequestsScreen()),
                              (route) => false);
                        },
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      RequestedByInfo1(
                        requestDate: _cubit
                            .medicalRequestDetails?.medicalRequest?.requestDate,
                        employeeCoverage: employeeCoverage,
                        requestedByName: _cubit
                            .medicalRequestDetails?.medicalRequest?.requestedBy,
                        requestedByDepartment: _cubit.medicalRequestDetails
                            ?.medicalRequest?.employeeDepartment,
                        phoneNumber: _cubit.medicalRequestDetails
                            ?.medicalRequest?.employeePhoneNumber,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
                Expanded(
                    child: Container(
                  decoration: BoxDecoration(
                    //   color:Color(0xFFf8f4f0),
                    color: AppColors.whiteColor,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(25.r),
                      topLeft: Radius.circular(25.r),
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(16.w, 20.h, 16.w, 10.h),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          DecoratedBox(
                            decoration: BoxDecoration(
                                //This is for background color
                                //  color: Colors.white.withOpacity(0.0),
                                color: Color(0xFFf8f4f0),
                                //This is for bottom border that is needed
                                borderRadius: BorderRadius.circular(10.r)),
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.r),
                                  color: Color(0xFF2c93e7)),
                              height: 50.h,
                              child: Padding(
                                padding:
                                    EdgeInsets.fromLTRB(4.w, 8.h, 4.w, 8.h),
                                child: TabBar(
                                    controller: _tabController,
                                    unselectedLabelColor: AppColors.whiteColor,
                                    labelColor: Color(0xFF2c93e7),
                                    indicator: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(10.r),
                                        color: AppColors.whiteColor),
                                    onTap: (index) {},
                                    tabs: [
                                      Tab(
                                        height: 30.h,
                                        child: Container(
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(15.r)),
                                          child: Align(
                                              alignment: Alignment.center,
                                              child: Text(
                                                AppStrings.request.tr(),
                                                style: TextStyle(
                                                  fontSize: 18.sp,
                                                  fontWeight: FontWeight.w600,
                                                  fontFamily: "Certa Sans",
                                                ),
                                              )),
                                        ),
                                      ),
                                      Tab(
                                        height: 35.h,
                                        child: Container(
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(15.r)),
                                          child: Align(
                                              alignment: Alignment.center,
                                              child: Text(
                                                  AppStrings.response.tr(),
                                                  style: TextStyle(
                                                    fontSize: 18.sp,
                                                    fontWeight: FontWeight.w600,
                                                    fontFamily: "Certa Sans",
                                                  ))),
                                        ),
                                      ),
                                    ]),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20.h,
                          ),
                          SizedBox(
                            height: 330.h,
                            child: TabBarView(
                                physics: NeverScrollableScrollPhysics(),
                                controller: _tabController,
                                children: [
                                  SingleChildScrollView(
                                    child: Column(children: [
                                      Container(
                                        color: AppColors.greyText,
                                        width: double.infinity,
                                        child: Padding(
                                          padding: EdgeInsets.fromLTRB(
                                              8.w, 6.h, 8.w, 6.h),
                                          child: Text(
                                            "${AppStrings.id.tr()} ${_cubit.medicalRequestDetails?.medicalRequestId ?? ""}",
                                            style: TextStyle(
                                                color: AppColors.whiteColor,
                                                //  color: Color(0xFF2c93e7),
                                                fontFamily: "Certa Sans",
                                                fontSize: 18.sp,
                                                fontWeight: FontWeight.w700),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        color: Color(0xFFf8f4f0),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            children: [
                                              Row(
                                                children: [
                                                  SizedBox(
                                                    width: 100.w,
                                                    child: Text(
                                                      AppStrings.createdBy.tr(),
                                                      style: TextStyle(
                                                          color: AppColors
                                                              .greyColor,
                                                          fontSize: 14.sp,
                                                          fontFamily:
                                                              "Certa Sans",
                                                          fontWeight:
                                                              FontWeight.w600),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    child: Text(
                                                      _cubit
                                                              .medicalRequestDetails
                                                              ?.medicalRequest
                                                              ?.createdBy ??
                                                          "",
                                                      style: TextStyle(
                                                          color: AppColors
                                                              .mainColor,
                                                          fontSize: 16.sp,
                                                          fontFamily:
                                                              "Certa Sans",
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          overflow: TextOverflow
                                                              .ellipsis),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                height: 8.h,
                                              ),
                                              Container(
                                                color: AppColors.greyColor,
                                                height: 0.1.h,
                                              ),
                                              SizedBox(
                                                height: 8.h,
                                              ),
                                              _cubit
                                                          .details
                                                          ?.medicalRequestDetails
                                                          ?.medicalRequest
                                                          ?.relation !=
                                                      AppStrings.self.tr()
                                                  ? Row(
                                                      children: [
                                                        SizedBox(
                                                          width: 100.w,
                                                          child: Text(
                                                            AppStrings.relation
                                                                .tr(),
                                                            style: TextStyle(
                                                                color: AppColors
                                                                    .greyColor,
                                                                fontSize: 14.sp,
                                                                fontFamily:
                                                                    "Certa Sans",
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600),
                                                          ),
                                                        ),
                                                        Expanded(
                                                          child: Text(
                                                            _cubit
                                                                    .medicalRequestDetails
                                                                    ?.medicalRequest
                                                                    ?.relation ??
                                                                "",
                                                            style: TextStyle(
                                                                color: AppColors
                                                                    .mainColor,
                                                                fontSize: 16.sp,
                                                                fontFamily:
                                                                    "Certa Sans",
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis),
                                                          ),
                                                        ),
                                                      ],
                                                    )
                                                  : SizedBox(),
                                              _cubit
                                                          .medicalRequestDetails
                                                          ?.medicalRequest
                                                          ?.relation !=
                                                      AppStrings.self.tr()
                                                  ? Column(
                                                      children: [
                                                        SizedBox(
                                                          height: 8.h,
                                                        ),
                                                        Container(
                                                          color: AppColors
                                                              .greyColor,
                                                          height: 0.1.h,
                                                        ),
                                                        SizedBox(
                                                          height: 8.h,
                                                        ),
                                                        Row(
                                                          children: [
                                                            SizedBox(
                                                              width: 100.w,
                                                              child: Text(
                                                                AppStrings
                                                                    .relativeName
                                                                    .tr(),
                                                                style: TextStyle(
                                                                    color: AppColors
                                                                        .greyColor,
                                                                    fontSize:
                                                                        14.sp,
                                                                    fontFamily:
                                                                        "Certa Sans",
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600),
                                                              ),
                                                            ),
                                                            Expanded(
                                                              child: Text(
                                                                _cubit
                                                                        .medicalRequestDetails
                                                                        ?.medicalRequest
                                                                        ?.requestedFor ??
                                                                    "",
                                                                style: TextStyle(
                                                                    color: AppColors
                                                                        .mainColor,
                                                                    fontSize:
                                                                        16.sp,
                                                                    fontFamily:
                                                                        "Certa Sans",
                                                                    overflow:
                                                                        TextOverflow
                                                                            .ellipsis,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        SizedBox(
                                                          height: 8.h,
                                                        ),
                                                        Container(
                                                          color: AppColors
                                                              .greyColor,
                                                          height: 0.1.h,
                                                        ),
                                                        SizedBox(
                                                          height: 8.h,
                                                        ),
                                                      ],
                                                    )
                                                  : SizedBox(),
                                              Row(
                                                children: [
                                                  SizedBox(
                                                    width: 100.w,
                                                    child: Text(
                                                      AppStrings.medicalEntity
                                                          .tr(),
                                                      style: TextStyle(
                                                          color: AppColors
                                                              .greyColor,
                                                          fontSize: 14.sp,
                                                          fontFamily:
                                                              "Certa Sans",
                                                          fontWeight:
                                                              FontWeight.w600),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    child: Text(
                                                      _cubit
                                                              .medicalRequestDetails
                                                              ?.medicalRequest
                                                              ?.medicalEntity ??
                                                          "",
                                                      style: TextStyle(
                                                          color: AppColors
                                                              .mainColor,
                                                          fontSize: 16.sp,
                                                          fontFamily:
                                                              "Certa Sans",
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          overflow: TextOverflow
                                                              .ellipsis),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                height: 8.h,
                                              ),
                                              Container(
                                                color: AppColors.greyColor,
                                                height: 0.1.h,
                                              ),
                                              SizedBox(
                                                height: 8.h,
                                              ),
                                              _cubit
                                                          .details
                                                          ?.medicalRequestDetails
                                                          ?.medicalRequest
                                                          ?.requestType !=
                                                      1
                                                  ? Column(
                                                      children: [
                                                        Row(
                                                          children: [
                                                            SizedBox(
                                                              width: 100.w,
                                                              child: Text(
                                                                AppStrings
                                                                    .medicalPurpose
                                                                    .tr(),
                                                                style: TextStyle(
                                                                    color: AppColors
                                                                        .greyColor,
                                                                    fontSize:
                                                                        14.sp,
                                                                    fontFamily:
                                                                        "Certa Sans",
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600),
                                                              ),
                                                            ),
                                                            Expanded(
                                                              child: Text(
                                                                _cubit
                                                                        .medicalRequestDetails
                                                                        ?.medicalRequest
                                                                        ?.medicalPurpose ??
                                                                    "_",
                                                                style: TextStyle(
                                                                    color: AppColors
                                                                        .mainColor,
                                                                    fontSize:
                                                                        16.sp,
                                                                    fontFamily:
                                                                        "Certa Sans",
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600,
                                                                    overflow:
                                                                        TextOverflow
                                                                            .ellipsis),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        SizedBox(
                                                          height: 8.h,
                                                        ),
                                                        Container(
                                                          color: AppColors
                                                              .greyColor,
                                                          height: 0.1.h,
                                                        ),
                                                        SizedBox(
                                                          height: 8.h,
                                                        ),
                                                      ],
                                                    )
                                                  : SizedBox(),
                                              Row(
                                                children: [
                                                  SizedBox(
                                                    width: 100.w,
                                                    child: Text(
                                                      AppStrings.requestComment
                                                          .tr(),
                                                      style: TextStyle(
                                                          color: AppColors
                                                              .greyColor,
                                                          fontSize: 14.sp,
                                                          fontFamily:
                                                              "Certa Sans",
                                                          fontWeight:
                                                              FontWeight.w600),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    child: Text(
                                                      _cubit
                                                              .medicalRequestDetails
                                                              ?.medicalRequest
                                                              ?.comment ??
                                                          "_",
                                                      style: TextStyle(
                                                        color:
                                                            AppColors.mainColor,
                                                        fontSize: 16.sp,
                                                        fontFamily:
                                                            "Certa Sans",
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        // overflow: TextOverflow.ellipsis
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 20.h,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            AppStrings.documents.tr(),
                                            style: TextStyle(
                                                color: AppColors.mainColor,
                                                fontSize: 18.sp,
                                                fontFamily: "Certa Sans",
                                                fontWeight: FontWeight.w500),
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              if (_cubit
                                                      .medicalRequestDetails
                                                      ?.medicalRequest
                                                      ?.attachment !=
                                                  null) {
                                                Navigator.of(context).push(
                                                    MaterialPageRoute(
                                                        builder: (_) =>
                                                            GalleryString(
                                                              images: _cubit
                                                                      .medicalRequestDetails
                                                                      ?.medicalRequest
                                                                      ?.attachment ??
                                                                  [],
                                                              index: 1,
                                                            )));
                                              }
                                            },
                                            child: Text(
                                              AppStrings.seeAll.tr(),
                                              style: TextStyle(
                                                  decoration:
                                                      TextDecoration.underline,
                                                  color: AppColors.greyColor,
                                                  fontSize: 16.sp,
                                                  fontFamily: "Certa Sans",
                                                  fontWeight: FontWeight.w200),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 10.h,
                                      ),
                                      SizedBox(
                                          height: 100.h,
                                          child: ListView.separated(
                                              scrollDirection: Axis.horizontal,
                                              itemBuilder: (context, index) =>
                                                  Card(
                                                    elevation: 5,
                                                    child: Image.network(
                                                      _cubit
                                                              .medicalRequestDetails
                                                              ?.medicalRequest
                                                              ?.attachment?[index] ??
                                                          "",
                                                      errorBuilder: (context,
                                                          error, stackTrace) {
                                                        return Image.network(
                                                            "https://www.businessleague.in/wp-content/uploads/2022/09/kerla.jpg");
                                                      },
                                                      fit: BoxFit.fill,
                                                      width: 100.w,
                                                    ),
                                                  ),
                                              separatorBuilder:
                                                  (context, index) => SizedBox(
                                                        width: 5.w,
                                                      ),
                                              itemCount: _cubit
                                                      .medicalRequestDetails
                                                      ?.medicalRequest
                                                      ?.attachment
                                                      ?.length ??
                                                  0))
                                    ]),
                                  ),
                                  SingleChildScrollView(
                                    physics: ScrollPhysics(),
                                    child: Form(
                                      key: _formKey,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            AppStrings.medicalEntity.tr(),
                                            style: TextStyle(
                                                color: AppColors.blackColor,
                                                fontWeight: FontWeight.w600,
                                                fontSize: 18.sp,
                                                fontFamily: "Certa Sans"),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.fromLTRB(
                                                0, 20.h, 0, 20.h),
                                            child: ChipsInput<DetailsOfMedical>(
                                              key: _chipKey1,
                                              maxChips: 1,
                                              // enabled: true,
                                              initialValue:
                                                  _cubit.selectedMedicalEntity !=
                                                          null
                                                      ? [
                                                          _cubit
                                                              .selectedMedicalEntity!
                                                        ]
                                                      : [],
                                              textStyle: TextStyle(
                                                fontSize: 12.sp,
                                                height: 1,
                                                fontWeight: FontWeight.w400,
                                                color: AppColors.mainColor,
                                              ),
                                              enabled:
                                                  _cubit.selectedMedicalEntity !=
                                                          null
                                                      ? false
                                                      : true,
                                              allowChipEditing: true,
                                              decoration: InputDecoration(
                                                isDense: true,
                                                suffixIconConstraints:
                                                    BoxConstraints(
                                                        maxHeight: 10.h,
                                                        minWidth: 50.w),
                                                contentPadding:
                                                    EdgeInsets.symmetric(
                                                  vertical: 10.0,
                                                  horizontal: 0.0,
                                                ),
                                                prefixIcon: Icon(
                                                  CustomIcons.home__2_,
                                                  size: 20.r,
                                                ),
                                                border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          15.0.r),
                                                ),
                                                labelText: AppStrings
                                                    .medicalEntity
                                                    .tr(),
                                                labelStyle:
                                                    TextStyle(fontSize: 14.sp),
                                                hintText: AppStrings
                                                    .medicalEntity
                                                    .tr(),
                                                hintStyle: TextStyle(
                                                    color:
                                                        const Color(0xffc1c1c1),
                                                    fontSize: 12.sp),
                                                errorStyle:
                                                    TextStyle(fontSize: 12.sp),
                                                //  errorText: _cubit.lowParticipantError,
                                                floatingLabelBehavior:
                                                    FloatingLabelBehavior
                                                        .always,
                                              ),
                                              findSuggestions: (String query) {
                                                if (query.length > 1) {
                                                  var lowercaseQuery =
                                                      query.toLowerCase();
                                                  return _cubit.medicalEntities!
                                                      .where((profile) {
                                                    return profile
                                                            .medicalDetailsName!
                                                            .toLowerCase()
                                                            .contains(query
                                                                .toLowerCase()) ||
                                                        profile
                                                            .medicalDetailsName
                                                            .toString()
                                                            .toLowerCase()
                                                            .contains(query
                                                                .toLowerCase());
                                                  }).toList(growable: false)
                                                    ..sort((a, b) => a
                                                        .medicalDetailsName!
                                                        .toLowerCase()
                                                        .indexOf(lowercaseQuery)
                                                        .compareTo(b
                                                            .medicalDetailsName!
                                                            .toLowerCase()
                                                            .indexOf(
                                                                lowercaseQuery)));
                                                } else {
                                                  return const <DetailsOfMedical>[];
                                                }
                                              },
                                              // onChanged: _cubit.participantsOnChange,
                                              onChanged: (List<DetailsOfMedical>
                                                  value) {
                                                _cubit.changeMedicalEntity(
                                                    value[0]);
                                              },
                                              chipBuilder:
                                                  (context, state, profile) {
                                                return InputChip(
                                                  onDeleted: () {
                                                    state.deleteChip(profile);
                                                    _cubit.changeMedicalEntity(
                                                        null);
                                                  },
                                                  padding: EdgeInsets.zero,
                                                  deleteIconColor:
                                                      AppColors.mainColor,
                                                  labelStyle: TextStyle(
                                                      fontSize: 14.sp,
                                                      fontWeight:
                                                          FontWeight.normal,
                                                      color:
                                                          AppColors.mainColor),
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15.r),
                                                    side: BorderSide(
                                                        color:
                                                            Color(0xFFC1C1C1)),
                                                  ),
                                                  backgroundColor:
                                                      Color(0xFFE7E7E7),
                                                  key: ObjectKey(profile),
                                                  label: Text(
                                                    profile.medicalDetailsName ??
                                                        "",
                                                    style: TextStyle(
                                                        fontSize: 12.sp),
                                                  ),
                                                  // onDeleted: () {
                                                  //   _cubit.participantOnRemove(profile);
                                                  //   state.forceDeleteChip(profile);
                                                  // },
                                                  materialTapTargetSize:
                                                      MaterialTapTargetSize
                                                          .shrinkWrap,
                                                );
                                              },
                                              suggestionBuilder:
                                                  (context, state, profile) {
                                                return ListTile(
                                                  key: ObjectKey(profile),
                                                  leading: CircleAvatar(
                                                    backgroundImage: AssetImage(
                                                        'assets/images/profile_avatar_placeholder.png'),
                                                  ),
                                                  title: Text(
                                                      profile.medicalDetailsName ??
                                                          "",
                                                      style: TextStyle(
                                                          fontSize: 12.sp)),
                                                  subtitle: Text(profile
                                                      .medicalDetailsName
                                                      .toString()),
                                                  onTap: () =>
                                                      state.selectSuggestion(
                                                          profile),
                                                );
                                              },
                                            ),
                                          ),
                                          _cubit.validateOnChipsKeyMedicalEntity(
                                                  _chipKey1
                                                          .currentState
                                                          ?.currentTextEditingValue
                                                          .text
                                                          .length ??
                                                      0)
                                              ? SizedBox()
                                              : Padding(
                                                  padding: EdgeInsets.only(
                                                      top: 0.h,
                                                      left: 10.w,
                                                      bottom: 10.h),
                                                  child: Text(
                                                    AppStrings.required.tr(),
                                                    style: TextStyle(
                                                        fontSize: 14.sp,
                                                        fontFamily:
                                                            "Certa Sans",
                                                        color:
                                                            AppColors.redColor),
                                                  ),
                                                ),
                                          _cubit.medicalItems != null
                                              ? Column(
                                                  children: [
                                                    Text(
                                                      AppStrings.medicalItems
                                                          .tr(),
                                                      style: TextStyle(
                                                          color: AppColors
                                                              .blackColor,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          fontSize: 18.sp,
                                                          fontFamily:
                                                              "Certa Sans"),
                                                    ),
                                                    SizedBox(
                                                      height: 10.h,
                                                    ),
                                                    InkWell(
                                                      onTap: () {
                                                        showDialog(
                                                            barrierDismissible:
                                                                false,
                                                            context: context,
                                                            builder:
                                                                (BuildContext
                                                                    context) {
                                                              return AlertDialog(
                                                                shape: RoundedRectangleBorder(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            10.r)),
                                                                scrollable:
                                                                    true,
                                                                title: Row(
                                                                  children: [
                                                                    Text(
                                                                      AppStrings
                                                                          .medicalItems
                                                                          .tr(),
                                                                    ),
                                                                    Spacer(),
                                                                    BlocBuilder<
                                                                        PendingRequestsCubit,
                                                                        PendingRequestsState>(
                                                                      builder:
                                                                          (context,
                                                                              state) {
                                                                        return bg
                                                                            .Badge(
                                                                          showBadge:
                                                                              true,
                                                                          ignorePointer:
                                                                              true,
                                                                          position: BadgePosition.bottomEnd(
                                                                              bottom: 0,
                                                                              end: 0),
                                                                          badgeColor:
                                                                              AppColors.redColor,
                                                                          padding:
                                                                              EdgeInsets.all(0),
                                                                          badgeContent:
                                                                              Container(
                                                                            decoration:
                                                                                BoxDecoration(shape: BoxShape.circle),
                                                                            width:
                                                                                25.w,
                                                                            height:
                                                                                25.h,
                                                                            child:
                                                                                AutoSizeText(
                                                                              _cubit.selectedMedicalItems.length.toString(),
                                                                              maxLines: 1,
                                                                              wrapWords: false,
                                                                              textAlign: TextAlign.center,
                                                                              minFontSize: 9,
                                                                              style: TextStyle(color: Colors.white, fontSize: 22.sp, fontWeight: FontWeight.bold),
                                                                            ),
                                                                          ),
                                                                          child:
                                                                              Material(
                                                                            borderRadius:
                                                                                BorderRadius.circular(150.r),
                                                                            clipBehavior:
                                                                                Clip.antiAlias,
                                                                            color:
                                                                                Colors.transparent,
                                                                            child:
                                                                                IconButton(
                                                                              onPressed: () {},
                                                                              iconSize: 30.w,
                                                                              icon: SimpleShadow(
                                                                                  offset: Offset(0, 4),
                                                                                  color: Colors.black.withOpacity(0.25),
                                                                                  child: Image.asset(
                                                                                    "assets/images/drugs.png",
                                                                                    width: 50.w,
                                                                                  )),
                                                                            ),
                                                                          ),
                                                                        );
                                                                      },
                                                                    ),
                                                                  ],
                                                                ),
                                                                content: BlocBuilder<
                                                                    PendingRequestsCubit,
                                                                    PendingRequestsState>(
                                                                  builder:
                                                                      (context,
                                                                          state) {
                                                                    return Form(
                                                                      child:
                                                                          Column(
                                                                        children: [
                                                                          SizedBox(
                                                                            width:
                                                                                280,
                                                                            child:
                                                                                Row(
                                                                              children: [
                                                                                SizedBox(
                                                                                  width: 230,
                                                                                  child: TextField(
                                                                                    style: TextStyle(fontSize: 12.sp, fontFamily: "Certa Sans"),
                                                                                    controller: _cubit.searchInMedicalItemsController,
                                                                                    keyboardType: TextInputType.text,
                                                                                    decoration: InputDecoration(
                                                                                      hintText: AppStrings.searchInMedicalItems.tr(),
                                                                                      isDense: true,
                                                                                      contentPadding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 11.w),
                                                                                      fillColor: Colors.white,
                                                                                      filled: true,
                                                                                      labelStyle: TextStyle(fontSize: 16.sp, fontFamily: "Certa Sans"),
                                                                                      hintStyle: TextStyle(color: Color(0xFFB5B9B9), fontSize: 16.sp, fontFamily: "Certa Sans", fontWeight: FontWeight.w500),
                                                                                      suffixIcon: IconButton(
                                                                                        icon: Icon(
                                                                                          Icons.clear,
                                                                                          size: 17.r,
                                                                                        ),
                                                                                        onPressed: () {
                                                                                          _cubit.clearSearchResultInMedicalItems();
                                                                                        },
                                                                                      ),
                                                                                      enabledBorder: OutlineInputBorder(
                                                                                        borderSide: BorderSide(color: AppColors.whiteGreyColor),
                                                                                        borderRadius: BorderRadius.circular(15.r),
                                                                                      ),
                                                                                      focusedBorder: OutlineInputBorder(
                                                                                        borderSide: BorderSide(color: AppColors.whiteGreyColor),
                                                                                        borderRadius: BorderRadius.circular(15.r),
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                                Spacer(),
                                                                                InkWell(
                                                                                  borderRadius: BorderRadius.circular(15.r),
                                                                                  onTap: () {
                                                                                    _cubit.searchInMedicalItems();
                                                                                  },
                                                                                  child: Ink(
                                                                                    width: 38.w,
                                                                                    height: 40.w,
                                                                                    decoration: BoxDecoration(
                                                                                        color: Color(0xFFe8f2ff),
                                                                                        boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 10)],
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
                                                                          ),
                                                                          _cubit.searchedMedicalItems.isNotEmpty
                                                                              ? Column(
                                                                                children: [
                                                                                  // SizedBox(
                                                                                  //   height: 10.h,
                                                                                  // ),
                                                                                  // Divider(
                                                                                  //   indent: 50,
                                                                                  //   endIndent: 50,
                                                                                  //   color: AppColors.greyColor,
                                                                                  //   height: 2,
                                                                                  // ),
                                                                                  SizedBox(
                                                                                      height: 300.h,
                                                                                      width: 300.w,
                                                                                      child: Padding(
                                                                                        padding: EdgeInsets.only(top: 10.h),
                                                                                        child: ListView.separated(
                                                                                            itemBuilder: (context, index) => InkWell(
                                                                                                  onTap: () {
                                                                                                    _cubit.addMedicalItems(_cubit.searchedMedicalItems[index], index);
                                                                                                  },
                                                                                                  child: SizedBox(
                                                                                                    width: 270.w,
                                                                                                    child: Card(
                                                                                                      elevation: 5,
                                                                                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r), side: BorderSide(color: _cubit.medicalItemsColor[index], width: 1.5.w)),
                                                                                                      child: Padding(
                                                                                                        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
                                                                                                        child: Column(
                                                                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                                                                          children: [
                                                                                                            Text(_cubit.searchedMedicalItems[index].itemName ?? "", style: TextStyle(color: AppColors.blackColor, fontWeight: FontWeight.w600, fontSize: 18.sp, fontFamily: "Certa Sans")),
                                                                                                            SizedBox(
                                                                                                              height: 5.h,
                                                                                                            ),
                                                                                                            Text(_cubit.searchedMedicalItems[index].itemType ?? "", style: TextStyle(color: AppColors.greyDark, fontWeight: FontWeight.w200, fontSize: 16.sp, fontFamily: "Certa Sans")),
                                                                                                          ],
                                                                                                        ),
                                                                                                      ),
                                                                                                    ),
                                                                                                  ),
                                                                                                ),
                                                                                            separatorBuilder: (context, index) => SizedBox(
                                                                                                  height: 5.h,
                                                                                                ),
                                                                                            itemCount: _cubit.searchedMedicalItems.length),
                                                                                      ),
                                                                                    ),
                                                                                ],
                                                                              )
                                                                              : Column(
                                                                                  children: [
                                                                                    SizedBox(
                                                                                      height: 20.h,
                                                                                    ),
                                                                                    Text(
                                                                                      AppStrings.noDataAvailable.tr(),
                                                                                      style: TextStyle(color: AppColors.greyDark, fontWeight: FontWeight.w600, fontSize: 16.sp, fontFamily: "Certa Sans"),
                                                                                    ),
                                                                                  ],
                                                                                ),
                                                                          SizedBox(
                                                                            height:
                                                                                20.h,
                                                                          ),
                                                                          InkWell(
                                                                            onTap:
                                                                                () {
                                                                              Navigator.pop(context);
                                                                            },
                                                                            child:
                                                                                Container(
                                                                              decoration: BoxDecoration(
                                                                                  borderRadius: BorderRadius.circular(10.r),
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
                                                                              child: Padding(
                                                                                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
                                                                                child: Text(AppStrings.close.tr(), style: TextStyle(color: AppColors.whiteColor, fontWeight: FontWeight.w600, fontSize: 18.sp, fontFamily: "Certa Sans")),
                                                                              ),
                                                                            ),
                                                                          )
                                                                        ],
                                                                      ),
                                                                    );
                                                                  },
                                                                ),
                                                              );
                                                            });
                                                      },
                                                      child: Container(
                                                        height: 80.h,
                                                        width: 80.w,
                                                        decoration: BoxDecoration(
                                                            border: Border.all(
                                                                color: AppColors
                                                                    .blackColor,
                                                                width: 0.3),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10.r)),
                                                        child: Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Image.asset(
                                                              "assets/images/select_items_2.png",
                                                              width: 40.w,
                                                            ),
                                                            SizedBox(
                                                              height: 10.h,
                                                            ),
                                                            Text(
                                                              AppStrings.select
                                                                  .tr(),
                                                              style: TextStyle(
                                                                  color: AppColors
                                                                      .greyDark,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  fontSize:
                                                                      16.sp,
                                                                  fontFamily:
                                                                      "Certa Sans"),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                )
                                              : SizedBox(),
                                          _cubit.selectedMedicalItems.isNotEmpty
                                              ? Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    SizedBox(
                                                      height: 10.h,
                                                    ),
                                                    Divider(
                                                      endIndent: 100,
                                                      indent: 100,
                                                      color: AppColors.greyDark,
                                                    ),
                                                    SizedBox(
                                                      height: 10.h,
                                                    ),
                                                    Text(
                                                      "${AppStrings.selectedItems.tr()}( ${_cubit.selectedMedicalItems.length} )",
                                                      style: TextStyle(
                                                          color: AppColors
                                                              .blackColor,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          fontSize: 18.sp,
                                                          fontFamily:
                                                              "Certa Sans"),
                                                    ),
                                                    SizedBox(
                                                      height: 5.h,
                                                    ),
                                                    Column(
                                                      children: List.generate(
                                                          _cubit
                                                              .selectedMedicalItems
                                                              .length,
                                                          (index) => Stack(
                                                                alignment:
                                                                    Alignment
                                                                        .topRight,
                                                                children: [
                                                                  Card(
                                                                    shape:
                                                                        RoundedRectangleBorder(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              15.r),
                                                                    ),
                                                                    child:
                                                                        Container(
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        color: Color(
                                                                            0xFFf8f4f0),
                                                                        borderRadius:
                                                                            BorderRadius.circular(15.r),
                                                                      ),
                                                                      child:
                                                                          Padding(
                                                                        padding:
                                                                            const EdgeInsets.all(8.0),
                                                                        child:
                                                                            IntrinsicHeight(
                                                                          child:
                                                                              Row(
                                                                            children: [
                                                                              IconButton(
                                                                                  padding: EdgeInsets.only(bottom: 10.h),
                                                                                  onPressed: () {
                                                                                    if (int.parse(_cubit.selectedMedicalItems[index].itemQuantity ?? "0") > 1) {
                                                                                      _cubit.minusMedicalItemQuantity(index);
                                                                                    }
                                                                                  },
                                                                                  icon: Icon(
                                                                                    Icons.minimize_outlined,
                                                                                    color: AppColors.whiteBlueColor,
                                                                                    size: 20.r,
                                                                                  )),
                                                                              VerticalDivider(
                                                                                indent: 5.h,
                                                                                endIndent: 5.h,
                                                                                color: AppColors.greyColor,
                                                                                thickness: 0.2,
                                                                              ),
                                                                              Spacer(),
                                                                              Column(
                                                                                children: [
                                                                                  SizedBox(
                                                                                    width: 180.w,
                                                                                    child: Text(_cubit.selectedMedicalItems[index].itemName ?? "", style: TextStyle(color: AppColors.whiteBlueColor, fontSize: 18.sp, fontWeight: FontWeight.w600), textAlign: TextAlign.center),
                                                                                  ),
                                                                                  SizedBox(
                                                                                    width: 180.w,
                                                                                    child: Row(
                                                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                                                      children: [
                                                                                        Row(
                                                                                          children: [
                                                                                            Text(AppStrings.qt.tr(), style: TextStyle(color: AppColors.greyDark, fontSize: 16.sp, fontWeight: FontWeight.w800), textAlign: TextAlign.center),
                                                                                            SizedBox(
                                                                                              width: 30.w,
                                                                                              child: Text(_cubit.selectedMedicalItems[index].itemQuantity ?? "0", style: TextStyle(color: AppColors.greyDark, fontSize: 16.sp, fontWeight: FontWeight.w600), textAlign: TextAlign.start),
                                                                                            ),
                                                                                          ],
                                                                                        ),
                                                                                        SizedBox(
                                                                                          width: 5.w,
                                                                                        ),
                                                                                        Row(
                                                                                          children: [
                                                                                            Text(AppStrings.typeMedicalItem.tr(), style: TextStyle(color: AppColors.greyDark, fontSize: 16.sp, fontWeight: FontWeight.w800), textAlign: TextAlign.center),
                                                                                            SizedBox(
                                                                                              width: 60.w,
                                                                                              child: Text(_cubit.selectedMedicalItems[index].itemType ?? "0", style: TextStyle(color: AppColors.greyDark, fontSize: 16.sp, fontWeight: FontWeight.w600), textAlign: TextAlign.center),
                                                                                            ),
                                                                                          ],
                                                                                        ),
                                                                                      ],
                                                                                    ),
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                              Spacer(),
                                                                              VerticalDivider(
                                                                                color: AppColors.greyColor,
                                                                                indent: 5.h,
                                                                                endIndent: 5.h,
                                                                                thickness: 0.2,
                                                                              ),
                                                                              IconButton(
                                                                                  onPressed: () {
                                                                                    _cubit.addMedicalItemQuantity(index);
                                                                                  },
                                                                                  icon: Icon(
                                                                                    Icons.add,
                                                                                    color: AppColors.whiteBlueColor,
                                                                                  ))
                                                                            ],
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Positioned(
                                                                      top: -10,
                                                                      right:
                                                                          -10,
                                                                      child:
                                                                          IconButton(
                                                                        iconSize:
                                                                            30.sp,
                                                                        onPressed:
                                                                            () {
                                                                          _cubit
                                                                              .removeMedicalItem(_cubit.selectedMedicalItems[index]);
                                                                        },
                                                                        icon: Icon(
                                                                            Icons.delete_forever_rounded),
                                                                        color: AppColors
                                                                            .redColor,
                                                                      )),
                                                                ],
                                                              )),
                                                    ),
                                                  ],
                                                )
                                              : SizedBox(),
                                          SizedBox(
                                            height: 10.h,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ]),
                          ),
                          SizedBox(
                            height: 50.h,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: GestureDetector(
                                  onTap: () async {
                                    if (_tabController.index == 0 &&
                                        _cubit.selectedMedicalEntity == null) {
                                      showMessageDialog(
                                        context: context,
                                        isSucceeded: false,
                                        message: AppStrings
                                            .pleaseSelectMedicalEntity
                                            .tr(),
                                      );
                                    } else {
                                      if (_cubit.medicalItems != null) {
                                        if (_cubit.selectedMedicalEntity !=
                                            null) {
                                          if (_cubit.selectedMedicalItems
                                              .isNotEmpty) {
                                            await showDialog<void>(
                                                context: context,
                                                builder: (context) =>
                                                    ReasonAndComment(
                                                      status: "3",
                                                    ));
                                          } else {
                                            showMessageDialog(
                                              context: context,
                                              isSucceeded: false,
                                              message: AppStrings
                                                  .pleaseSelectMedicalItems
                                                  .tr(),
                                            );
                                          }
                                        }
                                      } else {
                                        if (_cubit.selectedMedicalEntity !=
                                            null) {
                                          await showDialog<void>(
                                              context: context,
                                              builder: (context) =>
                                                  ReasonAndComment(
                                                    status: "3",
                                                  ));
                                        }
                                      }
                                    }
                                  },
                                  child: Container(
                                    height: 40.h,
                                    //  width: 150.w,
                                    decoration: BoxDecoration(
                                      color: Color(0xFF4daa57),
                                      borderRadius: BorderRadius.circular(10.r),
                                      border: Border.all(
                                        color: Color(0xFF4daa57),
                                      ),
                                      //    color: AppColors.whiteColor,
                                    ),
                                    child: Center(
                                      child: Text(
                                        AppStrings.approve.tr(),
                                        style: TextStyle(
                                            color: AppColors.whiteColor,
                                            //  color: Color(0xFF4daa57),
                                            fontSize: 18.sp,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              //    Spacer(),
                              SizedBox(
                                width: 10.w,
                              ),
                              Expanded(
                                  child: GestureDetector(
                                onTap: () async {
                                  await showDialog<void>(
                                      context: context,
                                      builder: (context) => ReasonAndComment(
                                            status: "4",
                                          ));
                                },
                                child: Container(
                                  height: 40.h,
                                  //  width: 150.w,
                                  decoration: BoxDecoration(
                                    color: AppColors.redColor,
                                    //  color: AppColors.whiteColor,
                                    borderRadius: BorderRadius.circular(10.r),
                                    border: Border.all(
                                      color: AppColors.redColor,
                                    ),
                                  ),
                                  child: Center(
                                    child: Text(
                                      AppStrings.reject.tr(),
                                      style: TextStyle(
                                          color: AppColors.whiteColor,
                                          // color: AppColors.redColor,
                                          fontSize: 18.sp,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                ),
                              )),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ))
              ],
            ),
          ),
        );
      },
    );
  }
}
