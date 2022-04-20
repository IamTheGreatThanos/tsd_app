import 'package:pharmacy_arrival/network/repository/hive_repository.dart';
import 'package:pharmacy_arrival/widgets/after_login_layer/after_login_layer.dart';
import 'package:pharmacy_arrival/widgets/after_login_layer/after_login_layer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/dynamic_link_layer_bloc.dart';

class DynamicLinkLayer extends StatelessWidget {
  final bool isAuthenticated;

  const DynamicLinkLayer({Key? key, required this.isAuthenticated})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<DynamicLinkLayerBloc>(
      create: (context) => DynamicLinkLayerBloc(
          context.read<HiveRepository>(), isAuthenticated)
        ..add(InitialDynamicLinkLayerEvent()),
      child: BlocConsumer<DynamicLinkLayerBloc, DynamicLinkLayerState>(
        listener: (context, state) {
          if (state is CreateNewPasswordState) {}
          if (state is NotAuthorizedState) {}
        },
        buildWhen: (p, c) => c is AuthorizedState || c is NotAuthorizedState,
        builder: (context, state) {
          if (state is NotAuthorizedState) {
            // return OnBoardingScreen();            // return MapControlsPage();
            return Container();
          }
          if (state is AuthorizedState) {
            // return BottomNavigationBarScreen();            // return MapControlsPage();
            return Container();
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}

Future openDialog(ctx, dynamic dialog) =>
    Navigator.of(ctx, rootNavigator: true).push(MaterialPageRoute<bool>(
        builder: (BuildContext context) {
          return dialog;
        },
        fullscreenDialog: true));
