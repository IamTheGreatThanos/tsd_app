import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pharmacy_arrival/core/styles/color_palette.dart';
import 'package:pharmacy_arrival/core/styles/text_styles.dart';
import 'package:pharmacy_arrival/core/utils/constants.dart';
import 'package:pharmacy_arrival/data/model/product_dto.dart';
import 'package:pharmacy_arrival/screens/goods_list/cubit/move_goods_screen_cubit.dart';
import 'package:pharmacy_arrival/screens/goods_list/ui/widgets/specifying_number_manually.dart';

class BuildMoveGoodsDetail extends StatefulWidget {
  final TextEditingController searchController;
  final int currentIndex;
  final ProductDTO good;
  final ProductDTO selectedProduct;
  final int orderID;
  const BuildMoveGoodsDetail({
    super.key,
    required this.searchController,
    required this.currentIndex,
    required this.good,
    required this.selectedProduct,
    required this.orderID,
  });

  @override
  State<BuildMoveGoodsDetail> createState() => _BuildMoveGoodsDetailState();
}

class _BuildMoveGoodsDetailState extends State<BuildMoveGoodsDetail> {
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
                  if (widget.currentIndex == 0)
                    Column(
                      children: [
                        const SizedBox(
                          height: 8,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            if (widget.good.totalCount! <=
                                (widget.good.scanCount ?? 0) +
                                    (widget.good.defective ?? 0) +
                                    (widget.good.underachievement ?? 0) +
                                    (widget.good.reSorting ?? 0) +
                                    (widget.good.overdue ?? 0) +
                                    (widget.good.netovar ?? 0))
                              MaterialButton(
                                color: ColorPalette.orange,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                padding: EdgeInsets.zero,
                                onPressed: () {
                                  BlocProvider.of<MoveGoodsScreenCubit>(context)
                                      .updateMoveProductById(
                                    orderId: widget.orderID,
                                    productDTO: ProductDTO(
                                      id: widget.good.id,
                                      scanCount: widget.good.scanCount,
                                      status: 2,
                                      defective: widget.good.defective,
                                      surplus: widget.good.surplus,
                                      underachievement:
                                          widget.good.underachievement,
                                      reSorting: widget.good.reSorting,
                                      overdue: widget.good.overdue,
                                      netovar: widget.good.netovar,
                                    ),
                                  );
                                  BlocProvider.of<MoveGoodsScreenCubit>(context)
                                      .saveMoveSelectedProductToCache(
                                    selectedProduct: ProductDTO(
                                      id: -1,
                                      movingId: widget.orderID,
                                    ),
                                  );
                                },
                                child: const Padding(
                                  padding: EdgeInsets.all(10.0),
                                  child: Text(
                                    'Завершить',
                                    style: TextStyle(
                                      color: ColorPalette.white,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ),
                            MaterialButton(
                              color: ColorPalette.orange,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              padding: EdgeInsets.zero,
                              onPressed: () {
                                bottomSheet(
                                  SpecifyingNumberManually(
                                    callback: (controller) {
                                      BlocProvider.of<MoveGoodsScreenCubit>(
                                        context,
                                      ).scannerBarCode(
                                        scannedResult: widget.good.barcode!,
                                        orderId: widget.orderID,
                                        search: widget.searchController.text
                                                .isNotEmpty
                                            ? widget.searchController.text
                                            : null,
                                        quantity: double.parse(controller.text),
                                        scanType: 1,
                                      );
                                      controller.clear();
                                      // focusNode.dispose();
                                      Navigator.pop(context);
                                    },
                                    productDTO: widget.good,
                                    orderID: widget.orderID,
                                  ),
                                  context,
                                );
                              },
                              child: const Padding(
                                padding: EdgeInsets.all(10.0),
                                child: Text(
                                  "Указать вручную",
                                  style: TextStyle(
                                    color: ColorPalette.white,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                      ],
                    )
                  else
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
