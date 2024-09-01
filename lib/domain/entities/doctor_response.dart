import 'dart:io';
import 'package:equatable/equatable.dart';
import 'medical_item.dart';

class DoctorResponse extends Equatable {
  final String? requestId;
  final String? createdBy;
  final String? status;
  final String? responseDate;
  final String? medicalEntity;
  final String? feedback;
  final String?  responseComment;
  final String? LanguageId;
  final List<File>? attachment;
  final List<MedicalItem>? medicalItems;
  const DoctorResponse({
    this.requestId,
    this.createdBy,
    this.status,
    this.responseDate,
    this.medicalEntity,
    this.feedback,
    this. responseComment,
    this.attachment,
    this.LanguageId,
    this.medicalItems,
  });

  @override
  List<Object?> get props => [
        requestId,
        createdBy,
        status,
        responseDate,
        medicalEntity,
        feedback,
    responseComment,
        LanguageId,
        attachment,
        medicalItems,
      ];
}
