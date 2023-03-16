import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pharmacy_arrival/core/utils/app_router.dart';
import 'package:pharmacy_arrival/screens/return_data/return_cubit/return_cubit.dart';
import 'package:pharmacy_arrival/screens/return_data/ui/return_data_screen.dart';
import 'package:pharmacy_arrival/screens/return_data/ui/return_products_screen.dart';

class ReturnDataLauncher extends StatefulWidget {
  const ReturnDataLauncher();

  @override
  State<ReturnDataLauncher> createState() => _ReturnDataLauncherState();
}

class _ReturnDataLauncherState extends State<ReturnDataLauncher> {
  @override
  void initState() {
    BlocProvider.of<ReturnCubit>(context).checkReturnDataOrder();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<ReturnCubit, ReturnState>(
        listener: (BuildContext context, state) {
          state.maybeWhen(
            activeState: () {
              AppRouter.pushReplacement(
                context,
                const ReturnProductsScreen(),
              );
            },
            passiveState: () {
              AppRouter.pushReplacement(
                context,
                const ReturnDataScreen(),
              );
            },
            orElse: () {
              return const Center(
                child: CircularProgressIndicator(color: Colors.amber),
              );
            },
          );
        },
        builder: (BuildContext context, state) {
          return const Center(
            child: CircularProgressIndicator(color: Colors.amber),
          );
        },
      ),
    );
  }
}
