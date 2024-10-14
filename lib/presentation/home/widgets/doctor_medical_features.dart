import 'package:carousel_slider/carousel_slider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:more4u/presentation/pending_requests/pending_requests_screen.dart';

import '../../../core/constants/app_strings.dart';
import '../../../core/constants/constants.dart';
import '../../../core/themes/app_colors.dart';
import '../../medical_benefits/medical_benefits_screen.dart';
import '../../medical_requests_history/medical_requests_history_screen.dart';
import '../../more4u_home/more4u_home_screen.dart';
import '../../our_paretners/our_partners_screen.dart';
import '../../widgets/utils/warning_diaglog.dart';
import '../home_screen.dart';
import 'medical_feature.dart';
class DoctorMedicalFeatures extends StatelessWidget {
  final CustomCarouselController carouselController;
  const DoctorMedicalFeatures({super.key,required this.carouselController});

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
        items: [
          MedicalFeature(
              imagePath:"assets/images/surprise.png",
              title:"More4u",
              description: AppStrings.followOurMore4Benefits.tr(),
              enabled: userData?.hasMore4uService??false,
              onTap:() {
                userData?.hasMore4uService == true? Navigator.of(context).pushNamed(
                    More4uHomeScreen.routeName):
                showWarningDialog(
                  context: context,
                  message:AppStrings.youNotHaveMore4uService.tr(),
                  isSucceeded: false,
                );
              }),
          MedicalFeature(
              imagePath:"assets/images/paper_15410515.png",
              title:AppStrings.requestsLog.tr(),
              description:AppStrings.followMedicalRequests.tr(),
              enabled: true,
              onTap:() {
                Navigator.of(context)
                    .pushNamed(MedicalRequestsHistoryScreen.routeName);
              }),
          MedicalFeature(
              imagePath: "assets/images/support.png",
              title:AppStrings.partnerShips.tr(),
              description: AppStrings.followOurPartnerShips.tr(),
              enabled: true,
              onTap:() {
                Navigator.of(context).pushNamed(
                    OurPartnersScreen.routeName);
              }),
          MedicalFeature(
              imagePath: "assets/images/medical-request.png",
              title:AppStrings.medical.tr(),
              description: AppStrings.followOurMedicalServices.tr(),
              enabled: true,
              onTap:() {
                Navigator.of(context).pushNamed(
                    MedicalBenefitsScreen.routeName);
              }),
        ],
        carouselController: carouselController,
        options: CarouselOptions(
          height: 210.h,
          aspectRatio: 18 / 9,
          viewportFraction: 0.46,
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
