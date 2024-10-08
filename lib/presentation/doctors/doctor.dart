import 'package:auto_size_text/auto_size_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:more4u/core/constants/app_strings.dart';
import 'package:more4u/data/models/details-of-medical-model.dart';
import '../../core/themes/app_colors.dart';
import '../../custom_icons.dart';
import '../home/widgets/app_bar.dart';
import '../more4u_home/cubits/more4u_home_cubit.dart';
import '../our_paretners/our_partners_screen.dart';
import '../widgets/card-of-medical-subCategory.dart';
import '../widgets/drawer_widget.dart';

class Doctors extends StatefulWidget {
  final List<DetailsOfMedicalModel> details;
  final String title;

  const Doctors({Key? key,required this.details,required this.title}) : super(key: key);

  @override
  State<Doctors> createState() => _DoctorsState();
}

class _DoctorsState extends State<Doctors> {
  // @override
  // void dispose() {
  //   HomeCubit.get(context).clearSearchController();
  //   super.dispose();
  // }
  @override
  void initState()
  {
    More4uHomeCubit.get(context).clearSearchController();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<More4uHomeCubit,More4uHomeState>(
  listener: (context, state) {
  },
  builder: (context, state) {
    return Scaffold(
        //appBar: myAppBarMedicalIos(),
        drawer: const DrawerWidget(),
        body: SafeArea(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(4.w, 14.h, 4.w, 0.h),
                  child: HomeAppBar(
                    title: widget.title,
                    onTap: () {
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>OurPartnersScreen()),
                              (route) => false);
                    },
                  ),
                ),
                Expanded(
                  child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.w,vertical: 20.h),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: TextField(
                                    style: TextStyle(fontSize: 14.sp,  fontFamily: "Certa Sans",),
                                    controller:
                                    More4uHomeCubit.get(context).searchMedicalController,
                                    keyboardType: TextInputType.text,
                                    decoration: InputDecoration(
                                      hintText: AppStrings.searchByName.tr(),
                                      hintStyle: TextStyle(fontSize: 14.sp,  fontFamily: "Certa Sans",),
                                      labelStyle: TextStyle(fontSize: 14.sp,  fontFamily: "Certa Sans",),
                                      isDense: true,
                                      contentPadding: EdgeInsets.symmetric(
                                          vertical: 14.h, horizontal: 11.w),
                                      fillColor: Colors.white,
                                      filled: true,
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
                                SizedBox(
                                  width: 5.w,
                                ),
                                InkWell(
                                  borderRadius: BorderRadius.circular(15.r),
                                  onTap: () {
                                    More4uHomeCubit.get(context).searchInMedicalDetails( widget.details,More4uHomeCubit.get(context).searchMedicalController.text);
                                  },
                                  child: Ink(
                                    width: 36.w,
                                    height: 38.w,
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
                            SizedBox(
                              height: 20.h,
                            ),
                            More4uHomeCubit.get(context).searchMedicalController.text.isEmpty?
                            widget.details.isNotEmpty?Expanded(
                                child: ListView.builder(
                                    itemBuilder: (context,index)=>WidgetOfSubCategory(obj: widget.details[index],),
                                  itemCount: widget.details.length,
                                ),
                            ):Expanded(
                              child: Center(
                                child: Text(AppStrings.thereIsNoData.tr()),
                              ),
                            ):
                            More4uHomeCubit.get(context).resultSearchInMedicalDetails.isNotEmpty?Expanded(
                              child: ListView.builder(
                                itemBuilder: (context,index)=>WidgetOfSubCategory(obj:More4uHomeCubit.get(context).resultSearchInMedicalDetails[index],),
                                itemCount:  More4uHomeCubit.get(context).resultSearchInMedicalDetails.length,
                              ),
                            ):Expanded(
                              child: Center(
                                child: Text(AppStrings.thereIsNoData.tr()),
                              ),
                            )
                          ])

                  ),
                ),
              ],
            )
        )
    );
  },
);
  }
}
