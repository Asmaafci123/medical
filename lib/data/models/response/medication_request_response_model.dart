import '../../../domain/entities/medication_request.dart';
import '../../../domain/entities/response/medication_request_response.dart';
import '../medical_request_details_model.dart';
import '../medication_request_model.dart';

class  MedicationRequestResponseModel extends  MedicationRequestResponse {
  const MedicationRequestResponseModel({
    required bool flag,
    required String message,
    required MedicalRequestDetailsModel? medicalRequestDetailsModel,
  }) : super(
    flag: flag,
    message: message,
    medicalRequestDetails:medicalRequestDetailsModel,
  );

  factory MedicationRequestResponseModel.fromJson(Map<String, dynamic> json) {
    return MedicationRequestResponseModel(
      flag: json['flag'],
      message: json['message'],
      medicalRequestDetailsModel:MedicalRequestDetailsModel.fromJson(json["data"]),
    );
  }
}
