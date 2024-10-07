import 'package:dartz/dartz.dart';
import '../../core/errors/failures.dart';
import '../../data/models/response/search_medical_items_model_response.dart';
import '../repositories/medical_repository.dart';

class SearchInMedicalItemsUseCase {
  MedicalRepository repository;

  SearchInMedicalItemsUseCase(this.repository);

  Future<Either<Failure, SearchMedicalItemsModelResponse>> call({
  String? requestType,
  String? searchText,
  required int languageCode,
  String? token
  }) {
    return repository.searchInMedicalItems(
        requestType: requestType,
        searchText:searchText,
        languageCode:languageCode,
        token: token
    );
  }
}
