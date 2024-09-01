import 'package:auto_size_text/auto_size_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:more4u/core/themes/app_colors.dart';
import 'package:more4u/custom_icons.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../core/constants/app_strings.dart';
import '../../../data/models/details-of-medical-model.dart';
import '../../widgets/banner.dart';
class MedicalItemCard extends StatelessWidget {
  final DetailsOfMedicalModel item;
  const MedicalItemCard({Key? key,required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<String>?splittedStrings=[];
    splittedStrings=item.medicalDetailsName?.split(" ");
    String? itemName1=splittedStrings?[0];
    String? itemName2=splittedStrings?[1];
    String? itemName="${itemName1!} ${itemName2!}";
    return GestureDetector(
      onTap: ()
      {
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
                  message: item.categoryName!,
                  textStyle:
                  TextStyle(fontSize: 10.sp, fontWeight: FontWeight.w700),
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
                              item.medicalDetailsImage!,
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
                                item.medicalDetailsName ?? '',
                                style: TextStyle(
                                  // color:Colors.white,
                                  color: AppColors.mainColor,
                                  fontSize: 24.sp,
                                  fontFamily: 'Joti',
                                  fontWeight: FontWeight.w500,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              SizedBox(
                                height: 30.h,
                              ),
                              Column(
                                children: List.generate(
                                  divideData( item.medicalDetailsMobile ?? '')
                                      .length,
                                      (index) => Column(
                                    children: [
                                      GestureDetector(
                                        onTap: ()async
                                        {
                                          String phoneNumber=divideData(
                                              item.medicalDetailsMobile ??
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
                                                      item.medicalDetailsMobile ??
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
                                          divideData( item.medicalDetailsMobile ??
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
                                  fontFamily: "Roboto",
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
                                        item.medicalDetailsWorkingHours??"",
                                        style: TextStyle(
                                          // color:Colors.white,
                                          color: AppColors.mainColor,
                                          fontSize: 16.sp,
                                          fontFamily:
                                          "Roboto",
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
                                            fontFamily: "Roboto",
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 5.h,
                                        ),
                                        Column(
                                          children: List.generate(
                                            divideData(
                                                item.medicalDetailsAddress ??
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
                                                            item.medicalDetailsAddress ??
                                                                '')[index],
                                                        style: TextStyle(
                                                          // color:Colors.white,
                                                          color: AppColors.mainColor,
                                                          fontSize: 16.sp,
                                                          fontFamily:
                                                          "Roboto",
                                                          fontWeight:
                                                          FontWeight.w400,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                index !=
                                                    divideData( item.medicalDetailsAddress ??
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
      child: Card(
        elevation: 1,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.r)
        ),
        child: Container(
          height: 80.h,
          decoration: BoxDecoration(
            color: Color(0xFFc4e9f2),
            borderRadius: BorderRadius.circular(15.r)
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w,vertical: 10.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(
                      color:AppColors.whiteColor,
                      borderRadius: BorderRadius.circular(15.r)
                  ),
                  child: Image.network(item.medicalDetailsImage??"",width: 50.w,),
                ),
                SizedBox(
                  width: 16.w,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(itemName,style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16.sp,
                        color: AppColors.mainColor
                    ),),
                    Row(
                      children: [
                        Text(item.categoryName??"",style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 12.sp,
                            color: AppColors.greyColor
                        ),),
                        item.categoryName=="Clinics"?Icon(Icons.keyboard_double_arrow_right_sharp,size: 14.sp,):SizedBox(),
                        item.categoryName=="Clinics"?Text(item.subCategoryName??"",style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 12.sp,
                            color: AppColors.greyColor
                        ),):SizedBox(),
                      ],
                    ),
                  ],
                ),
                const Spacer(),
                CircleAvatar(
                  radius: 14.r,
                    backgroundColor: AppColors.whiteColor,
                    child: Icon(Icons.phone,color: AppColors.mainColor,)),
                SizedBox(
                  width: 5.w,
                ),
                CircleAvatar(
                    radius: 14.r,
                    backgroundColor: AppColors.whiteColor,
                    child: Icon(Icons.more_horiz,color: AppColors.mainColor,))
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
