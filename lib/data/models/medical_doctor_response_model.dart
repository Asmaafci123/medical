import 'package:more4u/data/models/details-of-medical-model.dart';
import 'package:more4u/domain/entities/medical_response.dart';

import 'medical_item_model.dart';

class MedicalDoctorResponseModel extends MedicalDoctorResponse{
  const MedicalDoctorResponseModel ({
    required String? createdBy,
    required String? responseDate,
    required List<String>? attachment,
    required String? medicalEntity,
    required String? feedback,
    required String?  responseComment,
    required List<String>?feedbackCollection,

    required List<DetailsOfMedicalModel>? medicalEntities,
    required List<MedicalItemModel>? medicalItems,
  }) : super(
    createdBy:  createdBy,
    responseDate: responseDate,
      attachment:attachment,
      medicalEntity: medicalEntity,
      feedback:feedback,
      responseComment:responseComment,
      medicalEntities:medicalEntities,
      medicalItems:medicalItems,
      feedbackCollection:feedbackCollection
  );

  factory MedicalDoctorResponseModel.fromJson(Map<String, dynamic> json) {
    return MedicalDoctorResponseModel(
      createdBy: json['createdBy'],
      responseDate: json['responseDate'],
      attachment: json['attachment']!= null? List<String>.from(json['attachment']).toList():null,
      medicalEntity: json['medicalEntity'],
      feedback: json['feedback'],
      responseComment: json['responseComment'],
      medicalEntities: json['medicalEntities'] != null
          ? List<DetailsOfMedicalModel>.from(json['medicalEntities']
          .map((x) => DetailsOfMedicalModel.fromJson(x))
          .toList())
          : null,
      feedbackCollection: json['feedbackCollection'] != null
          ?List<String>.from(json['feedbackCollection']).toList():null,
      medicalItems: json['medicalItems'] != null
          ? List<MedicalItemModel>.from(json['medicalItems']
          .map((x) => MedicalItemModel.fromJson(x))
          .toList())
          : null,
    );
  }
}
