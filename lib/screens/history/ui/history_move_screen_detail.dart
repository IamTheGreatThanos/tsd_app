import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pharmacy_arrival/core/styles/color_palette.dart';
import 'package:pharmacy_arrival/core/styles/text_styles.dart';
import 'package:pharmacy_arrival/data/model/move_data_dto.dart';
import 'package:pharmacy_arrival/data/model/product_dto.dart';
import 'package:pharmacy_arrival/screens/goods_list/cubit/move_goods_screen_cubit.dart';
import 'package:pharmacy_arrival/widgets/app_loader_overlay.dart';
import 'package:pharmacy_arrival/widgets/custom_app_bar.dart';
import 'package:pharmacy_arrival/widgets/snackbar/custom_snackbars.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class HistoryMoveScreenDetail extends StatefulWidget {
  final MoveDataDTO moveDataDTO;
  const HistoryMoveScreenDetail({super.key, required this.moveDataDTO})
     ;

  @override
  State<HistoryMoveScreenDetail> createState() =>
      _HistoryMoveScreenDetailState();
}

class _HistoryMoveScreenDetailState extends State<HistoryMoveScreenDetail> {
  @override
  void initState() {
    BlocProvider.of<MoveGoodsScreenCubit>(context)
        .getMoveProducts(orderId: widget.moveDataDTO.id);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AppLoaderOverlay(
      child: Scaffold(
        backgroundColor: ColorPalette.main,
        appBar: CustomAppBar(
          title: "Список товаров".toUpperCase(),
          
        ),
        body: BlocConsumer<MoveGoodsScreenCubit, MoveGoodsScreenState>(
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
                  accept: widget.moveDataDTO.accept!,
                  send: widget.moveDataDTO.send!,
                  orderId: widget.moveDataDTO.id,
                  unscannedProducts: scannedProducts,
                  scannedProducts: scannedProducts,
                  selectedProduct: selectedProduct,
                  pharmacyOrder: widget.moveDataDTO,
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
  final int accept;
  final int send;
  final int orderId;
  final ProductDTO selectedProduct;
  final List<ProductDTO> unscannedProducts;
  final List<ProductDTO> scannedProducts;
  final MoveDataDTO? pharmacyOrder;
  const _BuildBody({
    required this.orderId,
    required this.scannedProducts,
    required this.unscannedProducts,
    required this.selectedProduct,
    this.pharmacyOrder,
    required this.accept,
    required this.send,
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
        const SizedBox(
          height: 25,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 12),
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
        Expanded(
          child: SmartRefresher(
            onRefresh: () {
              BlocProvider.of<MoveGoodsScreenCubit>(context)
                  .getMoveProducts(orderId: widget.orderId);
            },
            controller: controller,
            child: ListView.builder(
              shrinkWrap: true,
              padding: const EdgeInsets.only(left: 12.5, right: 12.5, top: 20),
              itemCount: currentIndex == 0
                  ? widget.unscannedProducts.length
                  : widget.scannedProducts.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    // if (currentIndex == 0) {
                    //   AppRouter.push(
                    //     context,
                    //     DefectScreen(
                    //       product: widget.unscannedProducts[index],
                    //       orderId: widget.orderId,
                    //     ),
                    //   );
                    // }
                  },
                  child: _BuildGoodDetails(
                    currentIndex: currentIndex,
                    orderID: widget.orderId,
                    good: currentIndex == 0
                        ? widget.unscannedProducts[index]
                        : widget.scannedProducts[index],
                    selectedProduct: widget.selectedProduct,
                  ),
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
                        'Возврат:   ${widget.good.refund??0}'.toUpperCase(),
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
