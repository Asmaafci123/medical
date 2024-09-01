import '../../../domain/entities/medical_request_details.dart';
import 'medical_doctor_response_model.dart';
import 'medical_request_model.dart';

class MedicalRequestDetailsModel extends MedicalRequestDetails{
  const MedicalRequestDetailsModel ({
    required String? medicalRequestId,
    required String?  requestStatus,
   required  MedicalRequestModel? medicalRequest,
    required MedicalDoctorResponseModel? medicalResponse
  }) : super(
    medicalRequestId: medicalRequestId,
    requestStatus: requestStatus,
      medicalRequest:medicalRequest,
      medicalResponse:medicalResponse
  );

  factory MedicalRequestDetailsModel.fromJson(Map<String, dynamic> json) {
    return MedicalRequestDetailsModel (
      medicalRequestId: json['medicalRequestId'],
      requestStatus: json['requestStatus'],
        medicalRequest: MedicalRequestModel.fromJson(json['medicalRequest']),
      medicalResponse:json['medicalResponse']!=null? MedicalDoctorResponseModel.fromJson(json['medicalResponse']):null,
    );
  }
}
