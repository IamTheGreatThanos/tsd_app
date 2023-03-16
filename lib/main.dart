import 'dart:io';

import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pharmacy_arrival/app/main/counteragent_cubit/counteragent_cubit.dart';
import 'package:pharmacy_arrival/app/main/dependency_initializer/dependency_initializer.dart';
import 'package:pharmacy_arrival/app/main/dependency_provider/dependency_provider.dart';
import 'package:pharmacy_arrival/app/main/login_bloc/login_bloc.dart';
import 'package:pharmacy_arrival/app/main/organization_cubit/organization_cubit.dart';
import 'package:pharmacy_arrival/app/main/top_level_blocs/top_level_blocs.dart';
import 'package:pharmacy_arrival/app/network/dio_wrapper/dio_wrapper.dart';
import 'package:pharmacy_arrival/app/network/services/network_service.dart';
import 'package:pharmacy_arrival/core/styles/color_palette.dart';
import 'package:pharmacy_arrival/locator_serviece.dart';
import 'package:pharmacy_arrival/widgets/dynamic_link_layer/dynamic_link_layer.dart';


void main() async {
  ///Global managers initialization
  HttpOverrides.global = MyHttpOverrides();
  WidgetsFlutterBinding.ensureInitialized();
  await initLocator();
  Future<bool> _initialize(BuildContext context) async {
    try {
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ]);
      /// TODO
      // await Firebase.initializeApp();
      // context.read<ErrorHandler>().initialize(S.of(context));


      // await context.read<FirebaseMessagingRepository>().init();

      context.read<NetworkService>().init(context.read<DioWrapper>());
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
    return true;
  }

  runApp(
    RestartWidget(
      child: DependenciesProvider(
        child: TopLevelBlocs(
          child: MaterialApp(
            builder: BotToastInit(),

            // builder: (context, child) {
            //   return ScrollConfiguration(
            //     behavior: DisableGlowScrollBehavior(),
            //     child: child!,
            //   );
            //
            // },
            title: 'Europharm',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              appBarTheme: const AppBarTheme(
                backgroundColor: Colors.white,
              ),
              scaffoldBackgroundColor: ColorPalette.main,
              fontFamily: 'ProductSans',
              textSelectionTheme: const TextSelectionThemeData().copyWith(
                cursorColor: ColorPalette.black,
              ),
            ),
            home: DependenciesInitializer(
              loadingIndicatorScreen: const Scaffold(
                backgroundColor: Colors.white,
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              ),
              initializer: _initialize,
              child: const MainAuthorization(),
            ),
          ),
        ),
      ),
    ),
  );
}

class MainAuthorization extends StatefulWidget {
  const MainAuthorization();

  @override
  State<MainAuthorization> createState() => _MainAuthorizationState();
}

class _MainAuthorizationState extends State<MainAuthorization> {
  @override
  void initState() {
    BlocProvider.of<OrganizationCubit>(context).loadOrganizations();
    BlocProvider.of<CounteragentsCubit>(context).loadCounteragents();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state is AuthorizedState) {
          // Navigator.of(context).pushAndRemoveUntil(
          //     MaterialPageRoute(builder: (_) => MainAuthorization()),
          //     (route) => route.isFirst);
          // Navigator.pushNamedAndRemoveUntil(context, '/', (_) => false);
          Navigator.of(context).popUntil((route) => route.isFirst);
        }
      },
      buildWhen: (p, c) =>
          c is LoadingLoginState ||
          c is UnauthorizedState ||
          c is AuthorizedState,
      builder: (context, state) {
        if (state is LoadingLoginState) {
          return const Material(
            child: Center(
              child: CircularProgressIndicator(
                strokeWidth: 2,
              ),
            ),
          );
        }
        if (state is UnauthorizedState) {
          return const Application(
            isAuthenticated: false,
            key: ValueKey(0),
          );
        }
        if (state is AuthorizedState) {
          return const Application(
            isAuthenticated: true,
            key: ValueKey(1),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}

class Application extends StatelessWidget {
  final bool isAuthenticated;

  const Application({
    required this.isAuthenticated,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return DynamicLinkLayer(isAuthenticated: isAuthenticated);
  }
}

class RestartWidget extends StatefulWidget {
  const RestartWidget({super.key, required this.child});

  final Widget child;

  static void restartApp(BuildContext context) {
    context.findAncestorStateOfType<_RestartWidgetState>()?.restartApp();
  }

  @override
  _RestartWidgetState createState() => _RestartWidgetState();
}

class _RestartWidgetState extends State<RestartWidget> {
  Key key = UniqueKey();

  void restartApp() {
    setState(() {
      key = UniqueKey();
    });
  }

  @override
  Widget build(BuildContext context) {
    return KeyedSubtree(
      key: key,
      child: widget.child,
    );
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
