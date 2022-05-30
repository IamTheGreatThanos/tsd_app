import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pharmacy_arrival/data/model/pharmacy_order_dto.dart';
import 'package:pharmacy_arrival/data/model/warehouse_order_dto.dart';
import 'package:pharmacy_arrival/screens/fill_invoice/ui/_vmodel.dart';
import 'package:pharmacy_arrival/screens/goods_list/ui/goods_list_screen.dart';
import 'package:pharmacy_arrival/screens/pharmacy_arrival/cubit/pharmacy_arrival_screen_cubit.dart';
import 'package:pharmacy_arrival/screens/signature/cubit/signature_screen_cubit.dart';
import 'package:pharmacy_arrival/styles/color_palette.dart';
import 'package:pharmacy_arrival/styles/text_styles.dart';
import 'package:pharmacy_arrival/utils/app_router.dart';
import 'package:pharmacy_arrival/widgets/app_loader_overlay.dart';
import 'package:pharmacy_arrival/widgets/custom_app_bar.dart';
import 'package:pharmacy_arrival/widgets/snackbar/custom_snackbars.dart';

class DigitalSignatureLoadScreen extends StatefulWidget {
  final bool isFromPharmacyPage;
  final PharmacyOrderDTO? pharmacyOrder;
  final WarehouseOrderDTO? warehouseOrder;
  const DigitalSignatureLoadScreen({
    Key? key,
    required this.isFromPharmacyPage,
    this.pharmacyOrder,
    this.warehouseOrder,
  }) : super(key: key);

  @override
  State<DigitalSignatureLoadScreen> createState() =>
      _DigitalSignatureLoadScreenState();
}

class _DigitalSignatureLoadScreenState
    extends State<DigitalSignatureLoadScreen> {
  @override
  Widget build(BuildContext context) {
    final FillInvoiceVModel _vmodel = context.read<FillInvoiceVModel>();
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: AppLoaderOverlay(
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
                    .getOrders();
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
              backgroundColor: ColorPalette.main,
              appBar: const CustomAppBar(
                backgroundColor: ColorPalette.main,
                title: "Загрузка эцп",
                isChevrone: true,
                showLogo: false,
              ),
              body: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 31.0, horizontal: 16),
                child: Stack(
                  // crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Загрузите AUTH сертификат",
                          style: ThemeTextStyle.textStyle12w600,
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            color: ColorPalette.white,
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  _vmodel.auth,
                                  overflow: TextOverflow.ellipsis,
                                  style: ThemeTextStyle.textStyle16w400,
                                ),
                              ),
                              const SizedBox(
                                width: 15,
                              ),
                              GestureDetector(
                                onTap: () async {
                                  final file =
                                      await FilePicker.platform.pickFiles(
                                    type: FileType.custom,
                                    allowedExtensions: ['p12'],
                                  );
                                  if (file != null) {
                                    _vmodel.setCertName(file.files.first.name);
                                  }
                                },
                                child: SvgPicture.asset(
                                  "assets/images/svg/file.svg",
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        const Text(
                          "Загрузите RSA/GOST сертификат",
                          style: ThemeTextStyle.textStyle12w600,
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            color: ColorPalette.white,
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  _vmodel.cert,
                                  overflow: TextOverflow.ellipsis,
                                  style: ThemeTextStyle.textStyle16w400,
                                ),
                              ),
                              const SizedBox(
                                width: 15,
                              ),
                              GestureDetector(
                                onTap: () async {
                                  final file =
                                      await FilePicker.platform.pickFiles(
                                    allowedExtensions: ['p12'],
                                    type: FileType.custom,
                                  );
                                  if (file != null) {
                                    _vmodel.setCertName(
                                      file.files.first.name,
                                      isAuth: false,
                                    );
                                  }
                                },
                                child: SvgPicture.asset(
                                  "assets/images/svg/file.svg",
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 45,
                        ),
                        Row(
                          children: [
                            const Expanded(
                              child: Text(
                                "Разные пароли сертификатов",
                                style: ThemeTextStyle.textStyle14w600,
                              ),
                            ),
                            CupertinoSwitch(
                              value: _vmodel.isTwoPassword,
                              onChanged: (value) {
                                FocusScope.of(context).unfocus();
                                _vmodel.changeSwitch(value);
                              },
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 45,
                        ),
                        const Text(
                          "Пароль от AUTH сертификата",
                          style: ThemeTextStyle.textStyle12w600,
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                        _vmodel.authPassword,
                        const SizedBox(
                          height: 15,
                        ),
                        Visibility(
                          visible: _vmodel.isTwoPassword,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Пароль от RSA/GOST сертификата",
                                style: ThemeTextStyle.textStyle12w600,
                              ),
                              const SizedBox(
                                height: 4,
                              ),
                              _vmodel.certificatePassword,
                            ],
                          ),
                        ),
                      ],
                    ),
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: GestureDetector(
                        onTap: () {
                          if (context
                              .read<FillInvoiceVModel>()
                              .digitalSignatureFillValidated()) {
                            BlocProvider.of<SignatureScreenCubit>(context)
                                .updateOrderStatus(
                              orderId: widget.isFromPharmacyPage
                                  ? widget.pharmacyOrder!.id
                                  : widget.warehouseOrder!.id,
                              status: 2,
                            );
                          }
                        },
                        child: Container(
                          height: 40,
                          decoration: BoxDecoration(
                            color: context
                                    .watch<FillInvoiceVModel>()
                                    .digitalSignatureFillValidated()
                                ? ColorPalette.orange
                                : ColorPalette.orangeInactive,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Center(
                            child: Text(
                              "Продолжить",
                              style: ThemeTextStyle.textStyle14w600
                                  .copyWith(color: ColorPalette.white),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
