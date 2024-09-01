import 'package:equatable/equatable.dart';
import '../response_medical_request.dart';
import '../requests_count.dart';

class RequestsResponse extends  Equatable{
  final bool flag;
  final String message;
  final RequestsCount requestsCount;
  final List<Request>requests;

  const RequestsResponse({
    required this.flag,
    required this.message,
    required this.requestsCount,
    required this.requests,
  });

  @override
  List<Object?> get props => [
    flag,
    message,
    requestsCount,
    requests,
  ];
}
