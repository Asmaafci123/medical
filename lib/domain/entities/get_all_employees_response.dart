import 'package:equatable/equatable.dart';
import 'package:more4u/domain/entities/employee.dart';

class AllEmployeeResponse extends Equatable {
  final String message;
  final List<Employee> employees;

  const  AllEmployeeResponse({
    required this.message,
    required this.employees,

  });

  @override
  List<Object?> get props => [
    message,
    employees,
  ];
}
