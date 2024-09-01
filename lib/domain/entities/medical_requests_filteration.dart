class FilteredMedicalRequestsSearch {
  final String selectedRequestType;
  final String selectedRequestStatus;
  final String requestId;
  final String userNumberSearch;
  final String relativeId;
  final String userNumber;
  final String searchDateFrom;
  final String searchDateTo;
  final String languageId;


  FilteredMedicalRequestsSearch(
      {required this.selectedRequestType,
        required this.selectedRequestStatus,
        required this.requestId,
        required this.userNumberSearch,
        required this.relativeId,
        required this.userNumber,
        required this.searchDateFrom,
        required this.searchDateTo,
        required this.languageId,
      });
}
