import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pharmacy_arrival/app/network/dio_wrapper/dio_wrapper.dart';
import 'package:pharmacy_arrival/app/network/repository/global_repository.dart';
import 'package:pharmacy_arrival/app/network/repository/hive_repository.dart';
import 'package:pharmacy_arrival/app/network/services/network_service.dart';
import 'package:pharmacy_arrival/app/network/tokens_repository/tokens_repository.dart';
import 'package:pharmacy_arrival/screens/common/signature/fill_invoice_vmodel.dart';
import 'package:provider/provider.dart';

///Providers for global managers
class DependenciesProvider extends StatelessWidget {
  final Widget child;

  const DependenciesProvider({super.key, required this.child});

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
        // TODO
        // RepositoryProvider(
        //   create: (_) => FirebaseMessagingRepository(),
        // ),
      ChangeNotifierProvider(
          create: (_) => FillInvoiceVModel()..init(),
        ),
      ],
      child: child,
    );
  }
}
