import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pharmacy_arrival/core/styles/color_palette.dart';
import 'package:pharmacy_arrival/core/styles/text_styles.dart';
import 'package:pharmacy_arrival/core/utils/app_router.dart';
import 'package:pharmacy_arrival/data/model/pharmacy_order_dto.dart';
import 'package:pharmacy_arrival/data/model/product_dto.dart';
import 'package:pharmacy_arrival/data/model/warehouse_order_dto.dart';
import 'package:pharmacy_arrival/screens/goods_list/cubit/goods_list_screen_cubit.dart';
import 'package:pharmacy_arrival/screens/history/history_cubit.dart/history_cubit.dart';
import 'package:pharmacy_arrival/screens/return_data/ui/return_detail_page.dart';
import 'package:pharmacy_arrival/widgets/app_loader_overlay.dart';
import 'package:pharmacy_arrival/widgets/custom_app_bar.dart';
import 'package:pharmacy_arrival/widgets/custom_button.dart';
import 'package:pharmacy_arrival/widgets/snackbar/custom_snackbars.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class HistoryScreenDetail extends StatefulWidget {
  final bool isFromPharmacyPage;
  final PharmacyOrderDTO? pharmacyOrder;
  final WarehouseOrderDTO? warehouseOrder;
  const HistoryScreenDetail({
    super.key,
    required this.isFromPharmacyPage,
    this.pharmacyOrder,
    this.warehouseOrder,
  });

  @override
  State<HistoryScreenDetail> createState() => _HistoryScreenDetailState();
}

class _HistoryScreenDetailState extends State<HistoryScreenDetail> {
  @override
  void initState() {
    if (widget.isFromPharmacyPage) {
      BlocProvider.of<GoodsListScreenCubit>(context)
          .getPharmacyProducts(orderId: widget.pharmacyOrder!.id);
    } else {}
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AppLoaderOverlay(
      child: Scaffold(
        floatingActionButton: widget.isFromPharmacyPage &&
                (widget.pharmacyOrder!.refundStatus == 0 ||
                    widget.pharmacyOrder!.refundStatus == 1)
            ? Padding(
                padding: const EdgeInsets.fromLTRB(32, 0, 0, 0),
                child: CustomButton(
                  height: 44,
                  onClick: () {
                    AppRouter.pushReplacement(
                      context,
                      ReturnDetailPage(
                        pharmacyOrder: widget.pharmacyOrder,
                      ),
                    );
                    BlocProvider.of<HistoryCubit>(context)
                        .updatePharmacyOrderStatus(
                      orderId: widget.pharmacyOrder!.id,
                      refundStatus: 1,
                      isFromHisPage: true,
                    );
                  },
                  body: Text(
                    widget.pharmacyOrder?.refundStatus == 0
                        ? 'Создать возврата'
                        : "Продолжить возврат",
                    style: const TextStyle(),
                  ),
                  style: pinkButtonStyle(),
                ),
              )
            : const SizedBox(),
        backgroundColor: ColorPalette.main,
        appBar: CustomAppBar(
          title: "Список товаров".toUpperCase(),
         
        ),
        body: BlocConsumer<GoodsListScreenCubit, GoodsListScreenState>(
          builder: (context, state) {
            return state.maybeWhen(
              loadingState: () {
                return const Center(
                  child: CircularProgressIndicator(
                    color: Colors.amber,
                  ),
                );
              },
              loadedState: (
                scannedProducts,
                unscannedProducts,
                selectedProduct,
              ) {
                return _BuildBody(
                  orderStatus: widget.isFromPharmacyPage
                      ? widget.pharmacyOrder?.status ?? 0
                      : widget.warehouseOrder?.status ?? 0,
                  orderId: widget.isFromPharmacyPage
                      ? widget.pharmacyOrder!.id
                      : widget.warehouseOrder!.id,
                  unscannedProducts: unscannedProducts,
                  scannedProducts: scannedProducts,
                  selectedProduct: selectedProduct,
                  pharmacyOrder: widget.pharmacyOrder,
                  warehouseOrder: widget.warehouseOrder,
                  isFromPharmacyPage: widget.isFromPharmacyPage,
                );
              },
              errorState: (String message) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const CircularProgressIndicator(
                        color: Colors.red,
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Text(
                        message,
                        style: const TextStyle(color: Colors.red),
                      )
                    ],
                  ),
                );
              },
              orElse: () {
                return const Center(
                  child: CircularProgressIndicator(
                    color: Colors.red,
                  ),
                );
              },
            );
          },
          listener: (context, state) {
            state.when(
              initialState: () {},
              loadingState: () {},
              successScannedState: (String message) {
                buildSuccessCustomSnackBar(context, message);
              },
              loadedState: (
                scannedProducts,
                unscannedProducts,
                selectedProductId,
              ) {},
              errorState: (String message) {
                buildErrorCustomSnackBar(context, message);
              },
            );
          },
        ),
      ),
    );
  }
}

class _BuildBody extends StatefulWidget {
  final int orderStatus;
  final int orderId;
  final ProductDTO selectedProduct;
  final List<ProductDTO> unscannedProducts;
  final List<ProductDTO> scannedProducts;
  final PharmacyOrderDTO? pharmacyOrder;
  final WarehouseOrderDTO? warehouseOrder;
  final bool isFromPharmacyPage;
  const _BuildBody({
    required this.orderId,
    required this.scannedProducts,
    required this.unscannedProducts,
    required this.selectedProduct,
    required this.orderStatus,
    this.pharmacyOrder,
    this.warehouseOrder,
    required this.isFromPharmacyPage,
  });

  @override
  State<_BuildBody> createState() => _BuildBodyState();
}

class _BuildBodyState extends State<_BuildBody> {
  int currentIndex = 0;
  RefreshController controller = RefreshController();
  int itemCount = 0;
  @override
  void initState() {
    itemCount = widget.unscannedProducts.length;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            const SizedBox(
              height: 25,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 5, horizontal: 12),
                decoration: BoxDecoration(
                  color: ColorPalette.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: [
                    Text(
                      "Продукты",
                      style: ThemeTextStyle.textStyle14w500
                          .copyWith(color: ColorPalette.grayText),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6),
                      decoration: BoxDecoration(
                        color: ColorPalette.borderGrey,
                        borderRadius: BorderRadius.circular(100),
                      ),
                      child: Text(
                        "${widget.scannedProducts.length}",
                        style: ThemeTextStyle.textStyle12w600.copyWith(
                          color: ColorPalette.black,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(
              width: 25,
            ),
          ],
        ),
        Expanded(
          child: SmartRefresher(
            onRefresh: () {
              BlocProvider.of<GoodsListScreenCubit>(context)
                  .getPharmacyProducts(orderId: widget.orderId);
            },
            controller: controller,
            child: ListView.builder(
              shrinkWrap: true,
              padding: const EdgeInsets.only(left: 12.5, right: 12.5, top: 20),
              itemCount: widget.scannedProducts.length,
              itemBuilder: (context, index) {
                return _BuildGoodDetails(
                  currentIndex: currentIndex,
                  orderID: widget.orderId,
                  good: widget.scannedProducts[index],
                  selectedProduct: widget.selectedProduct,
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}

class _BuildGoodDetails extends StatefulWidget {
  final int currentIndex;
  final ProductDTO good;
  final ProductDTO selectedProduct;
  final int orderID;
  const _BuildGoodDetails({
    required this.good,
    required this.selectedProduct,
    required this.orderID,
    required this.currentIndex,
  });

  @override
  State<_BuildGoodDetails> createState() => _BuildGoodDetailsState();
}

class _BuildGoodDetailsState extends State<_BuildGoodDetails> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: widget.good.id == widget.selectedProduct.id
              ? const Color.fromARGB(255, 183, 244, 215)
              : ColorPalette.white,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Image.network(
                  widget.good.image ??
                      'https://teelindy.com/wp-content/uploads/2019/03/default_image.png',
                  width: 104,
                  height: 104,
                  errorBuilder: (context, error, stackTrace) {
                    return Image.asset(
                      'assets/images/png/not_found.png',
                      width: 104,
                      height: 104,
                    );
                  },
                ),
                Positioned(
                  bottom: 8,
                  left: 24,
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: ColorPalette.white,
                      border: Border.all(
                        color: ColorPalette.red,
                      ),
                    ),
                    child: Text(
                      "${widget.good.totalCount} шт.",
                      style: ThemeTextStyle.textStyle12w600.copyWith(
                        color: ColorPalette.red,
                      ),
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(
              width: 12,
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "${widget.good.scanCount!}x",
                        style: ThemeTextStyle.textStyle14w400
                            .copyWith(color: ColorPalette.black),
                      ),
                      const SizedBox(
                        width: 12,
                      ),
                      Expanded(
                        child: Text(
                          widget.good.barcode ?? 'null',
                          style: ThemeTextStyle.textStyle14w600
                              .copyWith(color: ColorPalette.grayText),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Text(
                    '${widget.good.name}',
                    overflow: TextOverflow.fade,
                    style: ThemeTextStyle.textStyle20w600,
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Text(
                    "${widget.good.producer}",
                    style: ThemeTextStyle.textStyle14w400.copyWith(
                      color: ColorPalette.grayText,
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Кол-во:   ${widget.good.totalCount}'.toUpperCase()),
                      Text('Скан:   ${widget.good.scanCount}'.toUpperCase()),
                      Text('Просрочен:   ${widget.good.overdue}'.toUpperCase()),
                      Text(
                        'Нетоварный вид:   ${widget.good.netovar}'
                            .toUpperCase(),
                      ),
                      Text('Брак:   ${widget.good.defective}'.toUpperCase()),
                      Text('Излишка:   ${widget.good.surplus}'.toUpperCase()),
                      Text(
                        'Недостача:   ${widget.good.underachievement}'
                            .toUpperCase(),
                      ),
                      Text(
                        'Пересорт серий:   ${widget.good.reSorting}'
                            .toUpperCase(),
                      ),
                      Text(
                        'Возврат:   ${widget.good.refund}'.toUpperCase(),
                      ),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
