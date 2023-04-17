import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:pharmacy_arrival/app/bloc/counteragent_cubit.dart';
import 'package:pharmacy_arrival/app/bloc/organization_cubit.dart';
import 'package:pharmacy_arrival/app/bloc/profile_cubit.dart';
import 'package:pharmacy_arrival/core/platform/network_info.dart';
import 'package:pharmacy_arrival/data/datasource/local/accept_containers_local_ds.dart';
import 'package:pharmacy_arrival/data/datasource/local/auth_local_ds.dart';
import 'package:pharmacy_arrival/data/datasource/local/move_data_local_ds.dart';
import 'package:pharmacy_arrival/data/datasource/local/products_local_ds.dart';
import 'package:pharmacy_arrival/data/datasource/local/refund_local_ds.dart';
import 'package:pharmacy_arrival/data/datasource/remote/accept_containers_remote_ds.dart';
import 'package:pharmacy_arrival/data/datasource/remote/auth_remote_ds.dart';
import 'package:pharmacy_arrival/data/datasource/remote/move_data_remote_ds.dart';
import 'package:pharmacy_arrival/data/datasource/remote/pharmacy_arrival_remote_ds.dart';
import 'package:pharmacy_arrival/data/datasource/remote/products_remote_ds.dart';
import 'package:pharmacy_arrival/data/datasource/remote/refund_remote_ds.dart';
import 'package:pharmacy_arrival/data/datasource/remote/warehouse_arrival_remote_ds.dart';
import 'package:pharmacy_arrival/data/repositories/accept_containers_repository.dart';
import 'package:pharmacy_arrival/data/repositories/auth_repository_impl.dart';
import 'package:pharmacy_arrival/data/repositories/move_data_repository_impl.dart';
import 'package:pharmacy_arrival/data/repositories/pharmacy_repository_impl.dart';
import 'package:pharmacy_arrival/data/repositories/refund_repository_impl.dart';
import 'package:pharmacy_arrival/data/repositories/warehouse_repository_impl.dart';
import 'package:pharmacy_arrival/domain/repositories/auth_repository.dart';
import 'package:pharmacy_arrival/domain/repositories/move_data_repository.dart';
import 'package:pharmacy_arrival/domain/repositories/pharmacy_repository.dart';
import 'package:pharmacy_arrival/domain/repositories/refund_repository.dart';
import 'package:pharmacy_arrival/domain/repositories/warehouse_repository.dart';
import 'package:pharmacy_arrival/domain/usecases/auth_check.dart';
import 'package:pharmacy_arrival/domain/usecases/get_countragents.dart';
import 'package:pharmacy_arrival/domain/usecases/get_organizations.dart';
import 'package:pharmacy_arrival/domain/usecases/move_data_usecases/add_move_data_product.dart';
import 'package:pharmacy_arrival/domain/usecases/move_data_usecases/create_moving_order.dart';
import 'package:pharmacy_arrival/domain/usecases/move_data_usecases/delete_move_data_from_cache.dart';
import 'package:pharmacy_arrival/domain/usecases/move_data_usecases/delete_move_products_from_cahce.dart';
import 'package:pharmacy_arrival/domain/usecases/move_data_usecases/get_move_data_from_cache.dart';
import 'package:pharmacy_arrival/domain/usecases/move_data_usecases/get_move_data_products.dart';
import 'package:pharmacy_arrival/domain/usecases/move_data_usecases/get_move_products_from_cache.dart';
import 'package:pharmacy_arrival/domain/usecases/move_data_usecases/get_moving_history.dart';
import 'package:pharmacy_arrival/domain/usecases/move_data_usecases/get_product_by_barcode.dart';
import 'package:pharmacy_arrival/domain/usecases/move_data_usecases/save_move_data_to_cache.dart';
import 'package:pharmacy_arrival/domain/usecases/move_data_usecases/save_move_products_to_cahce.dart';
import 'package:pharmacy_arrival/domain/usecases/move_data_usecases/update_moving_order_status.dart';
import 'package:pharmacy_arrival/domain/usecases/pharmacy_usecases/get_order_by_number.dart';
import 'package:pharmacy_arrival/domain/usecases/pharmacy_usecases/get_orders_by_search.dart';
import 'package:pharmacy_arrival/domain/usecases/pharmacy_usecases/get_pharmacy_arrival_history.dart';
import 'package:pharmacy_arrival/domain/usecases/pharmacy_usecases/get_pharmacy_arrival_orders.dart';
import 'package:pharmacy_arrival/domain/usecases/pharmacy_usecases/get_pharmacy_selected_product.dart';
import 'package:pharmacy_arrival/domain/usecases/pharmacy_usecases/get_products_pharmacy_arrival.dart';
import 'package:pharmacy_arrival/domain/usecases/pharmacy_usecases/get_refund_order_by_incoming.dart';
import 'package:pharmacy_arrival/domain/usecases/pharmacy_usecases/save_pharmacy_selected_product.dart';
import 'package:pharmacy_arrival/domain/usecases/pharmacy_usecases/send_signature.dart';
import 'package:pharmacy_arrival/domain/usecases/pharmacy_usecases/update_pharmacy_order_status.dart';
import 'package:pharmacy_arrival/domain/usecases/pharmacy_usecases/update_pharmacy_product_by_id.dart';
import 'package:pharmacy_arrival/domain/usecases/refund_usecases/delete_refund_order_from_cache.dart';
import 'package:pharmacy_arrival/domain/usecases/refund_usecases/delete_refund_products_from_cahce.dart';
import 'package:pharmacy_arrival/domain/usecases/refund_usecases/get_refund_order_from_cache.dart';
import 'package:pharmacy_arrival/domain/usecases/refund_usecases/get_refund_products_from_cache.dart';
import 'package:pharmacy_arrival/domain/usecases/refund_usecases/remote_usecases/add_refund_data_product.dart';
import 'package:pharmacy_arrival/domain/usecases/refund_usecases/remote_usecases/create_refund_order.dart';
import 'package:pharmacy_arrival/domain/usecases/refund_usecases/remote_usecases/get_products_refund.dart';
import 'package:pharmacy_arrival/domain/usecases/refund_usecases/remote_usecases/get_refund_history.dart';
import 'package:pharmacy_arrival/domain/usecases/refund_usecases/remote_usecases/update_moving_order_status.dart';
import 'package:pharmacy_arrival/domain/usecases/refund_usecases/save_redund_products_to_cahce.dart';
import 'package:pharmacy_arrival/domain/usecases/refund_usecases/save_refund_order_to_cache.dart';
import 'package:pharmacy_arrival/domain/usecases/sign_in_user.dart';
import 'package:pharmacy_arrival/domain/usecases/warehouse_usecases/get_warehouse_arrival_history.dart';
import 'package:pharmacy_arrival/domain/usecases/warehouse_usecases/get_warehouse_arrival_orders.dart';
import 'package:pharmacy_arrival/domain/usecases/warehouse_usecases/update_warehouse_order_status.dart';
import 'package:pharmacy_arrival/screens/accept_containers/bloc/accept_cont_launch_cubit/accept_cont_launch_cubit.dart';
import 'package:pharmacy_arrival/screens/accept_containers/bloc/accept_cont_list_cubit/accept_cont_list_cubit.dart';
import 'package:pharmacy_arrival/screens/accept_containers/bloc/accept_cont_qr_cubit/accept_cont_qr_cubit.dart';
import 'package:pharmacy_arrival/screens/auth/bloc/sign_in_cubit.dart';
import 'package:pharmacy_arrival/screens/common/signature/cubit/signature_screen_cubit.dart';
import 'package:pharmacy_arrival/screens/goods_list/cubit/goods_list_screen_cubit.dart';
import 'package:pharmacy_arrival/screens/goods_list/cubit/move_goods_screen_cubit.dart';
import 'package:pharmacy_arrival/screens/history/history_cubit.dart/history_cat_cubit.dart';
import 'package:pharmacy_arrival/screens/history/history_cubit.dart/history_cubit.dart';
import 'package:pharmacy_arrival/screens/move_data/move_data_cubit/move_barcode_screen_cubit.dart';
import 'package:pharmacy_arrival/screens/move_data/move_data_cubit/move_data_screen_cubit.dart';
import 'package:pharmacy_arrival/screens/move_data/move_orders_cubit/move_order_cat_cubit.dart';
import 'package:pharmacy_arrival/screens/move_data/move_orders_cubit/move_order_page_cubit.dart';
import 'package:pharmacy_arrival/screens/move_data/move_products_cubit/move_products_screen_cubit.dart';
import 'package:pharmacy_arrival/screens/pharmacy_arrival/cubit/pharmacy_arrival_cat_cubit.dart';
import 'package:pharmacy_arrival/screens/pharmacy_arrival/cubit/pharmacy_arrival_screen_cubit.dart';
import 'package:pharmacy_arrival/screens/pharmacy_arrival/cubit/pharmacy_qr_screen_cubit.dart';
import 'package:pharmacy_arrival/screens/refund_containers/bloc/refund_container_cubit.dart';
import 'package:pharmacy_arrival/screens/return_data/return_cubit/return_cubit.dart';
import 'package:pharmacy_arrival/screens/return_data/return_cubit/return_order_cat_cubit.dart';
import 'package:pharmacy_arrival/screens/return_data/return_cubit/return_order_page_cubit.dart';
import 'package:pharmacy_arrival/screens/return_data/return_data_cubit/return_data_screen_cubit.dart';
import 'package:pharmacy_arrival/screens/return_data/return_products_cubit/return_products_screen_cubit.dart';
import 'package:pharmacy_arrival/screens/warehouse_arrival/cubit/warehouse_arrival_cat_cubit.dart';
import 'package:pharmacy_arrival/screens/warehouse_arrival/cubit/warehouse_arrival_screen_cubit.dart';
import 'package:shared_preferences/shared_preferences.dart';


final sl = GetIt.instance;

Future<void> initLocator() async {
  // BLoC / Cubit
  sl.registerFactory(() => SignInCubit(sl(), sl()));
  sl.registerFactory(() => ProfileCubit(sl(),));
  sl.registerFactory(() => WarehouseArrivalScreenCubit(sl(), sl()));
  sl.registerFactory(() => PharmacyArrivalScreenCubit(sl(), sl(), sl()));
  sl.registerFactory(() => GoodsListScreenCubit(sl(), sl(), sl(), sl()));
  sl.registerFactory(() => MoveGoodsScreenCubit(
        sl(),
      ),);
  sl.registerFactory(() => SignatureScreenCubit(sl(), sl(), sl()));
  sl.registerFactory(() => OrganizationCubit(sl()));
  sl.registerFactory(() => CounteragentsCubit(sl()));
  sl.registerFactory(() => MoveDataScreenCubit(sl(), sl()));
  sl.registerFactory(
    () => MoveBarcodeScreenCubit(sl(), sl(), sl(), sl(), sl()),
  );
  sl.registerFactory(
    () =>
        MoveProductsScreenCubit(sl(), sl(), sl(), sl(), sl(), sl(), sl(), sl()),
  );
  sl.registerFactory(
    () => ReturnDataScreenCubit(sl(),),
  );
  sl.registerFactory(
    () => ReturnCubit(sl()),
  );
  sl.registerFactory(
    () => ReturnProductsScreenCubit(
      sl(),
      sl(),
      sl(),
      sl(),
      sl(),
      sl(),
      sl(),
      sl(),
    ),
  );
  sl.registerFactory(() => HistoryCatCubit());
  sl.registerFactory(
    () => HistoryCubit(
      sl(),
      sl(),
      sl(),
      sl(),
    ),
  );
  sl.registerFactory(() => PharmacyQrScreenCubit(sl()));
  sl.registerFactory(() => PharmacyArrivalCatCubit());
  sl.registerFactory(() => WarehouseArrivalCatCubit());

  sl.registerFactory(
    () => ReturnOrderPageCubit(
      sl(),
      sl(),
    ),
  );
  sl.registerFactory(() => ReturnOrderCatCubit());

  sl.registerFactory(
    () => MoveOrderPageCubit(
      sl(),
    ),
  );
  sl.registerFactory(() => MoveOrderCatCubit());
  sl.registerFactory(() => AcceptContLaunchCubit(sl()));
  sl.registerFactory(() => AcceptContQrCubit(sl()));
  sl.registerFactory(() => AcceptContListCubit(sl()));
  sl.registerFactory(() => RefundContainerCubit(sl()));
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
  sl.registerLazySingleton(() => GetOrganizations(sl()));
  sl.registerLazySingleton(() => GetCountragents(sl()));

  ///Warehouse usecases
  sl.registerLazySingleton(() => GetWarehouseArrivalOrders(sl()));
  sl.registerLazySingleton(() => GetWarehouseArrivalHistory(sl()));
  sl.registerLazySingleton(() => UpdateWarehouseOrderStatus(sl()));

  ///Pharmacy usecases

  sl.registerLazySingleton(() => GetPharmacyArrivalOrders(sl()));
  sl.registerLazySingleton(() => GetProductsPharmacyArrival(sl()));
  sl.registerLazySingleton(() => UpdatePharmacyProductById(sl()));
  sl.registerLazySingleton(() => SavePharmacySelectedProduct(sl()));
  sl.registerLazySingleton(() => GetPharmacySelectedProduct(sl()));
  sl.registerLazySingleton(() => UpdatePharmacyOrderStatus(sl()));
  sl.registerLazySingleton(() => GetPharmacyArrivalHistory(sl()));
  sl.registerLazySingleton(() => GetOrderByNumber(sl()));
  sl.registerLazySingleton(() => GetOrdersBySearch(sl()));
  sl.registerLazySingleton(() => SendSignature(sl()));

  ///Move Data usecases
  sl.registerLazySingleton(() => GetMoveDataFromCache(sl()));
  sl.registerLazySingleton(() => GetMoveProductsFromCache(sl()));
  sl.registerLazySingleton(() => GetMoveDataProducts(sl()));
  sl.registerLazySingleton(() => GetProductByBarcode(sl()));
  sl.registerLazySingleton(() => SaveMoveDataToCache(sl()));
  sl.registerLazySingleton(() => SaveMoveProductsToCache(sl()));
  sl.registerLazySingleton(() => DeleteMoveDataFromCache(sl()));
  sl.registerLazySingleton(() => DeleteMoveProductsFromCache(sl()));
  sl.registerLazySingleton(() => CreateMovingOrder(sl()));
  sl.registerLazySingleton(() => AddMoveDataProduct(sl()));
  sl.registerLazySingleton(() => UpdateMovingOrderStatus(sl()));
  sl.registerLazySingleton(() => GetMovingHistory(sl()));

  ///Refund usecases
  sl.registerLazySingleton(() => CreateRefundOrder(sl()));
  sl.registerLazySingleton(() => DeleteRefundOrderFromCache(sl()));
  sl.registerLazySingleton(() => DeleteRefundProductsFromCache(sl()));
  sl.registerLazySingleton(() => GetRefundOrderFromCache(sl()));
  sl.registerLazySingleton(() => GetRefundProductsFromCache(sl()));
  sl.registerLazySingleton(() => SaveRefundOrderToCache(sl()));
  sl.registerLazySingleton(() => SaveRefundProductsToCache(sl()));
  sl.registerLazySingleton(() => GetProductsRefund(sl()));
  sl.registerLazySingleton(() => AddRefundDataProduct(sl()));
  sl.registerLazySingleton(() => UpdateRefundOrderStatus(sl()));
  sl.registerLazySingleton(() => GetRefundHistory(sl()));
  sl.registerLazySingleton(() => GetRefundOrderByIncoming(sl()));

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
  sl.registerLazySingleton<MoveDataRepository>(
    () => MoveDataRepositoryImpl(
      sl(),
      sl(),
      sl(),
      sl(),
      sl(),
      sl(),
    ),
  );
  sl.registerLazySingleton<RefundRepository>(
    () => RefundRepositoryImpl(
      sl(),
      sl(),
      sl(),
      sl(),
      sl(),
    ),
  );
  sl.registerLazySingleton<AcceptContainersRepository>(
    () => AcceptContainersRepositoryImpl(
      acceptContainersLocalDs: sl(),
      acceptContainersRemoteDs: sl(),
      authLocalDS: sl(),
      networkInfo: sl(),
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
  sl.registerLazySingleton<MoveDataRemoteDS>(
    () => MoveDataRemoteDSImpl(sl()),
  );
  sl.registerLazySingleton<RefundRemoteDS>(
    () => RefundRemoteDSImpl(sl()),
  );
  sl.registerLazySingleton<AcceptContainersRemoteDs>(
    () => AcceptContainersRemoteDsImpl(sl()),
  );

  ///
  ///
  /// LS
  sl.registerLazySingleton<AuthLocalDS>(
    () => AuthLocalDSImpl(sharedPreferences: sl()),
  );
  sl.registerLazySingleton<ProductsLocalDS>(
    () => ProductsLocalDSImpl(sl()),
  );
  sl.registerLazySingleton<MoveDataLocalDS>(
    () => MoveDataLocalDSImpl(sl()),
  );
  sl.registerLazySingleton<RefundLocalDS>(
    () => RefundLocalDSImpl(sl()),
  );
  sl.registerLazySingleton<AcceptContainersLocalDs>(
    () => AcceptContainersLocalDsImpl(sl()),
  );

  ///
  ///
  /// External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => Dio());
  sl.registerLazySingleton(() => InternetConnectionChecker());
}
