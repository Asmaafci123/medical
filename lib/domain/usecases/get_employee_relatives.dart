import 'package:dartz/dartz.dart';
import '../../core/errors/failures.dart';
import '../../data/models/response/employee_medical_response_model.dart';
import '../repositories/medical_repository.dart';

class GetEmployeeRelativesUseCase {
  MedicalRepository repository;

  GetEmployeeRelativesUseCase (this.repository);

  Future<Either<Failure,EmployeeMedicalResponseModel>> call({
    required String userNumber,
    required int requestType,
    required int languageCode,
    String? token
  }) {
    return repository.getEmployeeRelatives(
        userNumber: userNumber,
        requestType: requestType,
        languageCode:languageCode,
        token:token
    );
  }
}
