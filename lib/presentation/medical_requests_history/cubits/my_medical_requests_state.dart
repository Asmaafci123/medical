
abstract class MyMedicalRequestsState {}

class  MyMedicalRequestsInitial extends MyMedicalRequestsState  {}
class GetMyMedicalRequestsLoadingState extends MyMedicalRequestsState{}
class GetMyMedicalRequestsSuccessState extends MyMedicalRequestsState {}
class GetMyMedicalRequestsErrorState extends MyMedicalRequestsState{
  final String message;
  GetMyMedicalRequestsErrorState(this.message);
}


class ChangeFiltration extends MyMedicalRequestsState {}



class SearchInMedicalRequestsLoadingState extends MyMedicalRequestsState{}
class SearchInMedicalRequestsSuccessState extends MyMedicalRequestsState {}
class SearchInMedicalRequestsErrorState extends MyMedicalRequestsState{}

class ClearSearchResultSuccessState  extends MyMedicalRequestsState{}

class GetFilteredMedicalRequestsLoadingState extends MyMedicalRequestsState{}
class GetFilteredMedicalRequestsSuccessState extends MyMedicalRequestsState {}
class GetFilteredMedicalRequestsErrorState extends MyMedicalRequestsState{
  final String message;
  GetFilteredMedicalRequestsErrorState(this.message);
}


class SelectedRelativeSuccessState extends MyMedicalRequestsState {}
//class GetFilteredMedicalRequestsLoadingState extends MyMedicalRequestsState{}

class ClearFilteredHistoryListSuccessState extends MyMedicalRequestsState {}