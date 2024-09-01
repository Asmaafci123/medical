import '../../../domain/entities/response_medical_request.dart';
import '../../../domain/entities/requests_count.dart';
import '../../../domain/entities/response/requests_response.dart';
import '../request_count_model.dart';
import '../response_medical_request_model.dart';

class  RequestsResponseModel extends  RequestsResponse{
  const  RequestsResponseModel({
    required bool flag,
    required String message,
    required RequestsCount requestsCount,
    required List<Request> requests,
  }) : super(
    flag: flag,
    message: message,
    requestsCount: requestsCount,
    requests:  requests,
  );

  factory RequestsResponseModel.fromJson(Map<String, dynamic> json) {
    return  RequestsResponseModel(
      flag: json['flag'],
      message: json['message'],
      requestsCount: RequestsCountModel.fromJson(json['data']['requestsCount']),
      requests: List<RequestModel>.from(
          json['data']['requests'].map((x) => RequestModel.fromJson(x)).toList()),
    );
  }
}
