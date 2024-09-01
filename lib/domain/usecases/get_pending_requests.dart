import 'package:dartz/dartz.dart';
import 'package:more4u/data/models/response/pending_requests_response_model.dart';
import '../../core/errors/failures.dart';
import '../../data/models/response/employee_medical_response_model.dart';
import '../repositories/medical_repository.dart';

class GetPendingRequestsUseCase {
  MedicalRepository repository;

  GetPendingRequestsUseCase(this.repository);

  Future<Either<Failure,RequestsResponseModel>> call({
    required String requestTypeID,
    required int languageCode,
    String? token,
  }) {
    return repository.getPendingRequests(
        requestTypeID: requestTypeID,
        languageCode:languageCode,
        token:token
    );
  }
}
