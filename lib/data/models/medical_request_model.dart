import '../../domain/entities/medical_request.dart';

class MedicalRequestModel extends MedicalRequest {
  const MedicalRequestModel({
    required String? createdBy,
    required String? requestedBy,
    required String? requestedByNumber,
    required String? employeeCoverage,
    required String? requestedFor,
    required String? relativeCoverage,
    required String? relation,
    required String? order,
    required int? requestType,
    required String? requestDate,
    required bool? monthlyMedication,
    required List<String>? attachment,
    required bool? selfRequest,
    required String? medicalEntity,
    required String? medicalEntityId,
    required String? medicalPurpose,
    required String? comment,
    required String? employeeDepartment,
    required String? employeePhoneNumber,
  }) : super(
            createdBy: createdBy,
            requestedBy: requestedBy,
            requestedByNumber: requestedByNumber,
            employeeCoverage: employeeCoverage,
            requestedFor: requestedFor,
            relativeCoverage: relativeCoverage,
            relation: relation,
            order: order,
            requestType: requestType,
            requestDate: requestDate,
            monthlyMedication: monthlyMedication,
            attachment: attachment,
            selfRequest: selfRequest,
            medicalEntity: medicalEntity,
            medicalEntityId: medicalEntityId,
            medicalPurpose: medicalPurpose,
            comment: comment,
            employeeDepartment: employeeDepartment,
            employeePhoneNumber: employeePhoneNumber);

  factory MedicalRequestModel.fromJson(Map<String, dynamic> json) {
    return MedicalRequestModel(
      createdBy: json['createdBy'],
      requestedBy: json['requestedBy'],
      requestedByNumber: json['requestedByNumber'],
      employeeCoverage: json['employeeCoverage'],
      requestedFor: json['requestedFor'],
      relativeCoverage: json['relativeCoverage'],
      relation: json['relation'],
      order: json['order'],
      requestType: json['requestType'],
      requestDate: json['requestDate'],
      monthlyMedication: json['monthlyMedication'],
      attachment: json['attachment'] != null
          ? List<String>.from(json['attachment']).toList()
          : null,
      selfRequest: json['selfRequest'],
      medicalEntity: json['medicalEntity'],
      medicalEntityId: json['medicalEntityId'],
      medicalPurpose: json['medicalPurpose'],
      comment: json['comment'],
      employeeDepartment: json['employeeDepartment'],
      employeePhoneNumber: json['employeePhoneNumber'],
    );
  }
}
