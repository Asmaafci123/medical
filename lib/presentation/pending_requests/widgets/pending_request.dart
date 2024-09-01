import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:more4u/custom_icons.dart';
import 'package:more4u/presentation/medical_request_details_and_doctor_response/medical_doctor_response_screen.dart';
import 'package:more4u/presentation/pending_requests/cubits/pending_requests_cubit.dart';
import 'package:more4u/presentation/pending_requests/cubits/pending_requests_state.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

import '../../../core/themes/app_colors.dart';
import '../../../domain/entities/response_medical_request.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../../widgets/utils/loading_dialog.dart';

class RequestCard extends StatelessWidget {
  final Request request;

  const RequestCard({super.key, required this.request});

  @override
  Widget build(BuildContext context) {
    var outputFormat = DateFormat('dd MMM, yyyy hh:mm a');
    var requestDate = outputFormat.format(request.requestDate);
    return GestureDetector(
      onTap: () {
        PendingRequestsCubit.get(context)
            .getMedicalRequestDetails(request.requestID);
      },
      child:Stack(
        alignment: Alignment.topLeft,
        children: [
          SizedBox(
            height: 160.h,
          ),
          Positioned(
            top: 16.h,
            child: Card(
              elevation: 5,
              shape:
                  RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.r)),
              child: Container(
                width: 310.w,
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(15.r)),
                child: Padding(
                  padding:EdgeInsets.symmetric(horizontal:0.w,vertical: 12.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 90.w,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              FittedBox(
                                fit: BoxFit.contain,
                                child: SizedBox(
                                  width: 170.w,
                                  child: Text(
                                    request.employeeName,
                                    style: TextStyle(
                                      color: AppColors.whiteBlueColor,
                                      fontFamily: "Certa Sans",
                                      fontSize: 18.sp,
                                      fontWeight: FontWeight.w200,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ),
                              Text.rich(
                                  TextSpan(text: "Employee ID  ",
                                  style: TextStyle(
                                      color: AppColors.whiteBlueColor,
                                      fontFamily: "Certa Sans",
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w200) ,
                                  children: [
                                TextSpan(
                                  text:request.employeeNumber,
                                  style: TextStyle(
                                    height: 1.7,
                                      color: AppColors.whiteBlueColor,
                                      fontFamily: "Certa Sans",
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w200),
                                )
                              ])),
                              Text(
                                requestDate,
                                style: TextStyle(
                                  height: 1.7,
                                    color: AppColors.whiteBlueColor,
                                    fontFamily: "Certa Sans",
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w500),
                              ),
                              SizedBox(
                                height: 10.h,
                              ),
                              Row(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10.r),
                                        color: Color(0xFFe8f2ff)
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                          vertical: 12.h, horizontal: 12.w),
                                      child: Text(
                                        "ID : ${request.requestID}",
                                        style: TextStyle(
                                          //   color: AppColors.greenColor,
                                          //  color: AppColors.whiteColor,
                                            color: Color(0xFF2c93e7),
                                            fontFamily: "Certa Sans",
                                            fontSize: 16.sp,
                                            fontWeight: FontWeight.w700),
                                      ),
                                    ),
                                  ),
                               //   Spacer(),
                                  SizedBox(
                                    width: 30.w,
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10.r),
                                        // color: Color(0xFF2c93e7)
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
                                            ])
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                          vertical: 8.h, horizontal: 10.w),
                                      child: Icon(
                                        request.selfRequest==true?
                                        CustomIcons.person_solid:
                                        Icons.family_restroom,
                                        color: AppColors.whiteColor,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 5.w,
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10.r),
                                        color: Color(0xFFe8f2ff)),
                                    child: Padding(
                                        padding: EdgeInsets.symmetric(
                                            vertical: 4.h, horizontal: 4.w),
                                        child: Text(
                                          "100%",
                                          style: TextStyle(
                                            // color: AppColors.greenColor,
                                              color: Color(0xFF2c93e7),
                                              fontWeight: FontWeight.w700,
                                              fontSize: 16.sp),
                                        )),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          // CircleAvatar(
          //     radius: 30.r,
          //     backgroundImage:
          //     NetworkImage(request.employeeImageUrl)),
          Positioned(
            left: 15.w,
            top: 0,
            child: Card(
                elevation: 0,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.r)),
                shadowColor: Color(0xFF446CFF),
                child: Container(
                  height: 100.h,
                  width: 80.w,
                  decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(20.r)),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20.0),
                    child: Image.network(
                      request.employeeImageUrl,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => Image.asset(
                        'assets/images/profile_pricture_default.png',
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                )),
          ),
        ],
      ),
    );
  }
}
