
import 'package:more4u/domain/entities/response/medical_details_response.dart';

import '../medical_request_details_model.dart';

class MedicalDetailsResponseModel extends MedicalDetailsResponse {
  const MedicalDetailsResponseModel({
    required bool flag,
    required String message,
    required MedicalRequestDetailsModel? medicalRequestDetails,
  }) : super(
    flag: flag,
    message: message,
    medicalRequestDetails:medicalRequestDetails,
  );

  factory MedicalDetailsResponseModel .fromJson(Map<String, dynamic> json) {
    return MedicalDetailsResponseModel (
      flag: json['flag'],
      message: json['message'],
      medicalRequestDetails: MedicalRequestDetailsModel.fromJson(json['data']),
    );
  }
}
