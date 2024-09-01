import 'package:equatable/equatable.dart';
import '../medical_request_details.dart';
import '../medication_request.dart';

class MedicationRequestResponse extends  Equatable{
  final bool flag;
  final String message;
  final  MedicalRequestDetails? medicalRequestDetails;

  const MedicationRequestResponse({
    required this.flag,
    required this.message,
    required this.medicalRequestDetails
  });

  @override
  List<Object?> get props => [
    flag,
    message,
    medicalRequestDetails
  ];
}
