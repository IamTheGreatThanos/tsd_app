import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pharmacy_arrival/screens/accept_containers/bloc/accept_cont_launch_cubit/accept_cont_launch_cubit.dart';
import 'package:pharmacy_arrival/screens/accept_containers/ui/accept_cont_list_page.dart';
import 'package:pharmacy_arrival/screens/accept_containers/ui/accept_cont_qr_page.dart';

class AcceptContLauchPage extends StatefulWidget {
  const AcceptContLauchPage({super.key});

  @override
  State<AcceptContLauchPage> createState() => _AcceptContLauchPageState();
}

class _AcceptContLauchPageState extends State<AcceptContLauchPage> {
  @override
  void initState() {
    BlocProvider.of<AcceptContLaunchCubit>(context).checkAcceptCont();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<AcceptContLaunchCubit, AcceptContLaunchState>(
        listener: (BuildContext context, state) {},
        builder: (BuildContext context, state) {
          return state.when(
            initialState: () {
              return const Center(
                child: CircularProgressIndicator(color: Colors.amber),
              );
            },
            loadingState: () {
              return const Center(
                child: CircularProgressIndicator(color: Colors.amber),
              );
            },
            activeState: () {
              return const AcceptContListPage();
            },
            passiveState: () {
              return const AcceptContQrPage();
            },
          );
        },
      ),
    );
  }
}
