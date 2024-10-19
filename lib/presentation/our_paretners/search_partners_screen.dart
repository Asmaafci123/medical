import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:more4u/core/constants/app_strings.dart';
import 'package:more4u/presentation/more4u_home/cubits/more4u_home_cubit.dart';

import '../../core/constants/constants.dart';
import '../../core/themes/app_colors.dart';
import '../../custom_icons.dart';
import '../widgets/card-of-medical-subCategory.dart';
import 'our_partners_screen.dart';

class SearchPartnersScreen extends StatefulWidget {
  static const routeName = 'SearchPartnersScreen';
  const SearchPartnersScreen({Key? key}) : super(key: key);

  @override
  State<SearchPartnersScreen> createState() => _SearchPartnersScreenState();
}

class _SearchPartnersScreenState extends State<SearchPartnersScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocConsumer<More4uHomeCubit, More4uHomeState>(
          listener: (context, state) {
           if(state is SearchInMedicalSuccessState)
             {

             }
          },
          builder: (context, state) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(20.w, 20.h, 20.w, 0.h),
                  child: Row(
                    children: [
                      IconButton(
                          onPressed: () {
                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        OurPartnersScreen()),
                                    (route) => false);
                          },
                          padding: EdgeInsets.zero,
                          constraints: BoxConstraints(),
                          icon: Icon(
                          Icons.arrow_back_ios_new_outlined,
                            color: AppColors.mainColor,
                            size: 20.sp,
                          )),
                      // Spacer(),
                      SizedBox(
                        width: 10.w,
                      ),
                      SizedBox(
                        width: 250.w,
                        child: TextField(
                          style: TextStyle(fontSize: 12.sp),
                          controller: More4uHomeCubit.get(context)
                              .searchMedicalController1,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            hintText: AppStrings.searchDoctorOrHospitalOrCenter.tr(),
                            isDense: true,
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 12.h, horizontal: 11.w),
                            fillColor: Colors.white,
                            filled: true,
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: AppColors.whiteGreyColor,
                                  width: 0.1.w),
                              borderRadius: BorderRadius.circular(15.r),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  width: 0.1.w,
                                  color: AppColors.whiteGreyColor),
                              borderRadius: BorderRadius.circular(15.r),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10.w,
                      ),
                      // IconButton(
                      //     onPressed: (){},
                      //     padding: EdgeInsets.zero,
                      //     constraints: BoxConstraints(),
                      //     icon: Icon(Icons.search_outlined,color: AppColors.mainColor,size: 30.sp,)),
                      InkWell(
                        borderRadius: BorderRadius.circular(15.r),
                        onTap: () {
                          //  _cubit.searchInPendingRequests();
                          if(More4uHomeCubit.get(context)
                              .searchMedicalController1
                              .text.isNotEmpty)
                          {
                            More4uHomeCubit.get(context).searchInMedical(
                                More4uHomeCubit.get(context)
                                    .searchMedicalController1
                                    .text,false);
                          }
                        },
                        child: Ink(
                          width: 38.w,
                          height: 40.w,
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
                    ],
                  ),
                ),
                Divider(
                  indent: 0,
                  endIndent: 0,
                  color: AppColors.greyDark,
                  thickness: 0.2.w,
                ),
                Expanded(
                  child: Padding(
                    padding:
                    EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          AppStrings.recentlySearched.tr(),
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 18.sp,
                              color: AppColors.blackColor),
                        ),
                        SizedBox(
                          height: 5.h,
                        ),
                        recentlySearchOurPartners!=null?
                        Wrap(
                          children:recentlySearchOurPartners!.length<=5?
                          List<Widget>.generate(
                            recentlySearchOurPartners!
                                .length,
                                (int idx) {
                              return Padding(
                                padding: EdgeInsets.only(right: 5.w),
                                child: ChoiceChip(
                                    label: Text( recentlySearchOurPartners![idx]),
                                    selected: false,
                                    onSelected: (bool selected) {
                                      setState(() {
                                        More4uHomeCubit.get(context)
                                            .searchInMedical(
                                            recentlySearchOurPartners![idx],true);
                                      });
                                    }),
                              );
                            },
                          ).toList():
                          List<Widget>.generate(
                            5,
                                (int idx) {
                              return Padding(
                                padding: EdgeInsets.only(right: 5.w),
                                child: ChoiceChip(
                                    label: Text( recentlySearchOurPartners![recentlySearchOurPartners!.length-(5-idx)]),
                                    selected: false,
                                    onSelected: (bool selected) {
                                      setState(() {
                                        More4uHomeCubit.get(context)
                                            .searchInMedical(
                                            recentlySearchOurPartners![recentlySearchOurPartners!.length-(5-idx)],true);
                                      });
                                    }),
                              );
                            },
                          ).toList(),
                        ): SizedBox(),
                        SizedBox(
                          height: 10.h,
                        ),
                        More4uHomeCubit.get(context)
                            .resultList.isNotEmpty?
                        Text(
                          "${AppStrings.searchResult.tr()} (${More4uHomeCubit.get(context)
                              .resultList.length})",
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 18.sp,
                              color: AppColors.blackColor),
                        ): SizedBox(),
                        SizedBox(
                          height: 10.h,
                        ),
                        Expanded(
                          child: ListView.separated(
                              shrinkWrap: true,
                              itemBuilder: (context, index) => WidgetOfSubCategory(obj: More4uHomeCubit.get(context)
                                  .resultList[index],),
                              separatorBuilder: (context, index) => SizedBox(
                                height: 5.h,
                              ),
                              itemCount: More4uHomeCubit.get(context)
                                  .resultList
                                  .length),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
