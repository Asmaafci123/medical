import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:more4u/domain/entities/relative.dart';
import 'package:more4u/presentation/medical_benefits/medical_benefits_screen.dart';
import 'package:more4u/presentation/medical_requests_history/widgets/my_request_card.dart';
import '../../core/constants/app_strings.dart';
import '../../core/constants/constants.dart';
import '../../core/themes/app_colors.dart';
import '../../custom_icons.dart';
import '../../injection_container.dart';
import '../home/widgets/app_bar.dart';
import '../widgets/drawer_widget.dart';
import '../widgets/helpers.dart';
import '../widgets/selection_chip.dart';
import '../widgets/utils/message_dialog.dart';
import 'cubits/my_medical_requests_cubit.dart';
import 'cubits/my_medical_requests_state.dart';

class MedicalRequestsHistoryScreen extends StatefulWidget {
  static const routeName = 'MyMedicalRequestsScreen';
  const MedicalRequestsHistoryScreen({super.key});

  @override
  State<MedicalRequestsHistoryScreen> createState() =>
      _MyMedicalRequestsScreenState();
}

class _MyMedicalRequestsScreenState
    extends State<MedicalRequestsHistoryScreen> {
//  late MyMedicalRequestsCubit _cubit;
  //late  List<Request>? resultFilter;
  @override
  void initState() {
    // _cubit = sl<MyMedicalRequestsCubit>();
    // resultFilter=null;
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   _cubit.getMyMedicalRequests();
    // });
    super.initState();
  }

  @override
  void dispose() {
    // _cubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<MyMedicalRequestsCubit>(
      create: (context) => sl<MyMedicalRequestsCubit>()..getMyMedicalRequests(),
      child: BlocConsumer<MyMedicalRequestsCubit, MyMedicalRequestsState>(
        listener: (context, state) {
          // if (state is GetMyMedicalRequestsLoadingState) {
          //   loadingAlertDialog(context);
          // }
          // if (state is GetMyMedicalRequestsSuccessState) {
          //   Navigator.pop(context);
          // }
          if (state is GetMyMedicalRequestsErrorState) {
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
        },
        builder: (context, state) {
          var _cubit = MyMedicalRequestsCubit.get(context);
          return Scaffold(
            drawer: const DrawerWidget(),
            body: SafeArea(
              child: Padding(
                padding: EdgeInsets.fromLTRB(16.w, 20.h, 16.w, 20.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    HomeAppBar(
                      title: "Medical History",
                      onTap: () {
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MedicalBenefitsScreen()),
                            (route) => false);
                      },
                    ),
                    SizedBox(
                      height: 40.h,
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
                              controller:
                                  _cubit.searchInMyMedicalRequestsController,
                              keyboardType: TextInputType.text,
                              // onChanged: (String? value)
                              // {
                              //   _cubit.searchInPendingRequests();
                              // },
                              decoration: InputDecoration(
                                hintText: "Search by Request Id and medical entity",
                                isDense: true,
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 12.h, horizontal: 11.w),
                                fillColor: Colors.white,
                                filled: true,
                                labelStyle: TextStyle(
                                    fontSize: 14.sp, fontFamily: "Certa Sans"),
                                hintStyle: TextStyle(
                                    color: Color(0xFFB5B9B9),
                                    fontSize: 14.sp,
                                    fontFamily: "Certa Sans",
                                    fontWeight: FontWeight.w500),
                                suffixIcon: IconButton(
                                  icon: Icon(Icons.clear),
                                  onPressed: () {
                                    if(_cubit.searchInMyMedicalRequestsController.text.isNotEmpty)
                                  {
                                    _cubit.clearSearchResult();
                                  }
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
                          width: 5.w,
                        ),
                        InkWell(
                          borderRadius: BorderRadius.circular(15.r),
                          onTap: () {
                                _cubit.searchInPendingRequests();
                          },
                          child: Ink(
                            width: 35.w,
                            height: 34.w,
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
                        SizedBox(
                          width: 5.w,
                        ),
                        InkWell(
                          borderRadius: BorderRadius.circular(15.r),
                          onTap: () {
                            //   buildShowModalBottomSheet(context);
                            showModalBottomSheet(
                              isScrollControlled: true,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(25.r),
                                  topRight: Radius.circular(25.r),
                                ),
                              ),
                              context: context,
                              builder: (BuildContext context) {
                                return BlocBuilder(
                                  bloc: _cubit,
                                  builder: (context, state) {
                                    return Padding(
                                      padding: EdgeInsets.fromLTRB(
                                          20.w,
                                          0,
                                          20.w,
                                          MediaQuery.of(context)
                                              .viewInsets
                                              .bottom),
                                      child: SingleChildScrollView(
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(
                                              height: 12.h,
                                            ),
                                            Align(
                                              alignment: Alignment.center,
                                              child: Container(
                                                width: 51.w,
                                                height: 4.h,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(50),
                                                  color: Color(0xffd9d9d9),
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              height: 8.h,
                                            ),
                                            Row(
                                              children: [
                                                SizedBox(
                                                  width: 60.w,
                                                ),
                                                Spacer(),
                                                Align(
                                                  alignment: Alignment.center,
                                                  child: Text(
                                                    AppStrings.filtration.tr(),
                                                    style: TextStyle(
                                                        color:
                                                            AppColors.mainColor,
                                                        fontSize: 18.sp,
                                                        fontFamily:
                                                            "Certa Sans",
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ),
                                                Spacer(),
                                                TextButton(
                                                    onPressed: () {
                                                      //  Navigator.pop(context);
                                                      _cubit
                                                          .clearFilteredList();
                                                    },
                                                    child: Text(
                                                      "Clear All",
                                                      style: TextStyle(
                                                        color:
                                                            AppColors.redColor,
                                                        fontFamily:
                                                            "Certa Sans",
                                                        fontSize: 16.sp,
                                                        fontWeight:
                                                            FontWeight.w200,
                                                      ),
                                                    ))
                                              ],
                                            ),
                                            SizedBox(
                                              height: 16.h,
                                            ),
                                            Text(
                                              "Request Type",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                color: Color(0xff7f7f7f),
                                                fontSize: 16.sp,
                                                fontFamily: "Certa Sans",
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
                                            SizedBox(
                                              height: 10.h,
                                            ),
                                            Wrap(
                                              children: [
                                                SelectionChip(
                                                    label: "Medication",
                                                    index: 1,
                                                    selectedIndex: _cubit
                                                        .selectedRequestType,
                                                    selectIndex: _cubit
                                                        .selectRequestType),
                                                SelectionChip(
                                                    label: "CheckUps",
                                                    index: 2,
                                                    selectedIndex: _cubit
                                                        .selectedRequestType,
                                                    selectIndex: _cubit
                                                        .selectRequestType),
                                                SelectionChip(
                                                    label: "SickLeave",
                                                    index: 3,
                                                    selectedIndex: _cubit
                                                        .selectedRequestType,
                                                    selectIndex: _cubit
                                                        .selectRequestType),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 16.h,
                                            ),
                                            Text(
                                              "Request Status",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                color: Color(0xff7f7f7f),
                                                fontSize: 16.sp,
                                                fontFamily: "Certa Sans",
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
                                            SizedBox(
                                              height: 10.h,
                                            ),
                                            Wrap(
                                              children: [
                                                SelectionChip(
                                                    label: "Pending",
                                                    index: 1,
                                                    selectedIndex: _cubit
                                                        .selectedRequestStatus,
                                                    selectIndex: _cubit
                                                        .selectRequestStatus),
                                                SelectionChip(
                                                    label: "Approved",
                                                    index: 3,
                                                    selectedIndex: _cubit
                                                        .selectedRequestStatus,
                                                    selectIndex: _cubit
                                                        .selectRequestStatus),
                                                SelectionChip(
                                                    label: "Rejected",
                                                    index: 4,
                                                    selectedIndex: _cubit
                                                        .selectedRequestStatus,
                                                    selectIndex: _cubit
                                                        .selectRequestStatus),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 16.h,
                                            ),
                                            Text(
                                              "Request ID",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                color: Color(0xff7f7f7f),
                                                fontSize: 16.sp,
                                                fontFamily: "Certa Sans",
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
                                            SizedBox(
                                              height: 10.h,
                                            ),
                                            TextField(
                                              style: TextStyle(
                                                fontSize: 12.sp,
                                                fontFamily: "Certa Sans",
                                              ),
                                              controller: _cubit
                                                  .requestIdFiltrationController,
                                              keyboardType:
                                                  TextInputType.number,
                                              decoration: InputDecoration(
                                                hintText: "Request Id",
                                                isDense: true,
                                                contentPadding:
                                                    EdgeInsets.symmetric(
                                                        vertical: 12.h,
                                                        horizontal: 11.w),
                                                fillColor: Colors.white,
                                                filled: true,
                                                labelStyle: TextStyle(
                                                    fontSize: 14.sp,
                                                    fontFamily: "Certa Sans"),
                                                hintStyle: TextStyle(
                                                    color: Color(0xFFB5B9B9),
                                                    fontSize: 14.sp,
                                                    fontFamily: "Certa Sans",
                                                    fontWeight:
                                                        FontWeight.w500),
                                                enabledBorder:
                                                    OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color:
                                                          AppColors.greyDark),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          5.r),
                                                ),
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color:
                                                          AppColors.greyDark),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          5.r),
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              height: 16.h,
                                            ),
                                            (userData!.isDoctor == true ||
                                                    userData!.isMedicalAdmin ==
                                                        true)
                                                ? Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        "Employee Number",
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: TextStyle(
                                                          color:
                                                              Color(0xff7f7f7f),
                                                          fontSize: 16.sp,
                                                          fontFamily:
                                                              "Certa Sans",
                                                          fontWeight:
                                                              FontWeight.w700,
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        height: 10.h,
                                                      ),
                                                      TextField(
                                                        style: TextStyle(
                                                            fontSize: 12.sp),
                                                        controller: _cubit
                                                            .userNumberSearch,
                                                        keyboardType:
                                                            TextInputType
                                                                .number,
                                                        decoration:
                                                            InputDecoration(
                                                          hintText:
                                                              "Employee Number",
                                                          isDense: true,
                                                          contentPadding:
                                                              EdgeInsets
                                                                  .symmetric(
                                                                      vertical:
                                                                          12.h,
                                                                      horizontal:
                                                                          11.w),
                                                          fillColor:
                                                              Colors.white,
                                                          filled: true,
                                                          labelStyle: TextStyle(
                                                              fontSize: 14.sp,
                                                              fontFamily:
                                                                  "Certa Sans"),
                                                          hintStyle: TextStyle(
                                                              color: Color(
                                                                  0xFFB5B9B9),
                                                              fontSize: 14.sp,
                                                              fontFamily:
                                                                  "Certa Sans",
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500),
                                                          enabledBorder:
                                                              OutlineInputBorder(
                                                            borderSide: BorderSide(
                                                                color: AppColors
                                                                    .greyDark),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        5.r),
                                                          ),
                                                          focusedBorder:
                                                              OutlineInputBorder(
                                                            borderSide: BorderSide(
                                                                color: AppColors
                                                                    .greyDark),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        5.r),
                                                          ),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        height: 16.h,
                                                      ),
                                                    ],
                                                  )
                                                : SizedBox(),
                                            (userData!.isDoctor == false &&
                                                    userData!.isMedicalAdmin ==
                                                        false &&
                                                    userData!
                                                        .relatives!.isNotEmpty)
                                                ? Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        "Relative",
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: TextStyle(
                                                          color:
                                                              Color(0xff7f7f7f),
                                                          fontSize: 16.sp,
                                                          fontFamily:
                                                              "Certa Sans",
                                                          fontWeight:
                                                              FontWeight.w700,
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        height: 10.h,
                                                      ),
                                                      DropdownButtonFormField<
                                                              Relative>(
                                                          style: TextStyle(
                                                              fontFamily:
                                                                  'Roboto',
                                                              fontWeight:
                                                                  FontWeight
                                                                      .normal,
                                                              color: Colors
                                                                  .black87),
                                                          // value: _cubit.selectedDepartment,
                                                          decoration:
                                                              InputDecoration(
                                                            isDense: true,
                                                            label: Text(
                                                                "Relative"),
                                                            border:
                                                                OutlineInputBorder(),
                                                            labelStyle:
                                                                TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              fontFamily:
                                                                  "Certa Sans",
                                                            ),
                                                            contentPadding:
                                                                EdgeInsets.all(
                                                                    3.0),
                                                            prefixIcon:
                                                                const Icon(
                                                              CustomIcons
                                                                  .person_solid,
                                                            ),
                                                          ),
                                                          items: [
                                                            DropdownMenuItem<
                                                                Relative>(
                                                              child: Text(
                                                                  AppStrings.any
                                                                      .tr(),
                                                                  style: TextStyle(
                                                                      color: AppColors
                                                                          .mainColor)),
                                                              value: _cubit
                                                                  .selectedRelative,
                                                            ),
                                                            ...userData!
                                                                .relatives!
                                                                .map((e) =>
                                                                    DropdownMenuItem<
                                                                        Relative>(
                                                                      child: Text(
                                                                          e.relativeName,
                                                                          style: TextStyle(
                                                                            color:
                                                                                AppColors.mainColor,
                                                                            fontFamily:
                                                                                "Certa Sans",
                                                                          )),
                                                                      value: e,
                                                                    ))
                                                                .toList()
                                                          ],
                                                          onChanged: (relative) =>
                                                              _cubit.selectRelative(
                                                                  relative!)),
                                                      SizedBox(
                                                        height: 16.h,
                                                      ),
                                                    ],
                                                  )
                                                : SizedBox(),
                                            Text(
                                              AppStrings.date.tr(),
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                color: Color(0xff7f7f7f),
                                                fontSize: 16.sp,
                                                fontFamily: "Certa Sans",
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
                                            SizedBox(
                                              height: 10.h,
                                            ),
                                            Row(
                                              children: [
                                                Expanded(
                                                  child: DateTimeField(
                                                    controller: _cubit.fromText,
                                                    decoration: InputDecoration(
                                                        label: Text(AppStrings
                                                            .from
                                                            .tr()),
                                                        border:
                                                            OutlineInputBorder(),
                                                        labelStyle: TextStyle(
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            fontFamily:
                                                                "Certa Sans",
                                                            fontSize: 12.sp),
                                                        contentPadding:
                                                            EdgeInsets.all(3.0),
                                                        prefixIcon: Icon(
                                                          Icons.calendar_today,
                                                          size: 25.r,
                                                        ),
                                                        suffixIcon: IconButton(
                                                          icon:
                                                              Icon(Icons.close),
                                                          onPressed: () {
                                                            _cubit
                                                                .changeFromDate(
                                                                    null);
                                                          },
                                                          iconSize: 25.r,
                                                        )),
                                                    format: DateFormat(
                                                        "yyyy-MM-dd"),
                                                    style: TextStyle(
                                                      fontSize: 12.sp,
                                                      fontFamily: "Certa Sans",
                                                    ),
                                                    onShowPicker: (context,
                                                        currentValue) async {
                                                      return showDatePicker(
                                                        context: context,
                                                        firstDate: DateTime(
                                                            DateTime.now()
                                                                .year),
                                                        initialDate:
                                                            DateTime.now(),
                                                        lastDate: DateTime(
                                                                DateTime.now()
                                                                        .year +
                                                                    1)
                                                            .add(Duration(
                                                                days: -1)),
                                                      );
                                                    },
                                                    onChanged: (date) {
                                                      _cubit
                                                          .changeFromDate(date);
                                                    },
                                                  ),
                                                ),
                                                SizedBox(width: 16.w),
                                                Expanded(
                                                    child: DateTimeField(
                                                  controller: _cubit.toText,
                                                  enabled:
                                                      _cubit.fromDate != null,
                                                  decoration: InputDecoration(
                                                    label: Text(
                                                        AppStrings.to.tr()),
                                                    border:
                                                        OutlineInputBorder(),
                                                    labelStyle: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontSize: 12.sp),
                                                    contentPadding:
                                                        EdgeInsets.all(3.0),
                                                    prefixIcon: const Icon(
                                                      Icons.calendar_today,
                                                    ),
                                                  ),
                                                  format:
                                                      DateFormat("yyyy-MM-dd"),
                                                  style: TextStyle(
                                                    fontSize: 12.sp,
                                                    fontFamily: "Certa Sans",
                                                  ),
                                                  resetIcon: null,
                                                  onShowPicker: (context,
                                                      currentValue) async {
                                                    return showDatePicker(
                                                        context: context,
                                                        firstDate:
                                                            _cubit.fromDate ??
                                                                DateTime.now(),
                                                        initialDate:
                                                            _cubit.toDate ??
                                                                DateTime.now(),
                                                        lastDate: DateTime(
                                                                DateTime.now()
                                                                        .year +
                                                                    1)
                                                            .add(Duration(
                                                                days: -1)));
                                                  },
                                                  onChanged: (date) {
                                                    _cubit.changeToDate(date);
                                                  },
                                                )),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 16.h,
                                            ),
                                            Align(
                                              alignment: Alignment.center,
                                              child: SizedBox(
                                                  height: 42.h,
                                                  width: 187.w,
                                                  child: GestureDetector(
                                                    onTap: () {
                                                      Navigator.pop(context);
                                                      _cubit.filter();
                                                    },
                                                    child: Container(
                                                      width: 200.w,
                                                      decoration: BoxDecoration(
                                                          gradient:
                                                              LinearGradient(
                                                                  begin: Alignment
                                                                      .topLeft,
                                                                  end: Alignment
                                                                      .bottomRight,
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
                                                              ]),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      10.r)),
                                                      child: Center(
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: Text(
                                                            AppStrings.done
                                                                .tr(),
                                                            style: TextStyle(
                                                              fontSize: 16.sp,
                                                              fontFamily:
                                                                  "Certa Sans",
                                                              color: AppColors
                                                                  .whiteColor,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  )),
                                            ),
                                            SizedBox(
                                              height: 8.h,
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                );
                              },
                            );
                          },
                          child: Ink(
                            width: 35.w,
                            height: 34.w,
                            decoration: BoxDecoration(
                                // color: Color(0xFFe8f2ff),
                                boxShadow: const [
                                  BoxShadow(
                                      color: Colors.black26, blurRadius: 10)
                                ],
                                borderRadius: BorderRadius.circular(15),
                                gradient: const LinearGradient(
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
                            child: Center(
                                child: Icon(
                              CustomIcons.settings_sliders,
                              size: 17.r,
                              //  color: Color(0xFF2c93e7),
                              color: AppColors.whiteColor,
                            )),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    _cubit.filteredSearchList.isNotEmpty
                        ? Row(
                            children: [
                              Wrap(
                                children: List<Widget>.generate(
                                  MyMedicalRequestsCubit.get(context)
                                      .filteredSearchList
                                      .length,
                                  (int idx) {
                                    return Padding(
                                      padding: EdgeInsets.only(right: 5.w),
                                      child: ChoiceChip(
                                        //  selectedColor: AppColors.redColor,
                                        // backgroundColor: AppColors.greyColor,
                                        label: Text(
                                            MyMedicalRequestsCubit.get(context)
                                                .filteredSearchList[idx]),
                                        selected: false,
                                        disabledColor: AppColors.greyText,
                                        // onSelected: (bool selected) {
                                        //   setState(() {
                                        //     MyMedicalRequestsCubit.get(context)
                                        //         .searchInMedical(
                                        //         MyMedicalRequestsCubit.get(context)
                                        //             .recentlySearched[idx]);
                                        //   });
                                        // }
                                      ),
                                    );
                                  },
                                ).toList(),
                              ),
                              Spacer(),
                              TextButton(
                                  onPressed: () {
                                    _cubit.clearFilteredList();
                                  },
                                  child: Text(
                                    "Clear All",
                                    style: TextStyle(
                                      color: AppColors.redColor,
                                      fontFamily: "Certa Sans",
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w200,
                                    ),
                                  ))
                            ],
                          )
                        : SizedBox(),
                    state is ClearFilteredHistoryListSuccessState
                        ? _cubit.myMedicalRequests.isNotEmpty
                            ? Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                        "result(${_cubit.myMedicalRequests.length})",
                                        style: TextStyle(
                                          color: AppColors.greyDark,
                                          fontSize: 18.sp,
                                          fontWeight: FontWeight.w200,
                                          fontFamily: "Certa Sans",
                                        )),
                                    SizedBox(
                                      height: 5.h,
                                    ),
                                    Text(
                                        "Your medical requests : ",
                                        style: TextStyle(
                                          color: AppColors.greyDark,
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w200,
                                          fontFamily: "Certa Sans",
                                        )),
                                    SizedBox(
                                      height: 5.h,
                                    ),
                                    Expanded(
                                      child: ListView.separated(
                                          itemCount:
                                              _cubit.myMedicalRequests.length,
                                          separatorBuilder: (context, index) =>
                                              SizedBox(
                                                height: 10.h,
                                              ),
                                          itemBuilder: (context, index) =>
                                              MyRequestCard(
                                                request: _cubit
                                                    .myMedicalRequests[index],
                                              )),
                                    ),
                                  ],
                                ),
                              )
                            : Expanded(
                                child: Image.asset(
                                    "assets/images/couldnot_find.jpg"),
                              )
                        : SizedBox(),
                    state is GetFilteredMedicalRequestsLoadingState
                        ? LinearProgressIndicator(
                            minHeight: 2.h,
                            backgroundColor:
                                AppColors.mainColor.withOpacity(0.4),
                          )
                        : state is GetFilteredMedicalRequestsSuccessState
                            ? _cubit.filteredMedicalRequest.isNotEmpty
                                ? Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                            "result(${_cubit.filteredMedicalRequest.length})",
                                            style: TextStyle(
                                              color: AppColors.greyDark,
                                              fontSize: 18.sp,
                                              fontWeight: FontWeight.w200,
                                              fontFamily: "Certa Sans",
                                            )),
                                        SizedBox(
                                          height: 5.h,
                                        ),
                                        Text(
                                            "Medical requests for ${_cubit.filteredMedicalRequest[0].employeeName}: ",
                                            style: TextStyle(
                                              color: AppColors.greyDark,
                                              fontSize: 14.sp,
                                              fontWeight: FontWeight.w200,
                                              fontFamily: "Certa Sans",
                                            )),
                                        SizedBox(
                                          height: 5.h,
                                        ),
                                        Expanded(
                                          child: ListView.separated(
                                              itemCount: _cubit
                                                  .filteredMedicalRequest
                                                  .length,
                                              separatorBuilder:
                                                  (context, index) => SizedBox(
                                                        height: 10.h,
                                                      ),
                                              itemBuilder: (context, index) =>
                                                  MyRequestCard(
                                                    request: _cubit
                                                            .filteredMedicalRequest[
                                                        index],
                                                  )),
                                        ),
                                      ],
                                    ),
                                  )
                                : Expanded(
                                    child: Image.asset(
                                        "assets/images/couldnot_find.jpg"),
                                  )
                            : SizedBox(),
                    state is ClearSearchResultSuccessState
                        ? _cubit.myMedicalRequests.isNotEmpty
                            ? Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                        "result(${_cubit.myMedicalRequests.length})",
                                        style: TextStyle(
                                          color: AppColors.greyDark,
                                          fontSize: 18.sp,
                                          fontWeight: FontWeight.w200,
                                          fontFamily: "Certa Sans",
                                        )),
                                    SizedBox(
                                      height: 5.h,
                                    ),
                                    Text(
                                        "Your medical requests : ",
                                        style: TextStyle(
                                          color: AppColors.greyDark,
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w200,
                                          fontFamily: "Certa Sans",
                                        )),
                                    SizedBox(
                                      height: 5.h,
                                    ),
                                    Expanded(
                                      child: ListView.separated(
                                          itemCount:
                                              _cubit.myMedicalRequests.length,
                                          separatorBuilder: (context, index) =>
                                              SizedBox(
                                                height: 10.h,
                                              ),
                                          itemBuilder: (context, index) =>
                                              MyRequestCard(
                                                request: _cubit
                                                    .myMedicalRequests[index],
                                              )),
                                    ),
                                  ],
                                ),
                              )
                            : Expanded(
                                child: Image.asset(
                                    "assets/images/couldnot_find.jpg"),
                              )
                        : SizedBox(),
                    state is SearchInMedicalRequestsLoadingState
                        ? LinearProgressIndicator(
                            minHeight: 2.h,
                            backgroundColor:
                                AppColors.mainColor.withOpacity(0.4),
                          )
                        : state is SearchInMedicalRequestsSuccessState
                            ? _cubit.searchedResult.isNotEmpty
                                ? Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                            "result(${_cubit.searchedResult.length})",
                                            style: TextStyle(
                                              color: AppColors.greyDark,
                                              fontSize: 18.sp,
                                              fontWeight: FontWeight.w200,
                                              fontFamily: "Certa Sans",
                                            )),
                                        SizedBox(
                                          height: 5.h,
                                        ),
                                        Text(
                                            "Medical requests for ${_cubit.searchedResult[0].employeeName}: ",
                                            style: TextStyle(
                                              color: AppColors.greyDark,
                                              fontSize: 14.sp,
                                              fontWeight: FontWeight.w200,
                                              fontFamily: "Certa Sans",
                                            )),
                                        SizedBox(
                                          height: 5.h,
                                        ),
                                        Expanded(
                                          child: ListView.separated(
                                              itemCount:
                                                  _cubit.searchedResult.length,
                                              separatorBuilder:
                                                  (context, index) => SizedBox(
                                                        height: 10.h,
                                                      ),
                                              itemBuilder: (context, index) =>
                                                  MyRequestCard(
                                                    request: _cubit
                                                        .searchedResult[index],
                                                  )),
                                        ),
                                      ],
                                    ),
                                  )
                                : Expanded(
                                    child: Image.asset(
                                        "assets/images/couldnot_find.jpg"),
                                  )
                            : SizedBox(),
                    state is GetMyMedicalRequestsLoadingState
                        ? LinearProgressIndicator(
                            minHeight: 2.h,
                            backgroundColor:
                                AppColors.mainColor.withOpacity(0.4),
                          )
                        : state is GetMyMedicalRequestsSuccessState
                            ? _cubit.myMedicalRequests.isNotEmpty
                                ? Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                            "result(${_cubit.myMedicalRequests.length})",
                                            style: TextStyle(
                                              color: AppColors.greyDark,
                                              fontSize: 18.sp,
                                              fontWeight: FontWeight.w200,
                                              fontFamily: "Certa Sans",
                                            )),
                                        SizedBox(
                                          height: 5.h,
                                        ),
                                        Text(
                                            "Your medical requests : ",
                                            style: TextStyle(
                                              color: AppColors.greyDark,
                                              fontSize: 14.sp,
                                              fontWeight: FontWeight.w200,
                                              fontFamily: "Certa Sans",
                                            )),
                                        SizedBox(
                                          height: 5.h,
                                        ),
                                        Expanded(
                                          child: ListView.separated(
                                              itemCount: _cubit
                                                  .myMedicalRequests.length,
                                              separatorBuilder:
                                                  (context, index) => SizedBox(
                                                        height: 10.h,
                                                      ),
                                              itemBuilder: (context, index) =>
                                                  MyRequestCard(
                                                    request: _cubit
                                                            .myMedicalRequests[
                                                        index],
                                                  )),
                                        ),
                                      ],
                                    ),
                                  )
                                : Expanded(
                                    child: Image.asset(
                                        "assets/images/couldnot_find.jpg"))
                            : SizedBox(),
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
