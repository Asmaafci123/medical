import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:more4u/core/constants/app_strings.dart';
import 'package:more4u/core/constants/constants.dart';
import 'package:more4u/data/models/medication_request_model.dart';
import 'package:more4u/domain/usecases/get_employee_relatives.dart';
import 'package:more4u/domain/usecases/send_medication_request.dart';
import 'package:more4u/presentation/medication/cubits/request_medication_states.dart';
import '../../../core/utils/function/get_language.dart';
import '../../../domain/entities/category.dart';
import '../../../domain/entities/details-of-medical.dart';
import '../../../domain/entities/employee_relatives_api.dart';
import '../../../domain/entities/relative.dart';
import '../models/employee_info.dart';

class RequestMedicationCubit extends Cubit<RequestMedicationState> {
  final GetEmployeeRelativesUseCase getEmployeeRelativesUseCase;
  final SendMedicationRequestUseCase sendMedicationRequestUseCase ;
  static  RequestMedicationCubit get(context) => BlocProvider.of(context);

  RequestMedicationCubit ({required this.getEmployeeRelativesUseCase,required this.sendMedicationRequestUseCase})
      : super( RequestMedicationInitial());


  List<DetailsOfMedical> pharmacies=[];
  List<Category>? categories=[];
  List<Category>? subCategories=[];
  List<DetailsOfMedical>? medicalDetails=[];
  EmployeeRelativeApi? currentEmployee;
  TextEditingController searchController=TextEditingController();
  TextEditingController commentController=TextEditingController();
 //  EmployeeInf? currentEmployee1=EmployeeInf(
 //      employeeName:userData?.userName??"",
 //      employeeDepartment:userData?.departmentName??"",
 //      relatives: userData?.relatives??[],
 //      medicalCoverage: medicalCoverage??"",
 //      profilePicture:userData?.profilePictureAPI??"",
 //    cemexId: userData?.sapNumber.toString()??""
 //  );
  getEmployeeRelatives(String userId,String medicalType) async {
    pharmacies.clear();
    //currentEmployee1=null;
    selectedRelative=null;
    familyInsurance=false;
    monthlyInsurance=false;
    emit(GetEmployeeRelativesLoadingState());
    await getLanguageCode();
    final result = await getEmployeeRelativesUseCase(
        userNumber:userId, token: accessToken,languageCode:languageId!,requestType: medicalType=="medication"?1:2);
    result.fold((failure) {
      emit(GetEmployeeRelativesErrorState(failure.message));
    }, (employeeRelativesResponse) {
      currentEmployee=employeeRelativesResponse.employeeRelativesApiModel;
      currentEmployeeConstants= currentEmployee;
      //await fillEmployeeInfo(employeeRelativesResponse.employeeRelativesApiModel);
      categories=employeeRelativesResponse.category;
      subCategories=employeeRelativesResponse.subCategory;
      medicalDetails=employeeRelativesResponse.medicalDetails;
     if(employeeRelativesResponse.medicalDetails!.isNotEmpty)
       {
         for(int i=0;i<employeeRelativesResponse.medicalDetails!.length;i++)
         {
           String categoryName="Pharmacies".tr();
           if(employeeRelativesResponse.medicalDetails?[i].categoryName==categoryName &&employeeRelativesResponse.medicalDetails?[i].subCategoryName==categoryName )
             {
               pharmacies.add(employeeRelativesResponse.medicalDetails![i]);
             }
         }
       }
      emit(GetEmployeeRelativesSuccessState(medicalType));
    });
  }

  // clearCurrentEmployee()
  // {
  //   currentEmployee=null;
  //   searchController.clear();
  //   emit(ClearCurrentEmployeeSuccessState());
  //
  // }

  //
  // fillEmployeeInfo(EmployeeRelativeApi? medicalEmployeeInfo)
  // {
  //   currentEmployee1=
  //       EmployeeInf(
  //           employeeName: medicalEmployeeInfo?.employeeName??"",
  //           employeeDepartment:medicalEmployeeInfo?.employeeDepartment??"",
  //           relatives: medicalEmployeeInfo?.relatives??[],
  //           medicalCoverage: medicalEmployeeInfo?.medicalCoverage??"",
  //           profilePicture: medicalEmployeeInfo?.profilePicture??"",
  //       cemexId: medicalEmployeeInfo?.cemexId.toString()??"" );
  // }

  bool familyInsurance=false;
  changeFamilyInsuranceFlag()
  {
    if(familyInsurance==false)
      {
        familyInsurance=true;
      }
    else
      {
        familyInsurance=false;
        selectedRelative=null;
      }
    emit(ChangeFamilyInsuranceFlagSuccessState());
  }

  bool monthlyInsurance=false;
  changeMonthlyInsuranceFlag()
  {
    if(monthlyInsurance==false)
    {
      monthlyInsurance=true;
    }
    else
    {
      monthlyInsurance=false;
    }
    emit(ChangeMonthlyInsuranceFlagSuccessState());
  }

  Category? selectedCategory;
  List<Category> resultOfSelectCategory=[];

  Category? selectedSubCategory;
  List<DetailsOfMedical> resultOfSelectSubCategory=[];
  selectCategory(Category category)
  {
    selectedCategory=category;
    resultOfSelectCategory.clear();
    resultOfSelectSubCategory.clear();
    selectedSubCategory=null;
    selectedDetailsOfMedical=null;
    for(int i=0;i<subCategories!.length;i++)
    {
      if(subCategories?[i].categoryName==category.categoryName )
      {
        resultOfSelectCategory.add(subCategories![i]);
      }
    }
    if(resultOfSelectCategory.length==1)
    {
      resultOfSelectSubCategory=[];
      for(int i=0;i<medicalDetails!.length;i++)
      {
        if(medicalDetails?[i].categoryName==selectedCategory?.categoryName)
        {
          resultOfSelectSubCategory.add(medicalDetails![i]);
        }
      }
    }
    emit(SelectCategorySuccessState());
  }

  selectSubCategory(Category subCategory)
  {
    selectedSubCategory=subCategory;
    resultOfSelectSubCategory.clear();
    selectedDetailsOfMedical=null;
    for(int i=0;i<medicalDetails!.length;i++)
    {
      if(medicalDetails?[i].subCategoryName==subCategory.subCategoryName)
      {
        resultOfSelectSubCategory.add(medicalDetails![i]);
      }
    }
    emit(SelectSubCategorySuccessState());
  }



  DetailsOfMedical? selectedDetailsOfMedical;
  selectDetailsOfMedical(DetailsOfMedical detailsOfMedical)
  {
    selectedDetailsOfMedical=detailsOfMedical;
    emit(SelectDetailsOfMedicalSuccessState());
  }

  DetailsOfMedical? selectedPharmacy;
  selectPharmacy(DetailsOfMedical pharmacy)
  {
    selectedPharmacy=pharmacy;
    emit(SelectPharmacySuccessState());
  }



  List<File>imagesFiles=[];
  pickImage() async {
    final ImagePicker _picker = ImagePicker();
    List<XFile?> images =
    await _picker.pickMultiImage();
    if (images.isNotEmpty) {
      for(int i=0;i<images.length;i++)
        {
          File imageFile = File(images[i]!.path);
          imagesFiles.add(imageFile);
        }
      emit(ImagesPickedSuccessState());
    }
  }

  deleteImage(int index)
  {
    imagesFiles.removeAt(index);
    emit(DeleteImageSuccessState());
  }

 Relative? selectedRelative;
  selectRelative(Relative  relative)
  {
    selectedRelative=relative;
    emit(SelectRelativeSuccessState());
  }


  int activeStep=0;
  changeActiveStep(int active)
  {
    activeStep=active;
    emit(ChangeActiveStepSuccessState());
  }
  sendMedicationRequest(int requestId) async {
    emit(SendMedicationRequestLoadingState());
    await getLanguageCode();
    final result = await sendMedicationRequestUseCase(
      medicationRequestModel:
          MedicationRequestModel(
            createdBy: userNumber.toString(),
            requestBy:currentEmployee?.cemexId.toString() ,
            requestedFor: selectedRelative?.relativeId??0,
            requestType:requestId,
            requestDate: DateTime.now().toString(),
            monthlyMedication: monthlyInsurance,
            selfRequest:familyInsurance==true?false:true,
              medicalEntityId: requestId==1?selectedPharmacy?.medicalEntityId:selectedDetailsOfMedical!.medicalEntityId,
              medicalPurpose: "test",
            comment:  commentController.text,
            attachment: imagesFiles
          ),
      token: accessToken,
      languageCode:languageId!
    );
    result.fold((failure) {
      emit(SendMedicationRequestErrorState(failure.message));
    }, (sendMedicationRequestResponse) {
      medicationRequestId=sendMedicationRequestResponse;
      emit(SendMedicationRequestSuccessState());
    });
  }
  clearCurrentEmployee()
  {
    currentEmployee=null;
    searchController.clear();
    imagesFiles.clear();
    commentController.clear();
    selectedCategory=null;
    selectedSubCategory=null;
    resultOfSelectCategory=[];
    resultOfSelectSubCategory=[];
    familyInsurance=false;
    monthlyInsurance=false;
    activeStep=0;
    selectedRelative=null;
    selectedDetailsOfMedical=null;
    selectedPharmacy=null;
    emit(ClearCurrentEmployeeSuccessState());
  }
}
