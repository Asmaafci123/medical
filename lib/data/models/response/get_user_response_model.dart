import 'package:more4u/data/models/user_model.dart';

import '../../../domain/entities/get_current_user.dart';
import '../../../domain/entities/user.dart';

class GetCurrentUserModel extends GetCurrentUserResponse {
  const GetCurrentUserModel(
      {required String message,
      required User user,
      int? userUnSeenNotificationCount,
      int? pendingRequestMedicalCount,
      String? medicalCoverage,
        int? relativeCount})
      : super(
            message: message,
            user: user,
            userUnSeenNotificationCount: userUnSeenNotificationCount,
            pendingRequestMedicalCount: pendingRequestMedicalCount,
            medicalCoverage: medicalCoverage,
            relativeCount: relativeCount);

  factory GetCurrentUserModel.fromJson(Map<String, dynamic> json) {
    // print("*******************");
    // print(json['data']['pendingRequestMedicalCount']);
    // print("*******************");
    return GetCurrentUserModel(
      message: json['message'],
      user: UserModel.fromJson(json['data']['user']),
      userUnSeenNotificationCount: json['data']['userUnSeenNotificationCount'],
      pendingRequestMedicalCount: json['data']['pendingRequestMedicalCount'],
      medicalCoverage: json['data']['medicalCoverage'],
      relativeCount: json['data']['relativeCount'],
    );
  }
}
