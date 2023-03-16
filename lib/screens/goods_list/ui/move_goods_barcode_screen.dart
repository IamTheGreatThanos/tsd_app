import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pharmacy_arrival/screens/goods_list/cubit/move_goods_screen_cubit.dart';
import 'package:pharmacy_arrival/widgets/app_loader_overlay.dart';
import 'package:pharmacy_arrival/widgets/barcode_scanner_widget.dart';
import 'package:pharmacy_arrival/widgets/custom_app_bar.dart';

class MoveGoodsBarcodeScreen extends StatefulWidget {
  final int orderId;
  final TextEditingController searchController;
  const MoveGoodsBarcodeScreen({
    super.key,
    required this.orderId,
    required this.searchController,
  });

  @override
  State<MoveGoodsBarcodeScreen> createState() => _MoveGoodsBarcodeScreenState();
}

class _MoveGoodsBarcodeScreenState extends State<MoveGoodsBarcodeScreen> {
  @override
  Widget build(BuildContext context) {
    return AppLoaderOverlay(
      child: Scaffold(
        appBar: CustomAppBar(
          title: 'Отсканируйте  товары'.toUpperCase(),
          showLogo: false,
        ),
        body: SafeArea(
          child: BlocConsumer<MoveGoodsScreenCubit, MoveGoodsScreenState>(
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
                  await BlocProvider.of<MoveGoodsScreenCubit>(context).scannerBarCode(
                    scannedResult: barcode,
                    orderId: widget.orderId,
                    search: widget.searchController.text.isNotEmpty ? widget.searchController.text : null,
                    quantity: 1,
                    scanType: 0,
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
