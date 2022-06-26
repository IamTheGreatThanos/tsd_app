import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:pharmacy_arrival/data/model/counteragent_dto.dart';
import 'package:pharmacy_arrival/data/model/move_data_dto.dart';
import 'package:pharmacy_arrival/data/model/pharmacy_order_dto.dart';
import 'package:pharmacy_arrival/data/model/refund_data_dto.dart';
import 'package:pharmacy_arrival/data/model/warehouse_order_dto.dart';
import 'package:pharmacy_arrival/screens/common/goods_list/ui/goods_list_screen.dart';
import 'package:pharmacy_arrival/screens/history/history_cubit.dart/history_cat_cubit.dart';
import 'package:pharmacy_arrival/screens/history/history_cubit.dart/history_cubit.dart';
import 'package:pharmacy_arrival/styles/color_palette.dart';
import 'package:pharmacy_arrival/styles/text_styles.dart';
import 'package:pharmacy_arrival/utils/app_router.dart';
import 'package:pharmacy_arrival/widgets/custom_app_bar.dart';
import 'package:pharmacy_arrival/widgets/snackbar/custom_snackbars.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({Key? key}) : super(key: key);

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  RefreshController refreshController = RefreshController();
  @override
  void initState() {
    BlocProvider.of<HistoryCubit>(context).getPharmacyArrivalHistory();
    super.initState();
  }

  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "История заказов".toUpperCase(),
      ),
      body: Column(
        children: [
          SingleChildScrollView(
            padding:
                const EdgeInsets.symmetric(vertical: 12.0, horizontal: 12.5),
            scrollDirection: Axis.horizontal,
            child: BlocConsumer<HistoryCatCubit, HistoryCatState>(
              listener: (context, state) {
                state.when(
                  pharmacyHistoryCatState: () {
                    currentIndex = 0;
                    BlocProvider.of<HistoryCubit>(context)
                        .getPharmacyArrivalHistory();
                  },
                  warehouseHistoryCatState: () {
                    currentIndex = 1;
                    BlocProvider.of<HistoryCubit>(context)
                        .getWarehouseArrivalHistory();
                  },
                  movingHistoryCatState: () {
                    currentIndex = 3;
                    BlocProvider.of<HistoryCubit>(context).getMovingHistory();
                  },
                  refundHistoryCatState: () {
                    currentIndex = 2;
                    BlocProvider.of<HistoryCubit>(context).getRefundHistory();
                  },
                );
              },
              builder: (context, state) {
                return Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        BlocProvider.of<HistoryCatCubit>(context)
                            .changeToPharmacyCat();
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          vertical: 5,
                          horizontal: 12,
                        ),
                        decoration: BoxDecoration(
                          color: currentIndex == 0
                              ? ColorPalette.white
                              : ColorPalette.main,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          "Приход Аптека",
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
                        BlocProvider.of<HistoryCatCubit>(context)
                            .changeToWarehouseCat();
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          vertical: 5,
                          horizontal: 12,
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
                              "Приход на склад",
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
                    const SizedBox(
                      width: 25,
                    ),
                    GestureDetector(
                      onTap: () {
                        BlocProvider.of<HistoryCatCubit>(context)
                            .changeToRefundyCat();
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          vertical: 5,
                          horizontal: 12,
                        ),
                        decoration: BoxDecoration(
                          color: currentIndex == 2
                              ? ColorPalette.white
                              : ColorPalette.main,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          children: [
                            Text(
                              "Возврат",
                              style: ThemeTextStyle.textStyle14w500.copyWith(
                                color: currentIndex == 2
                                    ? ColorPalette.grayText
                                    : ColorPalette.grayTextDisabled,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 25,
                    ),
                    GestureDetector(
                      onTap: () {
                        BlocProvider.of<HistoryCatCubit>(context)
                            .changeToMovingCat();
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          vertical: 5,
                          horizontal: 12,
                        ),
                        decoration: BoxDecoration(
                          color: currentIndex == 3
                              ? ColorPalette.white
                              : ColorPalette.main,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          children: [
                            Text(
                              "Перемещение",
                              style: ThemeTextStyle.textStyle14w500.copyWith(
                                color: currentIndex == 3
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
          Expanded(
            child: BlocConsumer<HistoryCubit, HistoryState>(
              listener: (context, state) {
                state.when(
                  initialState: () {},
                  loadingState: () {},
                  pharmacyHistoryState: (orders) {},
                  warehouseHistoryState: (orders) {},
                  movingHistoryState: (orders) {},
                  refundHistoryState: (orders) {},
                  errorState: (String message) {
                    buildErrorCustomSnackBar(context, message);
                  },
                );
              },
              builder: (context, state) {
                return state.when(
                  initialState: () {
                    return const Center(
                      child: CircularProgressIndicator(
                        color: Colors.black,
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
                  pharmacyHistoryState: (List<PharmacyOrderDTO> orders) {
                    return SmartRefresher(
                      controller: refreshController,
                      onRefresh: () {
                        BlocProvider.of<HistoryCubit>(context)
                            .getPharmacyArrivalHistory();
                        refreshController.refreshCompleted();
                      },
                      child: orders.isEmpty
                          ? ListView(
                              children: [
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.1,
                                ),
                                Center(
                                  child: Lottie.asset(
                                    'assets/lotties/empty_box.json',
                                  ),
                                ),
                              ],
                            )
                          : ListView.builder(
                              padding: const EdgeInsets.symmetric(
                                vertical: 8,
                                horizontal: 11.5,
                              ),
                              itemBuilder: (context, index) {
                                return Material(
                                  borderRadius: BorderRadius.circular(15),
                                  child: InkWell(
                                    borderRadius: BorderRadius.circular(15),
                                    onTap: () {
                                      AppRouter.push(
                                        context,
                                        GoodsListScreen(
                                          isFromPharmacyPage: true,
                                          pharmacyOrder: orders[index],
                                        ),
                                      );
                                    },
                                    child: SizedBox(
                                      child: _BuildOrderData(
                                        orderNumber: '${orders[index].number}',
                                        orderId: orders[index].id,
                                        container: orders[index].container ?? 0,
                                        createdAt: orders[index].createdAt,
                                        counteragent: orders[index].sender,
                                      ),
                                    ),
                                  ),
                                );
                              },
                              itemCount: orders.length,
                              shrinkWrap: true,
                            ),
                    );
                  },
                  warehouseHistoryState: (List<WarehouseOrderDTO> orders) {
                    return SmartRefresher(
                      controller: refreshController,
                      onRefresh: () {
                        BlocProvider.of<HistoryCubit>(context)
                            .getPharmacyArrivalHistory();
                        refreshController.refreshCompleted();
                      },
                      child: orders.isEmpty
                          ? ListView(
                              children: [
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.1,
                                ),
                                Center(
                                  child: Lottie.asset(
                                    'assets/lotties/empty_box.json',
                                  ),
                                ),
                              ],
                            )
                          : ListView.builder(
                              padding: const EdgeInsets.symmetric(
                                vertical: 8,
                                horizontal: 11.5,
                              ),
                              itemBuilder: (context, index) {
                                return Material(
                                  child: InkWell(
                                    onTap: () {
                                      AppRouter.push(
                                          context,
                                          GoodsListScreen(
                                            isFromPharmacyPage: false,
                                            warehouseOrder: orders[index],
                                          ),);
                                    },
                                    child: _BuildOrderData(
                                      orderNumber: '${orders[index].number}',
                                      orderId: orders[index].id,
                                      container: orders[index].container ?? 0,
                                      createdAt: orders[index].createdAt,
                                      counteragent: orders[index].counteragent,
                                    ),
                                  ),
                                );
                              },
                              itemCount: orders.length,
                              shrinkWrap: true,
                            ),
                    );
                  },
                  movingHistoryState: (List<MoveDataDTO> orders) {
                    return SmartRefresher(
                      controller: refreshController,
                      onRefresh: () {
                        BlocProvider.of<HistoryCubit>(context)
                            .getPharmacyArrivalHistory();
                        refreshController.refreshCompleted();
                      },
                      child: orders.isEmpty
                          ? ListView(
                              children: [
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.1,
                                ),
                                Center(
                                  child: Lottie.asset(
                                    'assets/lotties/empty_box.json',
                                  ),
                                ),
                              ],
                            )
                          : ListView.builder(
                              padding: const EdgeInsets.symmetric(
                                vertical: 8,
                                horizontal: 11.5,
                              ),
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 16.0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      color: ColorPalette.white,
                                    ),
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 13,
                                      horizontal: 11,
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              '№.${orders[index].id}',
                                              style: ThemeTextStyle
                                                  .textStyle20w600,
                                            ),
                                            Container(
                                              decoration: BoxDecoration(
                                                color: const Color.fromARGB(
                                                  255,
                                                  203,
                                                  211,
                                                  216,
                                                ),
                                                border: Border.all(
                                                  color: const Color.fromARGB(
                                                    255,
                                                    94,
                                                    96,
                                                    97,
                                                  ),
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(100),
                                              ),
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                vertical: 4,
                                                horizontal: 8,
                                              ),
                                              child: Center(
                                                child: Text(
                                                  "Завершенный",
                                                  style: ThemeTextStyle
                                                      .textStyle12w600
                                                      .copyWith(
                                                    color: const Color.fromARGB(
                                                      255,
                                                      94,
                                                      96,
                                                      97,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 27,
                                        ),
                                        _BuildOrderDetailItem(
                                          icon: "container_ic",
                                          title: "Организация",
                                          data: (orders[index].organizationId)
                                              .toString(),
                                        ),
                                        _BuildOrderDetailItem(
                                          icon: "calendar_ic",
                                          title: "Дата создания",
                                          data: orders[index].createdAt != null
                                              ? DateFormat(
                                                  "dd.MM.yyyy; hh:mm a",
                                                ).format(
                                                  DateTime.parse(
                                                    orders[index].createdAt!,
                                                  ),
                                                )
                                              : "No data",
                                        ),
                                        _BuildOrderDetailItem(
                                          icon: "stock_ic",
                                          title: "Отрпавитель",
                                          data:
                                              orders[index].senderId.toString(),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                              itemCount: orders.length,
                              shrinkWrap: true,
                            ),
                    );
                  },
                  refundHistoryState: (List<RefundDataDTO> orders) {
                    return SmartRefresher(
                      controller: refreshController,
                      onRefresh: () {
                        BlocProvider.of<HistoryCubit>(context)
                            .getPharmacyArrivalHistory();
                        refreshController.refreshCompleted();
                      },
                      child: orders.isEmpty
                          ? ListView(
                              children: [
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.1,
                                ),
                                Center(
                                  child: Lottie.asset(
                                    'assets/lotties/empty_box.json',
                                  ),
                                ),
                              ],
                            )
                          : ListView.builder(
                              padding: const EdgeInsets.symmetric(
                                vertical: 8,
                                horizontal: 11.5,
                              ),
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 16.0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      color: ColorPalette.white,
                                    ),
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 13,
                                      horizontal: 11,
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              '№.${orders[index].id}',
                                              style: ThemeTextStyle
                                                  .textStyle20w600,
                                            ),
                                            Container(
                                              decoration: BoxDecoration(
                                                color: const Color.fromARGB(
                                                  255,
                                                  203,
                                                  211,
                                                  216,
                                                ),
                                                border: Border.all(
                                                  color: const Color.fromARGB(
                                                    255,
                                                    94,
                                                    96,
                                                    97,
                                                  ),
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(100),
                                              ),
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                vertical: 4,
                                                horizontal: 8,
                                              ),
                                              child: Center(
                                                child: Text(
                                                  "Завершенный",
                                                  style: ThemeTextStyle
                                                      .textStyle12w600
                                                      .copyWith(
                                                    color: const Color.fromARGB(
                                                      255,
                                                      94,
                                                      96,
                                                      97,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 27,
                                        ),
                                        _BuildOrderDetailItem(
                                          icon: "container_ic",
                                          title: "Организация",
                                          data: (orders[index].organizationId)
                                              .toString(),
                                        ),
                                        _BuildOrderDetailItem(
                                          icon: "calendar_ic",
                                          title: "Дата создания",
                                          data: orders[index].createdAt != null
                                              ? DateFormat(
                                                  "dd.MM.yyyy; hh:mm a",
                                                ).format(
                                                  DateTime.parse(
                                                    orders[index].createdAt!,
                                                  ),
                                                )
                                              : "No data",
                                        ),
                                        _BuildOrderDetailItem(
                                          icon: "stock_ic",
                                          title: "Контрагент",
                                          data: orders[index]
                                              .counteragentId
                                              .toString(),
                                        ),
                                        _BuildOrderDetailItem(
                                          icon: "stock_ic",
                                          title:
                                              "Склад с которого делается возврат",
                                          data: orders[index]
                                              .fromCounteragentId
                                              .toString(),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                              itemCount: orders.length,
                              shrinkWrap: true,
                            ),
                    );
                  },
                  errorState: (String message) {
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
        ],
      ),
    );
  }
}

class _BuildOrderData extends StatelessWidget {
  final String orderNumber;
  final int orderId;
  final int container;
  final String? createdAt;
  final CounteragentDTO? counteragent;
  const _BuildOrderData({
    Key? key,
    required this.orderNumber,
    required this.orderId,
    required this.container,
    this.createdAt,
    this.counteragent,
  }) : super(key: key);

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
                  '№.$orderId $orderNumber',
                  style: ThemeTextStyle.textStyle20w600,
                ),
                Container(
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 203, 211, 216),
                    border: Border.all(
                      color: const Color.fromARGB(255, 94, 96, 97),
                    ),
                    borderRadius: BorderRadius.circular(100),
                  ),
                  padding:
                      const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                  child: Center(
                    child: Text(
                      "Завершенный",
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
            _BuildOrderDetailItem(
              icon: "container_ic",
              title: "Контейнеров",
              data: (container).toString(),
            ),
            _BuildOrderDetailItem(
              icon: "calendar_ic",
              title: "Дата создания",
              data: createdAt != null
                  ? DateFormat("dd.MM.yyyy; hh:mm a")
                      .format(DateTime.parse(createdAt!))
                  : "No data",
            ),
            _BuildOrderDetailItem(
              icon: "stock_ic",
              title: "Склад",
              data: counteragent?.name ?? "No data",
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
