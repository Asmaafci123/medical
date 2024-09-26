import 'dart:io';

import '../../domain/entities/medication_request.dart';

class MedicationRequestModel extends MedicationRequest {
  const MedicationRequestModel(
      {required String? createdBy,
      required String? requestBy,
      required int? requestedFor,
      required int? requestType,
      required String? requestDate,
      required bool? monthlyMedication,
      required bool? selfRequest,
      required String? medicalEntityId,
      required String? medicalPurpose,
      required String? comment,
      List<File>? attachment})
      : super(
            createdBy: createdBy,
            requestBy: requestBy,
            requestedFor: requestedFor,
            requestType: requestType,
            requestDate: requestDate,
            monthlyMedication: monthlyMedication,
            selfRequest: selfRequest,
            medicalEntityId: medicalEntityId,
            medicalPurpose: medicalPurpose,
            comment: comment,
            attachment: attachment);

  factory MedicationRequestModel.fromJson(Map<String, dynamic> json) {
    return MedicationRequestModel(
      createdBy: json['createdBy'],
      requestBy: json['requestBy'],
      requestedFor: json['requestedFor'],
      requestType: json['requestType'],
      requestDate: json['requestDate'],
      monthlyMedication: json['monthlyMedication'],
      selfRequest: json['selfRequest'],
      medicalEntityId: json['medicalEntityId'],
      medicalPurpose: json['medicalPurpose'],
      comment: json['comment'],
      attachment: json['attachment'],
    );
  }
}
