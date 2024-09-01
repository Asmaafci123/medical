import '../../domain/entities/response_medical_request.dart';

class RequestModel extends Request {
  const RequestModel(
      {required String requestID,
      required String employeeName,
      required String employeeNumber,
      required String employeeImageUrl,
      required DateTime requestDate,
      required String createdBy,
      required String requestTypeID,
      required bool selfRequest,
      required String? requestComment,
      required String? requestStatus,
      required String? requestMedicalEntity})
      : super(
            requestID: requestID,
            employeeName: employeeName,
            employeeNumber: employeeNumber,
            employeeImageUrl: employeeImageUrl,
            requestDate: requestDate,
            createdBy: createdBy,
            requestTypeID: requestTypeID,
            selfRequest: selfRequest,
            requestComment: requestComment,
            requestStatus: requestStatus,
      requestMedicalEntity:requestMedicalEntity);

  factory RequestModel.fromJson(Map<String, dynamic> json) {
    return RequestModel(
      requestID: json['requestID'],
      employeeName: json['employeeName'],
      employeeNumber: json['employeeNumber'],
      employeeImageUrl: json['employeeImageUrl'],
      requestDate: DateTime.parse(json['requestDate']),
      createdBy: json['createdBy'],
      requestTypeID: json['requestTypeID'],
      selfRequest: json['selfRequest'],
      requestComment: json['requestComment'],
      requestStatus: json['requestStatus'],
        requestMedicalEntity: json['requestMedicalEntity']
    );
  }
}
