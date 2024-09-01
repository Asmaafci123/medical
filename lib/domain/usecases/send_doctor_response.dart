import 'package:dartz/dartz.dart';
import '../../core/errors/failures.dart';
import '../../data/models/doctor_resonse_model.dart';
import '../../data/models/medication_request_model.dart';
import '../repositories/medical_repository.dart';

class SendDoctorResponseUseCase {
  MedicalRepository repository;

  SendDoctorResponseUseCase(this.repository);

  Future<Either<Failure, String>> call(
      {required DoctorResponseModel doctorResponseModel,
        String? token,}) {
    return repository.sendDoctorResponse(
       doctorResponseModel: doctorResponseModel,
       token: token);
  }
}
