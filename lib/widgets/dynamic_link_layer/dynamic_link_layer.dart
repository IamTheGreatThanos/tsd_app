import 'package:pharmacy_arrival/network/repository/hive_repository.dart';
import 'package:pharmacy_arrival/screens/auth/ui/sign_in/signin_screen.dart';
import 'package:pharmacy_arrival/screens/menu/main_menu_screen.dart';
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
            // return OnBoardingScreen();
            // return MapControlsPage();
            return SignInScreen();
          }
          if (state is AuthorizedState) {
            // return BottomNavigationBarScreen();
            return MainMenuScreen();
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
