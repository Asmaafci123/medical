import 'package:more4u/data/datasources/remote_data_source.dart';
import 'package:more4u/data/repositories/benefit_repository_impl.dart';
import 'package:more4u/data/repositories/user_repository_impl.dart';
import 'package:more4u/data/repositories/redeem_repository_impl.dart';
import 'package:more4u/domain/repositories/benefit_repository.dart';
import 'package:more4u/domain/usecases/get_current_user.dart';
import 'package:more4u/domain/usecases/get_medical_request_details.dart';
import 'package:more4u/domain/usecases/get_mobile_version.dart';
import 'package:more4u/domain/usecases/get_participants.dart';
import 'package:more4u/domain/usecases/get_pending_requests.dart';
import 'package:more4u/domain/usecases/get_privileges.dart';
import 'package:more4u/domain/usecases/search_medical_items.dart';
import 'package:more4u/domain/usecases/send_doctor_response.dart';
import 'package:more4u/domain/usecases/send_medication_request.dart';
import 'package:more4u/presentation/Login/cubits/login_cubit.dart';
import 'package:more4u/presentation/benefit_details/cubits/benefit_details_cubit.dart';
import 'package:more4u/presentation/home/cubits/home_cubit.dart';
import 'package:more4u/presentation/manage_requests/cubits/manage_requests_cubit.dart';
import 'package:more4u/presentation/medical_requests_history/cubits/my_medical_requests_cubit.dart';
import 'package:more4u/presentation/medication/cubits/request_medication_cubit.dart';
import 'package:more4u/presentation/more4u_home/cubits/more4u_home_cubit.dart';
import 'package:more4u/presentation/notification/cubits/notification_cubit.dart';
import 'package:more4u/presentation/pending_requests/cubits/pending_requests_cubit.dart';
import 'package:more4u/presentation/profile/cubits/profile_cubit.dart';
import 'package:more4u/presentation/terms_and_conditions/cubits/terms_and_conditions_cubit.dart';
import 'core/network/network_info.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'data/datasources/local_data_source/local_data_source.dart';
import 'data/datasources/local_data_source/secure_local_data_source.dart';
import 'data/repositories/medical_repository_impl.dart';
import 'domain/repositories/medical_repository.dart';
import 'domain/repositories/user_repository.dart';
import 'domain/repositories/redeem_repository.dart';
import 'domain/usecases/add_response.dart';
import 'domain/usecases/cancel_request.dart';
import 'domain/usecases/changePassword.dart';
import 'domain/usecases/get-medical.dart';
import 'domain/usecases/get_benefit_details.dart';
import 'domain/usecases/get_benefits_to_manage.dart';
import 'domain/usecases/get_employee_profile_picture.dart';
import 'domain/usecases/get_employee_relatives.dart';
import 'domain/usecases/get_filtered_medical_requests.dart';
import 'domain/usecases/get_home_data.dart';
import 'domain/usecases/get_my_benefit_requests.dart';
import 'domain/usecases/get_my_benefits.dart';
import 'domain/usecases/get_my_gifts.dart';
import 'domain/usecases/get_my_medical_reuests.dart';
import 'domain/usecases/get_notifications.dart';
import 'domain/usecases/get_request_Profile_and_documents.dart';
import 'domain/usecases/get_terms_and_conditions.dart';
import 'domain/usecases/login_user.dart';
import 'domain/usecases/redeem_card.dart';
import 'domain/usecases/updateProfilePicture.dart';
import 'presentation/benefit_redeem/cubits/redeem_cubit.dart';
import 'presentation/my_benefit_requests/cubits/my_benefit_requests_cubit.dart';
import 'presentation/my_benefits/cubits/my_benefits_cubit.dart';
import 'presentation/my_gifts/cubits/my_gifts_cubit.dart';

final sl = GetIt.instance;

Future<void> init() async {
  sl.registerFactory(() => LoginCubit(loginUser: sl()));
  sl.registerFactory(
          () => HomeCubit(currentUserUseCase: sl(),));
  sl.registerFactory(
      () => More4uHomeCubit(homeData: sl(), getPrivilegesUsecase: sl(),getMedicalUsecase: sl(),localDataSource: sl()));
  sl.registerFactory(() => ProfileCubit(
      updateProfilePictureUsecase: sl(),
      changePasswordUsecase: sl(),
      getUserProfilePictureUsecase: sl()));
  sl.registerFactory(() => BenefitDetailsCubit(getBenefitDetailsUsecase: sl()));
  sl.registerFactory(
      () => RedeemCubit(getParticipantsUsecase: sl(), redeemCardUsecase: sl()));
  sl.registerFactory(() => MyBenefitsCubit(getMyBenefitsUsecase: sl()));
  sl.registerFactory(() => MyGiftsCubit(getMyGiftsUsecase: sl()));
  sl.registerFactory(() => MyBenefitRequestsCubit(
      getMyBenefitRequestsUsecase: sl(), cancelRequestsUsecase: sl()));
  sl.registerFactory(() => ManageRequestsCubit(
      getBenefitsToManageUsecase: sl(),
      addRequestResponseUsecase: sl(),
      getRequestProfileAndDocumentsUsecase: sl()));
  sl.registerFactory(() => TermsAndConditionsCubit(getTermsAndConditionsUseCase: sl()));
  sl.registerFactory(() => NotificationCubit(getNotificationsUsecase: sl()));
  sl.registerFactory(() => RequestMedicationCubit( getEmployeeRelativesUseCase:  sl(),sendMedicationRequestUseCase:  sl(),));
  sl.registerFactory(() => PendingRequestsCubit(getPendingRequestsUseCase:  sl(),
      getMedicalRequestDetailsUseCas: sl(),
      sendDoctorResponseUseCase: sl(),
  searchInMedicalItemsUseCase: sl()));
  sl.registerFactory(() => MyMedicalRequestsCubit(getMyMedicalRequestsRequestsUseCase: sl(), getFilteredMedicalRequestsRequestsUseCase: sl()));
  sl.registerLazySingleton(() => GetTermsAndConditionsUseCase(sl()));
  sl.registerLazySingleton(() => LoginUserUsecase(sl()));
  sl.registerLazySingleton(() => CurrentUserUseCase(sl()));
  sl.registerLazySingleton(() => GetUserProfilePictureUsecase(sl()));
  sl.registerLazySingleton(() => UpdateProfilePictureUsecase(sl()));
  sl.registerLazySingleton(() => ChangePasswordUsecase(sl()));
  sl.registerLazySingleton(() => GetBenefitDetailsUsecase(sl()));
  sl.registerLazySingleton(() => GetParticipantsUsecase(sl()));
  sl.registerLazySingleton(() => GetMyBenefitsUsecase(sl()));
  sl.registerLazySingleton(() => GetMyGiftsUsecase(sl()));
  sl.registerLazySingleton(() => GetMyBenefitRequestsUsecase(sl()));
  sl.registerLazySingleton(() => GetPrivilegesUsecase(sl()));
  sl.registerLazySingleton(() => CancelRequestsUsecase(sl()));
  sl.registerLazySingleton(() => AddRequestResponseUsecase(sl()));
  sl.registerLazySingleton(() => GetBenefitsToManageUsecase(sl()));
  sl.registerLazySingleton(() => GetRequestProfileAndDocumentsUsecase(sl()));
  sl.registerLazySingleton(() => RedeemCardUsecase(sl()));
  sl.registerLazySingleton(() => GetNotificationsUsecase(sl()));
  sl.registerLazySingleton(() => GetMobileVersionUseCase(sl()));
  sl.registerLazySingleton(() => GetMedicalUsecase(sl()));
  sl.registerLazySingleton(() => HomeDataUseCase(sl()));
  sl.registerLazySingleton(() =>  GetEmployeeRelativesUseCase(sl()));
  sl.registerLazySingleton(() =>  GetPendingRequestsUseCase(sl()));
  sl.registerLazySingleton(() =>  SendMedicationRequestUseCase(sl()));
  sl.registerLazySingleton(() =>  GetMedicalRequestDetailsUseCase(sl()));
  sl.registerLazySingleton(() =>  SendDoctorResponseUseCase(sl()));
  sl.registerLazySingleton(() =>  GetMyMedicalRequestsRequestsUseCase(sl()));
  sl.registerLazySingleton(() =>  GetFilteredMedicalRequestsRequestsUseCase(sl()));
  sl.registerLazySingleton(() =>  SearchInMedicalItemsUseCase(sl()));
  sl.registerLazySingleton<UserRepository>(() => UserRepositoryImpl(
      localDataSource: sl(),secureStorage: sl(), remoteDataSource: sl(), networkInfo: sl()));
  sl.registerLazySingleton<BenefitRepository>(
      () => BenefitRepositoryImpl(remoteDataSource: sl(), networkInfo: sl()));
  sl.registerLazySingleton<MedicalRepository>(
          () => MedicalRepositoryImpl(remoteDataSource: sl(), networkInfo: sl()));
  sl.registerLazySingleton<RedeemRepository>(
      () => RedeemRepositoryImpl(remoteDataSource: sl(), networkInfo: sl()));
  sl.registerLazySingleton<RemoteDataSource>(
      () => RemoteDataSourceImpl(client: sl()));
  sl.registerLazySingleton<LocalDataSource>(
      () => LocalDataSourceImpl(sharedPreferences: sl()));

  sl.registerLazySingleton<SecureStorage>(
          () =>  SecureStorageImpl());
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => InternetConnectionChecker());
}
