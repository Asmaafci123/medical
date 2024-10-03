import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:more4u/core/constants/constants.dart';
import 'package:more4u/data/models/doctor_resonse_model.dart';
import 'package:more4u/domain/entities/details-of-medical.dart';
import 'package:more4u/domain/entities/medical_request_details.dart';
import 'package:more4u/domain/entities/response_medical_request.dart';
import 'package:more4u/domain/usecases/get_medical_request_details.dart';
import 'package:more4u/domain/usecases/get_pending_requests.dart';
import 'package:more4u/domain/usecases/send_doctor_response.dart';
import 'package:more4u/presentation/pending_requests/cubits/pending_requests_state.dart';
import '../../../core/utils/function/get_language.dart';
import '../../../data/models/response/medication_request_response_model.dart';
import '../../../domain/entities/medical_item.dart';

class PendingRequestsCubit extends Cubit<PendingRequestsState> {
  final GetPendingRequestsUseCase getPendingRequestsUseCase;
  final GetMedicalRequestDetailsUseCase getMedicalRequestDetailsUseCas;
  final SendDoctorResponseUseCase sendDoctorResponseUseCase;
  static PendingRequestsCubit get(context) => BlocProvider.of(context);

  PendingRequestsCubit(
      {required this.getPendingRequestsUseCase,
      required this.getMedicalRequestDetailsUseCas,
      required this.sendDoctorResponseUseCase})
      : super(PendingRequestsInitial());

  List<Request> medicationPendingRequests = [];
  List<Request> checkUpsPendingRequests = [];
  List<Request> sickLeavePendingRequests = [];
  String requestTypeID = "1";
  String? medicationPendingRequestCount = "0";
  String? checkUpsPendingRequestCount = "0";
  String? sickLeavePendingRequestCount = "0";
  TextEditingController searchInPendingRequestsController=TextEditingController();
  List<Request> searchedResult=[];
  getPendingRequests() async {
    emit(GetPendingRequestsLoadingState());
    searchedResult.clear();
    searchInPendingRequestsController.clear();
    await getLanguageCode();
    final result = await getPendingRequestsUseCase(
        requestTypeID: requestTypeID,
        languageCode: languageId!,
        token: accessToken);
    result.fold((failure) {
      emit(GetPendingRequestsErrorState(failure.message));
    }, (pendingRequestsResponse) {
      if (requestTypeID == "1") {
        medicationPendingRequests = pendingRequestsResponse.requests;
      } else if (requestTypeID == "2") {
        checkUpsPendingRequests = pendingRequestsResponse.requests;
      } else {
        sickLeavePendingRequests = pendingRequestsResponse.requests;
      }
      medicationPendingRequestCount =
          pendingRequestsResponse.requestsCount.medications;
      checkUpsPendingRequestCount =
          pendingRequestsResponse.requestsCount.checkups;
      sickLeavePendingRequestCount =
          pendingRequestsResponse.requestsCount.sickleave;
      emit(GetPendingRequestsSuccessState());
    });
  }


  clearSearchResult()
  {
    searchInPendingRequestsController.clear();
    emit(ClearSearchResultSuccessState());
  }

  changeRequestTypeID(String requestType) {
    requestTypeID = requestType;
    emit(ChangeRequestTypeSuccessState());
  }
  MedicationRequestResponseModel? medicalRequestCurrentStatus;
  MedicalRequestDetails? medicalRequestDetails;
  List<DetailsOfMedical>? medicalEntities;
  List<MedicalItem>? medicalItems;
  MedicationRequestResponseModel? details;
  getMedicalRequestDetails(String medicalRequestId) async {
    emit(GetMedicalRequestDetailsLoadingState());
    await getLanguageCode();
    final result = await getMedicalRequestDetailsUseCas(
        medicalRequestId: medicalRequestId,
        employeeNumber: userNumber.toString(),
        languageCode: languageId!,
        token: accessToken);
    result.fold((failure) {
      emit(GetMedicalRequestDetailsErrorState(failure.message));
    }, (medicalRequestDetailsResponse) {
      details=medicalRequestDetailsResponse;
      medicalRequestCurrentStatus=medicalRequestDetailsResponse;
      medicalRequestDetails =
          medicalRequestDetailsResponse.medicalRequestDetails;
      medicalEntities = medicalRequestDetails?.medicalResponse?.medicalEntities;
      medicalItems = medicalRequestDetails?.medicalResponse?.medicalItems;
      emit(GetMedicalRequestDetailsSuccessState());
    });
  }

  DetailsOfMedical? selectedMedicalEntity;

  changeMedicalEntity(DetailsOfMedical? selectedMedicalEntityDoctor) {
    selectedMedicalEntity = selectedMedicalEntityDoctor;
    emit(ChangeMedicalEntitySuccessState());
  }
  List<MedicalItem> selectedMedicalItems=[];
  changeMedicalItems(List<MedicalItem> changedMedicalItems) {
   // selectedMedicalItems = changedMedicalItems;
    List<MedicalItem> items=[];
    bool x=false;
    int index=0;
    for(int i=0;i<changedMedicalItems.length;i++)
      {
        x=false;
        index=0;
       for(int j=0;j<selectedMedicalItems.length;j++)
         {
           if(changedMedicalItems[i].itemId==selectedMedicalItems[j].itemId)
             {
               x=true;
               index=j;
             }
         }
        if(x)
        {
          items.add(selectedMedicalItems[index]);
        }
        else
          {
            items.add(changedMedicalItems[i]);
          }
      }
    selectedMedicalItems=items;
    emit(ChangeMedicalItemsSuccessState());
  }

  addMedicalItemQuantity(int index)
  {
    MedicalItem newMedicalItem=
    MedicalItem(
        itemId: selectedMedicalItems[index].itemId,
        itemName: selectedMedicalItems[index].itemName,
        itemType: selectedMedicalItems[index].itemType,
        itemQuantity: (int.parse(selectedMedicalItems[index].itemQuantity??"0")+1).toString(),
        itemDateFrom: selectedMedicalItems[index].itemDateFrom,
        itemDateTo: selectedMedicalItems[index].itemDateTo,
      itemImage: selectedMedicalItems[index].itemImage,
      itemDose: selectedMedicalItems[index].itemDose
    );
    selectedMedicalItems[index]=newMedicalItem;
    emit(AddMedicalItemQuantitySuccessState());
  }
  minusMedicalItemQuantity(int index)
  {
    MedicalItem newMedicalItem=MedicalItem(
        itemId: selectedMedicalItems[index].itemId,
        itemName: selectedMedicalItems[index].itemName,
        itemType: selectedMedicalItems[index].itemType,
        itemQuantity: (int.parse(selectedMedicalItems[index].itemQuantity??"0")-1).toString(),
        itemDateFrom: selectedMedicalItems[index].itemDateFrom,
        itemDateTo: selectedMedicalItems[index].itemDateTo,
        itemImage: selectedMedicalItems[index].itemImage,
      itemDose: selectedMedicalItems[index].itemDose
    );
    selectedMedicalItems[index]=newMedicalItem;
    emit(MinusMedicalItemQuantitySuccessState());
  }


  removeMedicalItem(MedicalItem item)
  {
    selectedMedicalItems.remove(item);
    emit(RemoveMedicalItemQuantitySuccessState());
  }

  String? selectedFeedback;
  changeSelectedFeedback(String? value) {
    selectedFeedback = value;
    emit(ChangeSelectedFeedbackSuccessState());
  }

  List<File> doctorResponseImages = [];
  pickImage() async {
    final ImagePicker _picker = ImagePicker();
    List<XFile?> images = await _picker.pickMultiImage();
    if (images.isNotEmpty) {
      for (int i = 0; i < images.length; i++) {
        File imageFile = File(images[i]!.path);
        doctorResponseImages.add(imageFile);
      }
      emit(DoctorResponseImagesPickedSuccessState());
    }
  }

  TextEditingController  responseCommentController=TextEditingController();
  sendDoctorResponse(String medicalRequestId, String status) async {
    emit(SendDoctorResponseLoadingState());
    await getLanguageCode();
    final result = await sendDoctorResponseUseCase(
        doctorResponseModel: DoctorResponseModel(
          requestId: medicalRequestDetails?.medicalRequestId.toString() ?? "",
          createdBy: userNumber.toString(),
          status: status,
          responseDate: DateTime.now().toString(),
          medicalEntity:
              selectedMedicalEntity?.medicalEntityId.toString() ?? "",
          feedback:  "Any",
          responseComment: responseCommentController.text.toString()??"",
          LanguageId: languageId.toString(),
          attachment: doctorResponseImages,
           medicalItems: selectedMedicalItems,
        ),
        token: accessToken);
    result.fold((failure) {
      emit(SendDoctorResponseErrorState(failure.message));
    }, (doctorResponse) {
      emit(SendDoctorResponseSuccessState(doctorResponse));
    });
  }

  clearCurrentRequestData() {
    selectedMedicalEntity = null;
    selectedMedicalItems=[];
    doctorResponseImages = [];
  }


  searchInPendingRequests()
  {
    searchedResult.clear();
    emit(SearchInPendingRequestsLoadingState());
    if(requestTypeID=="1")
      {
        for(int i=0;i<medicationPendingRequests.length;i++)
          {
            if(medicationPendingRequests[i].employeeName.contains(searchInPendingRequestsController.text)  ||medicationPendingRequests[i].employeeNumber.contains(searchInPendingRequestsController.text)  ) {
              searchedResult.add(medicationPendingRequests[i]);
            }
          }
      }
    else if(requestTypeID=="2")
    {
      for(int i=0;i<checkUpsPendingRequests.length;i++)
      {
        if(checkUpsPendingRequests[i].employeeName.contains(searchInPendingRequestsController.text)  ||checkUpsPendingRequests[i].employeeNumber.contains(searchInPendingRequestsController.text)  ) {
          searchedResult.add(checkUpsPendingRequests[i]);
        }
      }
    }
    else
      {
        for(int i=0;i<sickLeavePendingRequests.length;i++)
        {
          if(sickLeavePendingRequests[i].employeeName.contains(searchInPendingRequestsController.text) ||sickLeavePendingRequests[i].employeeNumber.contains(searchInPendingRequestsController.text) ) {
            searchedResult.add(sickLeavePendingRequests[i]);
          }
        }
      }
    emit(SearchInPendingRequestsSuccessState());
  }


  bool validateOnChipsKeyMedicalEntity(int chipsKeyLength)
  {
    if(selectedMedicalEntity==null)
    {
      return false;
    }
    return true;
  }


  bool validateOnChipsKeyMedicalItems(int chipsKeyLength)
  {
    if(selectedMedicalItems.length<chipsKeyLength)
    {
      return false;
    }
    return true;
  }
}
