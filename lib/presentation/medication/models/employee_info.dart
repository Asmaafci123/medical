import '../../../domain/entities/relative.dart';

class EmployeeInf {
  final String employeeName;
  final String employeeDepartment;
  final List<Relative>? relatives;
  final String medicalCoverage;
  final String profilePicture;
  final String cemexId;
  EmployeeInf({
    required this.employeeName,
    required this.employeeDepartment,
    required this.relatives,
    required this.medicalCoverage,
    required this.profilePicture,
    required this.cemexId,
  });
}
