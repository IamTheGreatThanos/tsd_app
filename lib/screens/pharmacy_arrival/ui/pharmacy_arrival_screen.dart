import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:pharmacy_arrival/screens/fill_invoice/ui/_vmodel.dart';
import 'package:pharmacy_arrival/screens/pharmacy_arrival/bloc/bloc_pharmacy_arrival.dart';
import 'package:pharmacy_arrival/widgets/app_loader_overlay.dart';
import 'package:pharmacy_arrival/widgets/custom_app_bar.dart';
import 'package:provider/provider.dart';

import '../../../network/models/dto_models/response/dto_order_details_response.dart';
import '../../../styles/color_palette.dart';
import '../../../styles/text_styles.dart';
import '../../../utils/app_router.dart';
import '../../../widgets/main_text_field/app_text_field.dart';
import '../../fill_invoice/ui/fill_invoice_screen.dart';

class PharmacyArrivalScreen extends StatefulWidget {
  const PharmacyArrivalScreen({Key? key}) : super(key: key);

  @override
  State<PharmacyArrivalScreen> createState() => _PharmacyArrivalScreenState();
}

class _PharmacyArrivalScreenState extends State<PharmacyArrivalScreen> {
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          BlocPharmacyArrival()..add(EventReadPharmacyArrival()),
      child: AppLoaderOverlay(
        child: Scaffold(
          appBar: CustomAppBar(
            title: "Приход аптека".toUpperCase(),
          ),
          body: BlocConsumer<BlocPharmacyArrival, StateBlocPharmacyArrival>(
            listener: (context, state) {
              if (state is StatePharmacyArrivalLoading) {
                context.loaderOverlay.show();
              } else {
                context.loaderOverlay.hide();
              }
            },
            buildWhen: (p, c) => c is StatePharmacyArrivalLoadData,
            builder: (context, state) {
              if (state is StatePharmacyArrivalLoadData) {
                return SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 13, vertical: 15),
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
                              top: 17, bottom: 17, left: 13),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
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
              const _BuildOrderDetailItem(
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
              title: "Время отправления",
              data: orderData.createdAt != null
                  ? DateFormat("dd.MM.yyyy; hh:mm a")
                      .format(orderData.createdAt!)
                  : "No data",
            ),
            _BuildOrderDetailItem(
              icon: "user_star_ic",
              title: orderData.isActive ? "Отправитель" : "Контрагент",
              data: orderData.sender ?? "No data",
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
                                width: 5, color: ColorPalette.textYellow)),
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      RichText(
                          text: TextSpan(children: [
                        TextSpan(
                            text: "${orderData.addressFrom}, ",
                            style: ThemeTextStyle.textStyle16w500),
                        TextSpan(
                            text: orderData.cityFrom,
                            style: ThemeTextStyle.textStyle14w400.copyWith(
                              color: ColorPalette.grey400,
                            ))
                      ]))
                    ],
                  ),
                  // SizedBox(
                  //   height: 20,
                  // ),
                  Container(
                    padding: const EdgeInsets.only(left: 7),
                    height: 20,
                    child: DottedLine(
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
                                width: 5, color: ColorPalette.orange)),
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      RichText(
                          text: TextSpan(children: [
                        TextSpan(
                          text: "${orderData.addressTo}, ",
                          style: ThemeTextStyle.textStyle14w400,
                        ),
                        TextSpan(
                            text: orderData.cityTo,
                            style: ThemeTextStyle.textStyle14w400.copyWith(
                              color: ColorPalette.grey400,
                            ))
                      ]))
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 21,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset("assets/images/png/driver_stock.png"),
                SizedBox(
                  width: 12,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Қанат Тұрғанбай",
                        style: ThemeTextStyle.textStyle16w600.copyWith(
                          color: ColorPalette.black,
                        ),
                      ),
                      SizedBox(
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
                Container(
                  decoration: BoxDecoration(
                    color: ColorPalette.orange,
                    borderRadius: BorderRadius.circular(100),
                  ),
                  padding: const EdgeInsets.all(11),
                  child: SvgPicture.asset("assets/images/svg/driver_phone.svg"),
                )
              ],
            ),
            const SizedBox(
              height: 12,
            ),
            GestureDetector(
              onTap: () {
                context.read<FillInvoiceVModel>().init();
                AppRouter.push(
                    context,
                    ChangeNotifierProvider(
                      create: (_) => FillInvoiceVModel()..init(),
                      child: FillInvoiceScreen(
                        orderData: orderData,
                      ),
                    ));
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
}

class _BuildOrderDetailItem extends StatelessWidget {
  final String icon;
  final String title;
  final String data;
  final bool hasImage;

  const _BuildOrderDetailItem(
      {Key? key,
      required this.icon,
      required this.title,
      required this.data,
      this.hasImage = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
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
          SizedBox(
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
