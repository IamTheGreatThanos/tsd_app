import 'package:pharmacy_arrival/generated/l10n.dart';
import 'package:pharmacy_arrival/network/repository/global_repository.dart';
import 'package:pharmacy_arrival/network/repository/hive_repository.dart';
import 'package:pharmacy_arrival/network/tokens_repository/tokens_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/after_login_layer_bloc.dart';

class AfterLoginLayer extends StatelessWidget {
  const AfterLoginLayer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AfterLoginLayerBloc>(
      create: (context) => AfterLoginLayerBloc(
        context.read<GlobalRepository>(),
        context.read<TokensRepository>(),
        S.current,
        context.read<HiveRepository>(),
      )..add(InitialAfterLoginEvent()),
      child: Center(
        child: Text("Authorized"),
      )
    );
  }

}
