import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pharmacy_arrival/domain/usecases/auth_check.dart';
import 'package:pharmacy_arrival/locator_serviece.dart';
import 'package:pharmacy_arrival/screens/auth/bloc/bloc_auth.dart';
import 'package:pharmacy_arrival/screens/auth/bloc/sign_in_cubit.dart';

import '../../network/repository/global_repository.dart';
import '../../network/tokens_repository/tokens_repository.dart';
import '../login_bloc/login_bloc.dart';

///Providers for global blocs
class TopLevelBlocs extends StatelessWidget {
  final Widget child;

  const TopLevelBlocs({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => LoginBloc(
            sl<AuthCheck>()
          )..add(InitialLoginEvent()),
        ),
        BlocProvider(create: (context) => BlocAuth()),
        BlocProvider<SignInCubit>(
          create: (context) => sl<SignInCubit>(),
        ),
      ],
      child: child,
    );
  }
}
