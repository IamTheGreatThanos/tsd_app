import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:pharmacy_arrival/core/styles/color_palette.dart';
import 'package:pharmacy_arrival/core/styles/text_styles.dart';
import 'package:pharmacy_arrival/core/utils/app_router.dart';
import 'package:pharmacy_arrival/data/model/warehouse_order_dto.dart';
import 'package:pharmacy_arrival/screens/common/signature/fill_invoice_screen.dart';
import 'package:pharmacy_arrival/screens/goods_list/ui/goods_list_screen.dart';
import 'package:pharmacy_arrival/screens/warehouse_arrival/cubit/warehouse_arrival_cat_cubit.dart';
import 'package:pharmacy_arrival/screens/warehouse_arrival/cubit/warehouse_arrival_screen_cubit.dart';
import 'package:pharmacy_arrival/widgets/custom_app_bar.dart';
import 'package:pharmacy_arrival/widgets/main_text_field/app_text_field.dart';
import 'package:pharmacy_arrival/widgets/snackbar/custom_snackbars.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class WarehouseArrivalScreen extends StatefulWidget {
  const WarehouseArrivalScreen();

  @override
  State<WarehouseArrivalScreen> createState() => _WarehouseArrivalScreenState();
}

class _WarehouseArrivalScreenState extends State<WarehouseArrivalScreen> {
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    BlocProvider.of<WarehouseArrivalScreenCubit>(context)
        .onRefreshOrders(status: status);
    super.initState();
  }

  RefreshController refreshController = RefreshController();
  int currentIndex = 0;
  int status = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "Приход на склад".toUpperCase(),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 13,
          vertical: 15,
        ),
        child: Column(
          children: [
            AppTextField(
              focusNode: FocusNode(),
              onFieldSubmitted: (value) {
                final productCubit =
                    BlocProvider.of<WarehouseArrivalScreenCubit>(context);

                if (value.isNotEmpty) {
                  productCubit.getOrdersBySearch(
                    number: searchController.text,
                    status: status,
                  );
                } else {
                  productCubit.onRefreshOrders(status: status);
                }
              },
              onChanged: (String? text) {
                final productCubit =
                    BlocProvider.of<WarehouseArrivalScreenCubit>(context);

                if (text != null) {
                  productCubit.getOrdersBySearch(
                    number: searchController.text,
                    status: status,
                  );
                }
                if (text == null || text.isEmpty) {
                  productCubit.onRefreshOrders(status: status);
                }
              },
              controller: searchController,
              hintText: "Искать по номеру заказа",
              hintStyle: ThemeTextStyle.textStyle14w400
                  .copyWith(color: ColorPalette.grey400),
              fillColor: ColorPalette.white,
              prefixIcon: SvgPicture.asset(
                "assets/images/svg/search.svg",
                colorFilter: const ColorFilter.mode(
                  ColorPalette.grey400,
                  BlendMode.srcIn,
                ),
              ),
              contentPadding: const EdgeInsets.only(
                top: 17,
                bottom: 17,
                left: 13,
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            SingleChildScrollView(
              padding: const EdgeInsets.symmetric(
                horizontal: 12.5,
              ),
              scrollDirection: Axis.horizontal,
              child: BlocConsumer<WarehouseArrivalCatCubit,
                  WarehouseArrivalCatState>(
                listener: (context, state) {
                  state.when(
                    newOrdersCatState: () {
                      currentIndex = 0;
                      status = 1;
                      BlocProvider.of<WarehouseArrivalScreenCubit>(context)
                          .onRefreshOrders(status: status);
                      // BlocProvider.of<WarehouseArrivalScreenCubit>(context)
                      //     .onRefreshOrders(status: status);
                    },
                    discrepancyCatState: () {
                      currentIndex = 1;
                      status = 2;

                      BlocProvider.of<WarehouseArrivalScreenCubit>(context)
                          .onRefreshOrders(status: status);
                      // BlocProvider.of<WarehouseyArrivalScreenCubit>(context)
                      //     .onRefreshOrders(status: status);
                    },
                  );
                },
                builder: (context, state) {
                  return Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          BlocProvider.of<WarehouseArrivalCatCubit>(context)
                              .changeToNewOrdersCat();
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            vertical: 8,
                            horizontal: 16,
                          ),
                          decoration: BoxDecoration(
                            color: currentIndex == 0
                                ? ColorPalette.white
                                : ColorPalette.main,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            "Новые заказы",
                            style: ThemeTextStyle.textStyle14w500.copyWith(
                              color: currentIndex == 0
                                  ? ColorPalette.grayText
                                  : ColorPalette.grayTextDisabled,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 25,
                      ),
                      GestureDetector(
                        onTap: () {
                          BlocProvider.of<WarehouseArrivalCatCubit>(context)
                              .changeToDiscrepanyCat();
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            vertical: 8,
                            horizontal: 16,
                          ),
                          decoration: BoxDecoration(
                            color: currentIndex == 1
                                ? ColorPalette.white
                                : ColorPalette.main,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            children: [
                              Text(
                                "На расхождении",
                                style: ThemeTextStyle.textStyle14w500.copyWith(
                                  color: currentIndex == 1
                                      ? ColorPalette.grayText
                                      : ColorPalette.grayTextDisabled,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: BlocConsumer<WarehouseArrivalScreenCubit,
                    WarehouseArrivalScreenState>(
                  listener: (context, state) {
                    state.when(
                      initialState: () {},
                      loadingState: () {},
                      bySearch: (orders) {},
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
                      bySearch: (orders) {
                        return ListView.builder(
                          itemCount: orders.length,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return _BuildOrderData(
                              orderData: orders[index],
                            );
                          },
                        );
                      },
                      loadedState: (List<WarehouseOrderDTO> orders) {
                        return SmartRefresher(
                          enablePullUp: true,
                          onLoading: () {
                            BlocProvider.of<WarehouseArrivalScreenCubit>(
                                    context,)
                                .onLoadOrders(status: status);
                            refreshController.loadComplete();
                          },
                          onRefresh: () {
                            BlocProvider.of<WarehouseArrivalScreenCubit>(
                              context,
                            ).onRefreshOrders(status: status);
                            refreshController.refreshCompleted();
                          },
                          controller: refreshController,
                          child: orders.isEmpty
                              ? ListView(
                                  children: [
                                    SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.1,
                                    ),
                                    Center(
                                      child: Lottie.asset(
                                        'assets/lotties/empty_box.json',
                                      ),
                                    )
                                  ],
                                )
                              : ListView.builder(
                                  itemCount: orders.length,
                                  shrinkWrap: true,
                                  itemBuilder: (context, index) {
                                    return _BuildOrderData(
                                      orderData: orders[index],
                                    );
                                  },
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
            ),
          ],
        ),
      ),
    );
  }
}

class _BuildOrderData extends StatelessWidget {
  final WarehouseOrderDTO orderData;

  const _BuildOrderData({required this.orderData});

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
