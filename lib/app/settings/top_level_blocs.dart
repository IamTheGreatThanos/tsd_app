import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pharmacy_arrival/app/bloc/auth_bloc.dart';
import 'package:pharmacy_arrival/app/bloc/counteragent_cubit.dart';
import 'package:pharmacy_arrival/app/bloc/organization_cubit.dart';
import 'package:pharmacy_arrival/app/bloc/profile_cubit.dart';
import 'package:pharmacy_arrival/domain/repositories/auth_repository.dart';
import 'package:pharmacy_arrival/locator_serviece.dart';
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
import 'package:pharmacy_arrival/screens/move_data/vmodel/move_filter_vmodel.dart';
import 'package:pharmacy_arrival/screens/pharmacy_arrival/cubit/pharmacy_arrival_cat_cubit.dart';
import 'package:pharmacy_arrival/screens/pharmacy_arrival/cubit/pharmacy_arrival_screen_cubit.dart';
import 'package:pharmacy_arrival/screens/pharmacy_arrival/cubit/pharmacy_qr_screen_cubit.dart';
import 'package:pharmacy_arrival/screens/pharmacy_arrival/vmodel/pharmacy_filter_vmodel.dart';
import 'package:pharmacy_arrival/screens/refund_containers/bloc/refund_container_cubit.dart';
import 'package:pharmacy_arrival/screens/return_data/return_cubit/return_cubit.dart';
import 'package:pharmacy_arrival/screens/return_data/return_cubit/return_order_cat_cubit.dart';
import 'package:pharmacy_arrival/screens/return_data/return_cubit/return_order_page_cubit.dart';
import 'package:pharmacy_arrival/screens/return_data/return_data_cubit/return_data_screen_cubit.dart';
import 'package:pharmacy_arrival/screens/return_data/return_products_cubit/return_products_screen_cubit.dart';
import 'package:pharmacy_arrival/screens/warehouse_arrival/cubit/warehouse_arrival_cat_cubit.dart';
import 'package:pharmacy_arrival/screens/warehouse_arrival/cubit/warehouse_arrival_screen_cubit.dart';
import 'package:provider/provider.dart';

///Providers for global blocs
class TopLevelBlocs extends StatelessWidget {
  final Widget child;

  const TopLevelBlocs({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => PharmacyFilterVmodel(),
        ),
        ChangeNotifierProvider(
          create: (_) => MoveFilterVmodel(),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) =>
                AuthBloc(sl<AuthRepository>())..add(InitialLoginEvent()),
          ),
          BlocProvider<SignInCubit>(
            create: (context) => sl<SignInCubit>(),
          ),
          BlocProvider<ProfileCubit>(
            create: (context) => sl<ProfileCubit>(),
          ),
          BlocProvider<WarehouseArrivalScreenCubit>(
            create: (context) => sl<WarehouseArrivalScreenCubit>(),
          ),
          BlocProvider<PharmacyArrivalScreenCubit>(
            create: (context) => sl<PharmacyArrivalScreenCubit>(),
          ),
          BlocProvider<GoodsListScreenCubit>(
            create: (context) => sl<GoodsListScreenCubit>(),
          ),
          BlocProvider<SignatureScreenCubit>(
            create: (context) => sl<SignatureScreenCubit>(),
          ),
          BlocProvider<OrganizationCubit>(
            create: (context) => sl<OrganizationCubit>(),
          ),
          BlocProvider<CounteragentsCubit>(
            create: (context) => sl<CounteragentsCubit>(),
          ),
          BlocProvider<MoveDataScreenCubit>(
            create: (context) => sl<MoveDataScreenCubit>(),
          ),
          BlocProvider<MoveBarcodeScreenCubit>(
            create: (context) => sl<MoveBarcodeScreenCubit>(),
          ),
          BlocProvider<MoveProductsScreenCubit>(
            create: (context) => sl<MoveProductsScreenCubit>(),
          ),
          BlocProvider<ReturnCubit>(
            create: (context) => sl<ReturnCubit>(),
          ),
          BlocProvider<ReturnDataScreenCubit>(
            create: (context) => sl<ReturnDataScreenCubit>(),
          ),
          BlocProvider<ReturnProductsScreenCubit>(
            create: (context) => sl<ReturnProductsScreenCubit>(),
          ),
          BlocProvider<HistoryCatCubit>(
            create: (context) => sl<HistoryCatCubit>(),
          ),
          BlocProvider<HistoryCubit>(
            create: (context) => sl<HistoryCubit>(),
          ),
          BlocProvider<PharmacyQrScreenCubit>(
            create: (context) => sl<PharmacyQrScreenCubit>(),
          ),
          BlocProvider<PharmacyArrivalCatCubit>(
            create: (context) => sl<PharmacyArrivalCatCubit>(),
          ),
          BlocProvider<WarehouseArrivalCatCubit>(
            create: (context) => sl<WarehouseArrivalCatCubit>(),
          ),
          BlocProvider<ReturnOrderPageCubit>(
            create: (context) => sl<ReturnOrderPageCubit>(),
          ),
          BlocProvider<ReturnOrderCatCubit>(
            create: (context) => sl<ReturnOrderCatCubit>(),
          ),
          BlocProvider<MoveOrderPageCubit>(
            create: (context) => sl<MoveOrderPageCubit>(),
          ),
          BlocProvider<MoveOrderCatCubit>(
            create: (context) => sl<MoveOrderCatCubit>(),
          ),
          BlocProvider<MoveGoodsScreenCubit>(
            create: (context) => sl<MoveGoodsScreenCubit>(),
          ),
          BlocProvider<AcceptContLaunchCubit>(
            create: (context) => sl<AcceptContLaunchCubit>(),
          ),
          BlocProvider<AcceptContQrCubit>(
            create: (context) => sl<AcceptContQrCubit>(),
          ),
          BlocProvider<AcceptContListCubit>(
            create: (context) => sl<AcceptContListCubit>(),
          ),
          BlocProvider<RefundContainerCubit>(
            create: (context) => sl<RefundContainerCubit>(),
          ),
        ],
        child: child,
      ),
    );
  }
}
