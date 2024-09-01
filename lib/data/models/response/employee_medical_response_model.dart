import 'package:more4u/data/models/EmployeeRelativeApi_model.dart';
import 'package:more4u/data/models/category-model.dart';
import '../../../domain/entities/category.dart';
import '../../../domain/entities/details-of-medical.dart';
import '../../../domain/entities/employee_medical_api_response.dart';
import '../../../domain/entities/employee_relatives_api.dart';
import '../details-of-medical-model.dart';

class EmployeeMedicalResponseModel extends EmployeeMedicalResponse {
  const EmployeeMedicalResponseModel({
    required bool flag,
    required String message,
    required EmployeeRelativeApi employeeRelativesApiModel,
    required List<Category>? category,
    required List<Category>? subCategory,
    required List<DetailsOfMedical>? medicalDetails,
  }) : super(
          flag: flag,
          message: message,
    employeeRelativesApiModel: employeeRelativesApiModel,
          category: category,
          subCategory: subCategory,
          medicalDetails: medicalDetails,
        );

  factory EmployeeMedicalResponseModel.fromJson(Map<String, dynamic> json) {
    return EmployeeMedicalResponseModel(
      flag: json['flag'],
      message: json['message'],
      employeeRelativesApiModel: EmployeeRelativesApiModel.fromJson(json['employeeRelativesApiModel']),
      category: List<CategoryModel>.from(
          json['category'].map((x) => CategoryModel.fromJson(x)).toList()),
      subCategory: List<CategoryModel>.from(
          json['subCategory'].map((x) => CategoryModel.fromJson(x)).toList()),
      medicalDetails: List<DetailsOfMedicalModel>.from(json['medicalDetails']
          .map((x) => DetailsOfMedicalModel.fromJson(x))
          .toList()),
    );
  }
}
