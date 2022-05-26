import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pharmacy_arrival/screens/fill_invoice/ui/_vmodel.dart';
import 'package:provider/provider.dart';

import '../../main.dart';
import '../../managers/error_handler/error_handler.dart';
import '../../managers/secure_storage_manager/secure_storage_manager.dart';
import '../../managers/url_manager/url_manager.dart';
import '../../managers/user_store.dart';
import '../../network/dio_wrapper/dio_wrapper.dart';
import '../../network/repository/global_repository.dart';
import '../../network/repository/hive_repository.dart';
import '../../network/services/firebase_messaging_repository.dart';
import '../../network/services/network_service.dart';
import '../../network/tokens_repository/tokens_repository.dart';

///Providers for global managers
class DependenciesProvider extends StatelessWidget {
  final Widget child;

  const DependenciesProvider({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // RepositoryProvider(
        //   create: (_) => SyncSharedPreferences(),
        // ),
        RepositoryProvider(
          create: (_) => DioWrapper(),
        ),
        RepositoryProvider(
          create: (_) => TokensRepository(),
        ),
        RepositoryProvider(
          create: (_) => GlobalRepository(),
        ),
        RepositoryProvider(
          create: (_) => NetworkService(),
        ),
        RepositoryProvider(
          create: (_) => HiveRepository(),
        ),
        RepositoryProvider(
          create: (_) => ErrorHandler(),
        ),
        RepositoryProvider(
          create: (_) => SecureStorage(),
        ),
        RepositoryProvider(
          create: (_) => FirebaseMessagingRepository(),
        ),
        RepositoryProvider(
          create: (_) => UrlManager(baseUrl),
        ),
        ChangeNotifierProvider(
          create: (_) => UserStore(),
        ),ChangeNotifierProvider(
          create: (_) => FillInvoiceVModel()..init(),
        ),
      ],
      child: child,
    );
  }
}
