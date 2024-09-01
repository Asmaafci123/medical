import 'package:dartz/dartz.dart';
import 'package:more4u/domain/repositories/medical_repository.dart';
import '../../core/errors/failures.dart';
import '../../data/models/response/medication_request_response_model.dart';

class GetMedicalRequestDetailsUseCase {
  MedicalRepository repository;

  GetMedicalRequestDetailsUseCase (this.repository);

  Future<Either<Failure,  MedicationRequestResponseModel>> call(
      {required String medicalRequestId,
        required String employeeNumber,
        String? token,
        required int languageCode}
      ) {
    return repository.getMedicalRequestDetails(
        medicalRequestId: medicalRequestId,
        employeeNumber: employeeNumber,
        languageCode:languageCode,
        token:token
    );
  }
}
