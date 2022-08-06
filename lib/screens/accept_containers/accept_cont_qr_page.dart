import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pharmacy_arrival/data/model/product_dto.dart';
import 'package:pharmacy_arrival/screens/accept_containers/accept_cont_launch_cubit/accept_cont_launch_cubit.dart';
import 'package:pharmacy_arrival/screens/accept_containers/accept_cont_list_page.dart';
import 'package:pharmacy_arrival/screens/accept_containers/accept_cont_qr_cubit/accept_cont_qr_cubit.dart';
import 'package:pharmacy_arrival/utils/app_router.dart';
import 'package:pharmacy_arrival/widgets/app_loader_overlay.dart';
import 'package:pharmacy_arrival/widgets/barcode_scanner_widget.dart';
import 'package:pharmacy_arrival/widgets/custom_app_bar.dart';
import 'package:pharmacy_arrival/widgets/snackbar/custom_snackbars.dart';

class AcceptContQrPage extends StatefulWidget {
  const AcceptContQrPage({Key? key}) : super(key: key);

  @override
  State<AcceptContQrPage> createState() => _AcceptContQrPageState();
}

class _AcceptContQrPageState extends State<AcceptContQrPage> {
  @override
  Widget build(BuildContext context) {
    return AppLoaderOverlay(
      child: Scaffold(
        appBar: CustomAppBar(
          title: 'Сканируйте qr'.toUpperCase(),
        ),
        body: BlocConsumer<AcceptContQrCubit, AcceptContQrState>(
          listener: (context, state) {
            state.when(
              initialState: () {
                context.loaderOverlay.hide();
              },
              loadingState: () {
                context.loaderOverlay.show();
              },
              loadedState: (List<ProductDTO> products) {
                context.loaderOverlay.hide();
                // AppRouter.push(context, const AcceptContListPage());
                BlocProvider.of<AcceptContLaunchCubit>(context)
                    .chageToActiveState();
              },
              errorState: (String message) {
                // log("sdfsff");
                buildErrorCustomSnackBar(context, message);
                context.loaderOverlay.hide();
                Navigator.pop(context);
              },
            );
          },
          builder: (context, state) {
            return BarcodeScannerWidget(
              topPos: MediaQuery.of(context).size.height / 5,
              callback: (qr) {
                BlocProvider.of<AcceptContQrCubit>(context)
                    .getContainerByAng(number: qr);
                log(qr);
              },
              title: 'Отсканируйте контейнер',
              height: MediaQuery.of(context).size.width - 40,
              width: MediaQuery.of(context).size.width - 40,
            );
          },
        ),
      ),
    );
  }
}
