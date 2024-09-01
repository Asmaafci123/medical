import 'dart:io';

import '../../domain/entities/request_medication.dart';

class RequestMedicationModel extends RequestMedication{
  const RequestMedicationModel({
    required String createdBy,
    required int requestedBy,
    required int requestedFor,
    required int requestType,
    required DateTime requestDate,
    required bool monthlyMedication,
    required List<File> attachment,
    required bool selfRequest,
    required String comment,
    required int placeId,
    required String reason,
  }) : super(
      createdBy:  createdBy,
      requestedBy:requestedBy,
      requestedFor:requestedFor,
      requestType:requestType,
      requestDate:requestDate,
      monthlyMedication:monthlyMedication,
      attachment:attachment,
      selfRequest:selfRequest,
      comment:comment,
      placeId:placeId,
      reason:reason
  );

  factory  RequestMedicationModel.fromJson(Map<String, dynamic> json) {
    return  RequestMedicationModel(
      createdBy: json['createdBy'],
      requestedBy: json['requestedBy'],
      requestedFor: json['requestedFor'],
      requestType: json['requestType'],
      requestDate: json['requestDate'],
      monthlyMedication: json['monthlyMedication'],
      attachment: json['attachment'],
      selfRequest: json['selfRequest'],
      comment: json['comment'],
        placeId:json['placeId'],
      reason:json['reason'],
    );
  }


  Map<String, dynamic> toJson() {
    return {
      "createdBy":  createdBy,
      "requestedBy": requestedBy,
      "requestedFor":requestedFor,
      "requestType": requestType,
      "requestDate": requestDate,
      "monthlyMedication":monthlyMedication,
      "attachment":attachment,
      'selfRequest': selfRequest,
      "comment":comment,
      "placeId":placeId,
      "reason":reason
    };
  }

  factory RequestMedicationModel.fromEntity(RequestMedicationModel requestMedicationModel) =>
      RequestMedicationModel(
        createdBy: requestMedicationModel.createdBy!,
        requestedBy: requestMedicationModel.requestedBy!,
        requestedFor: requestMedicationModel.requestedFor!,
        requestType: requestMedicationModel.requestType!,
        requestDate: requestMedicationModel.requestDate!,
        monthlyMedication: requestMedicationModel.monthlyMedication!,
        attachment: requestMedicationModel.attachment!,
        selfRequest: requestMedicationModel.selfRequest!,
        comment: requestMedicationModel.comment!,
        placeId: requestMedicationModel.placeId!,
        reason: requestMedicationModel.reason!,
      );
}

