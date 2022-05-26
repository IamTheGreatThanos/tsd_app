import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:pharmacy_arrival/network/models/dto_models/response/dto_order_details_response.dart';
import 'package:pharmacy_arrival/screens/warehouse_arrival/bloc/bloc_stock_arrival.dart';
import 'package:pharmacy_arrival/styles/color_palette.dart';
import 'package:pharmacy_arrival/styles/text_styles.dart';
import 'package:pharmacy_arrival/widgets/app_loader_overlay.dart';
import 'package:pharmacy_arrival/widgets/custom_app_bar.dart';

import '../../../widgets/main_text_field/app_text_field.dart';

class StockArrivalScreen extends StatefulWidget {
  const StockArrivalScreen({Key? key}) : super(key: key);

  @override
  State<StockArrivalScreen> createState() => _StockArrivalScreenState();
}

class _StockArrivalScreenState extends State<StockArrivalScreen> {
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
      BlocStockArrival()
        ..add(EventReadStockArrival()),
      child: AppLoaderOverlay(
        child: Scaffold(
          appBar: CustomAppBar(
            title: "Приход на склад".toUpperCase(),
          ),
          body: BlocConsumer<BlocStockArrival, StateBlocStockArrival>(
            listener: (context, state) {
              if (state is StateStockArrivalLoading) {
                context.loaderOverlay.show();
              } else {
                context.loaderOverlay.hide();
              }
            },
            buildWhen: (p, c) => c is StateStockArrivalLoadData,
            builder: (context, state) {
              if (state is StateStockArrivalLoadData) {
                return SingleChildScrollView(
                  child: Padding(
                    padding:
                    const EdgeInsets.symmetric(horizontal: 13, vertical: 15),
                    child: Column(
                      children: [
                        AppTextField(
                          controller: searchController,
                          hintText: "Искать по номеру заказа",
                          hintStyle: ThemeTextStyle.textStyle14w400
                              .copyWith(color: ColorPalette.grey400),
                          fillColor: ColorPalette.white,
                          prefixIcon:
                          SvgPicture.asset(
                              "assets/images/svg/search.svg", color: ColorPalette
                              .grey400,),
                          contentPadding: const EdgeInsets.only(
                              top: 17, bottom: 17, left: 13),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                            itemCount: state.orderDetails.length,
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return _BuildOrderData(
                                  orderData: state.orderDetails[index]);
                            }),
                      ],
                    ),
                  ),
                );
              }
              return const SizedBox.shrink();
            },
          ),
        ),
      ),
    );
  }
}

class _BuildOrderData extends StatelessWidget {
  final DTOOrderDetails orderData;

  const _BuildOrderData({Key? key, required this.orderData}) : super(key: key);

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
                Text(
                  orderData.orderName ?? "No data",
                  style: ThemeTextStyle.textStyle20w600,
                ),
                Container(
                  decoration: BoxDecoration(
                      color: orderData.isActive
                          ? ColorPalette.lightGreen
                          : ColorPalette.lightYellow,
                      border: Border.all(
                        color: orderData.isActive
                            ? ColorPalette.borderGreen
                            : ColorPalette.borderYellow,
                      ),
                      borderRadius: BorderRadius.circular(100)),
                  padding:
                  const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                  child: Center(
                    child: Text(
                      orderData.isActive ? "Новый заказ" : "На расхождении",
                      style: ThemeTextStyle.textStyle12w600.copyWith(
                        color: orderData.isActive
                            ? ColorPalette.textGreen
                            : ColorPalette.textYellow,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 27,
            ),
            if (!orderData.isActive)
              _BuildOrderDetailItem(
                icon: "divergence",
                title: "Товары на расхождении",
                data: "5",
              ),
            _BuildOrderDetailItem(
              icon: "container_ic",
              title: "Контейнеров",
              data: (orderData.containerCount ?? 0).toString(),
            ),
            _BuildOrderDetailItem(
              icon: "calendar_ic",
              title: "Дата создания",
              data: orderData.createdAt != null
                  ? DateFormat("dd.MM.yyyy; hh:mm a")
                  .format(orderData.createdAt!)
                  : "No data",
            ),
            _BuildOrderDetailItem(
              icon: "stock_ic",
              title: "Склад",
              data: orderData.stockName ?? "No data",
            ),
            SizedBox(
              height: 12,
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 6),
              decoration: BoxDecoration(
                color: ColorPalette.orange,
                borderRadius: BorderRadius.circular(6),
              ),
              child: Center(
                child: Text(
                  "Оприходовать",
                  style: ThemeTextStyle.textStyle14w600
                      .copyWith(color: ColorPalette.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _BuildOrderDetailItem extends StatelessWidget {
  final String icon;
  final String title;
  final String data;

  const _BuildOrderDetailItem(
      {Key? key, required this.icon, required this.title, required this.data})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SvgPicture.asset("assets/images/svg/$icon.svg"),
          SizedBox(
            width: 14,
          ),
          Expanded(
            child: Text(
              title,
              style: ThemeTextStyle.textStyle14w400
                  .copyWith(color: ColorPalette.grey400),
            ),
          ),
          Text(
            data,
            style: ThemeTextStyle.textStyle16w500,
          ),
        ],
      ),
    );
  }
}
