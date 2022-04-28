import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:pharmacy_arrival/network/models/dto_models/response/dto_order_details_response.dart';
import 'package:pharmacy_arrival/screens/fill_invoice/ui/_vmodel.dart';
import 'package:pharmacy_arrival/styles/color_palette.dart';
import 'package:pharmacy_arrival/widgets/custom_app_bar.dart';
import 'package:pharmacy_arrival/widgets/main_text_field/app_text_field.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import '../../../styles/text_styles.dart';

class FillInvoiceScreen extends StatefulWidget {
  final DTOOrderDetails orderData;

  const FillInvoiceScreen({Key? key, required this.orderData})
      : super(key: key);

  @override
  State<FillInvoiceScreen> createState() => _FillInvoiceScreenState();
}

class _FillInvoiceScreenState extends State<FillInvoiceScreen> {
  final FillInvoiceVModel _vmodel = FillInvoiceVModel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: widget.orderData.orderName!.toUpperCase(),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 16.5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Заполните накладную",
                style: ThemeTextStyle.textTitleDella16w400,
              ),
              const SizedBox(
                height: 24,
              ),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: ColorPalette.white,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Входящий номер",
                          style: ThemeTextStyle.textStyle14w400.copyWith(
                            color: ColorPalette.grey400,
                          ),
                        ),
                        const SizedBox(
                          width: 16,
                        ),
                        Flexible(child: _vmodel.incomeNumber)
                      ],
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 4),
                      child: Divider(
                        color: ColorPalette.borderGrey,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Дата вх. номера",
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
                          controller: _vmodel.incomeNumberDateController,
                          readonly: true,
                          textAlign: TextAlign.right,
                          showErrorMessages: false,
                          suffixIcon: Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: GestureDetector(
                                onTap: () async {
                                  showDialog(context: context, builder: (context){
                                    return SfDateRangePicker(
                                      
                                    );
                                  });
                                  // final DateTime? date = await showDatePicker(
                                  //     context: context,
                                  //     initialDate: DateTime.now(),
                                  //     firstDate: DateTime(2019),
                                  //     lastDate: DateTime.now(),
                                  // );
                                  // if (date != null) {
                                  //   _vmodel.incomeNumberDateController.text =
                                  //       DateFormat("dd.MM.yyyy").format(date);
                                  // }
                                },
                                child: SvgPicture.asset(
                                  "assets/images/svg/calendar_circle_ic.svg",
                                  width: 24,
                                )),
                          ),
                        ))
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              _vmodel.bin,
              SizedBox(
                height: 12,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
