import 'package:auto_size_text/auto_size_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:more4u/core/constants/constants.dart';
import 'package:more4u/data/models/details-of-medical-model.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../core/constants/app_strings.dart';
import '../../core/themes/app_colors.dart';
import '../../core/utils/bottom_sheet/src/flexible_bottom_sheet_route.dart';
import 'banner.dart';

class WidgetOfSubCategory extends StatelessWidget {
  final DetailsOfMedicalModel obj;
  const WidgetOfSubCategory({Key? key, required this.obj}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print("ttttttttttttttttttttttt");
    print(obj.categoryName);
    return GestureDetector(
      onTap: () {
        print("aaaaaaaaaaaaaaa");
        showModalBottomSheet(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(25.r),
                    topRight: Radius.circular(25.r))),
            context: context,
            constraints: BoxConstraints(
              minWidth: 100.h,
              maxWidth: double.infinity,
              minHeight: 0.0,
              maxHeight:600.h,
            ),
            isScrollControlled: true,
            backgroundColor: Colors.white,
            builder: (BuildContext context) {
              return ClipRRect(
                child: MyBanner(
                  message: obj.categoryName!,
                  textStyle:
                      TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w700,fontFamily: "Certa Sans",),
                  location: BannerLocation.topEnd,
                  color: AppColors.mainColor,
                  child: Scrollbar(
                  // controller: scrollController,
                    thumbVisibility: true,
                    child: ClipRRect(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(25.r),
                          topRight: Radius.circular(25.r)),
                      child: ListView(
                        padding: EdgeInsets.zero,
                        shrinkWrap: true,
                        //controller: scrollController,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(25.r),
                                topRight: Radius.circular(25.r)),
                            child: Image.network(
                              obj.medicalDetailsImage!,
                              errorBuilder: (context, error, stackTrace) =>
                                  Image.asset(
                                      "assets/images/alzahra_hospital.jpg"),
                            ),
                          ),
                          SizedBox(
                            height: 30.h,
                          ),
                          Column(
                            children: [
                              AutoSizeText(
                                obj.medicalDetailsName ?? '',
                                style: TextStyle(
                                  // color:Colors.white,
                                  color: AppColors.mainColor,
                                  fontSize: 24.sp,
                                  fontFamily: "Certa Sans",
                                  fontWeight: FontWeight.w500,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              SizedBox(
                                height: 30.h,
                              ),
                              Column(
                                children: List.generate(
                                  divideData(obj.medicalDetailsMobile ?? '')
                                      .length,
                                  (index) => Column(
                                    children: [
                                      GestureDetector(
                                        onTap: ()async
                                        {
                                          String phoneNumber=divideData(
                                              obj.medicalDetailsMobile ??
                                                  '')[index];
                                          await launchUrl(Uri.parse("tel://$phoneNumber"),mode: LaunchMode.externalApplication,);
                                        },
                                        child: Container(
                                          width: 180.w,
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                                color: Colors.black,
                                                width: 1.5.w),
                                          ),
                                          child: Center(
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Icon(
                                                  Icons.phone,
                                                  color: AppColors.mainColor,
                                                ),
                                                SizedBox(
                                                  width: 5.w,
                                                ),
                                                Text(
                                                  divideData(
                                                      obj.medicalDetailsMobile ??
                                                          '')[index],
                                                  style: TextStyle(
                                                    fontSize: 15.sp,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      index !=
                                              divideData(obj.medicalDetailsMobile ??
                                                          '')
                                                      .length -
                                                  1
                                          ? SizedBox(
                                              height: 14.h,
                                            )
                                          : const SizedBox(
                                              height: 0,
                                            ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 30.h,
                              ),
                              Text(
                                AppStrings.workingHoursMedical.tr(),
                                style: TextStyle(
                                  // color:Colors.white,
                                  color: AppColors.mainColor,
                                  fontSize: 20.sp,
                                  fontFamily: "Certa Sans",
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              SizedBox(
                                height: 5.h,
                              ),
                              Padding(
                                padding: EdgeInsets.fromLTRB(25.w, 0, 25.w, 0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Icon(
                                      Icons.watch_later_sharp,
                                      color: AppColors.redColor,
                                      size: 20.sp,
                                    ),
                                    SizedBox(
                                      width: 5.w,
                                    ),
                                    Expanded(
                                      child: AutoSizeText(
                                        obj.medicalDetailsWorkingHours??"",
                                        style: TextStyle(
                                          // color:Colors.white,
                                          color: AppColors.mainColor,
                                          fontSize: 16.sp,
                                          fontFamily: "Certa Sans",
                                          fontWeight:
                                          FontWeight.w400,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 30.h,
                              ),
                              Padding(
                                padding: EdgeInsets.fromLTRB(25.w, 0, 25.w, 0),
                                child: Container(
                                  color: Colors.white,
                                  width: double.infinity,
                                  child: Center(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          AppStrings.locations.tr(),
                                          style: TextStyle(
                                            // color:Colors.white,
                                            color: AppColors.mainColor,
                                            fontSize: 20.sp,
                                            fontFamily: "Certa Sans",
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 5.h,
                                        ),
                                        Column(
                                          children: List.generate(
                                            divideData(
                                                    obj.medicalDetailsAddress ??
                                                        '')
                                                .length,
                                            (index) => Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              children: [
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Icon(
                                                      Icons.location_on,
                                                      color: AppColors.redColor,
                                                      size: 20.sp,
                                                    ),
                                                    Expanded(
                                                      child: AutoSizeText(
                                                        divideData(
                                                            obj.medicalDetailsAddress ??
                                                                '')[index],
                                                        style: TextStyle(
                                                          // color:Colors.white,
                                                          color: AppColors.mainColor,
                                                          fontSize: 16.sp,
                                                          fontFamily: "Certa Sans",
                                                          fontWeight:
                                                              FontWeight.w400,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                index !=
                                                        divideData(obj.medicalDetailsAddress ??
                                                                    '')
                                                                .length -
                                                            1
                                                    ? SizedBox(
                                                        height: 14.h,
                                                      )
                                                    : const SizedBox(
                                                        height: 0,
                                                      ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 15.h,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            }).whenComplete(() => true);
      },
      child: SizedBox(
        width:330.w,
        height: 120.h,
        child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
          elevation: 5,
          shadowColor: Colors.grey,
          child: Padding(
            padding:  EdgeInsets.symmetric(horizontal: 10.w,vertical: 6.h),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Container(
                    width: 100.w,
                    decoration: BoxDecoration(
                      borderRadius:  BorderRadius.circular(8.0),
                    ),
                    child: Image.network(
                      obj.medicalDetailsImage!,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) =>
                          Image.asset(
                              "assets/images/alzahra_hospital.jpg"),
                    ),
                  ),
                ),
                SizedBox(
                  width: 15.w,
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AutoSizeText(
                        maxLines: 4,
                        obj.medicalDetailsName!,
                        style:TextStyle(
                            fontSize: 18.sp,
                            fontFamily: "Certa Sans",
                            fontWeight: FontWeight.w200,
                          color: AppColors.mainColor
                        ),
                      ),
                      SizedBox(
                       height: 8.h,
                      ),
                      divideData(
                          obj.medicalDetailsAddress ??
                              '')[0].isNotEmpty?
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.location_on,
                            color: AppColors.greyDark,
                            size: 12.sp,
                          ),
                          SizedBox(
                            width: 2.w,
                          ),
                          Expanded(
                            child: AutoSizeText(
                              maxLines: 4,
                              divideData(
                                  obj.medicalDetailsAddress ??
                                      '')[0]??"",
                              style:TextStyle(
                                  fontSize: 14.sp,  fontFamily: "Certa Sans",fontWeight: FontWeight.w100,
                                color: AppColors.greyDark,
                              ),
                            ),
                          ),
                        ],
                      ):SizedBox(),
                      SizedBox(
                        height: 8.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                             borderRadius: BorderRadius.circular(4.r),
                              border: Border.all(
                                color: AppColors.greyDark,
                                width: 0.3.w
                              )
                            ),
                            child: Padding(
                              padding:  EdgeInsets.symmetric(horizontal: 10.w,vertical: 5.h),
                              child: Row(
                                children: [
                                  Text("View",style: TextStyle(
                                    color: AppColors.blackColor,
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w100,
                                    fontFamily: "Certa Sans",
                                  ),),
                                  Icon(
                                    Icons.arrow_forward_ios_outlined,
                                    color: AppColors.blackColor,
                                    size: 12.sp,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  List<String> divideData(String input) {
    List<String> phones = input.split('&');
    return phones;
  }
}



/*
Stack(
        children: [
          SizedBox(
            width: double.infinity,
            height: 100.h,
          ),
          Positioned(
            top: 10.h,
            child: SizedBox(
              width:330.w,
              height: 90.h,
              child: Card(
                shape:
                    RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.r)),
                elevation: 3,
                shadowColor: Colors.grey,
                child: Padding(
                  padding: EdgeInsets.fromLTRB(120.w, 0,10.w, 0),
                  child: Row(
                    children: [
                      // SizedBox(
                      //   width: 80.w,
                      // ),
                      Expanded(
                        child: AutoSizeText(
                          maxLines: 4,
                          obj.medicalDetailsName!,
                          style:TextStyle(fontSize: 16.sp,  fontFamily: "Certa Sans",fontWeight: FontWeight.w200),
                        ),
                      ),
                      SizedBox(
                        width: 10.w,
                      ),
                      // Padding(
                      //   padding:EdgeInsets.fromLTRB(5.w, 0, 5.w, 0),
                      //   child: Container(
                      //     width: 22.w,
                      //     height: 22.w,
                      //     decoration: BoxDecoration(
                      //       borderRadius: BorderRadius.circular(15.r),
                      //       color: AppColors.mainColor,
                      //     ),
                      //     child: Icon(Icons.arrow_downward_rounded,
                      //       fill: 1
                      //       ,color:Colors.white,size: 16.sp,),
                      //   ),
                      // ),
                      CircleAvatar(
                        radius: 12.r,
                        backgroundColor:
                        Colors.transparent,
                        child: Container(
                            decoration:
                            BoxDecoration(
                              shape:
                              BoxShape.circle,
                              gradient:
                              LinearGradient(
                                colors: [
                                  Color(0xFF446CFF),
                                  Color(0xFF1E9AFF),
                                ],
                              ),
                            ),
                            child: Center(
                                child: Icon(
                                  Icons
                                      .arrow_forward_ios_outlined,
                                  size: 14.sp,
                                  color: AppColors
                                      .whiteColor,
                                ))),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            left: 10.w,
            child: Card(
                elevation: 0,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.r)),
                shadowColor: Color(0xFF446CFF),
                child: Container(
                  height: 80.h,
                  width: 90.w,
                  decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(15.r)),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20.0),
                    child: Image.network(
                        obj.medicalDetailsImage!,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) =>
                          Image.asset(
                              "assets/images/alzahra_hospital.jpg"),
                    ),
                  ),
                )),)
        ],
      )
 */