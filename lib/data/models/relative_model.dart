import 'package:more4u/domain/entities/relative.dart';



class  RelativeModel extends  Relative{
  const  RelativeModel({
    required  int relativeId,
    required  String relativeName,
    required String birthDate,
    required String medicalCoverage,
    required  int order,
    required String relation
  }): super(
      relativeId:relativeId,
      relativeName: relativeName,
      birthDate:  birthDate,
      medicalCoverage: medicalCoverage,
      order: order,
      relation:relation);
  factory RelativeModel .fromJson(Map<String, dynamic> json) =>
      RelativeModel(
        relativeId: json['relativeId'],
        relativeName: json['relativeName'],
         birthDate: json['birthDate'],
        medicalCoverage: json['medicalCoverage'],
        order: json['order'],
        relation: json['relation'],
      );
}
