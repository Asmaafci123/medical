abstract class RequestMedicationState {}

class RequestMedicationInitial extends RequestMedicationState {}

class GetEmployeeRelativesLoadingState extends RequestMedicationState {}

class GetEmployeeRelativesSuccessState extends RequestMedicationState {
  final String message;
  GetEmployeeRelativesSuccessState(this.message);
}


class ClearCurrentEmployeeSuccessState extends RequestMedicationState {}



class GetEmployeeRelativesErrorState extends RequestMedicationState {
  final String message;
  GetEmployeeRelativesErrorState(this.message);
}


class ImagesPickedSuccessState extends RequestMedicationState  {}
class DeleteImageSuccessState extends RequestMedicationState {}

class SendMedicationRequestLoadingState extends RequestMedicationState {}

class SendMedicationRequestSuccessState extends RequestMedicationState {}

class SendMedicationRequestErrorState extends RequestMedicationState {
  final String message;
  SendMedicationRequestErrorState(this.message);
}

class SelectCategorySuccessState extends RequestMedicationState {}
class SelectSubCategorySuccessState extends RequestMedicationState {}
class SelectDetailsOfMedicalSuccessState extends RequestMedicationState {}


class ChangeFamilyInsuranceFlagSuccessState extends RequestMedicationState {}
class ChangeMonthlyInsuranceFlagSuccessState extends RequestMedicationState {}


class SelectRelativeSuccessState extends RequestMedicationState {}


class ChangeActiveStepSuccessState extends RequestMedicationState {}
class RemoveSelectedSubCategorySuccessState extends RequestMedicationState {}

class SelectPharmacySuccessState extends RequestMedicationState {}