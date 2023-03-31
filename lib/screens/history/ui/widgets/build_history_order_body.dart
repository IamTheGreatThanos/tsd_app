import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:pharmacy_arrival/core/styles/color_palette.dart';
import 'package:pharmacy_arrival/core/styles/text_styles.dart';
import 'package:pharmacy_arrival/core/utils/constants.dart';
import 'package:pharmacy_arrival/data/model/counteragent_dto.dart';
import 'package:pharmacy_arrival/data/model/pharmacy_order_dto.dart';

class BuildHistoryOrderData extends StatelessWidget {
  final String orderNumber;
  final int orderId;
  final int container;
  final String? createdAt;
  final String? counteragent;
  final PharmacyOrderDTO? pharmacyOrderDTO;
  final String? incomingNumber;
  const BuildHistoryOrderData({
    super.key,
    required this.orderNumber,
    required this.orderId,
    required this.container,
    this.createdAt,
    this.counteragent,
    this.pharmacyOrderDTO,
    this.incomingNumber,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: ColorPalette.white,
        ),
        padding: const EdgeInsets.symmetric(vertical: 13, horizontal: 11),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    '№ $orderNumber',
                    style: ThemeTextStyle.textStyle20w600,
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 203, 211, 216),
                    border: Border.all(
                      color: const Color.fromARGB(255, 94, 96, 97),
                    ),
                    borderRadius: BorderRadius.circular(100),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                  child: Center(
                    child: Text(
                      pharmacyOrderDTO?.refundStatus == 0
                          ? "Завершенный"
                          : pharmacyOrderDTO?.refundStatus == 1
                              ? "Возвращается"
                              : "Возвращен",
                      style: ThemeTextStyle.textStyle12w600.copyWith(
                        color: const Color.fromARGB(255, 94, 96, 97),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 27,
            ),
            BuildOrderDetailItem(
              icon: "divergence",
              title: "Входяящий номер",
              data: "$incomingNumber",
            ),
            BuildOrderDetailItem(
              icon: "container_ic",
              title: "Контейнеров",
              data: (container).toString(),
            ),
            BuildOrderDetailItem(
              icon: "calendar_ic",
              title: "Дата создания",
              data:
                  createdAt != null ? DateFormat("dd.MM.yyyy; hh:mm a").format(DateTime.parse(createdAt!)) : "No data",
            ),
            BuildOrderDetailItem(
              icon: "stock_ic",
              title: "Склад",
              data: counteragent ?? "No data",
            ),
             BuildOrderDetailItem(
              icon: "document",
              title: "Сумма",
              data: "${moneyFormatter(pharmacyOrderDTO?.amount??"0")} ₸",
            ),
            const SizedBox(
              height: 25,
            ),
          ],
        ),
      ),
    );
  }
}

class BuildOrderDetailItem extends StatelessWidget {
  final String icon;
  final String title;
  final String data;

  const BuildOrderDetailItem({
    super.key,
    required this.icon,
    required this.title,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              SvgPicture.asset("assets/images/svg/$icon.svg"),
              const SizedBox(
                width: 14,
              ),
              Text(
                title,
                style: ThemeTextStyle.textStyle14w400.copyWith(color: ColorPalette.grey400),
              ),
            ],
          ),
           const SizedBox(
            width: 16,
          ),
          Expanded(
            child: Align(
              alignment: Alignment.centerRight,
              child: Text(
                data,
                style: ThemeTextStyle.textStyle16w500,
                textAlign: TextAlign.end,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
