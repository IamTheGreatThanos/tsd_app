import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:pharmacy_arrival/core/styles/color_palette.dart';
import 'package:pharmacy_arrival/core/styles/text_styles.dart';
import 'package:pharmacy_arrival/widgets/main_text_field/app_text_field.dart';

class DatePicker extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final VoidCallback onClose;
  const DatePicker({
    super.key,
    required this.controller,
    required this.hintText,
    required this.onClose,
  });

  @override
  State<DatePicker> createState() => _DatePickerState();
}

class _DatePickerState extends State<DatePicker> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        final DateTime? date = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(1950),
          lastDate: DateTime(2050),
          helpText: widget.hintText,
          builder: (context, child) {
            return Theme(
              data: Theme.of(context).copyWith(
                colorScheme: const ColorScheme.light(
                  primary: ColorPalette.greyDark,
                ),
                textTheme: TextTheme(
                  headlineSmall: ThemeTextStyle.textTitleDella24w400,
                  labelSmall: ThemeTextStyle.textStyle16w600,
                ),
                textButtonTheme: TextButtonThemeData(
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.black,
                    textStyle: ThemeTextStyle.textStyle14w600.copyWith(color: Colors.black),
                  ),
                ),
              ),
              child: child!,
            );
          },
        );
        if (date != null) {
          widget.controller.text = DateFormat("yyyy-MM-dd").format(date);
        }
        setState(() {});
      },
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: ColorPalette.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              widget.hintText,
              //"Выберите дату отправления",
              style: ThemeTextStyle.textStyle14w400.copyWith(
                color: ColorPalette.grey400,
              ),
            ),
            const SizedBox(
              width: 16,
            ),
            Flexible(
              child: AppTextField(
                contentPadding: EdgeInsets.zero,
                capitalize: false,
                controller: widget.controller,
                readonly: true,
                textAlign: TextAlign.right,
                showErrorMessages: false,
                suffixIcon: Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: GestureDetector(
                    onTap: widget.controller.text.isNotEmpty
                        ? () {
                            widget.onClose();

                            // if (searchController.text.isEmpty) {
                            //   // BlocProvider.of<ReturnOrderPageCubit>(
                            //   //         context)
                            //   //     .onRefreshOrders(
                            //   //   refundStatus: status,
                            //   // );
                            // } else {
                            //   // BlocProvider.of<ReturnOrderPageCubit>(
                            //   //         context)
                            //   //     .getOrdersBySearch(
                            //   //   incomingNumber: searchController.text,
                            //   // );
                            // }
                          }
                        : () async {
                            final DateTime? date = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(2019),
                              lastDate: DateTime.now(),
                              helpText: widget.hintText,
                              builder: (context, child) {
                                return Theme(
                                  data: Theme.of(context).copyWith(
                                    colorScheme: const ColorScheme.light(
                                      primary: ColorPalette.greyDark,
                                    ),
                                    textTheme: TextTheme(
                                      headlineSmall: ThemeTextStyle.textTitleDella24w400,
                                      labelSmall: ThemeTextStyle.textStyle16w600,
                                    ),
                                    textButtonTheme: TextButtonThemeData(
                                      style: TextButton.styleFrom(
                                        foregroundColor: Colors.black,
                                        textStyle: ThemeTextStyle.textStyle14w600.copyWith(
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                  ),
                                  child: child!,
                                );
                              },
                            );
                            if (date != null) {
                              widget.controller.text = DateFormat("yyyy-MM-dd").format(date);
                            }
                            setState(() {});
                          },
                    child: widget.controller.text.isNotEmpty
                        ? const Icon(
                            Icons.close,
                            size: 24,
                            color: ColorPalette.grey400,
                          )
                        : SvgPicture.asset(
                            "assets/images/svg/calendar_circle_ic.svg",
                            width: 24,
                          ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
