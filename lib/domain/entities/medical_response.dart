import 'package:equatable/equatable.dart';
import 'package:more4u/domain/entities/details-of-medical.dart';

import 'medical_item.dart';

class MedicalDoctorResponse extends Equatable {
  final String? createdBy;
  final String? responseDate;
  final List<String>? attachment;
  final String? medicalEntity;
  final String? feedback;
  final String? responseComment;
  final List<String>?feedbackCollection;
  final List<DetailsOfMedical>? medicalEntities;
  final List<MedicalItem>? medicalItems;

  const MedicalDoctorResponse(
      {required this.createdBy,
      required this.responseDate,
      required this.attachment,
      required this.medicalEntity,
      required this.feedback,
      required this.responseComment,
      required this.medicalEntities,
      required this.medicalItems,
        required this.feedbackCollection
      });

  @override
  List<Object?> get props => [
        createdBy,
        responseDate,
        attachment,
        medicalEntity,
        feedback,
    responseComment,
        medicalEntities,
        medicalItems,
    feedbackCollection
      ];
}
