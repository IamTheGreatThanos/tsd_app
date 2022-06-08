import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pharmacy_arrival/data/model/pharmacy_order_dto.dart';
import 'package:pharmacy_arrival/data/model/warehouse_order_dto.dart';
import 'package:pharmacy_arrival/screens/common/goods_list/ui/goods_list_screen.dart';
import 'package:pharmacy_arrival/screens/common/signature/cubit/signature_screen_cubit.dart';
import 'package:pharmacy_arrival/screens/pharmacy_arrival/cubit/pharmacy_arrival_screen_cubit.dart';
import 'package:pharmacy_arrival/styles/color_palette.dart';
import 'package:pharmacy_arrival/styles/text_styles.dart';
import 'package:pharmacy_arrival/utils/app_router.dart';
import 'package:pharmacy_arrival/widgets/app_loader_overlay.dart';
import 'package:pharmacy_arrival/widgets/custom_app_bar.dart';
import 'package:pharmacy_arrival/widgets/snackbar/custom_snackbars.dart';
import 'package:signature/signature.dart';

class SignatureScreen extends StatefulWidget {
  final bool isFromPharmacyPage;
  final PharmacyOrderDTO? pharmacyOrder;
  final WarehouseOrderDTO? warehouseOrder;
  const SignatureScreen({
    Key? key,
    required this.isFromPharmacyPage,
    this.pharmacyOrder,
    this.warehouseOrder,
  }) : super(key: key);

  @override
  State<SignatureScreen> createState() => _SignatureScreenState();
}

class _SignatureScreenState extends State<SignatureScreen> {
  final SignatureController _controller = SignatureController(
    exportBackgroundColor: ColorPalette.main,
  );

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
              BlocProvider.of<PharmacyArrivalScreenCubit>(context).onRefreshOrders();
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
                        onTap: () {
                          BlocProvider.of<SignatureScreenCubit>(context)
                              .updateOrderStatus(
                            orderId: widget.isFromPharmacyPage
                                ? widget.pharmacyOrder!.id
                                : widget.warehouseOrder!.id,
                            status: 2,
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
  final VoidCallback onTap;
  final String title;
  final String icon;
  final Color color;

  const _BuildButton({
    Key? key,
    required this.onTap,
    required this.title,
    required this.icon,
    required this.color,
  }) : super(key: key);

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
