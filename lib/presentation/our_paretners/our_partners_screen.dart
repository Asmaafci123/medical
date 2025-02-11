import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:badges/badges.dart' as bg;
import 'package:more4u/presentation/our_paretners/search_partners_screen.dart';
import 'package:more4u/presentation/widgets/utils/loading_dialog.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../../core/constants/app_strings.dart';
import '../../core/themes/app_colors.dart';
import '../../data/models/category-model.dart';
import '../../data/models/details-of-medical-model.dart';
import '../doctors/doctor.dart';
import '../home/widgets/app_bar.dart';
import '../medical_benefits/medical_benefits_screen.dart';
import '../more4u_home/cubits/more4u_home_cubit.dart';
import '../widgets/drawer_widget.dart';
import '../widgets/helpers.dart';
import '../widgets/utils/message_dialog.dart';
class OurPartnersScreen extends StatefulWidget {
  static const routeName = 'OurPartnersScreen';
  const OurPartnersScreen({super.key});

  @override
  State<OurPartnersScreen> createState() => _OurPartnersScreenState();
}

class _OurPartnersScreenState extends State<OurPartnersScreen> {
  bool loadingSkeletonizer=true;
  @override
  void initState()
  {

    More4uHomeCubit.get(context).getMedical();
    super.initState();
    loadingSkeletonizer=true;
  }
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<More4uHomeCubit, More4uHomeState>(
      listener: (context, state)
      {
        // if(state is GetMedicalLoadingState)
        //   {
        //     loadingAlertDialog(context);
        //   }
        if(state is GetMedicalSuccessState)
          {loadingSkeletonizer=false;
           // Navigator.pop(context);

          }
          if (state is GetMedicalErrorState) {
          {
            if (state.message == AppStrings.sessionHasBeenExpired.tr()) {
              showMessageDialog(
                  context: context,
                  isSucceeded: false,
                  message: state.message,
                  onPressedOk: () {
                    logOut(context);
                  });
            }
            else {
              showMessageDialog(
                context: context,
                isSucceeded: false,
                message: state.message,
                onPressedOk: () => Navigator.pop(context),
              );
            }
          }
        }
      },
      builder: (context, state) {
        List<CategoryModel>result=More4uHomeCubit.get(context).getSubCategory(AppStrings.clinics.tr());
        return Scaffold(
          backgroundColor: Color(0xffecf0f6),
          drawer: const DrawerWidget(),
          body:SafeArea(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(16.w, 14.h, 16.w, 0.h),
                  child: HomeAppBar(
                    title:AppStrings.partnerShips.tr(),
                    onTap: () {
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  MedicalBenefitsScreen()),
                              (route) => false);
                    },
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 100.h,
                        color: AppColors.whiteColor,
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16.w,vertical: 20.h),
                          child: TextField(
                            style: TextStyle(fontSize: 12.sp),
                            onTap: (){
                              Navigator.pushNamed(context,SearchPartnersScreen.routeName);
                            },
                            // controller: _cubit.searchInMyMedicalRequestsController,
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                              hintText: AppStrings.searchDoctorOrHospitalOrCenter.tr(),
                              isDense: true,
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 12.h, horizontal: 11.w),
                              fillColor: Colors.white,
                              filled: true,
                              hintStyle: TextStyle(
                                fontFamily: "Certa Sans",
                                fontSize: 14.sp
                              ),
                              labelStyle:TextStyle(
                                  fontFamily: "Certa Sans",
                                  fontSize: 14.sp
                              ) ,
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
                        height: 10.h,
                      ),
                      state is GetMedicalLoadingState?
                      Container(
                        height: 160.h,
                        width: double.infinity,
                        color: AppColors.whiteColor,
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 20.h,horizontal: 10.w),
                          child: ListView.separated(
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context,index)=>Skeletonizer(
                              enabled: loadingSkeletonizer,
                              child: Column(
                                  children: [
                                    CircleAvatar(
                                        backgroundColor:Color(0xfff2f3f8),
                                        radius: 35.r,
                                    ),
                                    SizedBox(
                                      height: 5.h,
                                    ),
                                    Text(
                                      "medical details count",
                                      style: TextStyle(
                                          color: AppColors.greyDark,
                                          fontSize: 12.sp,
                                          fontFamily: "Certa Sans",
                                          fontWeight: FontWeight.w500
                                      ),),
                                    SizedBox(
                                      height: 5.h,
                                    ),
                                    Text(
                                      "sub category name",
                                      style: TextStyle(
                                          color: AppColors.mainColor,
                                          fontSize: 16.sp,
                                          fontFamily: "Certa Sans",
                                          fontWeight: FontWeight.w600
                                      ),)
                                  ],
                                ),
                              ),
                            itemCount:5,
                            separatorBuilder: (BuildContext context, int index)=>SizedBox(
                              width: 15.w,
                            ),)
                        ),
                      ):
                      Container(
                        height: 160.h,
                        width: double.infinity,
                        color: AppColors.whiteColor,
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 20.h,horizontal: 10.w),
                          child: ListView.separated(
                            scrollDirection: Axis.horizontal,
                              itemBuilder: (context,index)=>Skeletonizer(
                                enabled: loadingSkeletonizer,
                                child: GestureDetector(
                                  onTap: ()
                                  {
                                    List<DetailsOfMedicalModel>result=More4uHomeCubit.get(context).getDetailsOfMedical(More4uHomeCubit.get(context).cat[index].categoryName!,More4uHomeCubit.get(context).cat[index].categoryName!);
                                    Navigator.push(context,MaterialPageRoute(builder: (context)=>Doctors(details: result,title:More4uHomeCubit.get(context).cat[index].categoryName!)));
                                  },
                                  child: Column(
                                    children: [
                                      CircleAvatar(
                                        backgroundColor:Color(0xfff2f3f8),
                                        radius: 35.r,
                                        child: Image.network(
                                          More4uHomeCubit.get(context).cat[index].categoryImage??"",
                                          fit: BoxFit.cover,
                                          width: 35.w,
                                        )
                                      ),
                                      SizedBox(
                                        height: 5.h,
                                      ),
                                      Text("${ More4uHomeCubit.get(context).getDetailsOfMedical(More4uHomeCubit.get(context).cat[index].categoryName!,More4uHomeCubit.get(context).cat[index].categoryName!).length} ${AppStrings.items.tr()}",
                                        style: TextStyle(
                                            color: AppColors.greyDark,
                                            fontSize: 12.sp,
                                            fontFamily: "Certa Sans",
                                            fontWeight: FontWeight.w500
                                        ),),
                                      SizedBox(
                                        height: 5.h,
                                      ),
                                      Text(More4uHomeCubit.get(context).cat[index].categoryName??"",
                                        style: TextStyle(
                                          color: AppColors.mainColor,
                                          fontSize: 16.sp,
                                            fontFamily: "Certa Sans",
                                          fontWeight: FontWeight.w600
                                        ),)
                                    ],
                                  ),
                                ),
                              ),
                            itemCount:More4uHomeCubit.get(context).cat.length,
                            separatorBuilder: (BuildContext context, int index)=>SizedBox(
                              width: 15.w,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.w,vertical: 20.h),
                        child: Text(AppStrings.clinicsList.tr(),
                          style: TextStyle(
                              color: AppColors.greyDark,
                              fontWeight: FontWeight.w600,
                              fontFamily: "Certa Sans",
                              fontSize: 22.sp
                          ),
                        ),
                      ),

                      state is GetMedicalLoadingState?
                      Flexible(
                        child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(40.r),
                                topRight: Radius.circular(40.r)
                            ),
                            color: AppColors.whiteColor,
                          ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 20.h,horizontal:30.w),
                            child:
                            ListView.builder(itemBuilder:(context,index)=>Skeletonizer(
                              enabled: loadingSkeletonizer,
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "sub Category name",
                                            style: TextStyle(
                                              color: AppColors.mainColor,
                                              fontWeight: FontWeight.w600,
                                              fontSize: 18.sp,
                                              fontFamily: "Certa Sans",
                                            ),
                                          ),
                                          SizedBox(
                                            height: 10.h,
                                          ),
                                          Text(
                                            "medical details count",
                                            style: TextStyle(
                                                color: AppColors.greyDark,
                                                fontWeight: FontWeight.w500,
                                                fontFamily: "Certa Sans",
                                                fontSize: 16.sp
                                            ),
                                          ),
                                        ],
                                      ),
                                      Spacer(),
                                      Image.network(
                                        "https://more4u.cemex.com.eg/more4u/images/MedicalCategory/hospital.png",
                                        fit: BoxFit.cover,
                                        width: 35.w,
                                      )
                                    ],
                                  ),
                                  index!=result.length-1?
                                  SizedBox(
                                    height: 10.h,
                                  ):SizedBox(
                                  ),
                                  index!=result.length-1?  Divider(
                                    indent: 5.w,
                                    endIndent: 5.w,
                                    color: AppColors.greyText,
                                    thickness: 0.2,
                                  ):SizedBox(),
                                  index!=result.length-1?
                                  SizedBox(
                                    height: 10.h,
                                  ):SizedBox(),
                                ],
                              ),
                            ),
                              itemCount:5,
                            ),
                          ),
                        ),
                      ):
                      Flexible(
                        child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(40.r),
                              topRight: Radius.circular(40.r)
                            ),
                            color: AppColors.whiteColor,
                          ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 20.h,horizontal:30.w),
                            child:
                            ListView.builder(itemBuilder:(context,index)=>Skeletonizer(
                              enabled: loadingSkeletonizer,
                              child: InkWell(
                                onTap: ()
                                {
                                   List<DetailsOfMedicalModel>clinicsResult=More4uHomeCubit.get(context).getDetailsOfMedical(AppStrings.clinics.tr(),result[index].subCategoryName!);
                                  Navigator.push(context,MaterialPageRoute(builder: (context)=>Doctors(details: clinicsResult,title:result[index].subCategoryName!)));
                                },
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(result[index].subCategoryName??"",
                                              style: TextStyle(
                                                  color: AppColors.mainColor,
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 18.sp,
                                                fontFamily: "Certa Sans",
                                              ),
                                            ),
                                            SizedBox(
                                              height: 10.h,
                                            ),
                                            Text(
                                              "${More4uHomeCubit.get(context).getDetailsOfMedical(result[index].categoryName!,result[index].subCategoryName!).length.toString()} ${AppStrings.items.tr()}",
                                              style: TextStyle(
                                                  color: AppColors.greyDark,
                                                  fontWeight: FontWeight.w500,
                                                  fontFamily: "Certa Sans",
                                                  fontSize: 16.sp
                                              ),
                                            ),
                                          ],
                                        ),
                                       Spacer(),
                                        Image.network(
                                          result[index].subCategoryImage??"",
                                          fit: BoxFit.cover,
                                          width: 35.w,
                                        )
                                      ],
                                    ),
                                    index!=result.length-1?
                                    SizedBox(
                                      height: 10.h,
                                    ):SizedBox(
                                    ),
                                    index!=result.length-1?  Divider(
                                      indent: 5.w,
                                      endIndent: 5.w,
                                      color: AppColors.greyText,
                                      thickness: 0.2,
                                    ):SizedBox(),
                                    index!=result.length-1?
                                    SizedBox(
                                      height: 10.h,
                                    ):SizedBox(),
                                  ],
                                ),
                              ),
                            ),
                              itemCount: result.length,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
        );
      },
    );
  }
}
