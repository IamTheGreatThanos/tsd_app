// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:pharmacy_arrival/core/styles/color_palette.dart';
import 'package:pharmacy_arrival/core/styles/text_styles.dart';
import 'package:pharmacy_arrival/core/utils/app_router.dart';
import 'package:pharmacy_arrival/data/model/move_data_dto.dart';
import 'package:pharmacy_arrival/data/model/pharmacy_order_dto.dart';
import 'package:pharmacy_arrival/data/model/refund_data_dto.dart';
import 'package:pharmacy_arrival/data/model/warehouse_order_dto.dart';
import 'package:pharmacy_arrival/screens/history/history_cubit.dart/history_cat_cubit.dart';
import 'package:pharmacy_arrival/screens/history/history_cubit.dart/history_cubit.dart';
import 'package:pharmacy_arrival/screens/history/ui/history_move_screen_detail.dart';
import 'package:pharmacy_arrival/screens/history/ui/history_screen_detail.dart';
import 'package:pharmacy_arrival/screens/history/ui/widgets/build_history_order_body.dart';
import 'package:pharmacy_arrival/screens/move_data/ui/move_filter_page.dart';
import 'package:pharmacy_arrival/screens/move_data/vmodel/move_filter_vmodel.dart';
import 'package:pharmacy_arrival/screens/pharmacy_arrival/ui/pharmacy_filter_page.dart';
import 'package:pharmacy_arrival/screens/pharmacy_arrival/vmodel/pharmacy_filter_vmodel.dart';
import 'package:pharmacy_arrival/screens/return_data/ui/return_detail_page.dart';
import 'package:pharmacy_arrival/widgets/custom_app_bar.dart';
import 'package:pharmacy_arrival/widgets/filter/move_filter_widget.dart';
import 'package:pharmacy_arrival/widgets/filter/pharmacy_filter_widget.dart';
import 'package:pharmacy_arrival/widgets/main_text_field/app_text_field.dart';
import 'package:pharmacy_arrival/widgets/snackbar/custom_snackbars.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen();

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  RefreshController refreshController = RefreshController();
  TextEditingController searchController = TextEditingController();
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<MoveFilterVmodel>(
        context,
        listen: false,
      ).clear();
      Provider.of<PharmacyFilterVmodel>(
        context,
        listen: false,
      ).clear();
    });
    BlocProvider.of<HistoryCatCubit>(context).changeToPharmacyCat();
    BlocProvider.of<HistoryCubit>(context).getPharmacyArrivalHistory();
    super.initState();
  }

  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Consumer2<PharmacyFilterVmodel, MoveFilterVmodel>(
      builder: (context, pharmacyFilter, moveFilter, child) {
        return Scaffold(
          appBar: CustomAppBar(
            title: "История заказов".toUpperCase(),
          ),
          body: Column(
            children: [
              //tab bar
              SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  vertical: 12.0,
                  horizontal: 12.5,
                ),
                scrollDirection: Axis.horizontal,
                child: BlocConsumer<HistoryCatCubit, HistoryCatState>(
                  listener: (context, state) {
                    state.when(
                      pharmacyHistoryCatState: () {
                        currentIndex = 0;
                        BlocProvider.of<HistoryCubit>(context)
                            .getPharmacyArrivalHistory();
                        pharmacyFilter.clear();
                        searchController.clear();
                      },
                      warehouseHistoryCatState: () {
                        currentIndex = 1;
                        BlocProvider.of<HistoryCubit>(context)
                            .getWarehouseArrivalHistory();
                        searchController.clear();
                      },
                      movingHistoryCatState: () {
                        currentIndex = 3;
                        BlocProvider.of<HistoryCubit>(context)
                            .getMovingHistory();
                        moveFilter.clear();
                        searchController.clear();
                      },
                      refundHistoryCatState: () {
                        currentIndex = 2;
                        BlocProvider.of<HistoryCubit>(context)
                            .getRefundHistory(refundStatus: 2);
                        pharmacyFilter.clear();
                        searchController.clear();
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
                                  style:
                                      ThemeTextStyle.textStyle14w500.copyWith(
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
                                  style:
                                      ThemeTextStyle.textStyle14w500.copyWith(
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
                                  style:
                                      ThemeTextStyle.textStyle14w500.copyWith(
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

              //search bar
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: AppTextField(
                  validator: (p0) {
                    return [];
                  },
                  focusNode: FocusNode(),
                  onFieldSubmitted: (value) {
                    final productCubit = BlocProvider.of<HistoryCubit>(context);

                    switch (currentIndex) {
                      case 0:
                        if (value.isNotEmpty) {
                          productCubit.getPharmacyArrivalHistory(
                            number: searchController.text,
                          );
                        } else {
                          productCubit.getPharmacyArrivalHistory();
                        }
                        break;
                      case 1:
                        break;
                      case 2:
                        break;
                      case 3:
                        break;

                      default:
                        break;
                    }
                  },
                  onChanged: (String? text) {
                    final productCubit = BlocProvider.of<HistoryCubit>(context);

                    switch (currentIndex) {
                      case 0:
                        if (text != null) {
                          productCubit.getPharmacyArrivalHistory(
                            number: searchController.text,
                            pharmacyFilterVmodel: pharmacyFilter,
                          );
                        }
                        if (text == null || text.isEmpty) {
                          productCubit.getPharmacyArrivalHistory(
                            pharmacyFilterVmodel: pharmacyFilter,
                          );
                        }
                        break;
                      case 1:
                        break;
                      case 2:
                        break;
                      case 3:
                        break;

                      default:
                        break;
                    }
                  },
                  controller: searchController,
                  hintText: "Искать по номеру заказа",
                  hintStyle: ThemeTextStyle.textStyle14w400
                      .copyWith(color: ColorPalette.grey400),
                  fillColor: ColorPalette.white,
                  prefixIcon: SvgPicture.asset(
                    "assets/images/svg/search.svg",
                    colorFilter: const ColorFilter.mode(ColorPalette.grey400, BlendMode.srcIn),
                  ),
                  contentPadding: const EdgeInsets.only(
                    top: 18,
                    bottom: 18,
                    left: 13,
                  ),
                ),
              ),

              //filter bar
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: BlocBuilder<HistoryCatCubit, HistoryCatState>(
                  builder: (context, state) {
                    return state.when(
                      pharmacyHistoryCatState: () {
                        return PharmacyFilterWidget(
                          onTap: () {
                            AppRouter.push(
                              context,
                              PharmacyFilterPage(
                                isFromPharmacyPage: false,
                                callback: () {
                                  BlocProvider.of<HistoryCubit>(
                                    context,
                                  ).getPharmacyArrivalHistory(
                                    number: searchController.text.isEmpty
                                        ? null
                                        : searchController.text,
                                    pharmacyFilterVmodel: pharmacyFilter,
                                  );
                                },
                              ),
                            );
                          },
                          trailingCloseTap: () {
                            pharmacyFilter.clear();
                            BlocProvider.of<HistoryCubit>(
                              context,
                            ).getPharmacyArrivalHistory(
                              number: searchController.text.isEmpty
                                  ? null
                                  : searchController.text,
                              pharmacyFilterVmodel: pharmacyFilter,
                            );
                          },
                        );
                      },
                      warehouseHistoryCatState: () {
                        return const SizedBox();
                      },
                      movingHistoryCatState: () {
                        return MoveFilterWidget(
                          onTap: () {
                            AppRouter.push(
                              context,
                              MoveFilterPage(
                                callback: () {
                                  BlocProvider.of<HistoryCubit>(context)
                                      .getMovingHistory(
                                    senderId: moveFilter.sender?.id,
                                    recipientId: moveFilter.recipient?.id,
                                    date: moveFilter.date,
                                  );
                                },
                              ),
                            );
                          },
                          trailingCloseTap: () {
                            moveFilter.clear();
                            BlocProvider.of<HistoryCubit>(context)
                                .getMovingHistory(
                              senderId: moveFilter.sender?.id,
                              recipientId: moveFilter.recipient?.id,
                              date: moveFilter.date,
                            );
                          },
                        );
                      },
                      refundHistoryCatState: () {
                        return PharmacyFilterWidget(
                          onTap: () {
                            AppRouter.push(
                              context,
                              PharmacyFilterPage(
                                isFromPharmacyPage: false,
                                callback: () {
                                  BlocProvider.of<HistoryCubit>(
                                    context,
                                  ).getRefundHistory(
                                    refundStatus: 2,
                                    number: searchController.text.isEmpty
                                        ? null
                                        : searchController.text,
                                    pharmacyFilterVmodel: pharmacyFilter,
                                  );
                                },
                              ),
                            );
                          },
                          trailingCloseTap: () {
                            pharmacyFilter.clear();
                            BlocProvider.of<HistoryCubit>(
                              context,
                            ).getRefundHistory(
                              refundStatus: 2,
                              number: searchController.text.isEmpty
                                  ? null
                                  : searchController.text,
                              pharmacyFilterVmodel: pharmacyFilter,
                            );
                          },
                        );
                      },
                    );
                  },
                ),
              ),

              //body
              Expanded(
                child: BlocConsumer<HistoryCubit, HistoryState>(
                  listener: (context, state) {
                    state.maybeWhen(
                      initialState: () {},
                      loadingState: () {},
                      orElse: () {},
                      pharmacyHistoryState: (orders) {},
                      warehouseHistoryState: (orders) {},
                      movingHistoryState: (orders) {},
                      refundHistoryState: (orders) {},
                      errorState: (String message) {
                        buildErrorCustomSnackBar(context, message);
                      },
                      movingHistoryBySearch:
                          (List<MoveDataDTO> pharmacyOrders) {},
                      pharmacyHistoryBySearch:
                          (List<PharmacyOrderDTO> pharmacyOrders) {},
                      refundHistoryBySearch:
                          (List<RefundDataDTO> pharmacyOrders) {},
                      warehouseHistoryBySearch:
                          (List<WarehouseOrderDTO> warehouseOrders) {},
                    );
                  },
                  builder: (context, state) {
                    return state.maybeWhen(
                      orElse: () {
                        return const Center(
                          child: CircularProgressIndicator(
                            color: Colors.red,
                          ),
                        );
                      },
                      pharmacyHistoryBySearch: (orders) {
                        return ListView.builder(
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
                                    HistoryScreenDetail(
                                      isFromPharmacyPage: true,
                                      pharmacyOrder: orders[index],
                                    ),
                                  );
                                },
                                child: SizedBox(
                                  child: BuildHistoryOrderData(
                                    orderNumber: '${orders[index].number}',
                                    orderId: orders[index].id,
                                    container: orders[index].container ?? 0,
                                    createdAt: orders[index].createdAt,
                                    counteragent: orders[index].provider,
                                  ),
                                ),
                              ),
                            );
                          },
                          itemCount: orders.length,
                          shrinkWrap: true,
                        );
                      },
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
                                .getPharmacyArrivalHistory(
                              number: searchController.text.isEmpty
                                  ? null
                                  : searchController.text,
                              pharmacyFilterVmodel: pharmacyFilter,
                            );
                            refreshController.refreshCompleted();
                          },
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
                                            HistoryScreenDetail(
                                              isFromPharmacyPage: true,
                                              pharmacyOrder: orders[index],
                                            ),
                                          );
                                        },
                                        child: SizedBox(
                                          child: BuildHistoryOrderData(
                                            pharmacyOrderDTO: orders[index],
                                            orderNumber:
                                                '${orders[index].number}',
                                            orderId: orders[index].id,
                                            container:
                                                orders[index].container ?? 0,
                                            createdAt: orders[index].createdAt,
                                            counteragent: orders[index].provider,
                                            incomingNumber:
                                                orders[index].incomingNumber,
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
                                .getWarehouseArrivalHistory();
                            refreshController.refreshCompleted();
                          },
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
                                            HistoryScreenDetail(
                                              isFromPharmacyPage: false,
                                              warehouseOrder: orders[index],
                                            ),
                                          );
                                        },
                                        child: BuildHistoryOrderData(
                                          orderNumber:
                                              '${orders[index].number}',
                                          orderId: orders[index].id,
                                          container:
                                              orders[index].container ?? 0,
                                          createdAt: orders[index].createdAt,
                                          counteragent:
                                              orders[index].provider,
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
                                .getMovingHistory();
                            refreshController.refreshCompleted();
                          },
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
                                            HistoryMoveScreenDetail(
                                              moveDataDTO: orders[index],
                                            ),
                                          );
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                            bottom: 16.0,
                                          ),
                                          child: Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(12),
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
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                      '№.${orders[index].id}',
                                                      style: ThemeTextStyle
                                                          .textStyle20w600,
                                                    ),
                                                    Container(
                                                      decoration: BoxDecoration(
                                                        color: const Color
                                                            .fromARGB(
                                                          255,
                                                          203,
                                                          211,
                                                          216,
                                                        ),
                                                        border: Border.all(
                                                          color: const Color
                                                              .fromARGB(
                                                            255,
                                                            94,
                                                            96,
                                                            97,
                                                          ),
                                                        ),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                          100,
                                                        ),
                                                      ),
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                        vertical: 4,
                                                        horizontal: 8,
                                                      ),
                                                      child: Center(
                                                        child: Text(
                                                          "Завершенный",
                                                          style: ThemeTextStyle
                                                              .textStyle12w600
                                                              .copyWith(
                                                            color: const Color
                                                                .fromARGB(
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
                                                BuildOrderDetailItem(
                                                  icon: "container_ic",
                                                  title: "Организация",
                                                  data: (orders[index]
                                                          .recipientId)
                                                      .toString(),
                                                ),
                                                BuildOrderDetailItem(
                                                  icon: "calendar_ic",
                                                  title: "Дата создания",
                                                  data:
                                                      orders[index].createdAt !=
                                                              null
                                                          ? DateFormat(
                                                              "dd.MM.yyyy; hh:mm a",
                                                            ).format(
                                                              DateTime.parse(
                                                                orders[index]
                                                                    .createdAt!,
                                                              ),
                                                            )
                                                          : "No data",
                                                ),
                                                BuildOrderDetailItem(
                                                  icon: "stock_ic",
                                                  title: "Отрпавитель",
                                                  data: orders[index]
                                                      .senderId
                                                      .toString(),
                                                ),
                                              ],
                                            ),
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
                      refundHistoryState: (List<PharmacyOrderDTO> orders) {
                        return SmartRefresher(
                          controller: refreshController,
                          onRefresh: () {
                            BlocProvider.of<HistoryCubit>(context)
                                .getRefundHistory(
                              refundStatus: 2,
                              number: searchController.text.isEmpty
                                  ? null
                                  : searchController.text,
                              pharmacyFilterVmodel: pharmacyFilter,
                            );
                            refreshController.refreshCompleted();
                          },
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
                                            ReturnDetailPage(
                                              pharmacyOrder: orders[index],
                                            ),
                                          );
                                        },
                                        child: SizedBox(
                                          child: BuildHistoryOrderData(
                                            incomingNumber:
                                                orders[index].incomingNumber,
                                            pharmacyOrderDTO: orders[index],
                                            orderNumber:
                                                '${orders[index].number}',
                                            orderId: orders[index].id,
                                            container:
                                                orders[index].container ?? 0,
                                            createdAt: orders[index].createdAt,
                                            counteragent: orders[index].provider,
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
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
