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
        title: "Medications",
        description1: "Request your prescribed",
        description2: "mediscines",
      ),
      MedicalBenefitModel(
        imagePath: "assets/images/check-up.png",
        title: "Check Ups",
        description1: "Request your medical",
        description2: "transfer to labs and others ",
      ),
      MedicalBenefitModel(
        imagePath: "assets/images/sick_leave_icon.png",
        title: "Sick Leave",
        description1: "Request a sick leave when",
        description2: "feeling tired",
      ),
      MedicalBenefitModel(
        imagePath: "assets/images/my_requests_icon.png",
        title: "History",
        description1: "Track your pending, accepted",
        description2: " and rejected ",
      ),
      MedicalBenefitModel(
        imagePath: "assets/images/support_white.png",
        title: "Our Partnerships",
        description1:
            "View our partnerships with different labs and hospitals ",
        description2: "",
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
                  padding: EdgeInsets.fromLTRB(16.w, 20.h, 16.w, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      HomeAppBar(
                        title: "Medical Benefits",
                        onTap:  () {
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      HomeScreen()),
                                  (route) => false);
                        },
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      CarouselSlider(
                          items: [
                            Row(
                              children: [
                                Image.asset("assets/images/speaker.png",width: 15.w,color: AppColors.redColor,),
                                SizedBox(
                                  width: 5.w,
                                ),
                                Text(
                                  "your health condition matters to us",
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
                              // Navigator.pushAndRemoveUntil(
                              //     context,
                              //     MaterialPageRoute(
                              //         builder: (context) =>
                              //             RequestMedicationScreen(
                              //               medicationType: "medication",
                              //             )),
                              //         (route) => false);
                            },
                          ),
                          const Spacer(),
                          MedicalBenefitsCard1(
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
                                Navigator.of(context).pushNamed(
                                    RequestMedicationScreen.routeName,
                                    arguments: "checkups");
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
                            medicalBenefitModel: medicalBenefits[2],
                            onTap: () {
                              Navigator.of(context)
                                  .pushNamed(RequestMedicationScreen.routeName);
                            },
                          ),
                          const Spacer(),
                          MedicalBenefitsCard1(
                            dividerWidth: 140.w,
                            medicalBenefitModel: medicalBenefits[3],
                            onTap: () {
                              Navigator.of(context)
                                  .pushNamed(MedicalRequestsHistoryScreen.routeName);
                            },
                          )
                        ],
                      ),
                      SizedBox(
                        height:5.h,
                      ),
                      MedicalBenefitsCard1(
                        dividerWidth: 280.w,
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
