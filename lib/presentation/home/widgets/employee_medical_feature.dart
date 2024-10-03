import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:more4u/core/themes/app_colors.dart';
import 'package:toast/toast.dart';

import '../../../core/constants/constants.dart';
import '../../medical_benefits/medical_benefits_screen.dart';
import '../../more4u_home/more4u_home_screen.dart';
import '../../our_paretners/our_partners_screen.dart';
import '../../widgets/utils/warning_diaglog.dart';
import '../home_screen.dart';
import 'package:flutter/material.dart';

import 'medical_feature.dart';
class EmployeeMedicalFeature extends StatelessWidget {
  final CustomCarouselController carouselController;
  const EmployeeMedicalFeature({super.key,required this.carouselController
  });

  @override
  Widget build(BuildContext context) {
    ToastContext().init(context);
    return CarouselSlider(
        items: [
          MedicalFeature(
              imagePath:"assets/images/surprise.png",
              title:"More4u",
              description:  "Mange all Medical Requests",
              enabled: userData?.hasMore4uService??false,
              onTap:() {
                userData?.hasMore4uService == true? Navigator.of(context).pushNamed(
                    More4uHomeScreen.routeName):
                showWarningDialog(
                  context: context,
                  message:"You don't have more4u service",
                  isSucceeded: false,
                );

              }),
          MedicalFeature(
              imagePath: "assets/images/medical-report.png",
              title:"Medical",
              description: "Create New Medical Request",
              enabled: userData?.hasMedicalService ??false,
              onTap:() {
                userData?.hasMedicalService == true? Navigator.of(context).pushNamed(
                    MedicalBenefitsScreen.routeName):
                showWarningDialog(
                  context: context,
                  message:"You don't have medical service",
                  isSucceeded: false,
                );
              }),
          MedicalFeature(
              imagePath: "assets/images/support.png",
              title:"PartnerShips",
              enabled: true,
              description:  "Mange all Medical Requests",
              onTap:() {
                Navigator.of(context).pushNamed(
                    OurPartnersScreen.routeName);
              }),
        ],
        carouselController: carouselController,
        options: CarouselOptions(
          height: 200.h,
          aspectRatio: 18 / 9,
          viewportFraction: 0.5,
          initialPage: 0,
          enableInfiniteScroll: true,
          reverse: false,
          autoPlay: true,
          autoPlayInterval: Duration(seconds: 3),
          autoPlayAnimationDuration: Duration(milliseconds: 800),
          autoPlayCurve: Curves.fastOutSlowIn,
          enlargeCenterPage: true,
          enlargeStrategy:
          CenterPageEnlargeStrategy.scale,
          enlargeFactor: 0.19,
          //  onPageChanged: callbackFunction,
          scrollDirection: Axis.horizontal,
        ));
  }
}
