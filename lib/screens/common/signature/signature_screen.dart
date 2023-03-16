import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:pharmacy_arrival/core/styles/color_palette.dart';
import 'package:pharmacy_arrival/core/styles/text_styles.dart';
import 'package:pharmacy_arrival/core/utils/app_router.dart';
import 'package:pharmacy_arrival/data/model/pharmacy_order_dto.dart';
import 'package:pharmacy_arrival/data/model/warehouse_order_dto.dart';
import 'package:pharmacy_arrival/screens/common/_vmodel.dart';
import 'package:pharmacy_arrival/screens/common/signature/cubit/signature_screen_cubit.dart';
import 'package:pharmacy_arrival/screens/goods_list/ui/goods_list_screen.dart';
import 'package:pharmacy_arrival/screens/pharmacy_arrival/cubit/pharmacy_arrival_screen_cubit.dart';
import 'package:pharmacy_arrival/widgets/app_loader_overlay.dart';
import 'package:pharmacy_arrival/widgets/custom_app_bar.dart';
import 'package:pharmacy_arrival/widgets/snackbar/custom_snackbars.dart';
import 'package:signature/signature.dart';
import 'package:uri_to_file/uri_to_file.dart';

class SignatureScreen extends StatefulWidget {
  final bool isFromPharmacyPage;
  final PharmacyOrderDTO? pharmacyOrder;
  final WarehouseOrderDTO? warehouseOrder;
  const SignatureScreen({
    super.key,
    required this.isFromPharmacyPage,
    this.pharmacyOrder,
    this.warehouseOrder,
  });

  @override
  State<SignatureScreen> createState() => _SignatureScreenState();
}

class _SignatureScreenState extends State<SignatureScreen> {
  final SignatureController _controller = SignatureController(
    exportBackgroundColor: ColorPalette.main,
  );

//обратно запрашиваем уже сохранившеися файл через путь
  Future<File> getImageFileFromAssets(String path) async {
    final File file = await toFile(path);
    return file;
  }
//сохраняем нарисованную подпись
  Future<String> storeSignature() async {
    final status = await Permission.storage.status;
    if (!status.isGranted) {
      await Permission.storage.request();
    }

    final time = DateTime.now().toIso8601String().replaceAll('.', ':');
    final name = 'signature_$time';

    final result = await ImageGallerySaver.saveImage(
        (await _controller.toPngBytes())!,
        name: name,);
    final isSuccess = (result as Map<String,dynamic>)['isSuccess'] as bool;

    if (isSuccess) {
      log('Saved to signature folder');
    } else {
      log('Failed to save signature');
    }
    return result["filePath"].toString();
  }

  @override
  void initState() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
    ]);
    super.initState();
  }

  @override
  void dispose() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final FillInvoiceVModel vmodel = context.read<FillInvoiceVModel>();
    return AppLoaderOverlay(
      child: BlocConsumer<SignatureScreenCubit, SignatureScreenState>(
        listener: (context, state) {
          state.when(
            initialState: () {
              context.loaderOverlay.hide();
            },
            loadingState: () {
              context.loaderOverlay.show();
            },
            loadedState: () {
              context.loaderOverlay.hide();
              BlocProvider.of<PharmacyArrivalScreenCubit>(context)
                  .onRefreshOrders(status: 1);
              AppRouter.pushReplacement(
                context,
                GoodsListScreen(
                  isFromPharmacyPage: widget.isFromPharmacyPage,
                  pharmacyOrder: widget.pharmacyOrder,
                  warehouseOrder: widget.warehouseOrder,
                ),
              );
            },
            errorState: (message) {
              context.loaderOverlay.hide();
              buildErrorCustomSnackBar(context, message);
            },
          );
        },
        builder: (context, state) {
          return Scaffold(
            appBar: const CustomAppBar(
              backgroundColor: ColorPalette.main,
              title: "Распишитесь",
              showLogo: false,
              isChevrone: true,
            ),
            body: Stack(
              children: [
                Signature(
                  controller: _controller,
                  height: MediaQuery.of(context).size.height,
                  backgroundColor: ColorPalette.main,
                ),
                Positioned(
                  bottom: 32,
                  right: 16,
                  child: Row(
                    children: [
                      _BuildButton(
                        onTap: () {
                          setState(() {
                            _controller.clear();
                          });
                        },
                        title: "Очистить",
                        icon: "clear_signature",
                        color: ColorPalette.white,
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      _BuildButton(
                        onTap:  () async {
                                BlocProvider.of<SignatureScreenCubit>(context)
                                    .sendSignature(
                                  orderId: widget.isFromPharmacyPage
                                      ? widget.pharmacyOrder!.id
                                      : widget.warehouseOrder!.id,
                                  status: 2,
                                  incomingNumber: vmodel
                                          .incomeNumber.controller.text.isEmpty
                                      ? null
                                      : vmodel.incomeNumber.controller.text,
                                  incomingDate: vmodel
                                          .incomeNumberDateController
                                          .text
                                          .isEmpty
                                      ? null
                                      : vmodel.incomeNumberDateController.text,
                                  bin: vmodel.bin.controller.text.isEmpty
                                      ? null
                                      : vmodel.bin.controller.text,
                                  invoiceDate: vmodel.invoiceDate.text.isEmpty
                                      ? null
                                      : vmodel.invoiceDate.text,
                                  recipientId: vmodel.recipientId == -1
                                      ? null
                                      : vmodel.recipientId,
                                  signature: await getImageFileFromAssets(
                                    await storeSignature(),
                                  ),
                                );
                              },
                        title: "Отправить",
                        icon: "done_signature",
                        color: ColorPalette.orange,
                      ),
                    ],
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}

class _BuildButton extends StatelessWidget {
  final VoidCallback? onTap;
  final String title;
  final String icon;
  final Color color;

  const _BuildButton({
    required this.onTap,
    required this.title,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 40,
        padding: const EdgeInsets.symmetric(horizontal: 25),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            RotatedBox(
              quarterTurns: -45,
              child: SvgPicture.asset("assets/images/svg/$icon.svg"),
            ),
            const SizedBox(
              width: 8,
            ),
            Text(
              title.toUpperCase(),
              style: ThemeTextStyle.textStyle14w600.copyWith(
                color:
                    color == Colors.white ? ColorPalette.grey400 : Colors.white,
              ),
            )
          ],
        ),
      ),
    );
  }
}
