import 'package:dartz/dartz.dart';
import 'package:more4u/data/models/medication_request_model.dart';
import 'package:more4u/data/models/response/pending_requests_response_model.dart';
import '../../../../../core/errors/failures.dart';
import '../../data/models/doctor_resonse_model.dart';
import '../../data/models/response/employee_medical_response_model.dart';
import '../../data/models/response/medication_request_response_model.dart';
import '../entities/medical_requests_filteration.dart';

abstract class MedicalRepository {
  Future<Either<Failure, EmployeeMedicalResponseModel>> getEmployeeRelatives(
      {required String userNumber,
      required int languageCode,
      required int requestType,
      String? token});

  Future<Either<Failure, RequestsResponseModel>> getPendingRequests({
    required String requestTypeID,
    required int languageCode,
    String? token,
  });

  Future<Either<Failure, String>> sendMedicationRequest(
      {required MedicationRequestModel medicationRequestModel,
      String? token,
      required int languageCode});

  Future<Either<Failure, MedicationRequestResponseModel>>
      getMedicalRequestDetails(
          {required String medicalRequestId,
          required String employeeNumber,
          String? token,
          required int languageCode});

  Future<Either<Failure, String>>
  sendDoctorResponse(
      {required DoctorResponseModel doctorResponseModel,String? token,});

  Future<Either<Failure, RequestsResponseModel>> getMyMedicalRequests({
    required String employeeNumber,
    required int languageCode,
    String? token,
  });


  Future<Either<Failure, RequestsResponseModel>> getFilteredMedicalRequests({
    FilteredMedicalRequestsSearch? filter,
    String? token,
  });

}


