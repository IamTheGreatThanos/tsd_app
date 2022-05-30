import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:pharmacy_arrival/core/platform/network_info.dart';
import 'package:pharmacy_arrival/data/datasource/local/products_local_ds.dart';
import 'package:pharmacy_arrival/data/datasource/remote/auth_remote_ds.dart';
import 'package:pharmacy_arrival/data/datasource/local/auth_local_ds.dart';
import 'package:pharmacy_arrival/data/datasource/remote/pharmacy_arrival_remote_ds.dart';
import 'package:pharmacy_arrival/data/datasource/remote/products_remote_ds.dart';
import 'package:pharmacy_arrival/data/datasource/remote/warehouse_arrival_remote_ds.dart';
import 'package:pharmacy_arrival/data/repositories/auth_repository_impl.dart';
import 'package:pharmacy_arrival/data/repositories/pharmacy_repository_impl.dart';
import 'package:pharmacy_arrival/data/repositories/warehouse_repository_impl.dart';
import 'package:pharmacy_arrival/domain/repositories/auth_repository.dart';
import 'package:pharmacy_arrival/domain/repositories/pharmacy_repository.dart';
import 'package:pharmacy_arrival/domain/repositories/warehouse_repository.dart';
import 'package:pharmacy_arrival/domain/usecases/auth_check.dart';
import 'package:pharmacy_arrival/domain/usecases/pharmacy_usecases/get_pharmacy_arrival_orders.dart';
import 'package:pharmacy_arrival/domain/usecases/pharmacy_usecases/get_pharmacy_selected_product.dart';
import 'package:pharmacy_arrival/domain/usecases/pharmacy_usecases/get_products_pharmacy_arrival.dart';
import 'package:pharmacy_arrival/domain/usecases/pharmacy_usecases/save_pharmacy_selected_product.dart';
import 'package:pharmacy_arrival/domain/usecases/pharmacy_usecases/update_pharmacy_product_by_id.dart';
import 'package:pharmacy_arrival/domain/usecases/sign_in_user.dart';
import 'package:pharmacy_arrival/domain/usecases/warehouse_usecases/get_warehouse_arrival_orders.dart';
import 'package:pharmacy_arrival/screens/auth/bloc/sign_in_cubit.dart';
import 'package:pharmacy_arrival/screens/goods_list/cubit/goods_list_screen_cubit.dart';
import 'package:pharmacy_arrival/screens/pharmacy_arrival/cubit/pharmacy_arrival_screen_cubit.dart';
import 'package:pharmacy_arrival/screens/warehouse_arrival/cubit/warehouse_arrival_screen_cubit.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sl = GetIt.instance;

Future<void> initLocator() async {
  // BLoC / Cubit
  sl.registerFactory(() => SignInCubit(sl()));
  sl.registerFactory(() => WarehouseArrivalScreenCubit(sl()));
  sl.registerFactory(() => PharmacyArrivalScreenCubit(sl()));
  sl.registerFactory(() => GoodsListScreenCubit(sl(), sl(), sl(), sl()));
  // sl.registerFactory(() => LoginBloc(sl()));

  ///
  ///
  /// Core
  sl.registerLazySingleton<NetworkInfo>(
    () => NetworkInfoImp(sl()),
  );

  ///
  ///
  /// UseCasesff
  //auth

  sl.registerLazySingleton(() => AuthCheck(sl()));
  sl.registerLazySingleton(() => SignInUser(sl()));

  ///Warehouse usecases
  sl.registerLazySingleton(() => GetWarehouseArrivalOrders(sl()));

  ///Pharmacy usecases

  sl.registerLazySingleton(() => GetPharmacyArrivalOrders(sl()));
  sl.registerLazySingleton(() => GetProductsPharmacyArrival(sl()));
  sl.registerLazySingleton(() => UpdatePharmacyProductById(sl()));
  sl.registerLazySingleton(() => SavePharmacySelectedProduct(sl()));
  sl.registerLazySingleton(() => GetPharmacySelectedProduct(sl()));

  ///
  ///
  /// Repository
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(
      localDS: sl(),
      remoteDS: sl(),
      networkInfo: sl(),
    ),
  );
  sl.registerLazySingleton<WarehouseRepository>(
    () => WarehouseRepositoryImpl(
      authLocalDS: sl(),
      warehouseArrivalRemoteDS: sl(),
      networkInfo: sl(),
    ),
  );
  sl.registerLazySingleton<PharmacyRepository>(
    () => PharmacyRepositoryImpl(
      authLocalDS: sl(),
      arrivalRemoteDS: sl(),
      networkInfo: sl(),
      productsRemoteDS: sl(),
      productsLoacalDS: sl(),
    ),
  );

  ///
  ///
  /// DS
  sl.registerLazySingleton<AuthRemoteDS>(
    () => AuthRemoteDSImpl(sl()),
  );
  sl.registerLazySingleton<WarehouseArrivalRemoteDS>(
    () => WarehouseArrivalRemoteDSImpl(sl()),
  );
  sl.registerLazySingleton<PharmacyArrivalRemoteDS>(
    () => PharmacyArrivalRemoteDSImpl(sl()),
  );
  sl.registerLazySingleton<ProductsRemoteDS>(
    () => ProductsRemoteDSImpl(sl()),
  );

  ///
  ///
  /// LS
  sl.registerLazySingleton<AuthLocalDS>(
    () => AuthLocalDSImpl(sharedPreferences: sl()),
  );
  sl.registerLazySingleton<ProductsLoacalDS>(
    () => ProductsLoacalDSImpl(sl()),
  );

  ///
  ///
  /// External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => Dio());
  sl.registerLazySingleton(() => InternetConnectionChecker());
}
