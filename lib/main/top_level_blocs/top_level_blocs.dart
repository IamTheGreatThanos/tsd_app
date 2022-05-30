import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pharmacy_arrival/domain/usecases/auth_check.dart';
import 'package:pharmacy_arrival/locator_serviece.dart';
import 'package:pharmacy_arrival/main/login_bloc/login_bloc.dart';
import 'package:pharmacy_arrival/network/repository/global_repository.dart';
import 'package:pharmacy_arrival/screens/auth/bloc/bloc_auth.dart';
import 'package:pharmacy_arrival/screens/auth/bloc/sign_in_cubit.dart';
import 'package:pharmacy_arrival/screens/goods_list/cubit/goods_list_screen_cubit.dart';
import 'package:pharmacy_arrival/screens/move_data_scanned/bloc/bloc_move_data_bloc.dart';
import 'package:pharmacy_arrival/screens/pharmacy_arrival/cubit/pharmacy_arrival_screen_cubit.dart';
import 'package:pharmacy_arrival/screens/warehouse_arrival/cubit/warehouse_arrival_screen_cubit.dart';

///Providers for global blocs
class TopLevelBlocs extends StatelessWidget {
  final Widget child;

  const TopLevelBlocs({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              LoginBloc(sl<AuthCheck>())..add(InitialLoginEvent()),
        ),
        BlocProvider(
          create: (context) =>
              BlocMoveData(repository: context.read<GlobalRepository>())
                ..add(EventMoveDataInitial()),
        ),
        BlocProvider(create: (context) => BlocAuth()),
        BlocProvider<SignInCubit>(
          create: (context) => sl<SignInCubit>(),
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
      ],
      child: child,
    );
  }
}
