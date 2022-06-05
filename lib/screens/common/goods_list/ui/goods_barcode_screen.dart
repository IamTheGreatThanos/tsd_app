import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pharmacy_arrival/screens/common/goods_list/cubit/goods_list_screen_cubit.dart';
import 'package:pharmacy_arrival/widgets/app_loader_overlay.dart';
import 'package:pharmacy_arrival/widgets/barcode_scanner_widget.dart';
import 'package:pharmacy_arrival/widgets/custom_app_bar.dart';
import 'package:pharmacy_arrival/widgets/snackbar/custom_snackbars.dart';

class GoodsBarcodeScreen extends StatefulWidget {
  final int orderId;
  const GoodsBarcodeScreen({Key? key, required this.orderId}) : super(key: key);

  @override
  State<GoodsBarcodeScreen> createState() => _GoodsBarcodeScreenState();
}

class _GoodsBarcodeScreenState extends State<GoodsBarcodeScreen> {
  @override
  Widget build(BuildContext context) {
    return AppLoaderOverlay(
      child: Scaffold(
        appBar: CustomAppBar(
          title: 'Отсканируйте  товары'.toUpperCase(),
          showLogo: false,
        ),
        body: BlocConsumer<GoodsListScreenCubit, GoodsListScreenState>(
          listener: (context, state) {
            state.when(
              initialState: () {
                context.loaderOverlay.hide();
              },
              loadingState: () {
                context.loaderOverlay.show();
              },
              loadedState: (
                scannedProducts,
                unscannedProducts,
                selectedProduct,
                discrepancy,
              ) {
                context.loaderOverlay.hide();
                Navigator.pop(context);
              },
              errorState: (message) {
                buildErrorCustomSnackBar(context, message);
                context.loaderOverlay.hide();
              },
            );
          },
          builder: (context, state) {
            return BarcodeScannerWidget(
              callback: (barcode) {
                BlocProvider.of<GoodsListScreenCubit>(context).scannerBarCode(barcode, widget.orderId, 1);
              },
            );
          },
        ),
      ),
    );
  }
}
