import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pharmacy_arrival/screens/accept_containers/bloc/accept_cont_list_cubit/accept_cont_list_cubit.dart';
import 'package:pharmacy_arrival/widgets/app_loader_overlay.dart';
import 'package:pharmacy_arrival/widgets/barcode_scanner_widget.dart';
import 'package:pharmacy_arrival/widgets/custom_app_bar.dart';

class AcceptContsBarcodeScreen extends StatefulWidget {
  const AcceptContsBarcodeScreen({super.key});

  @override
  State<AcceptContsBarcodeScreen> createState() =>
      _AcceptContsBarcodeScreenState();
}

class _AcceptContsBarcodeScreenState extends State<AcceptContsBarcodeScreen> {
  @override
  Widget build(BuildContext context) {
    return AppLoaderOverlay(
      child: Scaffold(
        appBar: CustomAppBar(
          title: 'Отсканируйте контейнер'.toUpperCase(),
          showLogo: false,
        ),
        body: SafeArea(
          child: BlocConsumer<AcceptContListCubit, AcceptContListState>(
            listener: (context, state) {
              state.maybeWhen(
                orElse: () {},
                initialState: () {
                  context.loaderOverlay.hide();
                },
                loadingState: () {
                  context.loaderOverlay.show();
                },
                loadedState: (
                  containers,
                  selectedProduct,
                ) {
                  context.loaderOverlay.hide();
                  Navigator.pop(context);
                },
                successScannedState: (message) {},
                errorState: (message) {
                  context.loaderOverlay.hide();
                },
              );
            },
            builder: (context, state) {
              return BarcodeScannerWidget(
                topPos: MediaQuery.of(context).size.height / 4,
                title: 'Отсканируйте штрихкод товара',
                height: (MediaQuery.of(context).size.width - 26) / 1.5,
                width: MediaQuery.of(context).size.width - 26,
                callback: (barcode) async {
                  await BlocProvider.of<AcceptContListCubit>(context)
                      .refundScannerBarCode(
                    barcode,
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
