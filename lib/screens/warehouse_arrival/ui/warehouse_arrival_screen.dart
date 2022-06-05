import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:pharmacy_arrival/data/model/warehouse_order_dto.dart';
import 'package:pharmacy_arrival/screens/common/goods_list/ui/goods_list_screen.dart';
import 'package:pharmacy_arrival/screens/common/ui/fill_invoice_screen.dart';
import 'package:pharmacy_arrival/screens/warehouse_arrival/cubit/warehouse_arrival_screen_cubit.dart';
import 'package:pharmacy_arrival/styles/color_palette.dart';
import 'package:pharmacy_arrival/styles/text_styles.dart';
import 'package:pharmacy_arrival/utils/app_router.dart';
import 'package:pharmacy_arrival/widgets/custom_app_bar.dart';
import 'package:pharmacy_arrival/widgets/main_text_field/app_text_field.dart';
import 'package:pharmacy_arrival/widgets/snackbar/custom_snackbars.dart';

class WarehouseArrivalScreen extends StatefulWidget {
  const WarehouseArrivalScreen({Key? key}) : super(key: key);

  @override
  State<WarehouseArrivalScreen> createState() => _WarehouseArrivalScreenState();
}

class _WarehouseArrivalScreenState extends State<WarehouseArrivalScreen> {
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    BlocProvider.of<WarehouseArrivalScreenCubit>(context).getOrders();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "Приход на склад".toUpperCase(),
      ),
      body: BlocConsumer<WarehouseArrivalScreenCubit,
          WarehouseArrivalScreenState>(
        listener: (context, state) {
          state.when(
            initialState: () {},
            loadingState: () {},
            loadedState: (orders) {},
            errorState: (String message) {
              buildErrorCustomSnackBar(context, message);
            },
          );
        },
        builder: (context, state) {
          return state.maybeWhen(
            loadingState: () {
              return const Center(
                child: CircularProgressIndicator(
                  color: Colors.amber,
                ),
              );
            },
            loadedState: (List<WarehouseOrderDTO> orders) {
              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 13,
                    vertical: 15,
                  ),
                  child: Column(
                    children: [
                      AppTextField(
                        controller: searchController,
                        hintText: "Искать по номеру заказа",
                        hintStyle: ThemeTextStyle.textStyle14w400
                            .copyWith(color: ColorPalette.grey400),
                        fillColor: ColorPalette.white,
                        prefixIcon: SvgPicture.asset(
                          "assets/images/svg/search.svg",
                          color: ColorPalette.grey400,
                        ),
                        contentPadding: const EdgeInsets.only(
                          top: 17,
                          bottom: 17,
                          left: 13,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: orders.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return _BuildOrderData(
                            orderData: orders[index],
                          );
                        },
                      ),
                    ],
                  ),
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
    );
  }
}

class _BuildOrderData extends StatelessWidget {
  final WarehouseOrderDTO orderData;

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
                  '№.${orderData.id} ${orderData.number}',
                  style: ThemeTextStyle.textStyle20w600,
                ),
                Container(
                  decoration: BoxDecoration(
                    color: orderData.status == 1
                        ? ColorPalette.lightGreen
                        : ColorPalette.lightYellow,
                    border: Border.all(
                      color: orderData.status == 1
                          ? ColorPalette.borderGreen
                          : ColorPalette.borderYellow,
                    ),
                    borderRadius: BorderRadius.circular(100),
                  ),
                  padding:
                      const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                  child: Center(
                    child: Text(
                      orderData.status == 1 ? "Новый заказ" : "На расхождении",
                      style: ThemeTextStyle.textStyle12w600.copyWith(
                        color: orderData.status == 1
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
            if (orderData.status != 1)
              _BuildOrderDetailItem(
                icon: "divergence",
                title: "Товары на расхождении",
                data: "${orderData.container}",
              ),
            _BuildOrderDetailItem(
              icon: "container_ic",
              title: "Контейнеров",
              data: (orderData.container ?? 0).toString(),
            ),
            _BuildOrderDetailItem(
              icon: "calendar_ic",
              title: "Дата создания",
              data: orderData.createdAt != null
                  ? DateFormat("dd.MM.yyyy; hh:mm a")
                      .format(DateTime.parse(orderData.createdAt!))
                  : "No data",
            ),
            _BuildOrderDetailItem(
              icon: "stock_ic",
              title: "Склад",
              data: orderData.counteragent?.name ?? "No data",
            ),
            const SizedBox(
              height: 12,
            ),
            Material(
              color: ColorPalette.orange,
              borderRadius: BorderRadius.circular(6),
              child: InkWell(
                borderRadius: BorderRadius.circular(6),
                onTap: () {
                  if (orderData.status == 1) {
                    AppRouter.push(
                      context,
                      FillInvoiceScreen(
                        isFromPharmacyPage: false,
                        warehouseOrder: orderData,
                      ),
                    );
                  } else {
                    AppRouter.push(
                      context,
                      GoodsListScreen(
                        isFromPharmacyPage: false,
                        warehouseOrder: orderData,
                      ),
                    );
                  }
                },
                child: Container(
                  height: 32,
                  decoration: BoxDecoration(
                    color: Colors.transparent,
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

  const _BuildOrderDetailItem({
    Key? key,
    required this.icon,
    required this.title,
    required this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SvgPicture.asset("assets/images/svg/$icon.svg"),
          const SizedBox(
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
