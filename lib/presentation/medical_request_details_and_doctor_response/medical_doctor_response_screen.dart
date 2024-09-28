import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:more4u/custom_icons.dart';
import 'package:more4u/data/models/medical_item_model.dart';
import 'package:more4u/presentation/medical_request_details_and_doctor_response/widgets/gallery_strings.dart';
import 'package:more4u/presentation/medical_request_details_and_doctor_response/widgets/requested_by_info_2.dart';
import 'package:more4u/presentation/medical_request_details_and_doctor_response/widgets/resone_and_comment_widget.dart';
import 'package:more4u/presentation/pending_requests/pending_requests_screen.dart';
import 'package:more4u/presentation/widgets/utils/loading_dialog.dart';
import 'package:toast/toast.dart';
import '../../core/themes/app_colors.dart';
import '../../core/utils/flutter_chips/src/chips_input.dart';
import '../../domain/entities/details-of-medical.dart';
import '../../domain/entities/medical_item.dart';
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
                  "We are delighted to inform you that we received your response for request ${_cubit.medicalRequestDetails?.medicalRequestId ?? 0}.",
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
                        title: "Mange Request",
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
                        requestedByDepartment: "Planing",
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
                                color: Color(0xFFf8f4f0),
                              ),
                              height: 50.h,
                              child: Padding(
                                padding:
                                    EdgeInsets.fromLTRB(4.w, 8.h, 4.w, 8.h),
                                child: TabBar(
                                    controller: _tabController,
                                    unselectedLabelColor: AppColors.greyDark,
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
                                                "Request",
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
                                              child: Text("Response",
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
                            height: 310.h,
                            child: TabBarView(
                                physics: NeverScrollableScrollPhysics(),
                                controller: _tabController,
                                children: [
                                  SingleChildScrollView(
                                    child: Column(children: [
                                      Container(
                                        color: Color(0xFF2c93e7),
                                        width: double.infinity,
                                        child: Padding(
                                          padding: EdgeInsets.fromLTRB(
                                              8.w, 6.h, 8.w, 6.h),
                                          child: Text(
                                            "ID: ${_cubit.medicalRequestDetails?.medicalRequestId ?? ""}",
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
                                                      "Created By",
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
                                              Row(
                                                children: [
                                                  SizedBox(
                                                    width: 100.w,
                                                    child: Text(
                                                      "Relation",
                                                      style: TextStyle(
                                                          color: AppColors
                                                              .greyColor,
                                                          fontSize: 14.sp,
                                                          fontFamily:
                                                              "Certa Sans",
                                                          fontWeight:
                                                              FontWeight.w300),
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
                                                              FontWeight.w600,
                                                          overflow: TextOverflow
                                                              .ellipsis),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              _cubit
                                                          .medicalRequestDetails
                                                          ?.medicalRequest
                                                          ?.relation !=
                                                      "Self"
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
                                                                "Relative Name",
                                                                style: TextStyle(
                                                                    color: AppColors
                                                                        .greyColor,
                                                                    fontSize:
                                                                        14.sp,
                                                                    fontFamily:
                                                                        "Certa Sans",
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w300),
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
                                                      ],
                                                    )
                                                  : SizedBox(),
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
                                              Row(
                                                children: [
                                                  SizedBox(
                                                    width: 100.w,
                                                    child: Text(
                                                      "Medical Entity",
                                                      style: TextStyle(
                                                          color: AppColors
                                                              .greyColor,
                                                          fontSize: 14.sp,
                                                          fontFamily:
                                                              "Certa Sans",
                                                          fontWeight:
                                                              FontWeight.w300),
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
                                              Row(
                                                children: [
                                                  SizedBox(
                                                    width: 100.w,
                                                    child: Text(
                                                      "Medical Purpose",
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
                                                              ?.medicalPurpose ??
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
                                              Row(
                                                children: [
                                                  SizedBox(
                                                    width: 100.w,
                                                    child: Text(
                                                      "Comment",
                                                      style: TextStyle(
                                                          color: AppColors
                                                              .greyColor,
                                                          fontSize: 14.sp,
                                                          fontFamily:
                                                              "Certa Sans",
                                                          fontWeight:
                                                              FontWeight.w300),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    child: Text(
                                                      _cubit
                                                              .medicalRequestDetails
                                                              ?.medicalRequest
                                                              ?.comment ??
                                                          "",
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
                                            "Attachments",
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
                                              "See all",
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
                                            "Medical Entity",
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
                                                labelText: "Medical Entity",
                                                labelStyle:
                                                    TextStyle(fontSize: 14.sp),
                                                hintText:
                                                    "Enter Medical Entity",
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
                                                      top: 10.h,
                                                      left: 10.w,
                                                      bottom: 10.h),
                                                  child: Text(
                                                    "please select from suggestions List ",
                                                    style: TextStyle(
                                                        fontSize: 14.sp,
                                                        fontFamily:
                                                            "Certa Sans",
                                                        color:
                                                            AppColors.redColor),
                                                  ),
                                                ),
                                          _cubit.medicalItems != null
                                              ? Text(
                                                  "Medical Items",
                                                  style: TextStyle(
                                                      color:
                                                          AppColors.blackColor,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: 18.sp,
                                                      fontFamily: "Certa Sans"),
                                                )
                                              : SizedBox(),
                                          _cubit.medicalItems != null
                                              ? Padding(
                                                  padding: EdgeInsets.fromLTRB(
                                                      0, 20.h, 0, 20.h),
                                                  child:
                                                      ChipsInput<MedicalItem>(
                                                    key: _chipKey2,
                                                    enabled: true,
                                                    initialValue: _cubit
                                                            .selectedMedicalItems
                                                            .isNotEmpty
                                                        ? _cubit
                                                            .selectedMedicalItems
                                                        : [],
                                                    textStyle: TextStyle(
                                                      fontSize: 12.sp,
                                                      height: 1,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      color:
                                                          AppColors.mainColor,
                                                    ),
                                                    // enabled: false,
                                                    allowChipEditing: true,
                                                    decoration: InputDecoration(
                                                      isDense: true,
                                                      suffixIconConstraints:
                                                          BoxConstraints(
                                                              maxHeight: 20.h,
                                                              minWidth: 50.w),
                                                      prefixIcon: Icon(
                                                        CustomIcons.home__2_,
                                                        size: 20.r,
                                                      ),
                                                      contentPadding:
                                                          EdgeInsets.symmetric(
                                                        vertical: 10.0,
                                                        horizontal: 0.0,
                                                      ),
                                                      border: OutlineInputBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      15.0.r)),
                                                      labelText:
                                                          "Medical Items",
                                                      labelStyle: TextStyle(
                                                          fontSize: 14.sp),
                                                      hintText:
                                                          "Enter Medical Items",
                                                      hintStyle: TextStyle(
                                                          color: const Color(
                                                              0xffc1c1c1),
                                                          fontSize: 12.sp),
                                                      errorStyle: TextStyle(
                                                          fontSize: 12.sp),
                                                      //  errorText: _cubit.lowParticipantError,
                                                      floatingLabelBehavior:
                                                          FloatingLabelBehavior
                                                              .always,
                                                    ),
                                                    findSuggestions:
                                                        (String query) {
                                                      if (query.length > 1) {
                                                        var lowercaseQuery =
                                                            query.toLowerCase();
                                                        return _cubit
                                                            .medicalItems!
                                                            .where((profile) {
                                                          return profile
                                                                  .itemName!
                                                                  .toLowerCase()
                                                                  .contains(query
                                                                      .toLowerCase()) ||
                                                              profile.itemName
                                                                  .toString()
                                                                  .toLowerCase()
                                                                  .contains(query
                                                                      .toLowerCase());
                                                        }).toList(
                                                                growable: false)
                                                          ..sort((a, b) => a
                                                              .itemName!
                                                              .toLowerCase()
                                                              .indexOf(
                                                                  lowercaseQuery)
                                                              .compareTo(b
                                                                  .itemName!
                                                                  .toLowerCase()
                                                                  .indexOf(
                                                                      lowercaseQuery)));
                                                      } else {
                                                        return const <MedicalItemModel>[];
                                                      }
                                                    },
                                                    // onChanged: _cubit.participantsOnChange,
                                                    onChanged:
                                                        (List<MedicalItem>
                                                            value) {
                                                      _cubit.changeMedicalItems(
                                                          value);
                                                    },
                                                    chipBuilder: (context,
                                                        state, profile) {
                                                      return InputChip(
                                                        padding:
                                                            EdgeInsets.zero,
                                                        deleteIconColor:
                                                            AppColors.mainColor,
                                                        labelStyle: TextStyle(
                                                            fontSize: 14.sp,
                                                            fontWeight:
                                                                FontWeight
                                                                    .normal,
                                                            color: AppColors
                                                                .mainColor),
                                                        shape:
                                                            RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(8),
                                                          side: BorderSide(
                                                              color: Color(
                                                                  0xFFC1C1C1)),
                                                        ),
                                                        backgroundColor:
                                                            Color(0xFFE7E7E7),
                                                        key: ObjectKey(profile),
                                                        label: Text(
                                                          profile.itemName ??
                                                              "",
                                                          style: TextStyle(
                                                              fontSize: 12.sp),
                                                        ),
                                                        onDeleted: () {
                                                          state.deleteChip(
                                                              profile);
                                                          //  _cubit.changeMedicalEntity(null);
                                                        },
                                                        materialTapTargetSize:
                                                            MaterialTapTargetSize
                                                                .shrinkWrap,
                                                      );
                                                    },
                                                    suggestionBuilder: (context,
                                                        state, profile) {
                                                      return ListTile(
                                                        key: ObjectKey(profile),
                                                        leading: CircleAvatar(
                                                          backgroundImage:
                                                              AssetImage(
                                                                  'assets/images/profile_avatar_placeholder.png'),
                                                        ),
                                                        title: Text(
                                                            profile.itemName ??
                                                                "",
                                                            style: TextStyle(
                                                                fontSize:
                                                                    12.sp)),
                                                        subtitle: Text(profile
                                                            .itemDose
                                                            .toString()),
                                                        onTap: () => state
                                                            .selectSuggestion(
                                                                profile),
                                                      );
                                                    },
                                                  ),
                                                )
                                              : SizedBox(),
                                          _cubit.validateOnChipsKeyMedicalItems(
                                                  _chipKey2
                                                          .currentState
                                                          ?.currentTextEditingValue
                                                          .text
                                                          .length ??
                                                      0)
                                              ? SizedBox()
                                              : Padding(
                                                  padding: EdgeInsets.only(
                                                      top: 10.h, left: 10.w),
                                                  child: Text(
                                                    "please select from suggestions List ",
                                                    style: TextStyle(
                                                        fontSize: 14.sp,
                                                        fontFamily:
                                                            "Certa Sans",
                                                        color:
                                                            AppColors.redColor),
                                                  ),
                                                ),
                                          _cubit.selectedMedicalItems.isNotEmpty
                                              ? Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      "Items(${_cubit.selectedMedicalItems.length})",
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
                                                          (index) => Card(
                                                                shape:
                                                                    RoundedRectangleBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              15.r),
                                                                ),
                                                                child:
                                                                    Container(
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    color: Color(
                                                                        0xFFf8f4f0),
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            15.r),
                                                                  ),
                                                                  child:
                                                                      Padding(
                                                                    padding:
                                                                        const EdgeInsets.all(
                                                                            8.0),
                                                                    child:
                                                                        IntrinsicHeight(
                                                                      child:
                                                                          Row(
                                                                        children: [
                                                                          IconButton(
                                                                              padding: EdgeInsets.only(bottom: 10.h),
                                                                              onPressed: () {
                                                                                _cubit.minusMedicalItemQuantity(index);
                                                                              },
                                                                              icon: Icon(
                                                                                Icons.minimize_outlined,
                                                                                color: AppColors.whiteBlueColor,
                                                                                size: 20.r,
                                                                              )),
                                                                          VerticalDivider(
                                                                            indent:
                                                                                5.h,
                                                                            endIndent:
                                                                                5.h,
                                                                            color:
                                                                                AppColors.greyColor,
                                                                            thickness:
                                                                                0.2,
                                                                          ),
                                                                          Spacer(),
                                                                          Column(
                                                                            children: [
                                                                              Text(
                                                                                _cubit.selectedMedicalItems[index].itemName ?? "",
                                                                                style: TextStyle(color: AppColors.whiteBlueColor, fontSize: 18.sp, fontWeight: FontWeight.w600),
                                                                              ),
                                                                              Row(
                                                                                children: [
                                                                                  Text(
                                                                                    _cubit.selectedMedicalItems[index].itemQuantity ?? "0",
                                                                                    style: TextStyle(color: AppColors.greyDark, fontSize: 16.sp, fontWeight: FontWeight.w600),
                                                                                  ),
                                                                                  SizedBox(
                                                                                    width: 5.w,
                                                                                  ),
                                                                                  Text(
                                                                                    "${_cubit.selectedMedicalItems[index].itemType ?? "0"}s",
                                                                                    style: TextStyle(color: AppColors.greyDark, fontSize: 16.sp, fontWeight: FontWeight.w600),
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                            ],
                                                                          ),
                                                                          Spacer(),
                                                                          VerticalDivider(
                                                                            color:
                                                                                AppColors.greyColor,
                                                                            indent:
                                                                                5.h,
                                                                            endIndent:
                                                                                5.h,
                                                                            thickness:
                                                                                0.2,
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
                                    if (_cubit.medicalItems != null) {
                                      if (_cubit.selectedMedicalEntity !=
                                              null &&
                                          _chipKey2
                                                  .currentState
                                                  ?.currentTextEditingValue
                                                  .text
                                                  .length ==
                                              _cubit.selectedMedicalItems
                                                  .length) {
                                        await showDialog<void>(
                                            context: context,
                                            builder: (context) =>
                                                ReasonAndComment(
                                                  status: "3",
                                                ));
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
                                  },
                                  child: Container(
                                    height: 40.h,
                                    //  width: 150.w,
                                    decoration: BoxDecoration(
                                      // color: Color(0xFF4daa57),
                                      borderRadius: BorderRadius.circular(15.r),
                                      border: Border.all(
                                        color: Color(0xFF4daa57),
                                      ),
                                      color: AppColors.whiteColor,
                                    ),
                                    child: Center(
                                      child: Text(
                                        "Approve",
                                        style: TextStyle(
                                            // color: AppColors.whiteColor,
                                            color: Color(0xFF4daa57),
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
                                    // color: AppColors.redColor,
                                    color: AppColors.whiteColor,
                                    borderRadius: BorderRadius.circular(15.r),
                                    border: Border.all(
                                      color: AppColors.redColor,
                                    ),
                                  ),
                                  child: Center(
                                    child: Text(
                                      "Reject",
                                      style: TextStyle(
                                          // color: AppColors.whiteColor,
                                          color: AppColors.redColor,
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
