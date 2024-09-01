import 'package:dartz/dartz.dart';
import 'package:more4u/data/models/response/pending_requests_response_model.dart';
import 'package:more4u/domain/entities/medical_requests_filteration.dart';
import '../../core/errors/failures.dart';
import '../../data/models/response/employee_medical_response_model.dart';
import '../repositories/medical_repository.dart';

class GetFilteredMedicalRequestsRequestsUseCase {
  MedicalRepository repository;

  GetFilteredMedicalRequestsRequestsUseCase(this.repository);

  Future<Either<Failure,RequestsResponseModel>> call({
    FilteredMedicalRequestsSearch? filter,
    String? token,
  }) {
    return repository.getFilteredMedicalRequests(
       filter: filter,
        token:token
    );
  }
}
