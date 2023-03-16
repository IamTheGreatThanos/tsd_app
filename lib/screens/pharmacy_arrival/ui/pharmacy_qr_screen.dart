import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pharmacy_arrival/data/model/pharmacy_order_dto.dart';
import 'package:pharmacy_arrival/screens/pharmacy_arrival/cubit/pharmacy_arrival_screen_cubit.dart';
import 'package:pharmacy_arrival/screens/pharmacy_arrival/cubit/pharmacy_qr_screen_cubit.dart';
import 'package:pharmacy_arrival/widgets/app_loader_overlay.dart';
import 'package:pharmacy_arrival/widgets/barcode_scanner_widget.dart';
import 'package:pharmacy_arrival/widgets/custom_app_bar.dart';
import 'package:pharmacy_arrival/widgets/snackbar/custom_snackbars.dart';

class PharmacyQrScreen extends StatefulWidget {
  const PharmacyQrScreen();

  @override
  State<PharmacyQrScreen> createState() => _PharmacyQrScreenState();
}

class _PharmacyQrScreenState extends State<PharmacyQrScreen> {
  @override
  Widget build(BuildContext context) {
    return AppLoaderOverlay(
      child: Scaffold(
        appBar: CustomAppBar(
          title: 'Сканируйте qr'.toUpperCase(),
        ),
        body: BlocConsumer<PharmacyQrScreenCubit, PharmacyQrScreenState>(
          listener: (context, state) {
            state.when(
              initialState: () {
                context.loaderOverlay.hide();
              },
              loadingState: () {
                context.loaderOverlay.show();
              },
              loadedState: (PharmacyOrderDTO order) {
                context.loaderOverlay.hide();
                BlocProvider.of<PharmacyArrivalScreenCubit>(context)
                    .updateOrderStatus(orderId: order.id, status: order.status!,totalStatus: 4);
                Navigator.pop(context);
              },
              errorState: (String message) {
                buildErrorCustomSnackBar(context, message);
                context.loaderOverlay.hide();
              },
            );
          },
          builder: (context, state) {
            return BarcodeScannerWidget(
              topPos: MediaQuery.of(context).size.height / 5,
              callback: (qr) {
                BlocProvider.of<PharmacyQrScreenCubit>(context)
                    .getOrderByNumber(number: qr);
                log(qr);
              },
              title: 'Отсканируйте qr водителя',
              height: MediaQuery.of(context).size.width - 40,
              width: MediaQuery.of(context).size.width - 40,
            );
          },
        ),
      ),
    );
  }
}
