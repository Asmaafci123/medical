import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:more4u/presentation/pending_requests/cubits/pending_requests_cubit.dart';

import '../../../core/constants/app_strings.dart';
import '../../../core/themes/app_colors.dart';
import '../../../custom_icons.dart';
import '../../Login/widgets/cutom_text_form_field.dart';

class ReasonAndComment extends StatefulWidget {
  final String status;
  const ReasonAndComment({super.key,required this.status});

  @override
  State<ReasonAndComment> createState() => _ReasonAndCommentState();
}

class _ReasonAndCommentState extends State<ReasonAndComment> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.r)
      ),
      scrollable: true,
      content: Form(
        key: _formKey,
        child:Padding(
          padding: EdgeInsets.fromLTRB(0,10.h,0,10.h),
          child:  Column(
            children: [
              // DropdownButtonFormField(
              //   style: TextStyle(
              //       color: AppColors.mainColor, fontSize: 12.sp),
              //   validator: (String? value) {
              //     if (value == null) return AppStrings.required.tr();
              //     return null;
              //   },
              //   decoration: InputDecoration(
              //     isDense: false,
              //     contentPadding: EdgeInsets.symmetric(
              //         vertical: 10.h, horizontal: 8.w),
              //     suffixIconConstraints:
              //     BoxConstraints(minHeight: 50.h, minWidth: 50.w),
              //     prefixIconConstraints:
              //     BoxConstraints(minHeight: 20.h, minWidth: 40.w),
              //     prefixIcon: Image(
              //       image: AssetImage(
              //         'assets/images/language.png',
              //       ),
              //       height: 25.h,
              //       fit: BoxFit.contain,
              //     ),
              //     border: const OutlineInputBorder(),
              //     labelText: "Reason",
              //     hintText: "Choose your Reason",
              //     labelStyle: TextStyle(fontSize: 14.sp),
              //     hintStyle: TextStyle(
              //         color: Color(0xffc1c1c1), fontSize: 12.sp),
              //     errorStyle: TextStyle(fontSize: 12.sp),
              //     floatingLabelBehavior: FloatingLabelBehavior.always,
              //   ),
              //   items: PendingRequestsCubit.get(context).medicalRequestDetails!.medicalResponse!.feedbackCollection!.map((String value) {
              //     return DropdownMenuItem<String>(
              //       value: value,
              //       child: Text(value),
              //     );
              //   }).toList(),
              //   onChanged: (String? newValue) {
              //    PendingRequestsCubit.get(context).changeSelectedFeedback(newValue);
              //   },
              //   iconSize: 20.r,
              // ),
              // SizedBox(
              //   height: 30.h,
              // ),
              CustomTextFormField(
                prefixIcon: Icon(
                  Icons.comment_bank_outlined,
                  size: 20.r,
                ),
                labelText: "Feedback",
                hintText: "Enter Your Feedback",
                keyboardType: TextInputType.text,
                controller: PendingRequestsCubit.get(context).responseCommentController,
                suffixIconConstraints:
                BoxConstraints(maxHeight: 20.h, minWidth: 50.w),
                prefixIconConstraints:
                BoxConstraints(minHeight: 20.h, minWidth: 40.w),
                obscureText: false,
              ),
              SizedBox(
                height: 40.h,
              ),
              GestureDetector(
                onTap: () async{
                  Navigator.pop(context);
               PendingRequestsCubit.get(context).sendDoctorResponse(
                   PendingRequestsCubit.get(context).medicalRequestDetails!.medicalRequestId!,widget.status
               );
                },
                child: Container(
                  height: 40.h,
                  width: 120.w,
                  decoration: BoxDecoration(
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
                      borderRadius: BorderRadius.circular(15.r)),
                  child: Center(
                    child: Text(
                      "Send",
                      style: TextStyle(
                          color: AppColors.whiteColor,
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              ),
            ],
          ),
        )
      ),
    );
  }
}
