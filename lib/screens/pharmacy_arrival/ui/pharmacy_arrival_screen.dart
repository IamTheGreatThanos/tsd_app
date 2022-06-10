import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:pharmacy_arrival/data/model/pharmacy_order_dto.dart';
import 'package:pharmacy_arrival/screens/common/goods_list/ui/goods_list_screen.dart';
import 'package:pharmacy_arrival/screens/common/ui/_vmodel.dart';
import 'package:pharmacy_arrival/screens/common/ui/fill_invoice_screen.dart';
import 'package:pharmacy_arrival/screens/pharmacy_arrival/cubit/pharmacy_arrival_cat_cubit.dart';
import 'package:pharmacy_arrival/screens/pharmacy_arrival/cubit/pharmacy_arrival_screen_cubit.dart';
import 'package:pharmacy_arrival/screens/pharmacy_arrival/ui/pharmacy_qr_screen.dart';
import 'package:pharmacy_arrival/styles/color_palette.dart';
import 'package:pharmacy_arrival/styles/text_styles.dart';
import 'package:pharmacy_arrival/utils/app_router.dart';
import 'package:pharmacy_arrival/widgets/app_loader_overlay.dart';
import 'package:pharmacy_arrival/widgets/custom_app_bar.dart';
import 'package:pharmacy_arrival/widgets/main_text_field/app_text_field.dart';
import 'package:pharmacy_arrival/widgets/snackbar/custom_snackbars.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:url_launcher/url_launcher.dart';

class PharmacyArrivalScreen extends StatefulWidget {
  const PharmacyArrivalScreen({Key? key}) : super(key: key);

  @override
  State<PharmacyArrivalScreen> createState() => _PharmacyArrivalScreenState();
}

class _PharmacyArrivalScreenState extends State<PharmacyArrivalScreen> {
  RefreshController refreshController = RefreshController();
  TextEditingController searchController = TextEditingController();
  int currentIndex = 0;
  int status = 1;
  @override
  void initState() {
    BlocProvider.of<PharmacyArrivalScreenCubit>(context)
        .onRefreshOrders(status: status);
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
        floatingActionButton: SizedBox(
          height: 80,
          width: 80,
          child: FloatingActionButton(
            onPressed: () {
              AppRouter.push(context, const PharmacyQrScreen());
            },
            child: Image.asset(
              'assets/images/png/scan_button.png',
              fit: BoxFit.fill,
            ),
            //  Container(
            //   decoration: const BoxDecoration(
            //     image: DecorationImage(
            //       image: AssetImage(
            //         'assets/images/png/scan_button.png',
            //       ),
            //       fit: BoxFit.cover,
            //     ),
            //   ),
            // ),
          ),
        ),
        appBar: CustomAppBar(
          title: "Приход аптека".toUpperCase(),
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
                      BlocProvider.of<PharmacyArrivalScreenCubit>(context);

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
                      BlocProvider.of<PharmacyArrivalScreenCubit>(context);

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
                  color: ColorPalette.grey400,
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
                child: BlocConsumer<PharmacyArrivalCatCubit,
                    PharmacyArrivalCatState>(
                  listener: (context, state) {
                    state.when(
                      newOrdersCatState: () {
                        currentIndex = 0;
                        status = 1;
                        BlocProvider.of<PharmacyArrivalScreenCubit>(context)
                            .onRefreshOrders(status: status);
                      },
                      discrepancyCatState: () {
                        currentIndex = 1;
                        status = 2;
                        BlocProvider.of<PharmacyArrivalScreenCubit>(context)
                            .onRefreshOrders(status: status);
                      },
                    );
                  },
                  builder: (context, state) {
                    return Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            BlocProvider.of<PharmacyArrivalCatCubit>(context)
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
                            BlocProvider.of<PharmacyArrivalCatCubit>(context)
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
                  child: BlocConsumer<PharmacyArrivalScreenCubit,
                      PharmacyArrivalScreenState>(
                    listener: (context, state) {
                      state.when(
                        initialState: () {},
                        loadingState: () {},
                        loadedState: (orders) {},
                        bySearch: (orders) {},
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
                        loadedState: (orders) {
                          return SmartRefresher(
                            enablePullUp: true,
                            onLoading: () {
                              BlocProvider.of<PharmacyArrivalScreenCubit>(
                                      context)
                                  .onLoadOrders(status: status);
                              refreshController.loadComplete();
                            },
                            onRefresh: () {
                              BlocProvider.of<PharmacyArrivalScreenCubit>(
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
  final PharmacyOrderDTO orderData;

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
                  "№.${orderData.id} ${orderData.number}",
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
              const _BuildOrderDetailItem(
                icon: "divergence",
                title: "Товары на расхождении",
                data: "5",
              ),
            _BuildOrderDetailItem(
              icon: "container_ic",
              title: "Контейнеров",
              data: (orderData.container ?? 0).toString(),
            ),
            _BuildOrderDetailItem(
              icon: "calendar_ic",
              title: "Время отправления",
              data: orderData.createdAt != null
                  ? DateFormat("dd.MM.yyyy; hh:mm a")
                      .format(DateTime.parse('${orderData.createdAt}'))
                  : "No data",
            ),
            _BuildOrderDetailItem(
              icon: "user_star_ic",
              title: orderData.status == 1 ? "Отправитель" : "Контрагент",
              data: "${orderData.sender?.name}",
              hasImage: true,
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
                      RichText(
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
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 40,
                  width: 40,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(40),
                    child: Image.network(
                      (orderData.driver != null &&
                              orderData.driver!.avatar != null)
                          ? orderData.driver!.avatar!
                          : 'https://i.stack.imgur.com/l60Hf.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 12,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${orderData.driver?.name}",
                        style: ThemeTextStyle.textStyle16w600.copyWith(
                          color: ColorPalette.black,
                        ),
                      ),
                      const SizedBox(
                        height: 3,
                      ),
                      Text(
                        "Водитель-экспедитор",
                        style: ThemeTextStyle.textStyle12w400.copyWith(
                          color: ColorPalette.commonGrey,
                        ),
                      ),
                    ],
                  ),
                ),
                InkWell(
                  onTap: () async {
                    _launchUrl(Uri.parse(
                        'tel:${orderData.driver?.phone?[0] == '8' ? '' : '+7'}${orderData.driver?.phone}'));
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: ColorPalette.orange,
                      borderRadius: BorderRadius.circular(100),
                    ),
                    padding: const EdgeInsets.all(11),
                    child:
                        SvgPicture.asset("assets/images/svg/driver_phone.svg"),
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 12,
            ),
            GestureDetector(
              onTap: () {
                context.read<FillInvoiceVModel>().init();
                if (orderData.status == 1) {
                  AppRouter.push(
                    context,
                    FillInvoiceScreen(
                      isFromPharmacyPage: true,
                      pharmacyOrder: orderData,
                    ),
                  );
                } else {
                  AppRouter.push(
                    context,
                    GoodsListScreen(
                      isFromPharmacyPage: true,
                      pharmacyOrder: orderData,
                    ),
                  );
                }
              },
              child: Container(
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
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _launchUrl(Uri _url) async {
    if (!await launchUrl(_url)) throw 'Could not launch $_url';
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
