import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:more4u/custom_icons.dart';
import 'package:more4u/presentation/medical_request_details/medical_request_details_screen.dart';
import 'package:timeago/timeago.dart' as timeago;
import '../../../core/themes/app_colors.dart';
import '../../../domain/entities/response_medical_request.dart';
import '../../pending_requests/cubits/pending_requests_cubit.dart';
import '../../pending_requests/cubits/pending_requests_state.dart';
import 'package:jiffy/jiffy.dart';

class MyRequestCard extends StatelessWidget {
  final Request request;

  const MyRequestCard({super.key, required this.request});
  String getDaySuffix(int day) {
    if (day >= 11 && day <= 13) {
      return 'th';
    }
    switch (day % 10) {
      case 1:
        return 'st';
      case 2:
        return 'nd';
      case 3:
        return 'rd';
      default:
        return 'th';
    }
  }

  @override
  Widget build(BuildContext context) {
    // String employeeName = "${request.employeeName.split(' ')[0]} ${request
    //     .employeeName.split(' ')[1]}";
    final daySuffix = getDaySuffix(request.requestDate.day);
    var outputFormat = DateFormat('MMMM d').format(request.requestDate) +
        daySuffix +
        DateFormat(', yyyy').format(request.requestDate);
    // var convertedRequestDate=DateTime.parse(request.requestDate??"");
    // var outputDate = outputFormat.format(convertedRequestDate);
    return BlocListener<PendingRequestsCubit, PendingRequestsState>(
      listener: (context, state) {
        if (state is GetMedicalRequestDetailsSuccessState) {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                  builder: (context) => MedicalDetailsScreen(
                        request: PendingRequestsCubit.get(context)
                            .medicalRequestCurrentStatus,
                        employeeImageUrl: request.employeeImageUrl,
                      )),
              (route) => false);
        }
      },
      child: GestureDetector(
        onTap: () {
          PendingRequestsCubit.get(context)
              .getMedicalRequestDetails(request.requestID);
        },
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.r),
              ),
              child: Container(
                height: 140,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.r),
                    border:
                        Border.all(width: 0.1.w, color: AppColors.greyText)),
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text(
                           "STATUS",
                            style: TextStyle(
                              color: AppColors.greyColor,
                              fontFamily: "Certa Sans",
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          //approved_request_status.png
                          Spacer(),
                          request.requestStatus == "Pending"
                              ? Image.asset(
                                  "assets/images/pending-request_status_3.png",
                                  width: 20.w,
                                  color: AppColors.mainColor,
                                )
                              : request.requestStatus == "Rejected"
                                  ? Image.asset(
                                      "assets/images/rejected_request_status_2.png",
                                      width:25.w,
                                   fit: BoxFit.fill,
                                   //   color: AppColors.redColor,
                                    )
                                  : Image.asset(
                                      "assets/images/approved_request_status_2.png",
                                      width: 20.w,
                                      color: Color(0xFF4bce97),
                                    ),
                          SizedBox(
                            width: 5.w,
                          ),
                          Text(
                            request.requestStatus ?? "",
                            style: TextStyle(
                              color: AppColors.mainColor,
                              fontFamily: "Certa Sans",
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w600,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(
                            width: 5.w,
                          ),
                          GestureDetector(
                              onTap: () {},
                              child: Icon(
                                Icons.arrow_forward_ios_outlined,
                                size: 16.sp,
                                color: AppColors.greyColor,
                              ))
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.r)),
              child: Container(
                height: 100,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.r),
                    border:
                        Border.all(width: 0.2.w, color: AppColors.greyText)),
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 16.w, vertical: 5.h),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Container(
                            decoration: BoxDecoration(
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
                                  ]),
                            ),
                            height: 50.h,
                            width: 50.w,
                            child: Center(
                              child: FittedBox(
                                child: Text(
                                  request.requestID?? "",
                                  style: TextStyle(
                                    color: AppColors.whiteColor,
                                    fontFamily: "Certa Sans",
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 15.w,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              FittedBox(
                                child: SizedBox(
                                  width: 200.w,
                                  child: Text(
                                    request.requestMedicalEntity ?? "",
                                    style: TextStyle(
                                      color: AppColors.mainColor,
                                      fontFamily: "Certa Sans",
                                      fontSize: 18.sp,
                                      fontWeight: FontWeight.w600,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 5.h,
                              ),
                              Text(
                                request.requestTypeID == "1"
                                    ? "Medication"
                                    : request.requestTypeID == "2"
                                        ? "Checkups"
                                        : "SickLeave",
                                style: TextStyle(
                                  color: AppColors.greyColor,
                                  fontFamily: "Certa Sans",
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w600,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Row(
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.watch_later_outlined,
                                color: AppColors.greyColor,
                              ),
                              SizedBox(
                                width: 5.w,
                              ),
                              Text(
                                "Due $outputFormat",
                                style: TextStyle(
                                  color: AppColors.greyColor,
                                  fontFamily: "Certa Sans",
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w600,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                          const Spacer(),
                          Row(
                            children: [
                              Icon(
                                request.selfRequest
                                    ? CustomIcons.person_solid
                                    : Icons.family_restroom,
                                color: AppColors.greyColor,
                              ),
                              SizedBox(
                                width: 5.w,
                              ),
                              Text(
                                request.selfRequest
                                    ? "Self Insurance"
                                    : "Family Insurance",
                                style: TextStyle(
                                  color: AppColors.greyColor,
                                  fontFamily: "Certa Sans",
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w600,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
