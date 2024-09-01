
abstract class HomeState {}

class HomeInitial extends HomeState {}
class GetCurrentUserLoadingState extends HomeState {}
class GetCurrentUserSuccessState extends HomeState {}
class GetCurrentUserErrorState extends HomeState {
  final String message;
  GetCurrentUserErrorState(this.message);
}
