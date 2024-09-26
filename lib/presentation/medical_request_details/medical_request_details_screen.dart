import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:more4u/presentation/medical_request_details/widgets/info_field.dart';
import 'package:progress_indicators/progress_indicators.dart';

import '../../core/themes/app_colors.dart';
import '../../data/models/response/medication_request_response_model.dart';
import '../gallery_screen.dart';
import '../home/widgets/app_bar.dart';
import '../medical_requests_history/medical_requests_history_screen.dart';
import '../widgets/drawer_widget.dart';

class MedicalDetailsScreen extends StatelessWidget {
  final MedicationRequestResponseModel? request;
  final String? employeeImageUrl;
  static const routeName = 'MedicalDetailsScreen';
  const MedicalDetailsScreen(
      {super.key, required this.request, this.employeeImageUrl});

  @override
  Widget build(BuildContext context) {
    var outputFormat = DateFormat('dd MMM, yyyy hh:mm a');
    var convertedRequestDate=DateTime.parse(request?.medicalRequestDetails?.medicalRequest?.requestDate??"");
    var requestDate = outputFormat.format(convertedRequestDate);
    var convertedResponseDate=request?.medicalRequestDetails?.medicalResponse?.responseDate!=null?
    DateTime.parse(request?.medicalRequestDetails?.medicalResponse?.responseDate??""):null;
    var responseDate=convertedResponseDate!=null?outputFormat.format(convertedResponseDate):null;
    return Scaffold(
      drawer: const DrawerWidget(),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 16.w),
                child: Column(
                  children: [
                    HomeAppBar(
                      title:  "Request Details",
                      onTap: () {
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MedicalRequestsHistoryScreen()),
                                (route) => false);
                      },
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.r)),
                      child: Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: 10.h, horizontal: 8.w),
                        child: Column(
                          children: [
                            Image.asset(
                              request?.medicalRequestDetails?.requestStatus ==
                                      "Rejected"
                                  ? "assets/images/reject.png"
                                  : request?.medicalRequestDetails?.requestStatus ==
                                          "Pending"
                                      ? "assets/images/loading.png"
                                      : "assets/images/approved.png",
                              width:50.w,
                            ),
                            SizedBox(
                              height: 5.h,
                            ),
                            Text(
                              request?.medicalRequestDetails?.requestStatus ?? "",
                              style: TextStyle(
                                color:request?.medicalRequestDetails?.requestStatus ==
                                    "Rejected"
                                    ? AppColors.redColor:request?.medicalRequestDetails?.requestStatus ==
                                    "Approved"
                                    ? AppColors.greenColor:AppColors.mainColor,
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
                              "${request?.medicalRequestDetails?.medicalRequest?.requestType == 1 ? "Medication" :
                              request?.medicalRequestDetails?.medicalRequest?.requestType == 2 ? "CheckUps" :
                              "SickLeave"} Request",
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
                                  "Request Details",
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
                                  borderRadius: BorderRadius.circular(15.r),
                                  color: Color(0xFFf6f6f6)),
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: 10.h, horizontal: 8.w),
                                child: Row(
                                  children: [
                                    ClipOval(
                                      child: Image.network(
                                        employeeImageUrl ?? "",
                                        height: 50.w,
                                        width: 50.w,
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10.w,
                                    ),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Employee Name",
                                          style: TextStyle(
                                            color: AppColors.greyDark,
                                            fontFamily: "Certa Sans",
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.w500,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        SizedBox(
                                          height: 5.h,
                                        ),
                                        SizedBox(
                                          width: 150.w,
                                          child: Text(
                                             request?.medicalRequestDetails?.medicalRequest?.requestedBy??"",
                                            style: TextStyle(
                                              color: AppColors.blackColor,
                                              fontFamily: "Certa Sans",
                                              fontSize: 16.sp,
                                              fontWeight: FontWeight.w500,
                                            ),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Spacer(),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      children: [
                                        Text(
                                          "Request ID",
                                          style: TextStyle(
                                            color: AppColors.greyDark,
                                            fontFamily: "Certa Sans",
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.w500,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        SizedBox(
                                          height: 5.h,
                                        ),
                                        Text(
                                          request?.medicalRequestDetails
                                                  ?.medicalRequestId ??
                                              "",
                                          style: TextStyle(
                                            color: AppColors.blackColor,
                                            fontFamily: "Certa Sans",
                                            fontSize: 16.sp,
                                            fontWeight: FontWeight.w500,
                                          ),
                                          overflow: TextOverflow.ellipsis,
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
                              title: "Created by",
                              value: request?.medicalRequestDetails?.medicalRequest
                                      ?.createdBy ??
                                  "",
                            ),
                            SizedBox(
                              height: 5.h,
                            ),
                            InfoField(
                              title: "Request For",
                              value: request?.medicalRequestDetails?.medicalRequest
                                      ?.requestedFor ??
                                  "",
                            ),
                            SizedBox(
                              height: 5.h,
                            ),
                            InfoField(
                                title: "Employee Coverage",
                                value: request?.medicalRequestDetails?.medicalRequest
                                    ?.employeeCoverage??""
                            ),
                            SizedBox(
                              height: 5.h,
                            ),
                            InfoField(
                              title: "Monthly Medication",
                              value: request?.medicalRequestDetails?.medicalRequest
                                          ?.monthlyMedication ==
                                      true
                                  ? "Yes"
                                  : "No",
                            ),
                            SizedBox(
                              height: 5.h,
                            ),
                            InfoField(
                                title: "Time", value:  requestDate),
                            SizedBox(
                              height: 5.h,
                            ),
                            SizedBox(
                              height: 5.h,
                            ),
                            InfoField(
                                title: "Medical Entity",
                                value: request?.medicalRequestDetails?.medicalRequest
                                    ?.medicalEntity??""
                            ),
                            SizedBox(
                              height: 5.h,
                            ),
                            InfoField(
                                title: "Medical Purpose",
                                value: request?.medicalRequestDetails?.medicalRequest
                                    ?.medicalPurpose??""
                            ),
                            SizedBox(
                              height: 5.h,
                            ),
                            request?.medicalRequestDetails?.medicalRequest?.attachment!=null?
                            Row(
                              children: [
                                Text(
                                  "Documents",
                                  style: TextStyle(
                                    color: AppColors.mainColor,
                                    fontFamily: "Cairo",
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Spacer(),
                                IconButton(
                                    padding: EdgeInsets.zero,
                                    constraints: const BoxConstraints(),
                                    onPressed: () {
                                      Navigator.of(context).push(MaterialPageRoute(
                                          builder: (_) => GalleryScreen(
                                            images: request?.medicalRequestDetails?.medicalRequest?.attachment??[],
                                            index:0,
                                            numberColor: AppColors.blackColor,
                                          )));
                                    },
                                    icon: Icon(
                                      Icons.attachment,
                                      color: Color(0xFFdddddd),
                                    ))
                              ],
                            ):SizedBox(),
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
                                  "Response Details",
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
                            request?.medicalRequestDetails?.requestStatus=="Pending"?
                            Padding(
                              padding:EdgeInsets.only(top: 20.h),
                              child: FadingText('Loading...',style: TextStyle(
                                color:Color(0xFF2c93e7),
                                fontFamily: "Certa Sans",
                                fontSize: 20.sp,
                                fontWeight: FontWeight.w600,
                              ),),
                            ):
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 5.h,
                                ),
                                InfoField(
                                  title: "Created by",
                                  value: request?.medicalRequestDetails?.medicalResponse?.createdBy ??
                                      "",
                                ),
                                InfoField(
                                    title: "Time", value:responseDate??""),
                                InfoField(
                                  title: "Feedback",
                                  value: request?.medicalRequestDetails?.medicalResponse
                                          ?.feedback ??
                                      "",
                                ),
                                InfoField(
                                  title: "Comment",
                                  value: request?.medicalRequestDetails?.medicalResponse
                                          ?.responseComment ??
                                      "",
                                ),
                                request?.medicalRequestDetails?.medicalResponse?.attachment!=null?
                                Row(
                                  children: [
                                    Text(
                                      "Documents",
                                      style: TextStyle(
                                        color: AppColors.mainColor,
                                        fontFamily: "Certa Sans",
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w600,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    const Spacer(),
                                    IconButton(
                                        padding: EdgeInsets.zero,
                                        constraints: const BoxConstraints(),
                                        onPressed: () {
                                          Navigator.of(context).push(MaterialPageRoute(
                                              builder: (_) => GalleryScreen(
                                                images: request?.medicalRequestDetails?.medicalRequest?.attachment??[],
                                                index:0,
                                                numberColor: AppColors.blackColor,
                                              )));
                                        },
                                        icon: Icon(
                                          Icons.attachment,
                                          color: Color(0xFFdddddd),
                                        ))
                                  ],
                                ):SizedBox(),
                                InfoField(
                                  title: "Entity",
                                  value: request?.medicalRequestDetails?.medicalResponse
                                          ?.medicalEntity ??
                                      "",
                                ),
                                Row(
                                  children: [
                                    Text(
                                      "Medical Items ",
                                      style: TextStyle(
                                        color: AppColors.mainColor,
                                        fontFamily: "Certa Sans",
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w600,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    Text(
                                      "(${request?.medicalRequestDetails?.medicalResponse?.medicalItems?.length.toString()??""})",
                                      style: TextStyle(
                                        color: AppColors.mainColor,
                                        fontFamily: "Certa Sans",
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w600,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height:10.h,
                                ),
                                SizedBox(
                                  height: 80.h,
                                  child: ListView.separated(
                                    scrollDirection: Axis.horizontal,
                                      itemBuilder:(context,index)=>Container(
                                    decoration: BoxDecoration(
                                      color: AppColors.whiteColor,
                                      borderRadius: BorderRadius.circular(15.r),
                                      border: Border.all(
                                        width: 0.1.w,
                                        color: AppColors.greyDark
                                      )
                                    ),
                                        child: Padding(
                                          padding:EdgeInsets.symmetric(horizontal: 16.w),
                                          child: Row(
                                            children: [
                                              Image.asset("assets/images/capsules_10895948.png",width: 40.w,),
                                             SizedBox(
                                               width: 15.w,
                                             ),
                                              Column(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    "Omega 3",
                                                    style: TextStyle(
                                                      color: AppColors.blackColor,
                                                      fontFamily: "Certa Sans",
                                                      fontSize: 14.sp,
                                                      fontWeight: FontWeight.w600,
                                                    ),
                                                    overflow: TextOverflow.ellipsis,
                                                  ),
                                                  Text(
                                                    "30 Items",
                                                    style: TextStyle(
                                                      color: AppColors.greyDark,
                                                      fontFamily: "Certa Sans",
                                                      fontSize: 12.sp,
                                                      fontWeight: FontWeight.w600,
                                                    ),
                                                    overflow: TextOverflow.ellipsis,
                                                  ),
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                  ),
                                    itemCount: 3,
                                    separatorBuilder: (BuildContext context, int index)=>SizedBox(width: 15.w,),
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
