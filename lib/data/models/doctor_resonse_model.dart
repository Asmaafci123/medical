import 'dart:io';
import 'package:more4u/domain/entities/doctor_response.dart';
import '../../domain/entities/medical_item.dart';

class DoctorResponseModel extends DoctorResponse{
  const DoctorResponseModel({
    required String? requestId,
    required String? createdBy,
    required String? status,
    required String? responseDate,
    required String? medicalEntity,
    required String? feedback,
    required String? responseComment,
    required String? LanguageId,
     List<File>? attachment,
     List<MedicalItem>? medicalItems,
  }) : super(
   requestId: requestId,
    createdBy:createdBy,
    status: status,
     responseDate: responseDate,
     medicalEntity: medicalEntity,
    feedback: feedback,
    responseComment: responseComment,
     LanguageId:LanguageId,
     attachment:attachment,
    medicalItems: medicalItems,
  );

}

