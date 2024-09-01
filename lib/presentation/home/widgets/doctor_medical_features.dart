import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:more4u/presentation/pending_requests/pending_requests_screen.dart';

import '../../../core/themes/app_colors.dart';
import '../../medical_benefits/medical_benefits_screen.dart';
import '../../medical_requests_history/medical_requests_history_screen.dart';
import '../../more4u_home/more4u_home_screen.dart';
import '../../our_paretners/our_partners_screen.dart';
import '../home_screen.dart';
import 'medical_feature.dart';
class DoctorMedicalFeatures extends StatelessWidget {
  final CustomCarouselController carouselController;
  const DoctorMedicalFeatures({super.key,required this.carouselController});

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
        items: [
          // MedicalFeature(
          //   imagePath: "assets/images/pending.png",
          //   title:"Pending Requests",
          //   description:"Mange Pending Medical Requests",
          //   onTap:() {
          // Navigator.of(context).pushNamed(
          // PendingRequestsScreen.routeName);
          // }),
          MedicalFeature(
              imagePath:"assets/images/paper_15410515.png",
              title:"History",
              description:  "Mange all Medical Requests",
              onTap:() {
                Navigator.of(context)
                    .pushNamed(MedicalRequestsHistoryScreen.routeName);
              }),
          MedicalFeature(
              imagePath: "assets/images/support.png",
              title:"PartnerShips",
              description:  "Mange all Medical Requests",
              onTap:() {
                Navigator.of(context).pushNamed(
                    OurPartnersScreen.routeName);
              }),
          MedicalFeature(
              imagePath: "assets/images/medical-request.png",
              title:"Request",
              description: "Create New Medical Request",
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
