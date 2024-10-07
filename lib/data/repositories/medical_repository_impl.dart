import 'package:dartz/dartz.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../../../../core/errors/exceptions.dart';
import '../../../../../core/errors/failures.dart';
import '../../../../../core/network/network_info.dart';
import '../../core/constants/app_strings.dart';
import '../../domain/entities/medical_requests_filteration.dart';
import '../../domain/repositories/medical_repository.dart';
import '../datasources/remote_data_source.dart';
import '../models/doctor_resonse_model.dart';
import '../models/medication_request_model.dart';
import '../models/response/employee_medical_response_model.dart';
import '../models/response/medication_request_response_model.dart';
import '../models/response/pending_requests_response_model.dart';
import '../models/response/search_medical_items_model_response.dart';

class MedicalRepositoryImpl extends MedicalRepository {
  final RemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  MedicalRepositoryImpl(
      {required this.remoteDataSource, required this.networkInfo});

  @override
  Future<Either<Failure, EmployeeMedicalResponseModel>> getEmployeeRelatives(
      {required String userNumber,
        required int languageCode,
        required int requestType,
        String? token}) async {
    if (await networkInfo.isConnected) {
      try {
        EmployeeMedicalResponseModel result =
        await remoteDataSource.getEmployeeRelatives(
            userNumber: userNumber,
            languageCode: languageCode,
            requestType: requestType);
        return Right(result);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.message));
      }
    } else {
      return Left(ConnectionFailure(AppStrings.noInternetConnection.tr()));
    }
  }

  @override
  Future<Either<Failure, RequestsResponseModel>> getPendingRequests({
    required String requestTypeID,
    required int languageCode,
    String? token,
  }) async {
    if (await networkInfo.isConnected) {
      try {
        RequestsResponseModel result =
        await remoteDataSource.getPendingRequests(
            languageCode: languageCode,
            requestTypeID: requestTypeID,
            token: token);
        return Right(result);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.message));
      }
    } else {
      return Left(ConnectionFailure(AppStrings.noInternetConnection.tr()));
    }
  }

  @override
  Future<Either<Failure, String>> sendMedicationRequest(
      {required MedicationRequestModel medicationRequestModel,
        String? token,
        required int languageCode}) async {
    if (await networkInfo.isConnected) {
      try {
        var result = await remoteDataSource.sendMedicationRequest(
            medicationRequestModel: medicationRequestModel,
            token: token,
            languageCode: languageCode);
        return Right(result);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.message));
      }
    } else {
      return Left(ConnectionFailure(AppStrings.noInternetConnection.tr()));
    }
  }

  @override
  Future<Either<Failure, MedicationRequestResponseModel>>
  getMedicalRequestDetails({required String medicalRequestId,
    required String employeeNumber,
    String? token,
    required int languageCode}) async {
    if (await networkInfo.isConnected) {
      try {
        var result = await remoteDataSource.getMedicalRequestDetails(
            medicalRequestId: medicalRequestId,
            token: token,
            employeeNumber: employeeNumber,
            languageCode: languageCode);
        return Right(result);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.message));
      }
    } else {
      return Left(ConnectionFailure(AppStrings.noInternetConnection.tr()));
    }
  }

  @override
  Future<Either<Failure, String>> sendDoctorResponse({
    required DoctorResponseModel doctorResponseModel,
    String? token,
  }) async {
    if (await networkInfo.isConnected) {
      try {
        var result = await remoteDataSource.sendDoctorResponse(
          token: token,
          doctorResponseModel: doctorResponseModel,
        );
        return Right(result);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.message));
      }
    } else {
      return Left(ConnectionFailure(AppStrings.noInternetConnection.tr()));
    }
  }

  @override
  Future<Either<Failure, RequestsResponseModel>> getMyMedicalRequests({
    required String employeeNumber,
    required int languageCode,
    String? token,
  }) async {
    if (await networkInfo.isConnected) {
      try {
        RequestsResponseModel result =
        await remoteDataSource.getMyMedicalRequests(
            languageCode: languageCode,
            employeeNumber: employeeNumber,
            token: token);
        return Right(result);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.message));
      }
    } else {
      return Left(ConnectionFailure(AppStrings.noInternetConnection.tr()));
    }
  }


  @override
  Future<Either<Failure, RequestsResponseModel>> getFilteredMedicalRequests({
    FilteredMedicalRequestsSearch? filter,
    String? token,
  }) async {
    if (await networkInfo.isConnected) {
      try {
        RequestsResponseModel result =
        await remoteDataSource.getFilteredMedicalRequests(
            filter: filter,
            token: token);
        return Right(result);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.message));
      }
    } else {
      return Left(ConnectionFailure(AppStrings.noInternetConnection.tr()));
    }
  }


  @override
  Future<Either<Failure, SearchMedicalItemsModelResponse>>  searchInMedicalItems({
    String? requestType,
    String? searchText,
    required int languageCode,
    String? token,
  })async
  {
    if (await networkInfo.isConnected) {
      try {
        SearchMedicalItemsModelResponse result =
        await remoteDataSource.searchInMedicalItems(
            requestType: requestType,
            searchText:searchText,
            languageCode:languageCode,
            token: token);
        return Right(result);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.message));
      }
    } else {
      return Left(ConnectionFailure(AppStrings.noInternetConnection.tr()));
    }
  }
}
