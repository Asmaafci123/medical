import 'package:dartz/dartz.dart';
import 'package:more4u/data/models/response/pending_requests_response_model.dart';
import '../../core/errors/failures.dart';
import '../../data/models/response/employee_medical_response_model.dart';
import '../repositories/medical_repository.dart';

class GetMyMedicalRequestsRequestsUseCase {
  MedicalRepository repository;

  GetMyMedicalRequestsRequestsUseCase (this.repository);

  Future<Either<Failure,RequestsResponseModel>> call({
    required String employeeNumber,
    required int languageCode,
    String? token,
  }) {
    return repository.getMyMedicalRequests(
        employeeNumber:employeeNumber,
        languageCode:languageCode,
        token:token
    );
  }
}
