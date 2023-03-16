import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pharmacy_arrival/core/styles/color_palette.dart';
import 'package:pharmacy_arrival/core/styles/text_styles.dart';
import 'package:pharmacy_arrival/core/utils/app_router.dart';
import 'package:pharmacy_arrival/data/model/product_dto.dart';
import 'package:pharmacy_arrival/data/model/refund_data_dto.dart';
import 'package:pharmacy_arrival/screens/return_data/return_products_cubit/return_products_screen_cubit.dart';
import 'package:pharmacy_arrival/screens/return_data/ui/return_barcode_screen.dart';
import 'package:pharmacy_arrival/screens/return_data/ui/successfully_send_screen.dart';
import 'package:pharmacy_arrival/widgets/app_loader_overlay.dart';
import 'package:pharmacy_arrival/widgets/custom_app_bar.dart';

class ReturnProductsScreen extends StatefulWidget {
  const ReturnProductsScreen();

  @override
  State<ReturnProductsScreen> createState() => _ReturnProductsScreenState();
}

class _ReturnProductsScreenState extends State<ReturnProductsScreen> {
  @override
  void initState() {
    BlocProvider.of<ReturnProductsScreenCubit>(context).getProducts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AppLoaderOverlay(
      child: Scaffold(
        floatingActionButton: Padding(
          padding: const EdgeInsets.only(bottom: 75),
          child: SizedBox(
            height: 80,
            width: 80,
            child: FloatingActionButton(
              onPressed: () {
                AppRouter.push(
                  context,
                  const ReturnBarcodeScreen(
                    isFromProductsPage: true,
                  ),
                );
              },
              backgroundColor: ColorPalette.orange,
              child: SvgPicture.asset("assets/images/svg/move_plus.svg"),
            ),
          ),
        ),
        appBar: CustomAppBar(
          title: "на  расхождении".toUpperCase(),
        ),
        body:
            BlocConsumer<ReturnProductsScreenCubit, ReturnProductsScreenState>(
          listener: (context, state) {
            state.maybeWhen(
              finishedState: () {
                AppRouter.pushAndRemoveUntilRoot(
                  context,
                  const SuccessfullySendScreen(),
                );
              },
              orElse: () {},
            );
          },
          builder: (context, state) {
            return state.maybeWhen(
              loadedState: (
                List<ProductDTO> products,
                refundOrder,
                isFinishable,
              ) {
                return Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12.0,
                    vertical: 27.0,
                  ),
                  child: Column(
                    children: [
                      Expanded(
                        child: ListView.builder(
                          // physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 16.0),
                              child: _BuildGoodDetails(
                                good: products[index],
                                refundDataDTO: refundOrder,
                              ),
                            );
                          },
                          itemCount: products.length,
                          shrinkWrap: true,
                        ),
                      ),
                      MaterialButton(
                        height: 40,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        color: ColorPalette.orange,
                        disabledColor: ColorPalette.orangeInactive,
                        padding: EdgeInsets.zero,
                        onPressed: isFinishable == true
                            ? () {
                                BlocProvider.of<ReturnProductsScreenCubit>(
                                  context,
                                ).updateMovingOrderStatus(
                                  refundOrderId: refundOrder.id,
                                  status: 2,
                                );
                              }
                            : null,
                        child: Center(
                          child: Text(
                            "Завершить",
                            style: ThemeTextStyle.textStyle14w600
                                .copyWith(color: ColorPalette.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
              loadingState: () {
                return const Center(
                  child: CircularProgressIndicator(
                    color: Colors.amber,
                  ),
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
        ),
      ),
    );
  }
}

class _BuildGoodDetails extends StatefulWidget {
  final ProductDTO good;
  final RefundDataDTO refundDataDTO;

  const _BuildGoodDetails({
    required this.good,
    required this.refundDataDTO,
  });

  @override
  State<_BuildGoodDetails> createState() => _BuildGoodDetailsState();
}

class _BuildGoodDetailsState extends State<_BuildGoodDetails> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: ColorPalette.white,
      ),
      child: Row(
        children: [
          Stack(
            children: [
              SizedBox(
                width: 104,
                height: 104,
                child: Image.network(
                  widget.good.image ?? 'null',
                  errorBuilder: (context, child, stacktrace) {
                    return const Center(
                      child: Icon(Icons.error),
                    );
                  },
                ),
              ),
              Positioned(
                bottom: 8,
                left: 8,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: ColorPalette.white,
                    border: Border.all(
                      color: ColorPalette.green,
                    ),
                  ),
                  child: Text(
                    "${widget.good.totalCount ?? 0} шт.",
                    style: ThemeTextStyle.textStyle12w600.copyWith(
                      color: ColorPalette.green,
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
                Text(
                  "${widget.good.barcode}",
                  style: ThemeTextStyle.textStyle14w400
                      .copyWith(color: ColorPalette.black),
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
                if (widget.good.isReady == true)
                  Column(
                    children: [
                      const SizedBox(
                        height: 14,
                      ),
                      GestureDetector(
                        onTap: () {
                          _bottomSheet(
                            _SpecifyQuantity(
                              refundDataDTO: widget.refundDataDTO,
                              productDTO: widget.good,
                            ),
                          );
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 15.5,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFFF3F6FB),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            'Ввести количества',
                            style: ThemeTextStyle.textStyle14w600
                                .copyWith(color: const Color(0xFF5CA7FF)),
                          ),
                        ),
                      ),
                    ],
                  )
                else
                  const SizedBox()
              ],
            ),
          )
        ],
      ),
    );
  }

  Future _bottomSheet(Widget widget) {
    return showModalBottomSheet(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
      ),
      context: context,
      enableDrag: true,
      isDismissible: false,
      isScrollControlled: true,
      builder: (context) {
        return widget;
      },
    );
  }
}

class _SpecifyQuantity extends StatefulWidget {
  final RefundDataDTO refundDataDTO;
  final ProductDTO productDTO;
  const _SpecifyQuantity({
    required this.refundDataDTO,
    required this.productDTO,
  });

  @override
  State<_SpecifyQuantity> createState() => __SpecifyQuantityState();
}

class __SpecifyQuantityState extends State<_SpecifyQuantity> {
  TextEditingController controller = TextEditingController();
  FocusNode focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.3,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10),
          ),
        ),
        padding: const EdgeInsets.only(
          right: 16,
          left: 16,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40,
              height: 4,
              margin: const EdgeInsets.only(
                top: 14,
              ),
              decoration: BoxDecoration(
                color: const Color(0xffD9DBE9),
                borderRadius: BorderRadius.circular(100),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            const Text(
              'Укажите количество вручную ',
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
            const Spacer(),
            TextField(
              focusNode: focusNode,
              keyboardType: TextInputType.number,
              controller: controller,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Укажите количество',
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            MaterialButton(
              height: 40,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              color: ColorPalette.orange,
              disabledColor: ColorPalette.orangeInactive,
              padding: EdgeInsets.zero,
              onPressed: () {
                if (controller.text.isEmpty) {
                  Navigator.pop(context);
                } else {
                  BlocProvider.of<ReturnProductsScreenCubit>(context)
                      .addRefundDataProduct(
                    refundOrderId: widget.refundDataDTO.id,
                    addingProduct: widget.productDTO.copyWith(
                      totalCount: int.parse(controller.text),
                    ),
                  );
                  Navigator.pop(context);
                }
              },
              child: Center(
                child: Text(
                  "Отправить",
                  style: ThemeTextStyle.textStyle14w600
                      .copyWith(color: ColorPalette.white),
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
          ],
        ),
      ),
    );
  }
}
