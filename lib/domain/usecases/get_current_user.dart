import 'package:dartz/dartz.dart';
import '../../../../../core/errors/failures.dart';
import '../../data/models/response/get_user_response_model.dart';
import '../repositories/user_repository.dart';

class CurrentUserUseCase {
  UserRepository repository;

  CurrentUserUseCase(this.repository);

  Future<Either<Failure, GetCurrentUserModel>> call({
    required String userNumber,
    String? token,
    required int languageCode
  }) {
    return repository.getCurrentUser(
        languageCode:languageCode,
        userNumber: userNumber,token: token);
  }
}
