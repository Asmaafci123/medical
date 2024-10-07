
abstract class PendingRequestsState {}

class PendingRequestsInitial extends PendingRequestsState {}
class GetPendingRequestsLoadingState extends PendingRequestsState {}
class GetPendingRequestsSuccessState extends PendingRequestsState {}
class GetPendingRequestsErrorState extends PendingRequestsState {
  final String message;
  GetPendingRequestsErrorState(this.message);
}
class ChangeRequestTypeSuccessState extends PendingRequestsState {}


class GetMedicalRequestDetailsLoadingState extends PendingRequestsState {}
class GetMedicalRequestDetailsSuccessState extends PendingRequestsState {}
class GetMedicalRequestDetailsErrorState extends PendingRequestsState {
  final String message;
  GetMedicalRequestDetailsErrorState(this.message);
}

class ChangeInitialTabIndexSuccessState extends PendingRequestsState {}


class ClearSearchResultSuccessState extends PendingRequestsState {}

class SendDoctorResponseLoadingState extends PendingRequestsState {}
class SendDoctorResponseSuccessState extends PendingRequestsState {
  final String message;
  SendDoctorResponseSuccessState(this.message);
}
class SendDoctorResponseErrorState extends PendingRequestsState {
  final String message;
  SendDoctorResponseErrorState(this.message);
}


class ChangeMedicalEntitySuccessState extends PendingRequestsState {}


class DoctorResponseImagesPickedSuccessState extends PendingRequestsState {}

class ChangeSelectedFeedbackSuccessState extends PendingRequestsState {}


class ChangeMedicalItemsSuccessState extends PendingRequestsState {}


class AddMedicalItemQuantitySuccessState extends PendingRequestsState {}
class MinusMedicalItemQuantitySuccessState extends PendingRequestsState {}
class RemoveMedicalItemQuantitySuccessState extends PendingRequestsState {}

class SearchInPendingRequestsLoadingState extends PendingRequestsState {}
class SearchInPendingRequestsSuccessState extends PendingRequestsState {}

class AddMedicalItemSuccessState extends PendingRequestsState {}


class SearchInMedicalItemsLoadingState extends PendingRequestsState {}
class SearchInMedicalItemsSuccessState extends PendingRequestsState {}
class SearchInMedicalItemsErrorState extends PendingRequestsState {

  final String message;
  SearchInMedicalItemsErrorState(this.message);
}

