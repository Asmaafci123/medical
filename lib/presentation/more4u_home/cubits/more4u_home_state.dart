part of 'more4u_home_cubit.dart';

@immutable
abstract class More4uHomeState {}

class HomeInitial extends More4uHomeState {}
class GetHomeDataLoadingState extends More4uHomeState {}
class GetHomeDataSuccessState extends More4uHomeState {}
class GetHomeDataErrorState extends More4uHomeState {
 final String message;
  GetHomeDataErrorState(this.message);
}

class GetPrivilegesLoadingState extends More4uHomeState {}
class GetPrivilegesSuccessState extends More4uHomeState {}
class GetPrivilegesErrorState extends More4uHomeState {
 final String message;
 GetPrivilegesErrorState(this.message);

}

class NotificationCountChangeState extends More4uHomeState {}

class GetMedicalLoadingState extends More4uHomeState {}
class GetMedicalSuccessState extends More4uHomeState {}
class GetMedicalErrorState extends More4uHomeState {
 final String message;
 GetMedicalErrorState(this.message);
}

class SearchInMedicalSuccessState extends More4uHomeState {}