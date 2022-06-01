import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pharmacy_arrival/data/model/move_data_dto.dart';
import 'package:pharmacy_arrival/data/model/product_dto.dart';
import 'package:pharmacy_arrival/screens/move_data/move_data_cubit/move_barcode_screen_cubit.dart';
import 'package:pharmacy_arrival/screens/move_data_products/move_products_cubit/move_products_screen_cubit.dart';
import 'package:pharmacy_arrival/screens/move_data_products/move_products_screen.dart';
import 'package:pharmacy_arrival/styles/text_styles.dart';
import 'package:pharmacy_arrival/utils/app_router.dart';
import 'package:pharmacy_arrival/widgets/app_loader_overlay.dart';
import 'package:pharmacy_arrival/widgets/barcode_scanner_widget.dart';
import 'package:pharmacy_arrival/widgets/custom_app_bar.dart';
import 'package:pharmacy_arrival/widgets/snackbar/custom_snackbars.dart';

class MoveBarcodeScreen extends StatefulWidget {
  final bool isFromProductsPage;
  final MoveDataDTO moveDataDTO;
  const MoveBarcodeScreen({
    required this.moveDataDTO,
    Key? key,
    required this.isFromProductsPage,
  }) : super(key: key);

  @override
  State<MoveBarcodeScreen> createState() => _MoveBarcodeScreenState();
}

class _MoveBarcodeScreenState extends State<MoveBarcodeScreen> {
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
                if (widget.isFromProductsPage) {
                  BlocProvider.of<MoveProductsScreenCubit>(context)
                      .getProducts(moveOrderId: widget.moveDataDTO.id);
                  Navigator.pop(context);
                } else {
                  AppRouter.pushReplacement(
                    context,
                    MoveProductsScreen(
                      moveDataDTO: widget.moveDataDTO,
                    ),
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
              callback: (barcode) {
                BlocProvider.of<MoveBarcodeScreenCubit>(context)
                    .getProductByBarcode(barcode: barcode);
              },
            );
          },
        ),
      ),
    );
  }
}
