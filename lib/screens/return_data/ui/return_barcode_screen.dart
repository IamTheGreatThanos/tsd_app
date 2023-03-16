import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pharmacy_arrival/core/styles/text_styles.dart';
import 'package:pharmacy_arrival/core/utils/app_router.dart';
import 'package:pharmacy_arrival/data/model/product_dto.dart';
import 'package:pharmacy_arrival/screens/move_data/move_data_cubit/move_barcode_screen_cubit.dart';
import 'package:pharmacy_arrival/screens/return_data/return_products_cubit/return_products_screen_cubit.dart';
import 'package:pharmacy_arrival/screens/return_data/ui/return_products_screen.dart';
import 'package:pharmacy_arrival/widgets/app_loader_overlay.dart';
import 'package:pharmacy_arrival/widgets/barcode_scanner_widget.dart';
import 'package:pharmacy_arrival/widgets/custom_app_bar.dart';
import 'package:pharmacy_arrival/widgets/snackbar/custom_snackbars.dart';

class ReturnBarcodeScreen extends StatelessWidget {
  final bool isFromProductsPage;
  const ReturnBarcodeScreen({super.key, required this.isFromProductsPage})
     ;

  @override
  Widget build(BuildContext context) {
    return AppLoaderOverlay(
      child: Scaffold(
        appBar: CustomAppBar(
          title: "Отсканируйте  товары".toUpperCase(),
          leadingColor: const Color(0xFF28A745),
          textStyle: ThemeTextStyle.textStyle16w600,
          showLogo: false,
        ),
        body: BlocConsumer<MoveBarcodeScreenCubit, MoveBarcodeScreenState>(
          listener: (context, state) {
            state.when(
              initialState: () {
                context.loaderOverlay.hide();
              },
              loadingState: () {
                context.loaderOverlay.show();
              },
              loadedState: (ProductDTO product) {
                if (isFromProductsPage) {
                  BlocProvider.of<ReturnProductsScreenCubit>(context)
                      .getProducts();
                  Navigator.pop(context);
                } else {
                  AppRouter.pushReplacement(
                    context,
                    const ReturnProductsScreen(),
                  );
                }
                context.loaderOverlay.hide();
              },
              errorState: (String message) {
                context.loaderOverlay.hide();
                buildErrorCustomSnackBar(context, message);
              },
            );
          },
          builder: (context, state) {
            return BarcodeScannerWidget(
              topPos: MediaQuery.of(context).size.height / 4,
              title: 'Отсканируйте штрихкод товара',
              height: (MediaQuery.of(context).size.width - 26) / 1.5,
              width: MediaQuery.of(context).size.width - 26,
              callback: (barcode) {
                BlocProvider.of<MoveBarcodeScreenCubit>(context)
                    .getProductByBarcode(
                        barcode: barcode, isMoveProduct: false,
                        orderId: 0,);
              },
            );
          },
        ),
      ),
    );
  }
}
