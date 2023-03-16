
import 'package:flutter/material.dart';
import 'package:pharmacy_arrival/core/styles/color_palette.dart';
import 'package:pharmacy_arrival/core/styles/text_styles.dart';
import 'package:pharmacy_arrival/data/model/product_dto.dart';
import 'package:pharmacy_arrival/widgets/snackbar/custom_snackbars.dart';

class SpecifyingNumberManually extends StatefulWidget {
  final ProductDTO productDTO;
  final int orderID;
  final Function(TextEditingController controller)
      callback;
  const SpecifyingNumberManually({
    super.key,
    required this.productDTO,
    required this.orderID,
    required this.callback,
  });

  @override
  State<SpecifyingNumberManually> createState() =>
      _SpecifyingNumberManuallyState();
}

class _SpecifyingNumberManuallyState extends State<SpecifyingNumberManually> {
  TextEditingController controller = TextEditingController();
  FocusNode focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Container(
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
            const SizedBox(
              height: 24,
            ),
            TextField(
            //  focusNode: focusNode,
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              controller: controller,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Укажите количество вручную',
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
                final bool isWeightGood =
                    (widget.productDTO.barcode?.length ?? 0) <= 2;
                if (controller.text.isEmpty) {
                  Navigator.pop(context);
                } else {
                  if (int.tryParse(controller.text) != null) {
                    if (0 <= int.parse(controller.text) &&
                        int.parse(controller.text) <=
                            widget.productDTO.totalCount!) {
                      widget.callback(controller);
                    } else {
                      Navigator.pop(context);
                      buildErrorCustomSnackBar(
                        context,
                        'Укажите правильную количеству',
                      );
                    }
                  } else if (double.tryParse(controller.text) != null) {
                    if (0 <= double.parse(controller.text) &&
                        double.parse(controller.text) <=
                            widget.productDTO.totalCount!) {
                      if (isWeightGood) {
                        widget.callback(controller);
                      } else {
                        Navigator.pop(context);
                        buildErrorCustomSnackBar(
                          context,
                          'Товар не относится к весовой категории',
                        );
                      }
                    } else {
                      Navigator.pop(context);
                      buildErrorCustomSnackBar(
                        context,
                        'Укажите правильную количеству',
                      );
                    }
                  } else {
                    Navigator.pop(context);
                    buildErrorCustomSnackBar(
                      context,
                      'Ошибка',
                    );
                  }
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
              height: 50,
            ),
          ],
        ),
      ),
    );
  }
}
