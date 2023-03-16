import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pharmacy_arrival/screens/goods_list/cubit/goods_list_screen_cubit.dart';
import 'package:pharmacy_arrival/widgets/app_loader_overlay.dart';
import 'package:pharmacy_arrival/widgets/barcode_scanner_widget.dart';
import 'package:pharmacy_arrival/widgets/custom_app_bar.dart';

class GoodsBarcodeScreen extends StatefulWidget {
  final bool isFromPharmacyPage;
  final int orderId;
  final TextEditingController searchController;
  const GoodsBarcodeScreen({
    super.key,
    required this.orderId,
    required this.searchController,
    required this.isFromPharmacyPage,
  });

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
        body: SafeArea(
          child: BlocConsumer<GoodsListScreenCubit, GoodsListScreenState>(
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
                  if (widget.isFromPharmacyPage) {
                    await BlocProvider.of<GoodsListScreenCubit>(context)
                        .scannerBarCode(
                      scannedResult: barcode,
                      orderId: widget.orderId,
                      search: widget.searchController.text.isNotEmpty
                          ? widget.searchController.text
                          : null,
                      quantity: 1,
                      scanType: 0,
                    );
                  } else {
                    await BlocProvider.of<GoodsListScreenCubit>(context)
                        .refundScannerBarCode(
                      barcode,
                      widget.orderId,
                      widget.searchController.text.isNotEmpty
                          ? widget.searchController.text
                          : null,
                      1,
                      0,
                    );
                  }
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
