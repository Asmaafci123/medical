
import '../../../domain/entities/get_all_employees_response.dart';
import '../employee_model.dart';

class AllEmployeeResponseModel extends AllEmployeeResponse{
  const AllEmployeeResponseModel ({
    required String message,
    required  List<EmployeeModel> employees,
  }) : super(
      message:message,
      employees:employees,

  );

  factory  AllEmployeeResponseModel.fromJson(Map<String, dynamic> json) {
    return  AllEmployeeResponseModel(
      message: json['message'],
      employees: List<EmployeeModel>.from(json['data']
          .map((x) => EmployeeModel.fromJson(x))
          .toList()),
    );
  }
}

