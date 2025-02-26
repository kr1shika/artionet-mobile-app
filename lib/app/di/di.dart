import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:tryproject/core/network/api_service.dart';
import 'package:tryproject/core/network/hive_service.dart';
import 'package:tryproject/features/artwork/data/data_source/artwork_remote_datasource.dart';
import 'package:tryproject/features/artwork/data/repository/artwork_remote_repository.dart';
import 'package:tryproject/features/artwork/domain/use_case/create_artwork_usecase.dart';
import 'package:tryproject/features/artwork/domain/use_case/deleteArtworkByIdUsecase.dart';
import 'package:tryproject/features/artwork/domain/use_case/get_all_artwork_usecase.dart';
import 'package:tryproject/features/artwork/domain/use_case/get_artwork_usecase.dart';
import 'package:tryproject/features/artwork/domain/use_case/get_artworks_by_userId.dart';
import 'package:tryproject/features/artwork/domain/use_case/update_artwork_usecase.dart';
import 'package:tryproject/features/artwork/domain/use_case/upload_artwork_image_usecase.dart';
import 'package:tryproject/features/artwork/presentation/view_model/artwork_bloc.dart';
import 'package:tryproject/features/auth/data/data_source/local_data_source/auth_local_datasource.dart';
import 'package:tryproject/features/auth/data/data_source/remote_data_source/auth_remote_datasource.dart';
import 'package:tryproject/features/auth/data/repository/auth_local_repository/auth_local_repository.dart';
import 'package:tryproject/features/auth/data/repository/auth_remote_repository/auth_remote_repository.dart';
import 'package:tryproject/features/auth/domain/use_case/login_usecase.dart';
import 'package:tryproject/features/auth/domain/use_case/register_user_usecase.dart';
import 'package:tryproject/features/auth/domain/use_case/upload_image.dart';
import 'package:tryproject/features/auth/presentation/view_model/artist_signup/artist_register_bloc.dart';
import 'package:tryproject/features/auth/presentation/view_model/login/login_bloc.dart';
import 'package:tryproject/features/auth/presentation/view_model/signup/register_bloc.dart';
import 'package:tryproject/features/home/presentation/view_model/home_cubit.dart';
import 'package:tryproject/features/onboard/presentation/view_model/buyer_onboard/artist_onboard_cubit.dart';
import 'package:tryproject/features/onboard/presentation/view_model/buyer_onboard/onboard_cubit.dart';
import 'package:tryproject/features/profiles/presentation/view_model/profile_bloc.dart';
import 'package:tryproject/features/profiles/presentation/view_model/upload_edit/artwork_crud_bloc.dart';
import 'package:tryproject/features/purchases/data/data_source/purchase_remote_datasource.dart';
import 'package:tryproject/features/purchases/data/repository/purchase_remote_repository.dart';
import 'package:tryproject/features/purchases/domain/use_case/GetPurchasesByUserIdUsecase.dart';
import 'package:tryproject/features/purchases/domain/use_case/create_purchase_usecase.dart';
import 'package:tryproject/features/purchases/presentation/view_model/purchase_bloc.dart';
import 'package:tryproject/features/saved_artwork/data/data_source/save_artwork_remote_datasource.dart';
import 'package:tryproject/features/saved_artwork/data/repository/save_artwork_remote_repository.dart';
import 'package:tryproject/features/saved_artwork/domain/use_case/check_artwork_status_usecase.dart';
import 'package:tryproject/features/saved_artwork/domain/use_case/fetch_saved_artwork_by_userid.dart';
import 'package:tryproject/features/saved_artwork/domain/use_case/remove_saved_artwork_usecase.dart';
import 'package:tryproject/features/saved_artwork/domain/use_case/save_artwork_usecase.dart';
import 'package:tryproject/features/splash/presentation/view_model/splash_cubit.dart';
import 'package:tryproject/features/user-notification/data/datasource/notification_remote_datasource.dart';
import 'package:tryproject/features/user-notification/data/repository/notification_remote_repository.dart';
import 'package:tryproject/features/user-notification/domain/usecase/get_notification_usecase.dart';

final getIt = GetIt.instance;

Future<void> initDependencies() async {
  // First initialize hive service
  await _initHiveService();
  await _initApiService();
  await _initHomeDependencies();
  await _initRegisterDependencies();
  await _initLoginDependencies();
  await _initSplashScreenDependencies();
  await _initOnboardDependencies();
  await _initArtistRegisterDependencies();
  await _initArtistOnboardDependencies();
  await _initArtworkDependencies();
  await _initPurchaseDependencies();
  await _initProfileDependencies();
  await _initArtworkCrudDependencies();
  await _initSaveArtsDependencies();
  await _initNotificationDependencies();
}

_initApiService() {
  getIt.registerLazySingleton<Dio>(
    () => ApiService(Dio()).dio,
  );
}

_initHiveService() {
  getIt.registerLazySingleton<HiveService>(() => HiveService());
}

_initArtworkCrudDependencies() async {
  getIt.registerFactory<ArtworkCrudBloc>(() => ArtworkCrudBloc(
        createArtworkUsecase: getIt<CreateArtworkUsecase>(),
        uploadArtworkimageusecase: getIt<UploadArtworkUsecase>(),
        updateArtworkUsecase: getIt<UpdateArtworkUsecase>(),
      ));
}

_initProfileDependencies() async {
  getIt.registerFactory<ProfileBloc>(() => ProfileBloc(
        getPurchasesByUserIdUsecase: getIt<GetPurchasesByUserIdUsecase>(),
        artworkCrudBloc: getIt<ArtworkCrudBloc>(),
        getArtworksByUseridUsecase: getIt<GetArtworksByUseridUsecase>(),
        getArtworkByIdUsecase: getIt<GetArtworkByIdUsecase>(),
        deleteArtworkByIdUseCase: getIt<DeleteArtworkByIdUseCase>(),
        getSavedCollectionUsecase: getIt<GetSavedCollectionUsecase>(),
        artwork_bloc: getIt<ArtworkBloc>(),
        updateArtworkUsecase: getIt<UpdateArtworkUsecase>(),
        getNotificationsByUserIdUsecase:
            getIt<GetNotificationsByUserIdUsecase>(),
      ));
}

_initNotificationDependencies() async {
  getIt.registerFactory<NotificationRemoteDatasource>(
      () => NotificationRemoteDatasource(dio: getIt<Dio>()));

  getIt.registerLazySingleton(() => NotificationRemoteRepository(
      remoteDatasource: getIt<NotificationRemoteDatasource>()));

  getIt.registerLazySingleton<GetNotificationsByUserIdUsecase>(
    () => GetNotificationsByUserIdUsecase(
      notificationRepository: getIt<NotificationRemoteRepository>(),
    ),
  );
}

_initSaveArtsDependencies() async {
  getIt.registerFactory<SaveArtworkRemoteDatasource>(
      () => SaveArtworkRemoteDatasource(dio: getIt<Dio>()));

  // repository
  getIt.registerLazySingleton(() => SaveArtworkRemoteRepository(
      remoteDatasource: getIt<SaveArtworkRemoteDatasource>()));

  // usecase
  getIt.registerLazySingleton<SaveArtworkUsecase>(
    () => SaveArtworkUsecase(getIt<SaveArtworkRemoteRepository>()),
  );

  getIt.registerLazySingleton<RemoveSavedArtworkUsecase>(
    () => RemoveSavedArtworkUsecase(
      getIt<SaveArtworkRemoteRepository>(),
    ),
  );
  getIt.registerLazySingleton<GetSavedCollectionUsecase>(
    () => GetSavedCollectionUsecase(
      getIt<SaveArtworkRemoteRepository>(),
    ),
  );

  getIt.registerLazySingleton<CheckArtworkStatusUsecase>(
    () => CheckArtworkStatusUsecase(
      getIt<SaveArtworkRemoteRepository>(),
    ),
  );
}

// purchase register
_initPurchaseDependencies() async {
  getIt.registerFactory<PurchaseRemoteDatasource>(
      () => PurchaseRemoteDatasource(dio: getIt<Dio>()));

  // repository
  getIt.registerLazySingleton(() => PurchaseRemoteRepository(
      remoteDatasource: getIt<PurchaseRemoteDatasource>()));

  // usecase
  getIt.registerLazySingleton<CreatePurchaseUsecase>(
    () => CreatePurchaseUsecase(getIt<PurchaseRemoteRepository>()),
  );

  getIt.registerLazySingleton<GetPurchasesByUserIdUsecase>(
    () => GetPurchasesByUserIdUsecase(
      purchaseRepository: getIt<PurchaseRemoteRepository>(),
    ),
  );

  // purchase bloc
  getIt.registerFactory<PurchaseBloc>(() => PurchaseBloc(
        createPurchaseUsecase: getIt<CreatePurchaseUsecase>(),
        getArtworkByIdUsecase: getIt(),
        getPurchasesByUserIdUsecase: getIt<GetPurchasesByUserIdUsecase>(),
      ));
}

_initArtworkDependencies() async {
  // remote data
  getIt.registerFactory<ArtworkRemoteDatasource>(
      () => ArtworkRemoteDatasource(dio: getIt<Dio>()));

  // repository
  getIt.registerLazySingleton(() => ArtworkRemoteRepository(
      remoteDataSource: getIt<ArtworkRemoteDatasource>()));

  // usecase
  getIt.registerLazySingleton<GetAllArtworkUsecase>(
    () => GetAllArtworkUsecase(
        artworkRepository: getIt<ArtworkRemoteRepository>()),
  );

  getIt.registerLazySingleton<GetArtworkByIdUsecase>(
    () => GetArtworkByIdUsecase(
        artworkRepository: getIt<ArtworkRemoteRepository>()),
  );

  getIt.registerLazySingleton<GetArtworksByUseridUsecase>(() =>
      GetArtworksByUseridUsecase(
          artworkRepository: getIt<ArtworkRemoteRepository>()));

  getIt.registerLazySingleton<UploadArtworkUsecase>(
    () => UploadArtworkUsecase(
      getIt<ArtworkRemoteRepository>(),
    ),
  );

  getIt.registerLazySingleton<UpdateArtworkUsecase>(
    () => UpdateArtworkUsecase(
      getIt<ArtworkRemoteRepository>(),
    ),
  );

  getIt.registerLazySingleton<DeleteArtworkByIdUseCase>(
      () => DeleteArtworkByIdUseCase(getIt<ArtworkRemoteRepository>()));

  // CreateArtworkUsecase
  getIt.registerLazySingleton<CreateArtworkUsecase>(
    () => CreateArtworkUsecase(getIt<ArtworkRemoteRepository>()),
  );

  getIt.registerFactory<ArtworkBloc>(() => ArtworkBloc(
        getAllArtworkUsecase: getIt<GetAllArtworkUsecase>(),
        getArtworkByIdUsecase: getIt<GetArtworkByIdUsecase>(),
        purchaseBloc: getIt<PurchaseBloc>(),
        saveArtworkUsecase: getIt<SaveArtworkUsecase>(),
        removeSavedArtworkUsecase: getIt<RemoveSavedArtworkUsecase>(),
        checkArtworkStatusUsecase: getIt<CheckArtworkStatusUsecase>(),
      ));
}

_initRegisterDependencies() {
  // init local data source
  getIt.registerLazySingleton(
    () => AuthLocalDatasource(getIt<HiveService>()),
  );

  getIt.registerLazySingleton<AuthRemoteDatasource>(
      () => AuthRemoteDatasource(getIt<Dio>()));

  // init local repository
  getIt.registerLazySingleton(
    () => AuthLocalRepository(getIt<AuthLocalDatasource>()),
  );
  getIt.registerLazySingleton(
    () => AuthRemoteRepository(getIt<AuthRemoteDatasource>()),
  );

  // register use usecase
  getIt.registerLazySingleton<RegisterUseCase>(
    () => RegisterUseCase(
      getIt<AuthRemoteRepository>(),
    ),
  );

  getIt.registerLazySingleton<UploadImageUsecase>(
    () => UploadImageUsecase(
      getIt<AuthRemoteRepository>(),
    ),
  );

  getIt.registerFactory<RegisterBloc>(
    () => RegisterBloc(
      registerUseCase: getIt(), loginBloc: getIt<LoginBloc>(),
      uploadImageUsecase: getIt(),

      // LoginBloc: getIt<LoginBloc>(),
    ),
  );
}

_initArtistRegisterDependencies() {
  getIt.registerFactory<ArtistRegisterBloc>(
    () => ArtistRegisterBloc(
      registerUseCase:
          getIt(), // Already registered in _initRegisterDependencies
      loginBloc: getIt<LoginBloc>(),
    ),
  );
}

_initHomeDependencies() async {
  getIt.registerFactory<HomeCubit>(
    () => HomeCubit(),
  );
}

_initLoginDependencies() async {
  getIt.registerLazySingleton<LoginUseCase>(
    () => LoginUseCase(
      getIt<AuthRemoteRepository>(),
    ),
  );

  getIt.registerFactory<LoginBloc>(
    () => LoginBloc(
      // registerBloc: getIt<RegisterBloc>(),
      homeCubit: getIt<HomeCubit>(),
      loginUseCase: getIt<LoginUseCase>(),
    ),
  );
}

_initSplashScreenDependencies() async {
  getIt.registerFactory<SplashCubit>(
    () => SplashCubit(getIt<OnboardCubit>()),
  );
}

_initOnboardDependencies() async {
  // Register PageController
  getIt.registerFactory<PageController>(() => PageController());

  // Register OnboardCubit
  getIt.registerFactory<OnboardCubit>(
    () => OnboardCubit(
      getIt<PageController>(), // Inject PageController
      getIt<RegisterBloc>(), // Inject LoginBloc
    ),
  );
}

_initArtistOnboardDependencies() async {
  getIt.registerFactory<OnboardingCubit>(
    () => OnboardingCubit(
      getIt<PageController>(),
    ),
  );
}
