import 'package:equatable/equatable.dart';
import 'category.dart';
import 'details-of-medical.dart';
import 'employee_relatives_api.dart';

class EmployeeMedicalResponse extends  Equatable{
  final bool flag;
  final String message;
  final EmployeeRelativeApi employeeRelativesApiModel;
  final List<Category>? category;
  final List<Category>? subCategory;
  final List<DetailsOfMedical>? medicalDetails;

  const EmployeeMedicalResponse({
    required this.flag,
    required this.message,
    required this.employeeRelativesApiModel,
    required this.category,
    required this.subCategory,
    required this.medicalDetails,
  });

  @override
  List<Object?> get props => [
    flag,
    message,
    employeeRelativesApiModel,
    category,
    subCategory,
    medicalDetails
  ];
}
