import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:more4u/core/constants/constants.dart';
import '../../../core/utils/function/get_language.dart';
import '../../../domain/usecases/get_current_user.dart';
import 'home_states.dart';

class HomeCubit extends Cubit<HomeState> {
  final CurrentUserUseCase currentUserUseCase;

  static HomeCubit get(context) => BlocProvider.of(context);

  HomeCubit({
    required this.currentUserUseCase,
  }) : super(HomeInitial());


  getCurrentUser() async {
    emit(GetCurrentUserLoadingState());
    await getLanguageCode();
    final result = await currentUserUseCase(
        userNumber: userNumber.toString(),
        token: accessToken,
        languageCode: languageId!);
    result.fold((failure) {
      emit(GetCurrentUserErrorState(failure.message));
    }, (homeDataResponse) {
      userData = homeDataResponse.user;
      userUnSeenNotificationCount =
          homeDataResponse.userUnSeenNotificationCount??0;
      pendingRequestMedicalCount = homeDataResponse.pendingRequestMedicalCount;
      pendingRequestsCountMore4u=homeDataResponse.user.pendingRequestsCount;
      relativeCount = homeDataResponse.relativeCount;
      medicalCoverage = homeDataResponse.medicalCoverage;
      emit(GetCurrentUserSuccessState());
    });
  }
}
