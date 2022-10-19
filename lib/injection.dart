import 'package:chopper/chopper.dart';
import 'package:clean_architecture_flutter/core/network/network_info.dart';
import 'package:clean_architecture_flutter/core/network/rest_client_service.dart';
import 'package:clean_architecture_flutter/core/usecases/fetch_token.dart';
import 'package:clean_architecture_flutter/screens/change_password/data/datasources/change_password_local_datasource.dart';
import 'package:clean_architecture_flutter/screens/change_password/data/datasources/change_password_remote_datasource.dart';
import 'package:clean_architecture_flutter/screens/change_password/data/repositories/change_password_repository_impl.dart';
import 'package:clean_architecture_flutter/screens/change_password/domain/repositories/change_password_repository.dart';
import 'package:clean_architecture_flutter/screens/change_password/domain/usecases/change_password.dart';
import 'package:clean_architecture_flutter/screens/change_password/presentation/blocs/change_password/change_password_bloc.dart';
import 'package:clean_architecture_flutter/screens/home/data/datasources/home_local_datasource.dart';
import 'package:clean_architecture_flutter/screens/home/data/datasources/home_remote_datasource.dart';
import 'package:clean_architecture_flutter/screens/home/data/repositories/home_repository_impl.dart';
import 'package:clean_architecture_flutter/screens/home/domain/repositories/home_repository.dart';
import 'package:clean_architecture_flutter/screens/home/domain/usecases/logout_user.dart';
import 'package:clean_architecture_flutter/screens/home/presentation/blocs/logout/logout_bloc.dart';
import 'package:clean_architecture_flutter/screens/login/data/datasources/login_local_datasource.dart';
import 'package:clean_architecture_flutter/screens/login/data/datasources/login_remote_datasource.dart';
import 'package:clean_architecture_flutter/screens/login/data/repositories/login_repository_impl.dart';
import 'package:clean_architecture_flutter/screens/login/domain/repositories/login_repository.dart';
import 'package:clean_architecture_flutter/screens/login/domain/usecases/login_user.dart';
import 'package:clean_architecture_flutter/screens/login/presentation/blocs/user_login/user_login_bloc.dart';
import 'package:clean_architecture_flutter/screens/login/presentation/blocs/user_login/user_login_event.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // blocs
  sl.registerFactory(() => UserLoginBloc(
        loginUser: sl(),
        fetchToken: sl(),
      )..add(CheckLoginStatusEvent()));
  sl.registerFactory(() => LogoutBloc(fetchToken: sl(), logoutUser: sl()));
  sl.registerFactory(() => ChangePasswordBloc(changePassword: sl()));

  // use cases
  sl.registerLazySingleton(() => LoginUser(repository: sl()));
  sl.registerLazySingleton(() => FetchToken(repository: sl()));
  sl.registerLazySingleton(() => LogoutUser(repository: sl()));
  sl.registerLazySingleton(() => ChangePassword(repository: sl()));

  // repositories
  sl.registerLazySingleton<LoginRepository>(() => LoginRepositoryImpl(
      networkInfo: sl(), localDataSource: sl(), remoteDataSource: sl()));
  sl.registerLazySingleton<HomeRepository>(() => HomeRepositoryImpl(
      networkInfo: sl(), localDataSource: sl(), remoteDataSource: sl()));
  sl.registerLazySingleton<ChangePasswordRepository>(() =>
      ChangePasswordRepositoryImpl(
          networkInfo: sl(), localDataSource: sl(), remoteDataSource: sl()));

  // data sources
  sl.registerLazySingleton<LoginRemoteDataSource>(
    () => LoginRemoteDataSourceImpl(
      restClientService: sl(),
    ),
  );
  sl.registerLazySingleton<LoginLocalDataSource>(
    () => LoginLocalDataSourceImpl(
      sharedPreferences: sl(),
    ),
  );
  sl.registerLazySingleton<HomeRemoteDataSource>(
    () => HomeRemoteDataSourceImpl(
      restClientService: sl(),
    ),
  );
  sl.registerLazySingleton<HomeLocalDataSource>(
    () => HomeLocalDataSourceImpl(
      sharedPreferences: sl(),
    ),
  );
  sl.registerLazySingleton<ChangePasswordRemoteDataSource>(
    () => ChangePasswordRemoteDataSourceImpl(
      restClientService: sl(),
    ),
  );
  sl.registerLazySingleton<ChangePasswordLocalDataSource>(
    () => ChangePasswordLocalDataSourceImpl(
      sharedPreferences: sl(),
    ),
  );

  // core
  sl.registerLazySingleton<NetworkInfo>(
    () => NetworkInfoImpl(
      internetConnectionChecker: sl(),
    ),
  );

  // external
  final SharedPreferences sharedPreferences =
      await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => InternetConnectionChecker());
  final client = ChopperClient(interceptors: [
    CurlInterceptor(),
    HttpLoggingInterceptor(),
  ]);
  sl.registerLazySingleton(() => RestClientService.create(client));
}
