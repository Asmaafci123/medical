import 'package:equatable/equatable.dart';

class Request extends Equatable {
  final String requestID;
  final String employeeName;
  final String employeeNumber;
  final String employeeImageUrl;
  final DateTime requestDate;
  final String createdBy;
  final String requestTypeID;
  final bool selfRequest;
  final String? requestComment;
  final String? requestStatus;
  final String? requestMedicalEntity;

  const Request(
      {required this.requestID,
      required this.employeeName,
      required this.employeeNumber,
      required this.employeeImageUrl,
      required this.requestDate,
      required this.createdBy,
      required this.requestTypeID,
      required this.selfRequest,
        required this. requestStatus,
      this.requestComment,
        this.requestMedicalEntity
      });

  @override
  List<Object?> get props => [
        requestID,
        employeeName,
        employeeNumber,
        employeeImageUrl,
        requestDate,
        createdBy,
        requestTypeID,
        selfRequest,
    requestComment,
    requestStatus,
    requestMedicalEntity
      ];
}
