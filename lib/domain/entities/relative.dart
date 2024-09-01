import 'package:equatable/equatable.dart';

class Relative extends Equatable {
  final int relativeId;
  final String relativeName;
  final String relation;
  final String birthDate;
  final int order;
  final String medicalCoverage;


  const Relative({
    required this.relativeId,
    required this.relativeName,
    required this.relation,
    required this.birthDate,
    required this.order,
    required this.medicalCoverage,
  });

  @override
  List<Object?> get props => [
    relativeId,
    relativeName,
    relation,
    birthDate,
    order,
    medicalCoverage,
  ];
}
