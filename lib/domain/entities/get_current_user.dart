import 'package:equatable/equatable.dart';

import 'user.dart';

class GetCurrentUserResponse extends Equatable {
  final String message;
  final User user;
  final int? userUnSeenNotificationCount;
  final int? pendingRequestMedicalCount;
  final String? medicalCoverage;
  final int? relativeCount;
  const GetCurrentUserResponse(
      {required this.message,
        required this.user,
        required this.userUnSeenNotificationCount,
        required this.pendingRequestMedicalCount,
        required this.medicalCoverage,
        required this.relativeCount
      });

  @override
  List<Object?> get props =>
      [message,
        user,
        userUnSeenNotificationCount,
        pendingRequestMedicalCount,
        medicalCoverage,
       relativeCount];
}
