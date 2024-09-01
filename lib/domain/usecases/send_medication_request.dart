import 'package:dartz/dartz.dart';
import '../../core/errors/failures.dart';
import '../../data/models/medication_request_model.dart';
import '../repositories/medical_repository.dart';

class SendMedicationRequestUseCase {
  MedicalRepository repository;

  SendMedicationRequestUseCase(this.repository);

  Future<Either<Failure, String>> call(
      {required MedicationRequestModel medicationRequestModel,
      String? token,
      required int languageCode}) {
    return repository.sendMedicationRequest(
        medicationRequestModel: medicationRequestModel,
        languageCode: languageCode);
  }
}
