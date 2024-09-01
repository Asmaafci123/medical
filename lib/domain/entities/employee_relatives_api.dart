import 'package:equatable/equatable.dart';
import 'package:more4u/domain/entities/relative.dart';


class EmployeeRelativeApi extends Equatable {
  final int cemexId;
  final int relativeId;
  final String? employeeName;
  final String? birthDate;
  final String? medicalCoverage;
  final String? profilePicture;
  final String? employeeDepartment;
  final List<Relative>? relatives;

  const EmployeeRelativeApi({
    required this.cemexId,
    required this.relativeId,
    required this.employeeName,
    required this.birthDate,
    required this.medicalCoverage,
    required this.relatives,
    this.profilePicture,
    this.employeeDepartment
  });

  @override
  List<Object?> get props => [
        cemexId,
        relativeId,
        employeeName,
        birthDate,
        medicalCoverage,
        relatives,
    profilePicture
      ];
}
