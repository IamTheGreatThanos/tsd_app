import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:pharmacy_arrival/app/bloc/counteragent_cubit.dart';
import 'package:pharmacy_arrival/app/bloc/counteragent_of_user_cubit.dart';
import 'package:pharmacy_arrival/app/bloc/profile_cubit.dart';
import 'package:pharmacy_arrival/core/styles/color_palette.dart';
import 'package:pharmacy_arrival/core/styles/text_styles.dart';
import 'package:pharmacy_arrival/core/utils/app_router.dart';
import 'package:pharmacy_arrival/data/model/move_data_dto.dart';
import 'package:pharmacy_arrival/locator_serviece.dart';
import 'package:pharmacy_arrival/screens/goods_list/ui/move_goods_list_screen.dart';
import 'package:pharmacy_arrival/screens/history/ui/history_move_screen_detail.dart';
import 'package:pharmacy_arrival/screens/move_data/move_orders_cubit/move_order_cat_cubit.dart';
import 'package:pharmacy_arrival/screens/move_data/move_orders_cubit/move_order_page_cubit.dart';
import 'package:pharmacy_arrival/screens/move_data/ui/move_data_screen.dart';
import 'package:pharmacy_arrival/screens/move_data/ui/move_filter_page.dart';
import 'package:pharmacy_arrival/screens/move_data/ui/move_products_screen.dart';
import 'package:pharmacy_arrival/screens/move_data/vmodel/move_filter_vmodel.dart';
import 'package:pharmacy_arrival/widgets/app_loader_overlay.dart';
import 'package:pharmacy_arrival/widgets/custom_app_bar.dart';
import 'package:pharmacy_arrival/widgets/filter/move_filter_widget.dart';
import 'package:pharmacy_arrival/widgets/snackbar/custom_snackbars.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class MoveOrdersPage extends StatefulWidget {
  const MoveOrdersPage();

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
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<MoveFilterVmodel>(
        context,
        listen: false,
      ).clear();
    });
    BlocProvider.of<MoveOrderCatCubit>(context).changeToAcceptOrdersCat();
    BlocProvider.of<MoveOrderPageCubit>(context).onRefreshOrders(
      accept: 0,
      //recipientId: userId
    );
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
    return Consumer<MoveFilterVmodel>(
      builder: (context, model, child) {
        return AppLoaderOverlay(
          child: Scaffold(
            floatingActionButton: SizedBox(
              height: 80,
              width: 80,
              child: BlocBuilder<ProfileCubit, ProfileState>(
                builder: (context, state) {
                  return FloatingActionButton(
                    onPressed: () {
                      AppRouter.push(
                        context,
                        BlocProvider(
                          create: (context) => CounteragentOfUserCubit(sl())
                            ..loadCounteragents(
                              userId: state.whenOrNull(
                                loadedState: (user) => user.id,
                              ),
                            ),
                          child: const MoveDataScreen(),
                        ),
                      );
                    },
                    backgroundColor: ColorPalette.orange,
                    child: SvgPicture.asset("assets/images/svg/move_plus.svg"),
                  );
                },
              ),
            ),
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
                  MoveFilterWidget(
                    onTap: () {
                      AppRouter.push(
                        context,
                        MoveFilterPage(
                          callback: () {
                            switch (currentIndex) {
                              case 0:
                                BlocProvider.of<MoveOrderPageCubit>(
                                  context,
                                ).onRefreshOrders(
                                  sortType: model.sortType,
                                  accept: 0,
                                  recipientId: model.recipient?.id,
                                  senderId: model.sender?.id,
                                  date: model.date,
                                  //  recipientId: userId
                                );
                                break;
                              case 1:
                                BlocProvider.of<MoveOrderPageCubit>(
                                  context,
                                ).onRefreshOrders(
                                  sortType: model.sortType,
                                  recipientId: model.recipient?.id,
                                  senderId: model.sender?.id,
                                  date: model.date,
                                  //  senderId: userId
                                );
                                break;
                              case 2:
                                BlocProvider.of<MoveOrderPageCubit>(
                                  context,
                                ).onRefreshOrders(
                                  sortType: model.sortType,
                                  recipientId: model.recipient?.id,
                                  senderId: model.sender?.id,
                                  date: model.date,
                                  accept: 1,
                                  send: 1,
                                  // senderId: userId,
                                );
                                break;
                              default:
                            }
                          },
                        ),
                      );
                    },
                    trailingCloseTap: () {
                      model.clear();
                      switch (currentIndex) {
                        case 0:
                          BlocProvider.of<MoveOrderPageCubit>(
                            context,
                          ).onRefreshOrders(
                            sortType: model.sortType,
                            accept: 0,
                            recipientId: model.recipient?.id,
                            senderId: model.sender?.id,
                            date: model.date,
                            //  recipientId: userId
                          );
                          break;
                        case 1:
                          BlocProvider.of<MoveOrderPageCubit>(
                            context,
                          ).onRefreshOrders(
                            sortType: model.sortType,
                            recipientId: model.recipient?.id,
                            senderId: model.sender?.id,
                            date: model.date,
                            //  senderId: userId
                          );
                          break;
                        case 2:
                          BlocProvider.of<MoveOrderPageCubit>(
                            context,
                          ).onRefreshOrders(
                            sortType: model.sortType,
                            recipientId: model.recipient?.id,
                            senderId: model.sender?.id,
                            date: model.date,
                            accept: 1,
                            send: 1,
                            // senderId: userId,
                          );
                          break;
                        default:
                      }
                    },
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: BlocConsumer<MoveOrderCatCubit, MoveOrderCatState>(
                      listener: (context, state) {
                        state.when(
                          accept: () {
                            currentIndex = 0;
                            BlocProvider.of<MoveOrderPageCubit>(context)
                                .onRefreshOrders(
                              sortType: model.sortType,
                              recipientId: model.recipient?.id,
                              senderId: model.sender?.id,
                              date: model.date,
                              accept: 0,
                              //recipientId: userId,
                            );
                          },
                          send: () {
                            currentIndex = 1;
                            BlocProvider.of<MoveOrderPageCubit>(context)
                                .onRefreshOrders(
                              recipientId: model.recipient?.id,
                              senderId: model.sender?.id,
                              date: model.date,
                              sortType: model.sortType,
                              // senderId: userId,
                            );
                          },
                          alreadyAccepted: () {
                            currentIndex = 2;
                            BlocProvider.of<MoveOrderPageCubit>(context)
                                .onRefreshOrders(
                              recipientId: model.recipient?.id,
                              senderId: model.sender?.id,
                              date: model.date,
                              accept: 1, send: 1,
                              sortType: model.sortType,
                              // senderId: userId,
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
                              width: 10,
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
                            const SizedBox(
                              width: 10,
                            ),
                            GestureDetector(
                              onTap: () {
                                BlocProvider.of<MoveOrderCatCubit>(context)
                                    .changeToAlreadyAcceptedCat();
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 8,
                                  horizontal: 16,
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
                                      "Принятые",
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
                      child:
                          BlocConsumer<MoveOrderPageCubit, MoveOrderPageState>(
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
                            loadedState: (orders) {
                              return SmartRefresher(
                                enablePullUp: true,
                                onLoading: () {
                                  switch (currentIndex) {
                                    case 0:
                                      BlocProvider.of<MoveOrderPageCubit>(
                                        context,
                                      ).onLoadOrders(
                                        sortType: model.sortType,
                                        recipientId: model.recipient?.id,
                                        senderId: model.sender?.id,
                                        date: model.date,
                                        accept: 0,
                                        // recipientId: userId,
                                      );
                                      break;
                                    case 1:
                                      BlocProvider.of<MoveOrderPageCubit>(
                                        context,
                                      ).onLoadOrders(
                                        sortType: model.sortType,
                                        recipientId: model.recipient?.id,
                                        senderId: model.sender?.id,
                                        date: model.date,
                                        // senderId: userId,
                                      );
                                      break;
                                    case 2:
                                      BlocProvider.of<MoveOrderPageCubit>(
                                        context,
                                      ).onLoadOrders(
                                        sortType: model.sortType,
                                        recipientId: model.recipient?.id,
                                        senderId: model.sender?.id,
                                        date: model.date,
                                        accept: 1,
                                        send: 1,
                                        // senderId: userId,
                                      );
                                      break;
                                    default:
                                  }

                                  refreshController.loadComplete();
                                },
                                onRefresh: () {
                                  switch (currentIndex) {
                                    case 0:
                                      BlocProvider.of<MoveOrderPageCubit>(
                                        context,
                                      ).onRefreshOrders(
                                        sortType: model.sortType,
                                        recipientId: model.recipient?.id,
                                        senderId: model.sender?.id,
                                        date: model.date,
                                        accept: 0,
                                        //  recipientId: userId
                                      );
                                      break;
                                    case 1:
                                      BlocProvider.of<MoveOrderPageCubit>(
                                        context,
                                      ).onRefreshOrders(
                                        sortType: model.sortType,
                                        recipientId: model.recipient?.id,
                                        senderId: model.sender?.id,
                                        date: model.date,
                                        //  senderId: userId
                                      );
                                      break;
                                    case 2:
                                      BlocProvider.of<MoveOrderPageCubit>(
                                        context,
                                      ).onRefreshOrders(
                                        sortType: model.sortType,
                                        recipientId: model.recipient?.id,
                                        senderId: model.sender?.id,
                                        date: model.date,
                                        accept: 1,
                                        send: 1,
                                        // senderId: userId,
                                      );
                                      break;
                                    default:
                                  }
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
      },
    );
  }
}

class _BuildOrderData extends StatelessWidget {
  final int currentIndex;
  final MoveDataDTO orderData;

  const _BuildOrderData({
    required this.orderData,
    required this.currentIndex,
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
                    "№.${orderData.id}",
                    style: ThemeTextStyle.textStyle20w600,
                  ),
                ),
                if (currentIndex == 0 || currentIndex == 2)
                  Container(
                    decoration: BoxDecoration(
                      color: orderData.accept == 0
                          ? ColorPalette.lightGreen
                          : ColorPalette.lightYellow,
                      border: Border.all(
                        color: orderData.accept == 0
                            ? ColorPalette.borderGreen
                            : ColorPalette.borderYellow,
                      ),
                      borderRadius: BorderRadius.circular(100),
                    ),
                    padding:
                        const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                    child: Center(
                      child: Text(
                        orderData.accept == 0
                            ? orderData.send == 0
                                ? "Не отправлен"
                                : "Необходимо принять"
                            : "Уже принят",
                        style: ThemeTextStyle.textStyle12w600.copyWith(
                          color: orderData.accept == 0
                              ? ColorPalette.textGreen
                              : ColorPalette.textYellow,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  )
                else
                  Container(
                    decoration: BoxDecoration(
                      color: orderData.send == 1
                          ? ColorPalette.lightGreen
                          : ColorPalette.lightYellow,
                      border: Border.all(
                        color: orderData.send == 1
                            ? ColorPalette.borderGreen
                            : ColorPalette.borderYellow,
                      ),
                      borderRadius: BorderRadius.circular(100),
                    ),
                    padding:
                        const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                    child: Center(
                      child: Text(
                        orderData.send == 1 ? "Отправлен" : "Не отправлен",
                        style: ThemeTextStyle.textStyle12w600.copyWith(
                          color: orderData.send == 1
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
            // if (orderData.status != 1)
            // const _BuildOrderDetailItem(
            //   icon: "divergence",
            //   title: "Товары на расхождении",
            //   data: "5",
            // ),

            _BuildOrderDetailItem(
              icon: "calendar_ic",
              title: "Время создания",
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
            if (orderData.comment == null)
              const SizedBox()
            else
              _BuildOrderDetailItem(
                icon: "messages",
                title: "Коментарий",
                data: "${orderData.comment}",
              ),
            const SizedBox(
              height: 12,
            ),
            if (currentIndex == 0 || currentIndex == 2)
              GestureDetector(
                onTap: () {
                  if (orderData.accept == 0) {
                    if (orderData.send == 0) {
                      buildErrorCustomSnackBar(
                        context,
                        "Заказ еще не отправлен",
                      );
                    } else {
                      AppRouter.push(
                        context,
                        MoveGoodsListScreen(
                          moveDataDTO: orderData,
                        ),
                      );
                    }
                  } else {
                    AppRouter.push(
                      context,
                      HistoryMoveScreenDetail(moveDataDTO: orderData),
                    );
                  }
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
                      orderData.accept == 0
                          ? orderData.send == 0
                              ? "Заказ еще не отрпавлен"
                              : "Оприходовать"
                          : "Посмотреть детали заказа",
                      style: ThemeTextStyle.textStyle14w600
                          .copyWith(color: ColorPalette.white),
                    ),
                  ),
                ),
              )
            else
              GestureDetector(
                onTap: () {
                  AppRouter.push(
                    context,
                    MoveProductsScreen(
                      moveDataDTO: orderData,
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
