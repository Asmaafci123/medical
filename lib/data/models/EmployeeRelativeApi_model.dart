import 'package:more4u/data/models/relative_model.dart';
import '../../../domain/entities/employee_relatives_api.dart';
import '../../../domain/entities/relative.dart';

class EmployeeRelativesApiModel extends EmployeeRelativeApi {
  const EmployeeRelativesApiModel(
      {required int cemexId,
      required int relativeId,
      required String? employeeName,
      required String? birthDate,
      required String? medicalCoverage,
      required List<Relative>? relatives,
      String? profilePicture,
      String? employeeDepartment})
      : super(
            cemexId: cemexId,
            relativeId: relativeId,
            employeeName: employeeName,
            birthDate: birthDate,
            medicalCoverage: medicalCoverage,
            relatives: relatives,
            profilePicture: profilePicture,
            employeeDepartment: employeeDepartment);

  factory EmployeeRelativesApiModel.fromJson(Map<String, dynamic> json) {
    return EmployeeRelativesApiModel(
      cemexId: json['cemexId'],
      relativeId: json['relativeId'],
      employeeName: json['employeeName'],
      birthDate: json['birthDate'],
      profilePicture: json['profilePicture'],
      employeeDepartment: json['employeeDepartment'],
      medicalCoverage: json['medicalCoverage'],
      relatives: List<RelativeModel>.from(
          json['relatives'].map((x) => RelativeModel.fromJson(x)).toList()),
    );
  }
}
