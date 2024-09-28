import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:more4u/domain/entities/relative.dart';
import '../../../core/constants/constants.dart';
import '../../../core/utils/function/get_language.dart';
import '../../../domain/entities/medical_requests_filteration.dart';
import '../../../domain/entities/response_medical_request.dart';
import '../../../domain/usecases/get_filtered_medical_requests.dart';
import '../../../domain/usecases/get_my_medical_reuests.dart';
import 'my_medical_requests_state.dart';

class MyMedicalRequestsCubit extends Cubit<MyMedicalRequestsState> {
  final GetMyMedicalRequestsRequestsUseCase getMyMedicalRequestsRequestsUseCase;
  final GetFilteredMedicalRequestsRequestsUseCase getFilteredMedicalRequestsRequestsUseCase;
  MyMedicalRequestsCubit({required this.getMyMedicalRequestsRequestsUseCase,required this.getFilteredMedicalRequestsRequestsUseCase})
      : super(MyMedicalRequestsInitial());

  static MyMedicalRequestsCubit get(context) => BlocProvider.of(context);
  List<Request>myMedicalRequests=[];
 // List<Request>myMedicalRequestsBeforeReverse=[];
  TextEditingController searchInMyMedicalRequestsController=TextEditingController();
  getMyMedicalRequests() async {
    emit(GetMyMedicalRequestsLoadingState());
    await getLanguageCode();
    final result = await getMyMedicalRequestsRequestsUseCase(
        employeeNumber:userNumber.toString(),
        languageCode: languageId!,
        token: accessToken);
    result.fold((failure) {
      emit(GetMyMedicalRequestsErrorState(failure.message));
    }, (myMedicalRequestsResponse) {
      List<Request>requests=myMedicalRequestsResponse.requests;
     requests.sort((a,b) => a.requestDate.compareTo(b.requestDate));
      myMedicalRequests= requests.reversed.toList();
    //  myMedicalRequests=[];
      emit(GetMyMedicalRequestsSuccessState());
    });
  }
  List<Request> searchedResult=[];
  searchInPendingRequests()
  {
    searchedResult.clear();
    emit(SearchInMedicalRequestsLoadingState());
      for(int i=0;i<myMedicalRequests.length;i++)
      {
        String? medicalEntity=myMedicalRequests[i].requestMedicalEntity?.toLowerCase();
        String? requestId=myMedicalRequests[i].requestID.toLowerCase();
        String? searchText=searchInMyMedicalRequestsController.text.toLowerCase();
        if(requestId.contains(searchText)
        || medicalEntity!.contains(searchText)) {
          searchedResult.add(myMedicalRequests[i]);
        }
      }
      emit(SearchInMedicalRequestsSuccessState());
  }

  clearSearchResult()
  {
    searchInMyMedicalRequestsController.clear();
    emit(ClearSearchResultSuccessState());
  }
  int selectedRequestType=0;
  selectRequestType(int index) {
    selectedRequestType = index==-1?0:index;
    emit(ChangeFiltration());
  }

  int selectedRequestStatus=0;
  selectRequestStatus(int index) {
    selectedRequestStatus = index==-1?0:index;
    emit(ChangeFiltration());
  }

  TextEditingController requestIdFiltrationController=TextEditingController();

  TextEditingController fromText = TextEditingController()..addListener(() {});
  TextEditingController toText = TextEditingController();

  TextEditingController userNumberSearch = TextEditingController();
  DateTime? fromDate;
  DateTime? toDate;
  changeFromDate(DateTime? date) {
    fromDate = date;

    if (fromDate == null) {
      fromDate = null;
      toDate = null;
      fromText.clear();
      toText.clear();
    } else {
      if (toDate == null) {}
      if (toDate == null || toDate?.compareTo(fromDate!) == -1) {
        toDate = fromDate;
        toText.text = fromText.text;
      }
    }
    emit(ChangeFiltration());
  }
  changeToDate(DateTime? date) {
    toDate = date;
    emit(ChangeFiltration());
  }

  Relative? selectedRelative;

  selectRelative(Relative relative)
  {
    selectedRelative=relative;
    emit(SelectedRelativeSuccessState());
  }


  List<String>filteredSearchList=[];
  Set<String>filteredSearchSet={};
  filter()async {
    filteredSearchList=[];
    filteredSearchSet={};
    var filterMedical= FilteredMedicalRequestsSearch(
        selectedRequestType:selectedRequestType<=0?"": selectedRequestType.toString(),
        selectedRequestStatus:selectedRequestStatus<=0?"": selectedRequestStatus.toString(),
        requestId:requestIdFiltrationController.text ,
        userNumberSearch: userNumberSearch.text,
        relativeId: selectedRelative?.relativeId.toString()??"",
        userNumber:userData?.userNumber.toString()??"",
        searchDateFrom: fromText.text.isEmpty ? "" : fromText.text,
        searchDateTo: toText.text.isEmpty ? "" : toText.text,
        languageId:languageId.toString()
    );

    if(selectedRequestType==1) {
      filteredSearchSet.add("Medications");
    }
    else if(selectedRequestType==2) {
      filteredSearchSet.add("CheckUps");
    }
    else if(selectedRequestType==3) {
      filteredSearchSet.add("SickLeave");
    }


    if(selectedRequestStatus==1) {
      filteredSearchSet.add("Pending");
    }
    else if(selectedRequestStatus==3) {
      filteredSearchSet.add("Approved");
    }
    else if(selectedRequestStatus==4) {
      filteredSearchSet.add("Rejected");
    }

    if(requestIdFiltrationController.text.isNotEmpty)
   {
     filteredSearchSet.add(requestIdFiltrationController.text.toString());
   }
    if(userNumberSearch.text.isNotEmpty)
    {
      filteredSearchSet.add(userNumberSearch.text.toString());
    }
    if(selectedRelative!=null)
    {
      filteredSearchSet.add(selectedRelative!.relativeId.toString());
    }
    if(fromText.text.isNotEmpty)
    {
      filteredSearchSet.add(fromText.text.toString());
    }
    if(toText.text.isNotEmpty)
    {
      filteredSearchSet.add(toText.text.toString());
    }
    filteredSearchList=filteredSearchSet.toList();
    await getFilteredMedicalRequests(filter:filterMedical);
  }



  List<Request> filteredMedicalRequest=[];
  getFilteredMedicalRequests({FilteredMedicalRequestsSearch? filter}) async {
    filteredMedicalRequest=[];
    emit(GetFilteredMedicalRequestsLoadingState());
    final result = await getFilteredMedicalRequestsRequestsUseCase(
        token:accessToken,
        filter: filter);
    result.fold((failure) {
      emit(GetFilteredMedicalRequestsErrorState(failure.message));
    }, (filteredMedicalRequestsResponse) {
      filteredMedicalRequest=filteredMedicalRequestsResponse.requests;
      emit(GetFilteredMedicalRequestsSuccessState());
    });
  }

  clearFilteredList()
  {
    filteredSearchList.clear();
    filteredMedicalRequest.clear();
    selectedRequestType=-1;
    selectedRequestStatus=-1;
    requestIdFiltrationController.clear();
    userNumberSearch.clear();
    selectedRelative=null;
    fromText.clear();
    toText.clear();
    emit(ClearFilteredHistoryListSuccessState ());
  }
}
