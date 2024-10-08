import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:more4u/presentation/medical_request_details/widgets/info_field.dart';
import 'package:more4u/presentation/pending_requests/cubits/pending_requests_cubit.dart';
import 'package:progress_indicators/progress_indicators.dart';

import '../../core/constants/app_strings.dart';
import '../../core/themes/app_colors.dart';
import '../../data/models/response/medication_request_response_model.dart';
import '../../domain/entities/response_medical_request.dart';
import '../gallery_screen.dart';
import '../home/widgets/app_bar.dart';
import '../medical_requests_history/medical_requests_history_screen.dart';
import '../medical_requests_history/widgets/selected_medical_items.dart';
import '../pending_requests/cubits/pending_requests_state.dart';
import '../widgets/drawer_widget.dart';
import '../widgets/helpers.dart';
import '../widgets/utils/loading_dialog.dart';
import '../widgets/utils/message_dialog.dart';

class MedicalDetailsScreen extends StatefulWidget {
  final String requestId;
  final String? employeeImageUrl;
  static const routeName = 'MedicalDetailsScreen';
  const MedicalDetailsScreen(
      {super.key, required this.requestId, this.employeeImageUrl});

  @override
  State<MedicalDetailsScreen> createState() => _MedicalDetailsScreenState();
}

class _MedicalDetailsScreenState extends State<MedicalDetailsScreen> {
  @override
  void initState() {
    PendingRequestsCubit.get(context)
        .getMedicalRequestDetails(widget.requestId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PendingRequestsCubit, PendingRequestsState>(
      listener: (context, state) {
        if (state is GetMedicalRequestDetailsLoadingState) {
          loadingAlertDialog(context);
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
            );
          }
        }
      },
      builder: (context, state) {
        var _cubit = PendingRequestsCubit.get(context);
        var outputFormat = DateFormat('dd MMM, yyyy hh:mm a');
        var convertedRequestDate = DateTime.parse(_cubit
                .details?.medicalRequestDetails?.medicalRequest?.requestDate ??
            DateTime.now().toString());
        var requestDate = outputFormat.format(convertedRequestDate);
        var convertedResponseDate = _cubit.details?.medicalRequestDetails
                    ?.medicalResponse?.responseDate !=
                null
            ? DateTime.parse(_cubit.details?.medicalRequestDetails
                    ?.medicalResponse?.responseDate ??
                "")
            : null;
        var responseDate = convertedResponseDate != null
            ? outputFormat.format(convertedResponseDate)
            : null;
        return Scaffold(
          drawer: const DrawerWidget(),
          body: SingleChildScrollView(
            child: SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(4.w, 14.h, 4.w, 0.h),
                    child: HomeAppBar(
                      title: AppStrings.requestDetails.tr(),
                      onTap: () {
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    MedicalRequestsHistoryScreen()),
                                (route) => false);
                      },
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 20.h, horizontal: 16.w),
                    child: Column(
                      children: [

                        state is GetMedicalRequestDetailsSuccessState
                            ? Card(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15.r)),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 10.h, horizontal: 8.w),
                                  child: Column(
                                    children: [
                                      Image.asset(
                                        _cubit.details?.medicalRequestDetails
                                                    ?.requestStatus ==
                                                "Rejected"
                                            ? "assets/images/reject.png"
                                            : _cubit
                                                        .details
                                                        ?.medicalRequestDetails
                                                        ?.requestStatus ==
                                                    "Pending"
                                                ? "assets/images/loading.png"
                                                : "assets/images/approved.png",
                                        width: 50.w,
                                      ),
                                      SizedBox(
                                        height: 5.h,
                                      ),
                                      Text(
                                        "${_cubit.details?.medicalRequestDetails
                                            ?.requestStatus}".tr() ??
                                            "",
                                        style: TextStyle(
                                          color: _cubit
                                                      .details
                                                      ?.medicalRequestDetails
                                                      ?.requestStatus ==
                                                  "Rejected"
                                              ? AppColors.redColor
                                              : _cubit
                                                          .details
                                                          ?.medicalRequestDetails
                                                          ?.requestStatus ==
                                                      "Approved"
                                                  ? AppColors.greenColor
                                                  : AppColors.mainColor,
                                          fontFamily: "Certa Sans",
                                          fontSize: 22.sp,
                                          fontWeight: FontWeight.w200,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      Divider(
                                        indent: 100,
                                        endIndent: 100,
                                        color: AppColors.greyColor,
                                        thickness: 0.2.h,
                                      ),
                                      Text(
                                        "${AppStrings.request.tr()} ${_cubit.details?.medicalRequestDetails?.medicalRequest?.requestType == 1 ?
                                        AppStrings.medications.tr() :
                                        _cubit.details?.medicalRequestDetails?.medicalRequest?.requestType == 2 ? AppStrings.checkUps.tr()  :
                                        AppStrings.sickLeave.tr() } ",
                                        style: TextStyle(
                                          color: AppColors.greyDark,
                                          fontFamily: "Certa Sans",
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.w600,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      SizedBox(
                                        height: 20.h,
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            AppStrings.requestDetails.tr(),
                                            style: TextStyle(
                                              color: AppColors.blackColor,
                                              fontFamily: "Certa Sans",
                                              fontSize: 20.sp,
                                              fontWeight: FontWeight.w600,
                                            ),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 10.h,
                                      ),
                                      Container(
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(15.r),
                                            color: Color(0xFFf6f6f6)),
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 10.h, horizontal: 8.w),
                                          child: Row(
                                            children: [
                                              ClipOval(
                                                child: Image.network(
                                                  widget.employeeImageUrl ?? "",
                                                  height: 50.w,
                                                  width: 50.w,
                                                  fit: BoxFit.fill,
                                                ),
                                              ),
                                              SizedBox(
                                                width: 10.w,
                                              ),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    AppStrings.employeeName.tr(),
                                                    style: TextStyle(
                                                      color: AppColors.greyDark,
                                                      fontFamily: "Certa Sans",
                                                      fontSize: 14.sp,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                  SizedBox(
                                                    height: 5.h,
                                                  ),
                                                  SizedBox(
                                                    width: 150.w,
                                                    child: Text(
                                                      _cubit
                                                              .details
                                                              ?.medicalRequestDetails
                                                              ?.medicalRequest
                                                              ?.requestedBy ??
                                                          "",
                                                      style: TextStyle(
                                                        color: AppColors
                                                            .blackColor,
                                                        fontFamily:
                                                            "Certa Sans",
                                                        fontSize: 16.sp,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      ),
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Spacer(),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.end,
                                                children: [
                                                  Text(
                                                    AppStrings.requestID.tr(),
                                                    style: TextStyle(
                                                      color: AppColors.greyDark,
                                                      fontFamily: "Certa Sans",
                                                      fontSize: 14.sp,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                  SizedBox(
                                                    height: 5.h,
                                                  ),
                                                  Text(
                                                    _cubit
                                                            .details
                                                            ?.medicalRequestDetails
                                                            ?.medicalRequestId ??
                                                        "",
                                                    style: TextStyle(
                                                      color:
                                                          AppColors.blackColor,
                                                      fontFamily: "Certa Sans",
                                                      fontSize: 16.sp,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10.h,
                                      ),
                                      InfoField(
                                        title: AppStrings.createdBy.tr(),
                                        value: _cubit
                                                .details
                                                ?.medicalRequestDetails
                                                ?.medicalRequest
                                                ?.createdBy ??
                                            "",
                                      ),
                                      SizedBox(
                                        height: 5.h,
                                      ),
                                      InfoField(
                                        title: AppStrings.requestFor.tr(),
                                        value: _cubit
                                                .details
                                                ?.medicalRequestDetails
                                                ?.medicalRequest
                                                ?.requestedFor ??
                                            "",
                                      ),
                                      SizedBox(
                                        height: 5.h,
                                      ),
                                      InfoField(
                                          title: AppStrings.employeeCoverage.tr(),
                                          value: _cubit
                                                  .details
                                                  ?.medicalRequestDetails
                                                  ?.medicalRequest
                                                  ?.employeeCoverage ??
                                              ""),
                                      _cubit
                                          .details
                                          ?.medicalRequestDetails
                                          ?.medicalRequest?.relation!="Self"?
                                          Column(
                                            children: [
                                              SizedBox(
                                                height: 5.h,
                                              ),
                                              InfoField(
                                                  title: AppStrings.relativeCoverage.tr(),
                                                  value: _cubit
                                                      .details
                                                      ?.medicalRequestDetails
                                                      ?.medicalRequest
                                                      ?.relativeCoverage??
                                                      ""),

                                            ],
                                          ):SizedBox( ),
                                      SizedBox(
                                        height: 5.h,
                                      ),
                                      InfoField(
                                        title: AppStrings.monthlyMedication.tr(),
                                        value: _cubit
                                                    .details
                                                    ?.medicalRequestDetails
                                                    ?.medicalRequest
                                                    ?.monthlyMedication ==
                                                true
                                            ? "Yes"
                                            : "No",
                                      ),
                                      SizedBox(
                                        height: 5.h,
                                      ),
                                      InfoField(
                                          title: AppStrings.time.tr(), value: requestDate),
                                      SizedBox(
                                        height: 5.h,
                                      ),
                                      SizedBox(
                                        height: 5.h,
                                      ),
                                      InfoField(
                                          title: AppStrings.medicalEntity.tr(),
                                          value: _cubit
                                                  .details
                                                  ?.medicalRequestDetails
                                                  ?.medicalRequest
                                                  ?.medicalEntity ??
                                              ""),
                                      SizedBox(
                                        height: 5.h,
                                      ),
                                      InfoField(
                                          title: AppStrings.medicalPurpose.tr(),
                                          value: _cubit
                                                  .details
                                                  ?.medicalRequestDetails
                                                  ?.medicalRequest
                                                  ?.medicalPurpose ??
                                              "_"),
                                      SizedBox(
                                        height: 5.h,
                                      ),
                                      InfoField(
                                          title: AppStrings.requestComment.tr(),
                                          value: _cubit
                                              .details
                                              ?.medicalRequestDetails
                                              ?.medicalRequest
                                              ?.comment ??
                                              "_"),
                                      SizedBox(
                                        height: 5.h,
                                      ),
                                      _cubit
                                                  .details
                                                  ?.medicalRequestDetails
                                                  ?.medicalRequest
                                                  ?.attachment !=
                                              null
                                          ? Row(
                                              children: [
                                                Text(
                                                  AppStrings.documents.tr(),
                                                  style: TextStyle(
                                                    color: AppColors.mainColor,
                                                    fontFamily: "Certa Sans",
                                                    fontSize: 14.sp,
                                                    fontWeight: FontWeight.w300,
                                                  ),
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                                Spacer(),
                                                IconButton(
                                                    padding: EdgeInsets.zero,
                                                    constraints:
                                                        const BoxConstraints(),
                                                    onPressed: () {
                                                      Navigator.of(context).push(
                                                          MaterialPageRoute(
                                                              builder: (_) =>
                                                                  GalleryScreen(
                                                                    images: _cubit
                                                                            .details
                                                                            ?.medicalRequestDetails
                                                                            ?.medicalRequest
                                                                            ?.attachment ??
                                                                        [],
                                                                    index: 0,
                                                                    numberColor:
                                                                        AppColors
                                                                            .blackColor,
                                                                  )));
                                                    },
                                                    icon: Icon(
                                                      Icons.attachment,
                                                      color: Color(0xFFdddddd),
                                                    ))
                                              ],
                                            )
                                          : SizedBox(),
                                      Divider(
                                        indent: 100,
                                        endIndent: 100,
                                        color: AppColors.greyColor,
                                        thickness: 0.2.h,
                                      ),
                                      SizedBox(
                                        height: 20.h,
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                           AppStrings.responseDetails.tr(),
                                            style: TextStyle(
                                              color: AppColors.blackColor,
                                              fontFamily: "Certa Sans",
                                              fontSize: 20.sp,
                                              fontWeight: FontWeight.w600,
                                            ),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ],
                                      ),
                                      _cubit.details?.medicalRequestDetails
                                                  ?.requestStatus ==
                                              "Pending"
                                          ? Padding(
                                              padding:
                                                  EdgeInsets.only(top: 20.h),
                                              child: Text("Pending",
                                                  style: TextStyle(
                                                    color: Color(0xFF2c93e7),
                                                    fontFamily: "Certa Sans",
                                                    fontSize: 20.sp,
                                                    fontWeight: FontWeight.w600,
                                                  )))
                                          : Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                SizedBox(
                                                  height: 5.h,
                                                ),
                                                InfoField(
                                                  title: AppStrings.createdBy.tr(),
                                                  value: _cubit
                                                          .details
                                                          ?.medicalRequestDetails
                                                          ?.medicalResponse
                                                          ?.createdBy ??
                                                      "",
                                                ),
                                                InfoField(
                                                    title:AppStrings.time.tr(),
                                                    value: responseDate ?? ""),
                                                // InfoField(
                                                //   title: "Feedback",
                                                //   value: _cubit
                                                //           .details
                                                //           ?.medicalRequestDetails
                                                //           ?.medicalResponse
                                                //           ?.feedback ??
                                                //       "",
                                                // ),
                                                InfoField(
                                                  title: AppStrings.responseComment.tr(),
                                                  value: _cubit
                                                          .details
                                                          ?.medicalRequestDetails
                                                          ?.medicalResponse
                                                          ?.responseComment ??
                                                      "",
                                                ),
                                                _cubit
                                                            .details
                                                            ?.medicalRequestDetails
                                                            ?.medicalResponse
                                                            ?.attachment !=
                                                        null
                                                    ? Row(
                                                        children: [
                                                          Text(
                                                            AppStrings.documents.tr(),
                                                            style: TextStyle(
                                                              color: AppColors
                                                                  .mainColor,
                                                              fontFamily:
                                                                  "Certa Sans",
                                                              fontSize: 14.sp,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                            ),
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                          ),
                                                          const Spacer(),
                                                          IconButton(
                                                              padding:
                                                                  EdgeInsets
                                                                      .zero,
                                                              constraints:
                                                                  const BoxConstraints(),
                                                              onPressed: () {
                                                                Navigator.of(
                                                                        context)
                                                                    .push(MaterialPageRoute(
                                                                        builder: (_) => GalleryScreen(
                                                                              images: _cubit.details?.medicalRequestDetails?.medicalRequest?.attachment ?? [],
                                                                              index: 0,
                                                                              numberColor: AppColors.blackColor,
                                                                            )));
                                                              },
                                                              icon: Icon(
                                                                Icons
                                                                    .attachment,
                                                                color: Color(
                                                                    0xFFdddddd),
                                                              ))
                                                        ],
                                                      )
                                                    : SizedBox(),
                                                InfoField(
                                                  title: AppStrings.medicalEntity.tr(),
                                                  value: _cubit
                                                          .details
                                                          ?.medicalRequestDetails
                                                          ?.medicalResponse
                                                          ?.medicalEntity ??
                                                      "",
                                                ),
                                                Row(
                                                  children: [
                                                    Text(
                                                      AppStrings. medicalItems.tr(),
                                                      style: TextStyle(
                                                        color:
                                                            AppColors.mainColor,
                                                        fontFamily:
                                                            "Certa Sans",
                                                        fontSize: 14.sp,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      ),
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                    Text(
                                                      "(${_cubit.details?.medicalRequestDetails?.medicalResponse?.medicalItems?.length.toString() ?? ""})",
                                                      style: TextStyle(
                                                        color:
                                                            AppColors.mainColor,
                                                        fontFamily:
                                                            "Certa Sans",
                                                        fontSize: 14.sp,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      ),
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: 10.h,
                                                ),
                                                SizedBox(
                                                    height: 80.h,
                                                    child: SelectedMedicalItems(
                                                      medicalItems: _cubit
                                                              .details
                                                              ?.medicalRequestDetails
                                                              ?.medicalResponse
                                                              ?.medicalItems ??
                                                          [],
                                                    ))
                                              ],
                                            ),
                                    ],
                                  ),
                                ),
                              )
                            : SizedBox(),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
