import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:tryproject/core/network/api_service.dart';
import 'package:tryproject/core/network/hive_service.dart';
import 'package:tryproject/features/artwork/data/data_source/artwork_remote_datasource.dart';
import 'package:tryproject/features/artwork/data/repository/artwork_remote_repository.dart';
import 'package:tryproject/features/artwork/domain/use_case/get_all_artwork_usecase.dart';
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
import 'package:tryproject/features/splash/presentation/view_model/splash_cubit.dart';

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
}

_initApiService() {
  getIt.registerLazySingleton<Dio>(
    () => ApiService(Dio()).dio,
  );
}

_initHiveService() {
  getIt.registerLazySingleton<HiveService>(() => HiveService());
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
  getIt.registerFactory<ArtworkBloc>(
      () => ArtworkBloc(getAllArtworkUsecase: getIt<GetAllArtworkUsecase>()));
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
      loginBloc:
          getIt<LoginBloc>(), // Already registered in _initLoginDependencies
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
      getIt<PageController>(), // Reuse the existing PageController
    ),
  );
}
