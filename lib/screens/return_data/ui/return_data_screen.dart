// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:intl/intl.dart';
// import 'package:lottie/lottie.dart';
// import 'package:pharmacy_arrival/data/model/move_data_dto.dart';
// import 'package:pharmacy_arrival/data/model/pharmacy_order_dto.dart';
// import 'package:pharmacy_arrival/data/model/refund_data_dto.dart';
// import 'package:pharmacy_arrival/data/model/warehouse_order_dto.dart';
// import 'package:pharmacy_arrival/screens/history/history_cubit.dart/history_cat_cubit.dart';
// import 'package:pharmacy_arrival/screens/history/history_cubit.dart/history_cubit.dart';
// import 'package:pharmacy_arrival/screens/history/history_move_screen_detail.dart';
// import 'package:pharmacy_arrival/screens/history/history_screen_detail.dart';
// import 'package:pharmacy_arrival/screens/history/widgets/build_history_order_body.dart';
// import 'package:pharmacy_arrival/screens/move_data/ui/move_filter_page.dart';
// import 'package:pharmacy_arrival/screens/move_data/vmodel/move_filter_vmodel.dart';
// import 'package:pharmacy_arrival/screens/pharmacy_arrival/ui/pharmacy_filter_page.dart';
// import 'package:pharmacy_arrival/screens/pharmacy_arrival/vmodel/pharmacy_filter_vmodel.dart';
// import 'package:pharmacy_arrival/styles/color_palette.dart';
// import 'package:pharmacy_arrival/styles/text_styles.dart';
// import 'package:pharmacy_arrival/utils/app_router.dart';
// import 'package:pharmacy_arrival/widgets/custom_app_bar.dart';
// import 'package:pharmacy_arrival/widgets/filter/move_filter_widget.dart';
// import 'package:pharmacy_arrival/widgets/filter/pharmacy_filter_widget.dart';
// import 'package:pharmacy_arrival/widgets/main_text_field/app_text_field.dart';
// import 'package:pharmacy_arrival/widgets/snackbar/custom_snackbars.dart';
// import 'package:provider/provider.dart';
// import 'package:pull_to_refresh/pull_to_refresh.dart';

// class ReturnDataScreen extends StatefulWidget {
//   const ReturnDataScreen({Key? key});

//   @override
//   State<ReturnDataScreen> createState() => _ReturnDataScreenState();
// }

// class _ReturnDataScreenState extends State<ReturnDataScreen> {
//   RefreshController refreshController = RefreshController();
//   TextEditingController searchController = TextEditingController();
//   @override
//   void initState() {
//     WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
//       Provider.of<PharmacyFilterVmodel>(
//         context,
//         listen: false,
//       ).clear();
//     });
//     super.initState();
//     BlocProvider.of<HistoryCubit>(context).getPharmacyArrivalHistory();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Consumer2<PharmacyFilterVmodel, MoveFilterVmodel>(
//       builder: (context, pharmacyFilter, moveFilter, child) {
//         return Scaffold(
//           appBar: CustomAppBar(
//             title: "История заказов".toUpperCase(),
//           ),
//           body: Column(
//             children: [
//               //search bar
//               Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: AppTextField(
//                   focusNode: FocusNode(),
//                   onFieldSubmitted: (value) {
//                     final productCubit = BlocProvider.of<HistoryCubit>(context);
//                     if (value.isNotEmpty) {
//                       productCubit.getPharmacyArrivalHistory(
//                         number: searchController.text,
//                       );
//                     } else {
//                       productCubit.getPharmacyArrivalHistory();
//                     }
//                   },
//                   onChanged: (String? text) {
//                     final productCubit = BlocProvider.of<HistoryCubit>(context);
//                     if (text != null) {
//                       productCubit.getPharmacyArrivalHistory(
//                         number: searchController.text,
//                         pharmacyFilterVmodel: pharmacyFilter,
//                       );
//                     }
//                     if (text == null || text.isEmpty) {
//                       productCubit.getPharmacyArrivalHistory(
//                         pharmacyFilterVmodel: pharmacyFilter,
//                       );
//                     }
//                   },
//                   controller: searchController,
//                   hintText: "Искать по номеру заказа",
//                   hintStyle: ThemeTextStyle.textStyle14w400
//                       .copyWith(color: ColorPalette.grey400),
//                   fillColor: ColorPalette.white,
//                   prefixIcon: SvgPicture.asset(
//                     "assets/images/svg/search.svg",
//                     color: ColorPalette.grey400,
//                   ),
//                   contentPadding: const EdgeInsets.only(
//                     top: 18,
//                     bottom: 18,
//                     left: 13,
//                   ),
//                 ),
//               ),

//               //filter bar
//               Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: PharmacyFilterWidget(
//                   onTap: () {
//                     AppRouter.push(
//                       context,
//                       PharmacyFilterPage(
//                         isFromPharmacyPage: false,
//                         callback: () {
//                           BlocProvider.of<HistoryCubit>(
//                             context,
//                           ).getPharmacyArrivalHistory(
//                             number: searchController.text.isEmpty
//                                 ? null
//                                 : searchController.text,
//                             pharmacyFilterVmodel: pharmacyFilter,
//                           );
//                         },
//                       ),
//                     );
//                   },
//                   trailingCloseTap: () {
//                     pharmacyFilter.clear();
//                     BlocProvider.of<HistoryCubit>(
//                       context,
//                     ).getPharmacyArrivalHistory(
//                       number: searchController.text.isEmpty
//                           ? null
//                           : searchController.text,
//                       pharmacyFilterVmodel: pharmacyFilter,
//                     );
//                   },
//                 ),
//               ),

//               //body
//               Expanded(
//                 child: BlocConsumer<HistoryCubit, HistoryState>(
//                   listener: (context, state) {
//                     state.maybeWhen(
//                       initialState: () {},
//                       loadingState: () {},
//                       orElse: () {},
//                       pharmacyHistoryState: (orders) {},
//                       warehouseHistoryState: (orders) {},
//                       movingHistoryState: (orders) {},
//                       refundHistoryState: (orders) {},
//                       errorState: (String message) {
//                         buildErrorCustomSnackBar(context, message);
//                       },
//                       movingHistoryBySearch:
//                           (List<MoveDataDTO> pharmacyOrders) {},
//                       pharmacyHistoryBySearch:
//                           (List<PharmacyOrderDTO> pharmacyOrders) {},
//                       refundHistoryBySearch:
//                           (List<RefundDataDTO> pharmacyOrders) {},
//                       warehouseHistoryBySearch:
//                           (List<WarehouseOrderDTO> warehouseOrders) {},
//                     );
//                   },
//                   builder: (context, state) {
//                     return state.maybeWhen(
//                       orElse: () {
//                         return const Center(
//                           child: CircularProgressIndicator(
//                             color: Colors.red,
//                           ),
//                         );
//                       },
//                       initialState: () {
//                         return const Center(
//                           child: CircularProgressIndicator(
//                             color: Colors.black,
//                           ),
//                         );
//                       },
//                       loadingState: () {
//                         return const Center(
//                           child: CircularProgressIndicator(
//                             color: Colors.amber,
//                           ),
//                         );
//                       },
//                       pharmacyHistoryState: (List<PharmacyOrderDTO> orders) {
//                         return SmartRefresher(
//                           controller: refreshController,
//                           onRefresh: () {
//                             BlocProvider.of<HistoryCubit>(context)
//                                 .getPharmacyArrivalHistory(
//                               number: searchController.text.isEmpty
//                                   ? null
//                                   : searchController.text,
//                               pharmacyFilterVmodel: pharmacyFilter,
//                             );
//                             refreshController.refreshCompleted();
//                           },
//                           child: orders.isEmpty
//                               ? ListView(
//                                   children: [
//                                     SizedBox(
//                                       height:
//                                           MediaQuery.of(context).size.height *
//                                               0.1,
//                                     ),
//                                     Center(
//                                       child: Lottie.asset(
//                                         'assets/lotties/empty_box.json',
//                                       ),
//                                     ),
//                                   ],
//                                 )
//                               : ListView.builder(
//                                   padding: const EdgeInsets.symmetric(
//                                     vertical: 8,
//                                     horizontal: 11.5,
//                                   ),
//                                   itemBuilder: (context, index) {
//                                     return Material(
//                                       borderRadius: BorderRadius.circular(15),
//                                       child: InkWell(
//                                         borderRadius: BorderRadius.circular(15),
//                                         onTap: () {
//                                           AppRouter.push(
//                                             context,
//                                             HistoryScreenDetail(
//                                               isFromPharmacyPage: true,
//                                               pharmacyOrder: orders[index],
//                                             ),
//                                           );
//                                         },
//                                         child: SizedBox(
//                                           child: BuildHistoryOrderData(
//                                             pharmacyOrderDTO: orders[index],
//                                             orderNumber:
//                                                 '${orders[index].number}',
//                                             orderId: orders[index].id,
//                                             container:
//                                                 orders[index].container ?? 0,
//                                             createdAt: orders[index].createdAt,
//                                             counteragent: orders[index].sender,
//                                             incomingNumber:
//                                                 orders[index].incomingNumber,
//                                           ),
//                                         ),
//                                       ),
//                                     );
//                                   },
//                                   itemCount: orders.length,
//                                   shrinkWrap: true,
//                                 ),
//                         );
//                       },
//                       errorState: (String message) {
//                         return Center(
//                           child: Column(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: [
//                               const CircularProgressIndicator(
//                                 color: Colors.red,
//                               ),
//                               const SizedBox(
//                                 height: 8,
//                               ),
//                               Text(
//                                 message,
//                                 style: const TextStyle(color: Colors.red),
//                               )
//                             ],
//                           ),
//                         );
//                       },
//                     );
//                   },
//                 ),
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pharmacy_arrival/data/model/pharmacy_order_dto.dart';
import 'package:pharmacy_arrival/screens/history/history_cubit.dart/history_cubit.dart';
import 'package:pharmacy_arrival/screens/return_data/return_data_cubit/return_data_screen_cubit.dart';
import 'package:pharmacy_arrival/screens/return_data/ui/return_detail_page.dart';
import 'package:pharmacy_arrival/utils/app_router.dart';
import 'package:pharmacy_arrival/widgets/app_loader_overlay.dart';
import 'package:pharmacy_arrival/widgets/custom_app_bar.dart';
import 'package:pharmacy_arrival/widgets/date_picker.dart';
import 'package:pharmacy_arrival/widgets/main_text_field/app_text_field.dart';
import 'package:pharmacy_arrival/widgets/snackbar/custom_snackbars.dart';

class ReturnDataScreen extends StatefulWidget {
  const ReturnDataScreen();

  @override
  State<ReturnDataScreen> createState() => _ReturnDataScreenState();
}

class _ReturnDataScreenState extends State<ReturnDataScreen> {
  TextEditingController incomingDateController = TextEditingController();
  TextEditingController incomingNumberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AppLoaderOverlay(
      child: Scaffold(
        appBar: CustomAppBar(title: "Возврат".toUpperCase()),
        body: BlocConsumer<ReturnDataScreenCubit, ReturnDataScreenState>(
          listener: (context, state) {
            state.when(
              initialState: () {
                context.loaderOverlay.hide();
              },
              loadingState: () {
                context.loaderOverlay.show();
              },
              loadedState: (PharmacyOrderDTO refundDataDTO) {
                context.loaderOverlay.hide();
                AppRouter.push(
                  context,
                  ReturnDetailPage(
                    pharmacyOrder: refundDataDTO,
                  ),
                );
                BlocProvider.of<HistoryCubit>(context)
                    .updatePharmacyOrderStatus(
                  orderId: refundDataDTO.id,
                  refundStatus: 1,
                  isFromHisPage: true,
                );
              },
              errorState: (String message) {
                buildErrorCustomSnackBar(context, message);
                context.loaderOverlay.hide();
              },
            );
          },
          builder: (context, state) {
            return Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 15.0, horizontal: 16.5),
              child: ListView(
                children: [
                  const SizedBox(
                    height: 16,
                  ),
                  AppTextField(
                    validator: (p0) {
                      return [];
                    },
                    controller: incomingNumberController,
                    hintText: "Введите номер документа",
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  DatePicker(
                    controller: incomingDateController,
                    hintText: "Дата накладной",
                    onClose: () {
                      incomingDateController.clear();
                      setState(() {});
                    },
                  ),
                  const SizedBox(
                    height: 32,
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: GestureDetector(
                      onTap: () {
                        if (incomingNumberController.text.isNotEmpty &&
                            incomingDateController.text.isNotEmpty) {
                          BlocProvider.of<ReturnDataScreenCubit>(context)
                              .checkRefundOrder(
                            incomingDate: incomingDateController.text,
                            incomingNumber: incomingNumberController.text,
                          );
                        } else {
                          buildErrorCustomSnackBar(
                            context,
                            "Заполните все поля!",
                          );
                        }
                      },
                      child: Container(
                        padding: const EdgeInsets.all(28),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF87615),
                          borderRadius: BorderRadius.circular(100),
                          border: Border.all(color: const Color(0xFFd86814)),
                        ),
                        child:
                            SvgPicture.asset("assets/images/svg/move_plus.svg"),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
