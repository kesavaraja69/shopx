import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopx/data/repositories/auth_repository_impl.dart';
import 'package:shopx/data/src/auth_firebase_datasource.dart';
import 'package:shopx/domain/repositories/auth_repo.dart';
import 'package:shopx/domain/usecases/checkloginStatus_usecase.dart';
import 'package:shopx/domain/usecases/login_usecase.dart';
import 'package:shopx/domain/usecases/register_usecase.dart';
import 'package:shopx/presentation/bloc/Auth/auth_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerSingleton<SharedPreferences>(sharedPreferences);
  sl.registerSingleton<FirebaseAuth>(FirebaseAuth.instance);

  // Data sources
  sl.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(sl()),
  );

  // Repositories
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(sl(), sl()),
  );

  // usecases
  sl.registerLazySingleton(() => LoginUser(sl()));
  sl.registerLazySingleton(() => RegisterUser(sl()));
  sl.registerLazySingleton(() => CheckLoginStatus(sl()));

  // bloc
  sl.registerFactory(
    () => AuthBloc(loginUser: sl(), registerUser: sl(), checkLoginStatus: sl()),
  );
}
