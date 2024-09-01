import 'package:equatable/equatable.dart';

class Employee extends Equatable {
  final String name;
  final int employeeNumber;

  const  Employee({
    required this.name,
    required this.employeeNumber

  });

  @override
  List<Object?> get props => [
    name,
    employeeNumber
  ];
}
