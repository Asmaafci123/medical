import 'package:flutter/material.dart';
import 'package:more4u/domain/entities/response_medical_request.dart';
import 'package:more4u/presentation/medication/request_medication_screen.dart';

import '../../../data/models/category-model.dart';
import '../../../data/models/response/medication_request_response_model.dart';
import '../../../presentation/home/home_screen.dart';
import '../../../presentation/medical_benefits/medical_benefits_screen.dart';
import '../../../presentation/medical_request_details/medical_request_details_screen.dart';
import '../../../presentation/medical_request_details_and_doctor_response/medical_doctor_response_screen.dart';
import '../../../presentation/medical_requests_history/medical_requests_history_screen.dart';
import '../../../presentation/more4u_home/more4u_home_screen.dart';
import '../../../presentation/my_benefit_requests/my_benefit_requests_screen.dart';
import '../../../domain/entities/benefit.dart';
import '../../../presentation/Login/login_screen.dart';
import '../../../presentation/benefit_details/beneifit_detailed_screen.dart';
import '../../../presentation/benefit_redeem/BenefitRedeemScreen.dart';
import '../../../presentation/manage_requests/manage_requests_screen.dart';
import '../../../presentation/my_benefits/my_benefits_screen.dart';
import '../../../presentation/my_gifts/my_gifts_screen.dart';
import '../../../presentation/notification/notification_screen.dart';
import '../../../presentation/our_paretners/our_partners_screen.dart';
import '../../../presentation/our_paretners/search_partners_screen.dart';
import '../../../presentation/pending_requests/pending_requests_screen.dart';
import '../../../presentation/splash/splash_screen.dart';
import '../../../presentation/profile/profile_screen.dart';
import '../../../presentation/subcategory-medical/subcategory.dart';
import '../../../presentation/terms_and_conditions/terms_and_conditions.dart';

class AppRoutes {
  static Route onGenerateRoutes(RouteSettings settings) {
    switch (settings.name) {
      case SplashScreen.routeName:
        return _materialRoute(const SplashScreen(), SplashScreen.routeName);

      case LoginScreen.routeName:
        return _materialRoute(const LoginScreen(), LoginScreen.routeName);

      case TermsAndConditions.routeName:
        return _materialRoute(TermsAndConditions(isLogin: settings.arguments as bool),
    TermsAndConditions.routeName);
      case ProfileScreen.routeName:
        Map<String, dynamic> args = settings.arguments as Map<String, dynamic>;
        return _materialRoute(
            ProfileScreen(
              user: args['user'],
              isProfile: args['isProfile'] ?? false,
            ),
            ProfileScreen.routeName);

      case NotificationScreen.routeName:
        return _materialRoute(
            const NotificationScreen(), NotificationScreen.routeName);
      case HomeScreen.routeName:
        return _materialRoute(const HomeScreen(), HomeScreen.routeName);

      case More4uHomeScreen.routeName:
        return _materialRoute(const More4uHomeScreen(), More4uHomeScreen.routeName);

      case MedicalBenefitsScreen.routeName:
        return _materialRoute(const MedicalBenefitsScreen(), MedicalBenefitsScreen.routeName);

      case PendingRequestsScreen.routeName:
        return _materialRoute(const PendingRequestsScreen(), PendingRequestsScreen.routeName);


     case RequestMedicationScreen.routeName:
        return _materialRoute( RequestMedicationScreen(medicationType:settings.arguments as String ,), RequestMedicationScreen.routeName);

      case MedicalRequestsHistoryScreen.routeName:
        return _materialRoute(const MedicalRequestsHistoryScreen(),MedicalRequestsHistoryScreen.routeName);

      case OurPartnersScreen.routeName:
        return _materialRoute(const OurPartnersScreen(), OurPartnersScreen.routeName);

      case MedicalDetailsScreen.routeName:
        return _materialRoute( MedicalDetailsScreen(
          requestId:settings.arguments as String,employeeImageUrl: settings.arguments as String ,), MedicalDetailsScreen.routeName);


      case SearchPartnersScreen.routeName:
        return _materialRoute(const SearchPartnersScreen(), SearchPartnersScreen.routeName);

      case MedicalDoctorResponseScreen.routeName:
        return _materialRoute(const MedicalDoctorResponseScreen(), MedicalDoctorResponseScreen.routeName);

      case MyBenefitsScreen.routeName:
         return _materialRoute(
            const MyBenefitsScreen(), MyBenefitsScreen.routeName);

      case MyGiftsScreen.routeName:
        return _materialRoute(
            const MyGiftsScreen(), MyGiftsScreen.routeName);

      case ManageRequestsScreen.routeName:
        return _materialRoute(
            const ManageRequestsScreen(), ManageRequestsScreen.routeName);

      case MyBenefitRequestsScreen.routeName:
        return _materialRoute(
            MyBenefitRequestsScreen(
              benefitID: settings.arguments as int,
            ),
            MyBenefitRequestsScreen.routeName);

      case BenefitDetailedScreen.routeName:
        return _materialRoute(
            BenefitDetailedScreen(benefit: settings.arguments as Benefit),
            BenefitDetailedScreen.routeName);

      case BenefitRedeemScreen.routeName:
        return _materialRoute(
            BenefitRedeemScreen(
              benefit: settings.arguments as Benefit,
            ),
            BenefitRedeemScreen.routeName);
      case SubCategory.routeName:
        List<CategoryModel> args = settings.arguments as List<CategoryModel>;
        return _materialRoute(
            SubCategory(
              subCategory: args,
            ),
            SubCategory.routeName);
      default:
      // If there is no such named route in the switch statement, e.g. /third
        return _materialRoute(
            const Scaffold(
              body: SafeArea(
                child: Center(
                  child: Text('Route Error'),
                ),
              ),
            ),
            '404');
    }
  }

  static Route<dynamic> _materialRoute(Widget view, String routeName) {
    return MaterialPageRoute(
      settings: RouteSettings(name: routeName),
      builder: (_) => view,
    );
  }
}
