import 'dart:io';

import 'package:equatable/equatable.dart';

class MedicationRequest extends Equatable {
  final String? createdBy;
  final String? requestBy;
  final int? requestedFor;
  final int? requestType;
  final String? requestDate;
  final bool? monthlyMedication;
  final  bool? selfRequest;
  final String? medicalEntityId;
  final String? medicalPurpose;
  final String? comment;
  final List<File>? attachment;
  const MedicationRequest ({
    this.createdBy,
    this.requestBy,
    this.requestedFor,
    this.requestType,
    this.requestDate,
    this.monthlyMedication,
    this.selfRequest,
    this.medicalEntityId,
    this.medicalPurpose,
    this.comment,
    this.attachment
  });

  @override
  List<Object?> get props => [];
}
