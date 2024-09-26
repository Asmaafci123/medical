import 'package:dotted_border/dotted_border.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:more4u/core/constants/constants.dart';
import 'package:more4u/presentation/home/home_screen.dart';
import 'package:more4u/presentation/medical_benefits/medical_benefits_screen.dart';
import 'package:more4u/presentation/medication/widgets/check_box.dart';
import 'package:more4u/presentation/medication/widgets/comment.dart';
import 'package:more4u/presentation/medication/widgets/employee_info_2.dart';
import 'package:more4u/presentation/medication/widgets/gallery.dart';
import 'package:more4u/presentation/medication/widgets/search_field.dart';
import 'package:more4u/presentation/medication/widgets/select_family_insurance.dart';
import 'package:more4u/presentation/medication/widgets/select_medical_category.dart';
import 'package:more4u/presentation/medication/widgets/select_medical_entity.dart';
import 'package:toast/toast.dart';
import '../../core/constants/app_strings.dart';
import '../../core/themes/app_colors.dart';
import '../../custom_icons.dart';
import '../../domain/entities/category.dart';
import '../../domain/entities/details-of-medical.dart';
import '../home/widgets/app_bar.dart';
import '../widgets/drawer_widget.dart';
import '../widgets/helpers.dart';
import '../widgets/utils/loading_dialog.dart';
import '../widgets/utils/message_dialog.dart';
import 'cubits/request_medication_cubit.dart';
import 'cubits/request_medication_states.dart';

class RequestMedicationScreen extends StatefulWidget {
  final String medicationType;
  static const routeName = 'RequestMedicationScreen';

  const RequestMedicationScreen({super.key, required this.medicationType});

  @override
  State<RequestMedicationScreen> createState() =>
      _RequestMedicationScreenState();
}

class _RequestMedicationScreenState extends State<RequestMedicationScreen> {
  @override
  Widget build(BuildContext context) {
    var _cubit = RequestMedicationCubit.get(context);
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    ToastContext().init(context);
    return BlocConsumer<RequestMedicationCubit, RequestMedicationState>(
      listener: (context, state) {
        if (state is GetEmployeeRelativesLoadingState) {
          loadingAlertDialog(context);
        }
        if (state is GetEmployeeRelativesSuccessState) {
          if (Navigator.canPop(context)) {
            Navigator.pop(context);
          }
        }
        if (state is GetEmployeeRelativesErrorState) {
          showMessageDialog(
              context: context,
              isSucceeded: true,
              message:"Employee Id ${_cubit.currentEmployee?.cemexId??""} is not exit .",
              onPressedOk: () {
                Navigator.pushNamedAndRemoveUntil(context, HomeScreen.routeName, (route) => false);
              });
        }
        if (state is SendMedicationRequestLoadingState) {
          loadingAlertDialog(context);
        }
        if (state is SendMedicationRequestSuccessState) {
          Navigator.pop(context);
          showMessageDialog(
              context: context,
              isSucceeded: true,
              message:"We are delighted to inform you that we received your request with Id $medicationRequestId.",
              onPressedOk: () {
                Navigator.pushNamedAndRemoveUntil(context, HomeScreen.routeName, (route) => false);
              });
        }
        if (state is SendMedicationRequestErrorState) {
          Navigator.pop(context);
          Toast.show("Failed Request",
              duration: Toast.lengthLong, gravity: Toast.top,backgroundColor: AppColors.redColor);
        }
      },
      builder: (context, state) {
        return Scaffold(
          drawer: const DrawerWidget(),
          body: SingleChildScrollView(
            physics: const ScrollPhysics(),
            child: SafeArea(
                child: Padding(
              padding: EdgeInsets.fromLTRB(16.w, 20.h, 16.w, 10),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    HomeAppBar(
                      title: widget.medicationType == "medication"
                          ? "Medications"
                          : "CheckUps",
                      onTap: () {
                        RequestMedicationCubit.get(context).clearCurrentEmployee();
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MedicalBenefitsScreen()),
                            (route) => false);
                      },
                    ),
                    SizedBox(
                      height: 30.h,
                    ),
                    userData?.isMedicalAdmin == true || userData?.isDoctor == true
                        ? Column(
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: Container(
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(50.r),
                                          boxShadow: [
                                            BoxShadow(
                                                blurRadius: 10,
                                                offset: Offset(0, 4),
                                                color: Colors.black26)
                                          ]),
                                      child: TextField(
                                        style: TextStyle(fontSize: 12.sp,fontFamily: "Certa Sans"),
                                        controller: _cubit.searchController,
                                        keyboardType: TextInputType.text,
                                        decoration: InputDecoration(
                                          hintText: "Search any Employee",
                                          isDense: true,
                                          contentPadding: EdgeInsets.symmetric(
                                              vertical: 0.h, horizontal: 11.w),
                                          fillColor: Colors.white,
                                          filled: true,
                                          labelStyle: TextStyle(fontSize: 14.sp,fontFamily: "Certa Sans"),
                                          hintStyle: TextStyle(color: Color(0xFFB5B9B9), fontSize: 14.sp, fontFamily: "Certa Sans",fontWeight: FontWeight.w500),
                                          suffixIcon: IconButton(
                                            icon: Icon(Icons.clear),
                                            onPressed: ()
                                            {
                                              _cubit.clearCurrentEmployee();
                                            },
                                          ),
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
                                        inputFormatters: [
                                          FilteringTextInputFormatter.allow(
                                              RegExp("[0-9]")),
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 5.w,
                                  ),
                                  InkWell(
                                    borderRadius: BorderRadius.circular(15.r),
                                    onTap: () {
                                      RequestMedicationCubit.get(context)
                                          .getEmployeeRelatives(
                                          RequestMedicationCubit.get(context)
                                              .searchController
                                              .text
                                              .toString(),
                                          widget.medicationType
                                      );
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
                              RequestMedicationCubit.get(context).currentEmployee ==null?
                                  Column(
                                    children: [
                                      SizedBox(
                                        height: 100.h,
                                      ),
                                      Image.asset("assets/images/search.png"),
                                    ],
                                  ):SizedBox(),
                              SizedBox(
                                height: 20.h,
                              ),
                            ],
                          )
                        : SizedBox(),
                    RequestMedicationCubit.get(context).currentEmployee != null
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                                EmployeeInfo2(),
                                SizedBox(
                                  height: 10.h,
                                ),
                              Divider(
                                indent: 70.w,
                                endIndent: 70.w,
                                color: AppColors.greyDark,
                                thickness: 0.1.w,
                              ),
                              widget.medicationType == "medication"?CheckBoxInsurance(title:  "Monthly Medication",value: RequestMedicationCubit.get(context)
                                  .monthlyInsurance,
                              onChanged: (bool? value) {
                                RequestMedicationCubit.get(context)
                                    .changeMonthlyInsuranceFlag();
                              } ,):SizedBox(),
                              SizedBox(
                                height:10.h,
                              ),
                       RequestMedicationCubit.get(context)
                      .currentEmployee!.relatives!.isNotEmpty?
                              CheckBoxInsurance(title:"Family Insurance",
                                value:RequestMedicationCubit.get(context)
                                    .familyInsurance,
                                onChanged: (bool? value) {
                                  RequestMedicationCubit.get(context)
                                      .changeFamilyInsuranceFlag();
                                },):SizedBox(),
                                (RequestMedicationCubit.get(context)
                                                .familyInsurance ==
                                            true &&
                                        RequestMedicationCubit.get(context)
                                                .currentEmployee !=
                                            null && RequestMedicationCubit.get(context)
                                    .currentEmployee!.relatives!.isNotEmpty)
                                    ? Column(
                                      children: [
                                        SizedBox(
                                          height:10.h,
                                        ),
                                        SelectFamilyInsurance(),
                                      ],
                                    )
                                    : const SizedBox(),
                              (RequestMedicationCubit.get(context)
                                  .familyInsurance ==
                                  true &&
                                  RequestMedicationCubit.get(context)
                                      .currentEmployee !=
                                      null &&
                                  RequestMedicationCubit.get(context)
                                      .selectedRelative !=
                                      null
                              )?Padding(
                                padding: EdgeInsets.symmetric(horizontal: 8.w),
                                child: Column(
                                  children: [
                                    SizedBox(
                                      height: 15.h,
                                    ),
                                    Row(
                                      children: [
                                        Icon(CustomIcons.cake_birthday,color: AppColors.greyDark,size: 14.sp,),
                                        SizedBox(
                                          width: 10.w,
                                        ),
                                        Text(
                                          RequestMedicationCubit.get(context).selectedRelative?.birthDate??"" ,
                                          style: TextStyle(
                                              color: AppColors.greyDark,
                                              fontWeight: FontWeight.w600,
                                              fontSize: 14.sp,
                                              fontFamily: "Certa Sans"),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 10.h,
                                    ),
                                    Row(
                                      children: [
                                        Icon(Icons.percent_outlined,color: AppColors.greyDark,size: 14.sp,),
                                        SizedBox(
                                          width: 10.w,
                                        ),
                                        Text(
                                         "${ RequestMedicationCubit.get(context).selectedRelative?.medicalCoverage??"" } medical coverage",
                                          style: TextStyle(
                                              color: AppColors.greyDark,
                                              fontWeight: FontWeight.w600,
                                              fontSize: 14.sp,
                                              fontFamily: "Certa Sans"),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 10.h,
                                    ),
                                  ],
                                ),
                              ):const SizedBox(),
                              SizedBox(
                                height: 15.h,
                              ),
                              Text(
                                "Medical Entity",
                                style: TextStyle(
                                    color: AppColors.blackColor,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 18.sp,
                                    fontFamily: "Certa Sans"),
                              ),
                              SizedBox(
                                height:10.h,
                              ),
                              (RequestMedicationCubit.get(context).currentEmployee !=
                                  null &&
                                  widget.medicationType == "checkups")
                                  ?
                              Column(
                                children: [
                                  SizedBox(
                                    height:15.h,
                                  ),
                                  SelectMedicalCategory(
                                      selectedCategory:
                                      RequestMedicationCubit.get(context)
                                          .selectedCategory,
                                      onChangeMedicalCategory: (Category? newValue) {
                                        RequestMedicationCubit.get(context)
                                            .selectCategory(newValue!);
                                        setState(() {});
                                      },
                                      medicalCategories:
                                      RequestMedicationCubit.get(context)
                                          .categories!,
                                      hintTitle: "Medical Category"),
                                  SizedBox(
                                    height: 15.h,
                                  ),
                                ],
                              )
                                  : SizedBox(),
                              (RequestMedicationCubit.get(context).currentEmployee !=
                                  null &&
                                  widget.medicationType == "checkups" &&
                                  RequestMedicationCubit.get(context)
                                      .resultOfSelectCategory
                                      .length >
                                      1)
                                  ? Column(
                                children: [
                                  DropdownSearch<Category>(
                                    dropdownBuilder: (context, selectedItem) {
                                      return Text(
                                          RequestMedicationCubit.get(context)
                                              .selectedSubCategory?.subCategoryName?? "",
                                          style:TextStyle(
                                              color: AppColors.greyDark,
                                              fontSize: 14.sp,
                                              fontWeight: FontWeight.w200,
                                              fontFamily: "Certa Sans"
                                          )
                                      );
                                    },
                                    popupProps:PopupProps.dialog(
                                      showSearchBox: true,
                                      fit: FlexFit.loose,
                                      searchFieldProps: TextFieldProps(
                                        decoration: InputDecoration(
                                          contentPadding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 10.w),
                                          border: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(10.r)
                                          ),
                                          labelText: "Select ${RequestMedicationCubit.get(context)
                                              .selectedCategory?.categoryName??""}",
                                          labelStyle:TextStyle(
                                              color: AppColors.greyDark,
                                              fontSize: 16.sp,
                                              fontWeight: FontWeight.w300,
                                              fontFamily: "Certa Sans"
                                          ),
                                        ),
                                      ),
                                    ),
                                    items:RequestMedicationCubit.get(context)
                                        .resultOfSelectCategory,
                                    itemAsString: (Category u) => u.subCategoryName??"",
                                    dropdownButtonProps: DropdownButtonProps(
                                      icon:Icon(Icons.keyboard_arrow_down_outlined,color:Color(0xff697480),size: 16.sp,)  ,
                                    ),
                                    dropdownDecoratorProps: DropDownDecoratorProps(
                                      dropdownSearchDecoration: InputDecoration(
                                        labelText: "choose your Sub",
                                        hintText:"choose your Sub",
                                        hintStyle:  TextStyle(
                                            color:AppColors.greyDark,
                                            fontSize: 16.sp,
                                            fontFamily: "Certa Sans"
                                        ),
                                        labelStyle: TextStyle(
                                            color: AppColors.greyDark,
                                            fontSize: 16.sp,
                                            fontFamily: "Certa Sans"
                                        ),
                                        contentPadding: EdgeInsets.symmetric(
                                            vertical: 10.h, horizontal: 8.w),
                                        prefixIcon: Icon(CustomIcons.home__2_,color: AppColors.greyColor,size: 16.sp,),
                                        // suffixIcon: Icon(Icons.keyboard_arrow_down_outlined,color:Color(0xff697480),size: 16.sp,) ,
                                          border: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(15.0.r),
                                              borderSide: BorderSide(
                                                  width: 0.5.w,
                                                  color: Color(0xffbec0ca)
                                              )
                                          ) ,
                                          focusedBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(15.0.r),
                                              borderSide: BorderSide(
                                                  width: 0.5.w,
                                                  color: Color(0xffbec0ca)
                                              )
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(15.0.r),
                                              borderSide: BorderSide(
                                                  width: 0.5.w,
                                                  color: Color(0xffbec0ca)
                                              )
                                          )
                                      ),
                                    ),
                                    onChanged: (Category? newValue) {
                                      RequestMedicationCubit.get(context)
                                          .selectSubCategory(newValue!);
                                      setState(() {});
                                    },
                                    selectedItem: RequestMedicationCubit.get(context)
                                        .selectedSubCategory,
                                    validator: (Category? value) {
                                      if (value==null) return AppStrings.required.tr();
                                      return null;
                                    },
                                  ),
                                  SizedBox(
                                    height: 15.h,
                                  ),
                                ],
                              ) : const SizedBox(),
                              (RequestMedicationCubit.get(context).currentEmployee !=
                                  null &&
                                  widget.medicationType == "checkups" &&
                                  RequestMedicationCubit.get(context)
                                      .resultOfSelectSubCategory
                                      .length >
                                      1)
                                  ? DropdownSearch<DetailsOfMedical>(
                                    popupProps:PopupProps.dialog(
                                      showSearchBox: true,
                                      fit: FlexFit.loose,
                                      searchFieldProps: TextFieldProps(
                                        decoration: InputDecoration(
                                          contentPadding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 10.w),
                                          border: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(10.r)
                                          ),
                                          labelText: "Select ${RequestMedicationCubit.get(context)
                                              .selectedSubCategory?.subCategoryName??""}",
                                          labelStyle:TextStyle(
                                              color: AppColors.greyDark,
                                              fontSize: 16.sp,
                                              fontWeight: FontWeight.w300,
                                              fontFamily: "Certa Sans"
                                          ),
                                        ),
                                      ),
                                    ),
                                    items:RequestMedicationCubit.get(context)
                                        .resultOfSelectSubCategory,
                                    itemAsString: (DetailsOfMedical u) => u.medicalDetailsName??"",
                                    dropdownButtonProps: DropdownButtonProps(
                                      icon:Icon(Icons.keyboard_arrow_down_outlined,color:Color(0xff697480),size: 16.sp,)  ,
                                    ),
                                    dropdownDecoratorProps: DropDownDecoratorProps(
                                      dropdownSearchDecoration: InputDecoration(
                                        labelText: "Medical Authority",
                                        hintText:"choose your Medical Authority",
                                          hintStyle:  TextStyle(
                                              color:AppColors.greyDark,
                                              fontSize: 16.sp,
                                              fontFamily: "Certa Sans"
                                          ),
                                          labelStyle: TextStyle(
                                              color: AppColors.greyDark,
                                              fontSize: 16.sp,
                                              fontFamily: "Certa Sans"
                                          ),
                                        contentPadding: EdgeInsets.symmetric(
                                            vertical: 10.h, horizontal: 8.w),
                                        prefixIcon: Icon(CustomIcons.home__2_,color: AppColors.greyColor,size: 16.sp,),
                                        // suffixIcon: Icon(Icons.keyboard_arrow_down_outlined,color:Color(0xff697480),size: 16.sp,) ,
                                          border: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(15.0.r),
                                              borderSide: BorderSide(
                                                  width: 0.5.w,
                                                  color: Color(0xffbec0ca)
                                              )
                                          ) ,
                                          focusedBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(15.0.r),
                                              borderSide: BorderSide(
                                                  width: 0.5.w,
                                                  color: Color(0xffbec0ca)
                                              )
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(15.0.r),
                                              borderSide: BorderSide(
                                                  width: 0.5.w,
                                                  color: Color(0xffbec0ca)
                                              )
                                          )
                                      ),
                                    ),
                                    onChanged: (DetailsOfMedical? newValue) {
                                      RequestMedicationCubit.get(context)
                                          .selectDetailsOfMedical(newValue!);
                                      setState(() {});
                                    },
                                    selectedItem: RequestMedicationCubit.get(context)
                                        .selectedDetailsOfMedical,
                                validator: (DetailsOfMedical? value) {
                                  if (value==null) return AppStrings.required.tr();
                                  return null;
                                },
                                  )
                                  : SizedBox(),
                              SizedBox(
                                height: 10.h,
                              ),
                              (RequestMedicationCubit.get(context).currentEmployee !=
                                  null &&
                                  widget.medicationType == "medication")
                                  ? SelectMedicalDetails(
                                  medicalDetails:
                                  RequestMedicationCubit.get(context).pharmacies,
                                  hintTitle: "Pharmacy",
                                  requestType: "medication")
                                  : const SizedBox(),
                              RequestMedicationCubit.get(context).selectedDetailsOfMedical !=
                                  null?
                              Padding(
                                padding: EdgeInsets.fromLTRB(13.w,15.h,13.w,0),
                                child: Row(
                                  children: [
                                    Icon(CustomIcons.home__2_,size: 14.sp,color: AppColors.greyDark,),
                                    SizedBox(
                                      width: 10.w,
                                    ),
                                    FittedBox(
                                      child: SizedBox(
                                        width: 270.w,
                                        child: Text(
                                          RequestMedicationCubit.get(context).
                                          selectedDetailsOfMedical?.
                                          medicalDetailsAddress??"",
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                              color: AppColors.greyDark,
                                              fontWeight: FontWeight.w500,
                                              fontSize: 14.sp,
                                              fontFamily: "Certa Sans"),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ) : SizedBox(),
                              RequestMedicationCubit.get(context).selectedPharmacy !=
                                  null?
                              Padding(
                                padding: EdgeInsets.fromLTRB(13.w,15.h,13.w,0),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Icon(CustomIcons.home__2_,size: 14.sp,color: AppColors.greyDark,),
                                    SizedBox(
                                      width: 10.w,
                                    ),
                                    FittedBox(
                                      child: SizedBox(
                                        width: 270.w,
                                        child: Text(
                                          _cubit.selectedPharmacy?.medicalDetailsAddress??"",
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                              color: AppColors.greyDark,
                                              fontWeight: FontWeight.w500,
                                              fontSize: 14.sp,
                                              fontFamily: "Certa Sans"),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ) : SizedBox(),
                              SizedBox(
                                height: 10.h,
                              ),
                              Divider(
                                indent: 70.w,
                                endIndent: 70.w,
                                color: AppColors.greyDark,
                                thickness: 0.1.w,
                              ),
                              SizedBox(
                                height: 10.h,
                              ),
                              Text(
                                "Documents",
                                style: TextStyle(
                                    color: AppColors.blackColor,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 18.sp,
                                    fontFamily: "Certa Sans"),
                              ),
                              SizedBox(
                                height: 10.h,
                              ),
                              GestureDetector(
                                onTap: () {
                                  RequestMedicationCubit.get(context).pickImage();
                                },
                                child: DottedBorder(
                                    color: AppColors.greyDark,
                                    strokeWidth: 0.7,
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                          vertical:5.h, horizontal: 15.w),
                                      child: Column(
                                        children: [
                                          Image.asset(
                                            "assets/images/upload_image_icon.png",
                                            height: 30.h,
                                            width: 30.w,
                                          ),
                                          SizedBox(
                                            height: 10.h,
                                          ),
                                          Text(
                                            "Upload",
                                            style: TextStyle(
                                                color: AppColors.greyColor,
                                                fontWeight: FontWeight.w600,
                                                fontSize: 16.sp,
                                                fontFamily: "Certa Sans"),
                                          ),
                                        ],
                                      ),
                                    )),
                              ),
                              SizedBox(
                                height: 10.h,
                              ),
                              RequestMedicationCubit.get(context).imagesFiles.isNotEmpty
                                  ? Card(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15.r)),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 10.h, horizontal: 20.w),
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "Uploading ${RequestMedicationCubit.get(context).imagesFiles.length} images",
                                            style: TextStyle(
                                                color: AppColors.blackColor,
                                                fontWeight: FontWeight.w500,
                                                fontSize: 14.sp,
                                                fontFamily: "Certa Sans"),
                                          ),
                                          GestureDetector(
                                            onTap: ()
                                            {
                                              Navigator.of(context).push(MaterialPageRoute(
                                                  builder: (_) => Gallery(
                                                    images: _cubit.imagesFiles,
                                                    index: 1,
                                                  )));
                                            },
                                            child: Image.asset(
                                              "assets/images/see_all.png",
                                              height: 20.h,
                                              width: 20.w,
                                            ),
                                          )
                                        ],
                                      ),
                                      SizedBox(
                                        height: 20.h,
                                      ),
                                      SizedBox(
                                        height: 80.h,
                                        child: ListView.separated(
                                            scrollDirection: Axis.horizontal,
                                            itemBuilder: (context, index) => Stack(
                                              alignment: Alignment.topRight,
                                              children: [
                                                Container(
                                                  height: 80.h,
                                                  width: 65.w,
                                                  color: AppColors.whiteColor,
                                                ),
                                                ClipRRect(
                                                  borderRadius:
                                                  BorderRadius.circular(
                                                      15.0.r),
                                                  child: Image.file(
                                                    RequestMedicationCubit.get(
                                                        context)
                                                        .imagesFiles[index],
                                                    width: 60.w,
                                                    height: 60.h,
                                                    fit: BoxFit.fill,
                                                  ),
                                                ),
                                                Positioned(
                                                  // right: 5,
                                                  top: -2,
                                                  child: Container(
                                                    width: 25,
                                                    height: 25,
                                                    child: IconButton(
                                                      iconSize: 20,
                                                      padding: EdgeInsets.zero,
                                                      icon: Icon(
                                                        Icons.remove_circle,
                                                        size: 20,
                                                        color: Colors.red,
                                                      ),
                                                      onPressed: () {
                                                        RequestMedicationCubit
                                                            .get(context)
                                                            .deleteImage(index);
                                                      },
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            separatorBuilder: (context, index) =>
                                                SizedBox(
                                                  width: 5.w,
                                                ),
                                            itemCount:
                                            RequestMedicationCubit.get(context)
                                                .imagesFiles
                                                .length),
                                      )
                                    ],
                                  ),
                                ),
                              )
                                  : SizedBox(),
                              SizedBox(
                                height: 10.h,
                              ),
                              Text(
                                "Add your Notes",
                                style: TextStyle(
                                    color: AppColors.blackColor,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 18.sp,
                                    fontFamily: "Certa Sans"),
                              ),
                              SizedBox(
                                height:10.h,
                              ),
                              Comment(
                                controller:
                                RequestMedicationCubit.get(context).commentController,
                              ),
                              SizedBox(
                                height: 20.h,
                              ),
                              GestureDetector(
                                onTap: () {
                                  if (_formKey.currentState!.validate()) {
                                    RequestMedicationCubit.get(context).sendMedicationRequest(
                                        widget.medicationType == "medication"
                                            ? 1
                                            : widget.medicationType == "checkups"
                                            ? 2
                                            : 3);
                                  }
                                },
                                child: Container(
                                  height: 50.h,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(17.r),
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
                                    child: Text(
                                      "Submit",
                                      style: TextStyle(
                                          color: AppColors.whiteColor,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 24.sp,
                                          fontFamily: "Certa Sans"
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 20.h,
                              ),
                              ])
                        : SizedBox(),
                  ],
                ),
              ),
            )),
          ),
        );
      },
    );
  }
}
