import 'package:equatable/equatable.dart';

class PendingRequest extends Equatable {
  final String requestID;
  final String employeeName;
  final String employeeNumber;
  final String employeeEmageUrl;
  final String requestDate;
  final String createdBy;
  final String requestTypeID;

  const PendingRequest(
      {required this.requestID,
      required this.employeeName,
      required this.employeeNumber,
      required this.employeeEmageUrl,
      required this.requestDate,
      required this.createdBy,
      required this.requestTypeID});

  @override
  List<Object?> get props => [
        requestID,
        employeeName,
        employeeNumber,
        employeeEmageUrl,
        requestDate,
        createdBy,
        requestTypeID
      ];
}
