import 'package:bot_toast/bot_toast.dart';
import 'package:pharmacy_arrival/styles/color_palette.dart';
import 'package:pharmacy_arrival/utils/scroll_glow_disable.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

import 'generated/l10n.dart';
import 'main/dependency_initializer/dependency_initializer.dart';
import 'main/dependency_provider/dependency_provider.dart';
import 'main/login_bloc/login_bloc.dart';
import 'main/top_level_blocs/top_level_blocs.dart';
import 'managers/secure_storage_manager/secure_storage_manager.dart';
import 'managers/user_store.dart';
import 'network/dio_wrapper/dio_wrapper.dart';
import 'network/repository/global_repository.dart';
import 'network/repository/hive_repository.dart';
import 'network/services/network_service.dart';
import 'network/tokens_repository/tokens_repository.dart';
import 'widgets/dynamic_link_layer/dynamic_link_layer.dart';

const String baseUrl = 'http://185.129.50.172/api/v1/';

void main() async {
  ///Global managers initialization
  WidgetsFlutterBinding.ensureInitialized();
  Future<bool> _initialize(BuildContext context) async {
    try {
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ]);
      await Firebase.initializeApp();
      // context.read<ErrorHandler>().initialize(S.of(context));
      final docDir = await getApplicationDocumentsDirectory();
      Hive.init(docDir.path);
      await context.read<SecureStorage>().init();
      await context.read<HiveRepository>().init();
      await context.read<UserStore>().init(context.read<HiveRepository>());
      await context
          .read<TokensRepository>()
          .init(context.read<HiveRepository>());
      // await context.read<FirebaseMessagingRepository>().init();
      await context.read<DioWrapper>().init(
          baseURL: baseUrl,
          tokensRepository: context.read<TokensRepository>(),
          globalRepository: context.read<GlobalRepository>(),
          loginBloc: context.read<LoginBloc>());

      context.read<NetworkService>().init(context.read<DioWrapper>());
      context
          .read<GlobalRepository>()
          .init(context.read<NetworkService>(), context.read<HiveRepository>());
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
            localizationsDelegates: const [
              S.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            locale: const Locale('zh'),
            supportedLocales: S.delegate.supportedLocales,
            theme: ThemeData(
              appBarTheme: const AppBarTheme(
                backgroundColor: Colors.white,
              ),
              scaffoldBackgroundColor: ColorPalette.main,
              fontFamily: 'Gilroy',
              textSelectionTheme: const TextSelectionThemeData().copyWith(
                cursorColor: ColorPalette.black,
              ),
            ),
            home: DependenciesInitializer(
              loadingIndicatorScreen: const Scaffold(
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

class MainAuthorization extends StatelessWidget {
  const MainAuthorization({Key? key}) : super(key: key);

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
      buildWhen: (p, c) => (c is LoadingLoginState ||
          c is UnauthorizedState ||
          c is AuthorizedState),
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
            false,
            key: ValueKey(0),
          );
        }
        if (state is AuthorizedState) {
          return const Application(
            true,
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

  const Application(
    this.isAuthenticated, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DynamicLinkLayer(isAuthenticated: isAuthenticated);
  }
}

class RestartWidget extends StatefulWidget {
  const RestartWidget({Key? key, required this.child}) : super(key: key);

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
