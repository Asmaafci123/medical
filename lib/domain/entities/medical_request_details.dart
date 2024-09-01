import 'package:equatable/equatable.dart';
import 'medical_request.dart';
import 'medical_response.dart';

class MedicalRequestDetails extends  Equatable{
  final String? medicalRequestId;
  final String?  requestStatus;
  final MedicalRequest? medicalRequest;
  final MedicalDoctorResponse? medicalResponse;

  const MedicalRequestDetails({
    required this.medicalRequestId,
    required this.requestStatus,
    required this.medicalRequest,
    required this.medicalResponse
  });

  @override
  List<Object?> get props => [
    medicalRequestId,
    requestStatus,
    medicalRequest,
    medicalResponse
  ];
}
