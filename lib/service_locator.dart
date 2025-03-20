import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopx/data/repositories/auth_repository_impl.dart';
import 'package:shopx/data/repositories/product_repository_impl.dart';
import 'package:shopx/data/src/auth_firebase_datasource.dart';
import 'package:shopx/data/src/product_datasource.dart';
import 'package:shopx/domain/repositories/auth_repo.dart';
import 'package:shopx/domain/repositories/product_repositories.dart';
import 'package:shopx/domain/usecases/checkloginstatus_usecase.dart';
import 'package:shopx/domain/usecases/get_category_usecase.dart';
import 'package:shopx/domain/usecases/get_products_usecase.dart';
import 'package:shopx/domain/usecases/login_usecase.dart';
import 'package:shopx/domain/usecases/logout_usecase.dart';
import 'package:shopx/domain/usecases/register_usecase.dart';
import 'package:shopx/presentation/bloc/Auth/auth_bloc.dart';
import 'package:shopx/presentation/bloc/Category/category_bloc.dart';
import 'package:shopx/presentation/bloc/product/product_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerSingleton<SharedPreferences>(sharedPreferences);
  sl.registerSingleton<FirebaseAuth>(FirebaseAuth.instance);
  sl.registerLazySingleton(() => http.Client());

  //! Data sources
  sl.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(sl()),
  );
  sl.registerLazySingleton<ProductRemoteDataSource>(
    () => ProductRemoteDataSourceImpl(sl()),
  );

  //! Repositories
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(sl(), sl()),
  );
  sl.registerLazySingleton<ProductRepository>(
    () => ProductRepositoryImpl(sl()),
  );

  //! usecases
  sl.registerLazySingleton(() => LoginUser(sl()));
  sl.registerLazySingleton(() => RegisterUser(sl()));
  sl.registerLazySingleton(() => CheckLoginstatus(sl()));
  sl.registerLazySingleton(() => Logout(sl()));

  //! products
  sl.registerLazySingleton(() => GetProducts(sl()));
  sl.registerLazySingleton(() => GetCategories(sl()));

  //! bloc
  sl.registerFactory(
    () => AuthBloc(
      loginUser: sl(),
      registerUser: sl(),
      checkLoginStatus: sl(),
      logout: sl(),
    ),
  );
  sl.registerFactory(() => ProductBloc(getProducts: sl()));
  sl.registerFactory(() => CategoryBloc(getCategories: sl()));
}
