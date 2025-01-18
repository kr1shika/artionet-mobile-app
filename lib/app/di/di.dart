// import 'package:flutter/material.dart';
// import 'package:get_it/get_it.dart';
// import 'package:tryproject/core/network/hive_service.dart';
// import 'package:tryproject/features/auth/data/data_source/local_data_source/auth_local_datasource.dart';
// import 'package:tryproject/features/auth/data/repository/auth_local_repository/auth_local_repository.dart';
// import 'package:tryproject/features/auth/domain/use_case/login_usecase.dart';
// import 'package:tryproject/features/auth/domain/use_case/register_user_usecase.dart';
// import 'package:tryproject/features/auth/presentation/view_model/login/login_bloc.dart';
// import 'package:tryproject/features/auth/presentation/view_model/signup/register_bloc.dart';
// import 'package:tryproject/features/home/presentation/view_model/home_cubit.dart';
// import 'package:tryproject/features/onboard/presentation/view_model/onboard_cubit.dart';
// import 'package:tryproject/features/splash/presentation/view_model/splash_cubit.dart';

// final getIt = GetIt.instance;

// Future<void> initDependencies() async {
//   // First initialize hive service
//   await _initHiveService();

//   await _initHomeDependencies();
//   await _initRegisterDependencies();
//   await _initLoginDependencies();

//   await _initSplashScreenDependencies();
//   await _initOnboardDependencies();
// }

// _initOnboardDependencies() async {
//   // Register PageController
//   getIt.registerFactory<PageController>(() => PageController());

//   // Register OnboardCubit
//   getIt.registerFactory<OnboardCubit>(
//     () => OnboardCubit(
//       getIt<PageController>(), // Inject PageController
//       getIt<LoginBloc>(), // Inject LoginBloc
//     ),
//   );
// }

// _initHiveService() {
//   getIt.registerLazySingleton<HiveService>(() => HiveService());
// }

// _initRegisterDependencies() {
//   // init local data source
//   getIt.registerLazySingleton(
//     () => AuthLocalDatasource(getIt<HiveService>()),
//   );

//   // init local repository
//   getIt.registerLazySingleton(
//     () => AuthLocalRepository(getIt<AuthLocalDatasource>()),
//   );

//   // register use usecase
//   getIt.registerLazySingleton<RegisterUseCase>(
//     () => RegisterUseCase(
//       getIt<AuthLocalRepository>(),
//     ),
//   );

//   getIt.registerFactory<RegisterBloc>(
//     () => RegisterBloc(
//       registerUseCase: getIt(),
//       // LoginBloc: getIt<LoginBloc>(),
//     ),
//   );
// }

// _initHomeDependencies() async {
//   getIt.registerFactory<HomeCubit>(
//     () => HomeCubit(),
//   );
// }

// _initLoginDependencies() async {
//   getIt.registerLazySingleton<LoginUseCase>(
//     () => LoginUseCase(
//       getIt<AuthLocalRepository>(),
//     ),
//   );

//   getIt.registerFactory<LoginBloc>(
//     () => LoginBloc(
//       registerBloc: getIt<RegisterBloc>(),
//       homeCubit: getIt<HomeCubit>(),
//       loginUseCase: getIt<LoginUseCase>(),
//     ),
//   );
// }

// _initSplashScreenDependencies() async {
//   getIt.registerFactory<SplashCubit>(
//     () => SplashCubit(getIt<OnboardCubit>()),
//   );
// }

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:tryproject/core/network/hive_service.dart';
import 'package:tryproject/features/auth/data/data_source/local_data_source/auth_local_datasource.dart';
import 'package:tryproject/features/auth/data/repository/auth_local_repository/auth_local_repository.dart';
import 'package:tryproject/features/auth/domain/use_case/login_usecase.dart';
import 'package:tryproject/features/auth/domain/use_case/register_user_usecase.dart';
import 'package:tryproject/features/auth/presentation/view_model/login/login_bloc.dart';
import 'package:tryproject/features/auth/presentation/view_model/signup/register_bloc.dart';
import 'package:tryproject/features/home/presentation/view_model/home_cubit.dart';
import 'package:tryproject/features/onboard/presentation/view_model/buyer_onboard/onboard_cubit.dart';
import 'package:tryproject/features/splash/presentation/view_model/splash_cubit.dart';

final getIt = GetIt.instance;

Future<void> initDependencies() async {
  // First initialize hive service
  await _initHiveService();

  await _initHomeDependencies();
  await _initRegisterDependencies();
  await _initLoginDependencies();

  await _initSplashScreenDependencies();
  await _initOnboardDependencies();
}

_initHiveService() {
  getIt.registerLazySingleton<HiveService>(() => HiveService());
}

_initRegisterDependencies() {
  // init local data source
  getIt.registerLazySingleton(
    () => AuthLocalDatasource(getIt<HiveService>()),
  );

  // init local repository
  getIt.registerLazySingleton(
    () => AuthLocalRepository(getIt<AuthLocalDatasource>()),
  );

  // register use usecase
  getIt.registerLazySingleton<RegisterUseCase>(
    () => RegisterUseCase(
      getIt<AuthLocalRepository>(),
    ),
  );

  getIt.registerFactory<RegisterBloc>(
    () => RegisterBloc(
      registerUseCase: getIt(), loginBloc: getIt<LoginBloc>(),
      // LoginBloc: getIt<LoginBloc>(),
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
      getIt<AuthLocalRepository>(),
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
