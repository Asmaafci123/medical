
import '../../domain/entities/requests_count.dart';

class RequestsCountModel extends RequestsCount{
  const  RequestsCountModel ({
    required String  medications,
    required String   checkups ,
    required String  sickleave,
    required String  totalRequest,
  }) : super(
      medications: medications,
      checkups: checkups,
      sickleave:sickleave,
      totalRequest: totalRequest
  );

  factory RequestsCountModel.fromJson(Map<String, dynamic> json) {
    return  RequestsCountModel(
      medications: json['medications'],
      checkups: json['checkups'],
      sickleave: json['sickleave'],
      totalRequest: json['totalRequest'],
    );
  }
}

