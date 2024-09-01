import 'package:equatable/equatable.dart';

class MedicalRequest extends Equatable {
  final String? createdBy;
  final String? requestedBy;
  final String? requestedByNumber;
  final String? employeeCoverage;
  final String? requestedFor;
  final String? relativeCoverage;
  final String? relation;
  final String? order;
  final int? requestType;
  final String? requestDate;
  final bool? monthlyMedication;
  final List<String>? attachment;
  final bool? selfRequest;
  final String? medicalEntity;
  final String? medicalEntityId;
  final String? medicalPurpose;
  final String? comment;

  const MedicalRequest({
    required this.createdBy,
    required this.requestedBy,
    required this.requestedByNumber,
    required this.employeeCoverage,
    required this.requestedFor,
    required this.relativeCoverage,
    required this.relation,
    required this.order,
    required this.requestType,
    required this.requestDate,
    required this.monthlyMedication,
    required this.attachment,
    required this.selfRequest,
    required this.medicalEntity,
    required this.medicalEntityId,
    required this.medicalPurpose,
    required this.comment,
  });

  @override
  List<Object?> get props => [
        createdBy,
        requestedBy,
        requestedByNumber,
        employeeCoverage,
        requestedFor,
        relativeCoverage,
        relation,
        order,
        requestType,
        requestDate,
        monthlyMedication,
        attachment,
        selfRequest,
        medicalEntity,
        medicalEntityId,
        medicalPurpose,
        comment,
      ];
}
