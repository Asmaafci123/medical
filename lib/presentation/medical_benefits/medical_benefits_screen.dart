import 'package:carousel_slider/carousel_slider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:more4u/core/themes/app_colors.dart';
import 'package:more4u/presentation/medical_benefits/widgets/medication_card_1.dart';
import 'package:more4u/presentation/medication/request_medication_screen.dart';
import '../../core/constants/app_strings.dart';
import '../../core/constants/constants.dart';
import '../home/home_screen.dart';
import '../home/widgets/app_bar.dart';
import '../medical_requests_history/medical_requests_history_screen.dart';
import '../medication/cubits/request_medication_cubit.dart';
import '../medication/cubits/request_medication_states.dart';
import '../our_paretners/our_partners_screen.dart';
import '../widgets/drawer_widget.dart';
import '../widgets/helpers.dart';
import '../widgets/utils/loading_dialog.dart';
import '../widgets/utils/message_dialog.dart';
import '../widgets/utils/warning_diaglog.dart';
import 'models/medical_benefit_model.dart';

class MedicalBenefitsScreen extends StatefulWidget {
  static const routeName = 'MedicalBenefitsScreen';

  const MedicalBenefitsScreen({super.key});

  @override
  State<MedicalBenefitsScreen> createState() => _MedicalBenefitsScreenState();
}

class _MedicalBenefitsScreenState extends State<MedicalBenefitsScreen> {
  @override
  Widget build(BuildContext context) {
    List<MedicalBenefitModel> medicalBenefits = [
      MedicalBenefitModel(
        imagePath: "assets/images/medication_request_2.png",
        title: AppStrings.medications.tr(),
        description1: AppStrings.requestYourPrescribed.tr(),
      ),
      MedicalBenefitModel(
        imagePath: "assets/images/check-up.png",
        title: AppStrings.checkUps.tr(),
        description1: AppStrings.requestYourCheckUp.tr(),
      ),
      MedicalBenefitModel(
        imagePath: "assets/images/sick_leave_icon.png",
        title: AppStrings.sickLeave.tr(),
        description1: AppStrings.requestYourSickLeave.tr(),
      ),
      MedicalBenefitModel(
        imagePath: "assets/images/my_requests_icon.png",
        title: AppStrings.requestsLog.tr(),
        description1: AppStrings.trackYourPendingAndAccepted.tr(),
      ),
      MedicalBenefitModel(
        imagePath: "assets/images/support_white.png",
        title: AppStrings.partnerShips.tr(),
        description1:  AppStrings.viewOurPartnerships.tr(),
      ),
    ];
    return Scaffold(
      drawer: const DrawerWidget(),
      body: SingleChildScrollView(
        child: SafeArea(
          child: BlocListener<RequestMedicationCubit, RequestMedicationState>(
            listener: (context, state) {
              if (state is GetEmployeeRelativesLoadingState) {
                loadingAlertDialog(context);
              }
              else if (state is GetEmployeeRelativesSuccessState) {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            RequestMedicationScreen(
                              medicationType: state.message,
                            )),
                        (route) => false);
              }
              else if (state is GetEmployeeRelativesErrorState) {
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(4.w, 14.h, 4.w, 0.h),
                  child: HomeAppBar(
                    title: AppStrings. medicalBenefits.tr(),
                    onTap:  () {
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  HomeScreen()),
                              (route) => false);
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(16.w, 0.h, 16.w, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CarouselSlider(
                          items: [
                            Row(
                              children: [
                                Image.asset("assets/images/speaker.png",width: 15.w,color: AppColors.redColor,),
                                SizedBox(
                                  width: 5.w,
                                ),
                                Text(
                                 AppStrings. healthCondition.tr(),
                                  style: TextStyle(
                                    color: AppColors.greyDark,
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w200,
                                      fontFamily: "Certa Sans"
                                  ),
                                ),
                              ],
                            ),
                          ],
                          // carouselController: carouselController,
                          options: CarouselOptions(
                            height: 50.h,
                            aspectRatio: 18 / 9,
                            viewportFraction: 0.9,
                            initialPage: 0,
                            enableInfiniteScroll: true,
                            reverse: false,
                            autoPlay: true,
                            autoPlayInterval: Duration(seconds: 10),
                            autoPlayAnimationDuration:
                                Duration(milliseconds: 8000),
                            autoPlayCurve: Curves.fastOutSlowIn,
                            enlargeCenterPage: true,
                            enlargeStrategy: CenterPageEnlargeStrategy.scale,
                            enlargeFactor: 0.19,
                            //  onPageChanged: callbackFunction,
                            scrollDirection: Axis.horizontal,
                          )),
                      Row(
                        children: [
                          MedicalBenefitsCard1(
                            history:false,
                            dividerWidth: 140.w,
                            medicalBenefitModel: medicalBenefits[0],
                            onTap: () {
                              RequestMedicationCubit.get(context)
                                  .clearCurrentEmployee();
                              if (userData?.isDoctor == false &&
                                  userData?.isMedicalAdmin == false) {
                                RequestMedicationCubit.get(context)
                                    .getEmployeeRelatives(
                                        userNumber.toString(), "medication");
                              } else {
                                Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            RequestMedicationScreen(
                                              medicationType: "medication",
                                            )),
                                    (route) => false);
                              }
                            },
                          ),
                          const Spacer(),
                          MedicalBenefitsCard1(
                            history:false,
                            dividerWidth: 140.w,
                            medicalBenefitModel: medicalBenefits[1],
                            onTap: () {
                              RequestMedicationCubit.get(context)
                                  .clearCurrentEmployee();
                              if (userData?.isDoctor == false &&
                                  userData?.isMedicalAdmin == false) {
                                RequestMedicationCubit.get(context)
                                    .getEmployeeRelatives(
                                        userNumber.toString(), "checkups");
                              } else {
                                Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            RequestMedicationScreen(
                                              medicationType: "checkups",
                                            )),
                                        (route) => false);
                              }
                              // Navigator.of(context).pushNamed(
                              //     RequestMedicationScreen.routeName,
                              //     arguments: "checkups");
                            },
                          ),
                        ],
                      ),
                      SizedBox(
                        height:5.h,
                      ),
                      Row(
                        children: [
                          MedicalBenefitsCard1(
                            dividerWidth: 140.w,
                            history:false,
                            medicalBenefitModel: medicalBenefits[2],
                            onTap: () {
                              showWarningDialog(
                                context: context,
                                message:"You don't have Sick Leave service",
                                isSucceeded: false,
                              );
                            },
                          ),
                          const Spacer(),
                          MedicalBenefitsCard1(
                            dividerWidth: 140.w,
                            history:true,
                            medicalBenefitModel: medicalBenefits[3],
                            onTap: () {
                              Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                      MedicalRequestsHistoryScreen()),
                                      (route) => false);
                            },
                          )
                        ],
                      ),
                      SizedBox(
                        height:5.h,
                      ),
                      MedicalBenefitsCard1(
                        dividerWidth: 280.w,
                        history:true,
                        medicalBenefitModel: medicalBenefits[4],
                        onTap: () {
                          Navigator.of(context)
                              .pushNamed(OurPartnersScreen.routeName);
                        },
                      ),
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
}
