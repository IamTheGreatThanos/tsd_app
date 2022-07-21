import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:pharmacy_arrival/data/model/move_data_dto.dart';
import 'package:pharmacy_arrival/screens/move_data/move_orders_cubit/move_order_cat_cubit.dart';
import 'package:pharmacy_arrival/screens/move_data/move_orders_cubit/move_order_page_cubit.dart';
import 'package:pharmacy_arrival/styles/color_palette.dart';
import 'package:pharmacy_arrival/styles/text_styles.dart';
import 'package:pharmacy_arrival/widgets/app_loader_overlay.dart';
import 'package:pharmacy_arrival/widgets/custom_app_bar.dart';
import 'package:pharmacy_arrival/widgets/snackbar/custom_snackbars.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class MoveOrdersPage extends StatefulWidget {
  const MoveOrdersPage({Key? key}) : super(key: key);

  @override
  State<MoveOrdersPage> createState() => _MoveOrdersPageState();
}

class _MoveOrdersPageState extends State<MoveOrdersPage> {
  RefreshController refreshController = RefreshController();
  TextEditingController searchController = TextEditingController();
  int currentIndex = 0;
  int userId = 5;
  @override
  void initState() {
    BlocProvider.of<MoveOrderCatCubit>(context).changeToAcceptOrdersCat();
    BlocProvider.of<MoveOrderPageCubit>(context)
        .onRefreshOrders(recipientId: userId);
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
    return AppLoaderOverlay(
      child: Scaffold(
        appBar: CustomAppBar(
          title: "Перемещение".toUpperCase(),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 13,
            vertical: 15,
          ),
          child: Column(
            children: [
              const SizedBox(
                height: 16,
              ),
              SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12.5,
                ),
                scrollDirection: Axis.horizontal,
                child: BlocConsumer<MoveOrderCatCubit, MoveOrderCatState>(
                  listener: (context, state) {
                    state.when(
                      accept: () {
                        currentIndex = 0;
                        BlocProvider.of<MoveOrderPageCubit>(context)
                            .onRefreshOrders(
                          recipientId: userId,
                        );
                      },
                      send: () {
                        currentIndex = 1;
                        BlocProvider.of<MoveOrderPageCubit>(context)
                            .onRefreshOrders(
                          senderId: userId,
                        );
                      },
                    );
                  },
                  builder: (context, state) {
                    return Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            BlocProvider.of<MoveOrderCatCubit>(context)
                                .changeToAcceptOrdersCat();
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
                              "Необходимо принять",
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
                            BlocProvider.of<MoveOrderCatCubit>(context)
                                .changeToSendCat();
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
                                  "Отрпавленные",
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
                  child: BlocConsumer<MoveOrderPageCubit, MoveOrderPageState>(
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
                            child:
                                CircularProgressIndicator(color: Colors.amber),
                          );
                        },
                        loadedState: (orders) {
                          return SmartRefresher(
                            enablePullUp: true,
                            onLoading: () {
                              currentIndex == 0
                                  ? BlocProvider.of<MoveOrderPageCubit>(
                                      context,
                                    ).onLoadOrders(
                                      recipientId: userId,
                                    )
                                  : BlocProvider.of<MoveOrderPageCubit>(
                                      context,
                                    ).onLoadOrders(
                                      senderId: userId,
                                    );

                              refreshController.loadComplete();
                            },
                            onRefresh: () {
                              currentIndex == 0
                                  ? BlocProvider.of<MoveOrderPageCubit>(
                                      context,
                                    ).onRefreshOrders(recipientId: userId)
                                  : BlocProvider.of<MoveOrderPageCubit>(
                                      context,
                                    ).onRefreshOrders(senderId: userId);
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
                                        currentIndex: currentIndex,
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
  }
}

class _BuildOrderData extends StatelessWidget {
  final int currentIndex;
  final MoveDataDTO orderData;

  const _BuildOrderData({
    Key? key,
    required this.orderData,
    required this.currentIndex,
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
                Expanded(
                  child: Text(
                    "№.${orderData.id} ${orderData.id}",
                    style: ThemeTextStyle.textStyle20w600,
                  ),
                ),
                // Container(
                //   decoration: BoxDecoration(
                //     color: orderData.status == 1
                //         ? ColorPalette.lightGreen
                //         : ColorPalette.lightYellow,
                //     border: Border.all(
                //       color: orderData.status == 1
                //           ? ColorPalette.borderGreen
                //           : ColorPalette.borderYellow,
                //     ),
                //     borderRadius: BorderRadius.circular(100),
                //   ),
                //   padding:
                //       const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                //   child: Center(
                //     child: Text(
                //         orderData.status == 1
                //             ? "Новый заказ"
                //             : "Активный заказ",
                //         style: ThemeTextStyle.textStyle12w600.copyWith(
                //           color: orderData.status == 1
                //               ? ColorPalette.textGreen
                //               : ColorPalette.textYellow,
                //         ),
                //         textAlign: TextAlign.center),
                //   ),
                // ),
              ],
            ),
            const SizedBox(
              height: 27,
            ),
            // if (orderData.status != 1)
            // const _BuildOrderDetailItem(
            //   icon: "divergence",
            //   title: "Товары на расхождении",
            //   data: "5",
            // ),

            _BuildOrderDetailItem(
              icon: "calendar_ic",
              title: "Время отпр.",
              data: orderData.createdAt != null
                  ? DateFormat("dd.MM.yyyy; hh:mm")
                      .format(DateTime.parse('${orderData.createdAt}'))
                  : "No data",
            ),
            // _BuildOrderDetailItem(
            //   icon: "user_star_ic",
            //   title: orderData.status == 1 ? "Отправитель" : "Контрагент",
            //   data: "${orderData.sender?.name}",
            //   hasImage: true,
            // ),
            // _BuildOrderDetailItem(
            //   icon: "document",
            //   title: "Сумма",
            //   data: "${moneyFormatter(orderData.amount.toString())} ₸",
            // ),
            const SizedBox(
              height: 24,
            ),

            if (orderData.send == 1)
              _BuildOrderDetailItem(
                icon: "clock",
                title: "Время отправки",
                data: "${orderData.date}",
              ),
            _BuildOrderDetailItem(
              icon: "messages",
              title: "Коментарий",
              data: "${orderData.comment}",
            ),
            const SizedBox(
              height: 12,
            ),
            if (currentIndex == 0)
              GestureDetector(
                onTap: () {},
                child: Container(
                  height: 44,
                  padding: const EdgeInsets.symmetric(vertical: 6),
                  decoration: BoxDecoration(
                    color: ColorPalette.orange,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Center(
                    child: Text(
                      orderData.accept == 0
                          ? "Оприходовать"
                          : "Посмотреть детали заказа",
                      style: ThemeTextStyle.textStyle14w600
                          .copyWith(color: ColorPalette.white),
                    ),
                  ),
                ),
              )
            else
              GestureDetector(
                onTap: () {},
                child: Container(
                  height: 44,
                  padding: const EdgeInsets.symmetric(vertical: 6),
                  decoration: BoxDecoration(
                    color: ColorPalette.orange,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Center(
                    child: Text(
                      orderData.send == 0
                          ? "Продолжить перемещение"
                          : "Посмотреть детали заказа",
                      style: ThemeTextStyle.textStyle14w600
                          .copyWith(color: ColorPalette.white),
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

class _BuildOrderDetailItem extends StatelessWidget {
  final String icon;
  final String title;
  final String data;
  final bool hasImage;

  const _BuildOrderDetailItem({
    Key? key,
    required this.icon,
    required this.title,
    required this.data,
    this.hasImage = false,
  }) : super(key: key);

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
