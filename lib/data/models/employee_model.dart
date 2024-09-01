import 'package:more4u/domain/entities/employee.dart';

class EmployeeModel extends Employee{
  const EmployeeModel ({
    required String name,
    required int employeeNumber,
  }) : super(
    name: name,
    employeeNumber:employeeNumber

  );

  factory  EmployeeModel.fromJson(Map<String, dynamic> json) {
    return  EmployeeModel(
      name: json['name'],
      employeeNumber: json['employeeNumber'],
    );
  }
}

