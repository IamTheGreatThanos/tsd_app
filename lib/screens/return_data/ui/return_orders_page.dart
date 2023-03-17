import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:pharmacy_arrival/core/styles/color_palette.dart';
import 'package:pharmacy_arrival/core/styles/text_styles.dart';
import 'package:pharmacy_arrival/core/utils/app_router.dart';
import 'package:pharmacy_arrival/core/utils/constants.dart';
import 'package:pharmacy_arrival/data/model/pharmacy_order_dto.dart';
import 'package:pharmacy_arrival/screens/pharmacy_arrival/ui/pharmacy_filter_page.dart';
import 'package:pharmacy_arrival/screens/pharmacy_arrival/vmodel/pharmacy_filter_vmodel.dart';
import 'package:pharmacy_arrival/screens/return_data/return_cubit/return_order_cat_cubit.dart';
import 'package:pharmacy_arrival/screens/return_data/return_cubit/return_order_page_cubit.dart';
import 'package:pharmacy_arrival/screens/return_data/ui/return_data_screen.dart';
import 'package:pharmacy_arrival/screens/return_data/ui/return_detail_page.dart';
import 'package:pharmacy_arrival/widgets/app_loader_overlay.dart';
import 'package:pharmacy_arrival/widgets/custom_app_bar.dart';
import 'package:pharmacy_arrival/widgets/filter/pharmacy_filter_widget.dart';
import 'package:pharmacy_arrival/widgets/main_text_field/app_text_field.dart';
import 'package:pharmacy_arrival/widgets/snackbar/custom_snackbars.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class ReturnOrdersPage extends StatefulWidget {
  const ReturnOrdersPage();

  @override
  State<ReturnOrdersPage> createState() => _ReturnOrdersPageState();
}

class _ReturnOrdersPageState extends State<ReturnOrdersPage> {
  RefreshController refreshController = RefreshController();
  TextEditingController searchController = TextEditingController();
  int currentIndex = 0;
  int status = 1;
  TextEditingController invoiceDateController = TextEditingController();
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<PharmacyFilterVmodel>(
        context,
        listen: false,
      ).clear();
    });
    BlocProvider.of<ReturnOrderCatCubit>(context).changeToActiveOrdersCat();
    BlocProvider.of<ReturnOrderPageCubit>(context)
        .onRefreshOrders(refundStatus: status);
    super.initState();
  }

  @override
  void dispose() {
    searchController.dispose();
    FocusNode().dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<PharmacyFilterVmodel>(
      builder: (context, model, child) {
        return AppLoaderOverlay(
          child: Scaffold(
            floatingActionButton: SizedBox(
              height: 80,
              width: 80,
              child: FloatingActionButton(
                onPressed: () {
                  AppRouter.push(
                    context,
                    const ReturnDataScreen(),
                  );
                },
                backgroundColor: ColorPalette.orange,
                child: SvgPicture.asset("assets/images/svg/move_plus.svg"),
              ),
            ),
            appBar: CustomAppBar(
              title: "Возврат".toUpperCase(),
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
                          BlocProvider.of<ReturnOrderPageCubit>(context);

                      if (value.isNotEmpty) {
                        productCubit.onRefreshOrders(
                          number: searchController.text,
                          refundStatus: status,
                          incomingDate: model.incomingDate,
                          incomingNumber: model.incomingNumber,
                          senderId: model.sender?.id,
                          departureDate: model.departureDate,
                          sortType: model.sortType,
                          amountStart: model.amountStart,
                          amountEnd: model.amountEnd,
                        );
                      } else {
                        productCubit.onRefreshOrders(
                          refundStatus: status,
                          incomingDate: model.incomingDate,
                          incomingNumber: model.incomingNumber,
                          senderId: model.sender?.id,
                          departureDate: model.departureDate,
                          sortType: model.sortType,
                          amountStart: model.amountStart,
                          amountEnd: model.amountEnd,
                        );
                      }
                    },
                    onChanged: (String? text) {
                      final productCubit =
                          BlocProvider.of<ReturnOrderPageCubit>(context);

                      if (text != null) {
                        productCubit.onRefreshOrders(
                          number: searchController.text,
                          refundStatus: status,
                          incomingDate: model.incomingDate,
                          incomingNumber: model.incomingNumber,
                          senderId: model.sender?.id,
                          departureDate: model.departureDate,
                          sortType: model.sortType,
                          amountStart: model.amountStart,
                          amountEnd: model.amountEnd,
                        );
                      }
                      if (text == null || text.isEmpty) {
                        productCubit.onRefreshOrders(
                          refundStatus: status,
                          incomingDate: model.incomingDate,
                          incomingNumber: model.incomingNumber,
                          senderId: model.sender?.id,
                          departureDate: model.departureDate,
                          sortType: model.sortType,
                          amountStart: model.amountStart,
                          amountEnd: model.amountEnd,
                        );
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
                      top: 18,
                      bottom: 18,
                      left: 13,
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  PharmacyFilterWidget(
                    onTap: () {
                      AppRouter.push(
                        context,
                        PharmacyFilterPage(
                          isFromPharmacyPage: false,
                          callback: () {
                            BlocProvider.of<ReturnOrderPageCubit>(
                              context,
                            ).onRefreshOrders(
                              number: searchController.text.isEmpty
                                  ? null
                                  : searchController.text,
                              refundStatus: status,
                              incomingDate: model.incomingDate,
                              incomingNumber: model.incomingNumber,
                              senderId: model.sender?.id,
                              departureDate: model.departureDate,
                              sortType: model.sortType,
                              amountStart: model.amountStart,
                              amountEnd: model.amountEnd,
                            );
                          },
                        ),
                      );
                    },
                    trailingCloseTap: () {
                      model.clear();
                      BlocProvider.of<ReturnOrderPageCubit>(
                        context,
                      ).onRefreshOrders(
                        number: searchController.text.isEmpty
                            ? null
                            : searchController.text,
                        refundStatus: status,
                        incomingDate: model.incomingDate,
                        incomingNumber: model.incomingNumber,
                        senderId: model.sender?.id,
                        departureDate: model.departureDate,
                        sortType: model.sortType,
                        amountStart: model.amountStart,
                        amountEnd: model.amountEnd,
                      );
                    },
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12.5,
                    ),
                    scrollDirection: Axis.horizontal,
                    child:
                        BlocConsumer<ReturnOrderCatCubit, ReturnOrderCatState>(
                      listener: (context, state) {
                        state.when(
                          activeOrdersCatState: () {
                            currentIndex = 0;
                            status = 1;
                            BlocProvider.of<ReturnOrderPageCubit>(
                              context,
                            ).onRefreshOrders(
                              number: searchController.text.isEmpty
                                  ? null
                                  : searchController.text,
                              refundStatus: status,
                              incomingDate: model.incomingDate,
                              incomingNumber: model.incomingNumber,
                              senderId: model.sender?.id,
                              departureDate: model.departureDate,
                              sortType: model.sortType,
                              amountStart: model.amountStart,
                              amountEnd: model.amountEnd,
                            );
                          },
                          finishedCatState: () {
                            currentIndex = 1;
                            status = 2;
                            BlocProvider.of<ReturnOrderPageCubit>(
                              context,
                            ).onRefreshOrders(
                              number: searchController.text.isEmpty
                                  ? null
                                  : searchController.text,
                              refundStatus: status,
                              incomingDate: model.incomingDate,
                              incomingNumber: model.incomingNumber,
                              senderId: model.sender?.id,
                              departureDate: model.departureDate,
                              sortType: model.sortType,
                              amountStart: model.amountStart,
                              amountEnd: model.amountEnd,
                            );
                          },
                        );
                      },
                      builder: (context, state) {
                        return Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                BlocProvider.of<ReturnOrderCatCubit>(context)
                                    .changeToActiveOrdersCat();
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
                                  "Активные возвраты",
                                  style:
                                      ThemeTextStyle.textStyle14w500.copyWith(
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
                                BlocProvider.of<ReturnOrderCatCubit>(context)
                                    .changeToFinishedCat();
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
                                      "Завершенные возвраты",
                                      style: ThemeTextStyle.textStyle14w500
                                          .copyWith(
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
                      child: BlocConsumer<ReturnOrderPageCubit,
                          ReturnOrderPageState>(
                        listener: (context, state) {
                          state.when(
                            initialState: () {},
                            loadingState: () {},
                            loadedState: (orders) {},
                            byFilterState: (orders) {},
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
                            byFilterState: (orders) {
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
                            loadedState: (orders) {
                              return SmartRefresher(
                                enablePullUp: true,
                                onLoading: () {
                                  BlocProvider.of<ReturnOrderPageCubit>(
                                    context,
                                  ).onLoadOrders(
                                    number: searchController.text.isEmpty
                                        ? null
                                        : searchController.text,
                                    refundStatus: status,
                                    incomingDate: model.incomingDate,
                                    incomingNumber: model.incomingNumber,
                                    senderId: model.sender?.id,
                                    departureDate: model.departureDate,
                                    sortType: model.sortType,
                                    amountStart: model.amountStart,
                                    amountEnd: model.amountEnd,
                                  );
                                  refreshController.loadComplete();
                                },
                                onRefresh: () {
                                  BlocProvider.of<ReturnOrderPageCubit>(
                                    context,
                                  ).onRefreshOrders(
                                    number: searchController.text.isEmpty
                                        ? null
                                        : searchController.text,
                                    refundStatus: status,
                                    incomingDate: model.incomingDate,
                                    incomingNumber: model.incomingNumber,
                                    senderId: model.sender?.id,
                                    departureDate: model.departureDate,
                                    sortType: model.sortType,
                                    amountStart: model.amountStart,
                                    amountEnd: model.amountEnd,
                                  );
                                  refreshController.refreshCompleted();
                                },
                                controller: refreshController,
                                child: orders.isEmpty
                                    ? ListView(
                                        children: [
                                          SizedBox(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
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
          ),
        );
      },
    );
  }
}

class _BuildOrderData extends StatelessWidget {
  final PharmacyOrderDTO orderData;

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
                Expanded(
                  child: Text(
                    "№ ${orderData.number}",
                    style: ThemeTextStyle.textStyle20w600,
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: orderData.refundStatus == 1 ||
                            orderData.refundStatus == 0
                        ? ColorPalette.lightGreen
                        : ColorPalette.lightYellow,
                    border: Border.all(
                      color: orderData.refundStatus == 1 ||
                              orderData.refundStatus == 0
                          ? ColorPalette.borderGreen
                          : ColorPalette.borderYellow,
                    ),
                    borderRadius: BorderRadius.circular(100),
                  ),
                  padding:
                      const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                  child: Center(
                    child: Text(
                      orderData.refundStatus == 1 || orderData.refundStatus == 0
                          ? "Активный возврат"
                          : orderData.refundStatus == 2
                              ? "Завершенный\nвозврат"
                              : "Ошибка статуса",
                      style: ThemeTextStyle.textStyle12w600.copyWith(
                        color: orderData.refundStatus == 1 ||
                                orderData.refundStatus == 0
                            ? ColorPalette.textGreen
                            : ColorPalette.textYellow,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 27,
            ),

            _BuildOrderDetailItem(
              icon: "divergence",
              title: "Входяящий номер",
              data: "${orderData.incomingNumber}",
            ),
            _BuildOrderDetailItem(
              icon: "container_ic",
              title: "Контейнеров",
              data: (orderData.container ?? 0).toString(),
            ),
            _BuildOrderDetailItem(
              icon: "calendar_ic",
              title: "Дата создания.",
              data: orderData.createdAt != null
                  ? DateFormat("dd.MM.yyyy; hh:mm")
                      .format(DateTime.parse('${orderData.createdAt}'))
                  : "No data",
            ),
            _BuildOrderDetailItem(
              icon: "calendar_ic",
              title: "Дата накладной.",
              data: orderData.incomingDate != null
                  ? DateFormat("dd.MM.yyyy")
                      .format(DateTime.parse('${orderData.incomingDate}'))
                  : "No data",
            ),
            _BuildOrderDetailItem(
              icon: "user_star_ic",
              title: orderData.status == 1 ? "Отправитель" : "Контрагент",
              data: "${orderData.sender?.name}",
              hasImage: true,
            ),
            _BuildOrderDetailItem(
              icon: "document",
              title: "Сумма",
              data: "${moneyFormatter(orderData.amount.toString())} ₸",
            ),
            const SizedBox(
              height: 24,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 3),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 16,
                        height: 16,
                        decoration: BoxDecoration(
                          color: ColorPalette.white,
                          borderRadius: BorderRadius.circular(100),
                          border: Border.all(
                            width: 5,
                            color: ColorPalette.textYellow,
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      Expanded(
                        child: RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: "${orderData.fromAddress}, ",
                                style: ThemeTextStyle.textStyle16w500,
                              ),
                              TextSpan(
                                text: orderData.fromCityName,
                                style: ThemeTextStyle.textStyle14w400.copyWith(
                                  color: ColorPalette.grey400,
                                ),
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                  // SizedBox(
                  //   height: 20,
                  // ),
                  Container(
                    padding: const EdgeInsets.only(left: 7),
                    height: 20,
                    child: const DottedLine(
                      dashColor: ColorPalette.dashGrey,
                      direction: Axis.vertical,
                    ),
                  ),
                  Row(
                    children: [
                      Container(
                        width: 16,
                        height: 16,
                        decoration: BoxDecoration(
                          color: ColorPalette.white,
                          borderRadius: BorderRadius.circular(100),
                          border: Border.all(
                            width: 5,
                            color: ColorPalette.orange,
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      Expanded(
                        child: RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: "${orderData.toAddress}, ",
                                style: ThemeTextStyle.textStyle14w400,
                              ),
                              TextSpan(
                                text: orderData.toCityName,
                                style: ThemeTextStyle.textStyle14w400.copyWith(
                                  color: ColorPalette.grey400,
                                ),
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 21,
            ),
            // _BuildOrderDetailItem(
            //   icon: "messages",
            //   title: "Статус",
            //   data: "${totalStatuses[orderData.totalStatus]}",
            // ),
            // _BuildOrderDetailItem(
            //   icon: "clock",
            //   title: "Время доставки",
            //   data: "${orderData.yandexTime}",
            // ),
            // const SizedBox(
            //   height: 12,
            // ),
            if (orderData.totalStatus == 3 || orderData.totalStatus == 4)
              GestureDetector(
                onTap: () {
                  AppRouter.push(
                    context,
                    ReturnDetailPage(
                      pharmacyOrder: orderData,
                    ),
                  );
                },
                child: Container(
                  height: 44,
                  padding: const EdgeInsets.symmetric(vertical: 6),
                  decoration: BoxDecoration(
                    color: ColorPalette.orange,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Center(
                    child: Text(
                      orderData.refundStatus == 0
                          ? "Начать возврат"
                          : orderData.refundStatus == 1
                              ? "Продолжить возврат"
                              : "Посмотреть детали возврата",
                      style: ThemeTextStyle.textStyle14w600
                          .copyWith(color: ColorPalette.white),
                    ),
                  ),
                ),
              )
            else
              const SizedBox(),
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
  final bool hasImage;

  const _BuildOrderDetailItem({
    required this.icon,
    required this.title,
    required this.data,
    this.hasImage = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: Row(
        children: [
          SvgPicture.asset(
            "assets/images/svg/$icon.svg",
            height: 18,
            width: 18,
          ),
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
          const SizedBox(
            width: 12,
          ),
          if (hasImage)
            Image.asset(
              "assets/images/png/akniet_stock.png",
              width: 32,
              height: 32,
            ),
        ],
      ),
    );
  }
}
