
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:pharmacy_arrival/data/model/pharmacy_order_dto.dart';
import 'package:pharmacy_arrival/data/model/warehouse_order_dto.dart';
import 'package:pharmacy_arrival/screens/common/signature/cubit/signature_screen_cubit.dart';
import 'package:pharmacy_arrival/screens/common/ui/_vmodel.dart';
import 'package:pharmacy_arrival/screens/pharmacy_arrival/cubit/pharmacy_arrival_screen_cubit.dart';
import 'package:pharmacy_arrival/screens/pharmacy_arrival/ui/pharmacy_arrival_screen.dart';
import 'package:pharmacy_arrival/screens/warehouse_arrival/cubit/warehouse_arrival_screen_cubit.dart';
import 'package:pharmacy_arrival/styles/color_palette.dart';
import 'package:pharmacy_arrival/styles/text_styles.dart';
import 'package:pharmacy_arrival/utils/app_router.dart';
import 'package:pharmacy_arrival/widgets/app_loader_overlay.dart';
import 'package:pharmacy_arrival/widgets/custom_app_bar.dart';
import 'package:pharmacy_arrival/widgets/main_text_field/app_text_field.dart';
import 'package:pharmacy_arrival/widgets/snackbar/custom_snackbars.dart';

class FillInvoiceScreen extends StatefulWidget {
  final bool isFromPharmacyPage;
  final PharmacyOrderDTO? pharmacyOrder;
  final WarehouseOrderDTO? warehouseOrder;
  const FillInvoiceScreen({
    Key? key,
    this.warehouseOrder,
    this.pharmacyOrder,
    required this.isFromPharmacyPage,
  }) : super(key: key);

  @override
  State<FillInvoiceScreen> createState() => _FillInvoiceScreenState();
}

class _FillInvoiceScreenState extends State<FillInvoiceScreen> {
  TextEditingController numberController = TextEditingController();
  FocusNode focusNode1 = FocusNode();

  String? recipient;
  int recipientId = -1;
  @override
  void dispose() {
    focusNode1.dispose();
    numberController.dispose();
    super.dispose();
  }

 

  @override
  Widget build(BuildContext context) {
    final FillInvoiceVModel _vmodel = context.read<FillInvoiceVModel>();
    return AppLoaderOverlay(
      child: BlocConsumer<SignatureScreenCubit, SignatureScreenState>(
        listener: (context, state) {
          state.when(
            initialState: () {
              context.loaderOverlay.hide();
            },
            loadingState: () {
              context.loaderOverlay.show();
            },
            loadedState: () {
              context.loaderOverlay.hide();
              buildSuccessCustomSnackBar(
                context,
                'Накладная будет загружена в 1С в течении 15 минут !',
              );
              widget.isFromPharmacyPage
                  ? BlocProvider.of<PharmacyArrivalScreenCubit>(context)
                      .onRefreshOrders(status: 1)
                  : BlocProvider.of<WarehouseArrivalScreenCubit>(context)
                      .onRefreshOrders(status: 1);
              AppRouter.pushAndRemoveUntilRoot(
                context,
                const PharmacyArrivalScreen(),
              );
            },
            errorState: (message) {
              context.loaderOverlay.hide();
              buildErrorCustomSnackBar(context, message);
            },
          );
        },
        builder: (context, state) {
          return Scaffold(
            appBar: CustomAppBar(
              title: widget.isFromPharmacyPage
                  ? '№.${widget.pharmacyOrder?.id} ${widget.pharmacyOrder?.number}'
                  : '№.${widget.warehouseOrder?.id} ${widget.warehouseOrder?.number}',
            ),
            body: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 15.0, horizontal: 16.5),
              child: CustomScrollView(
                slivers: [
                  SliverFillRemaining(
                    hasScrollBody: false,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Заполните накладную",
                          style: ThemeTextStyle.textTitleDella16w400,
                        ),
                        const SizedBox(
                          height: 24,
                        ),
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: ColorPalette.white,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Column(
                            children: [
                              _vmodel.incomeNumber,
                              const Padding(
                                padding: EdgeInsets.symmetric(vertical: 4),
                                child: Divider(
                                  color: ColorPalette.borderGrey,
                                ),
                              ),
                              GestureDetector(
                                onTap: () async {
                                  final DateTime? date = await showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime(2019),
                                    lastDate: DateTime.now(),
                                    helpText: "Дата входящего номера",
                                    builder: (context, child) {
                                      return Theme(
                                        data: Theme.of(context).copyWith(
                                          colorScheme: const ColorScheme.light(
                                            primary: ColorPalette.greyDark,
                                          ),
                                          textTheme: TextTheme(
                                            headline5: ThemeTextStyle
                                                .textTitleDella24w400,
                                            overline:
                                                ThemeTextStyle.textStyle16w600,
                                          ),
                                          textButtonTheme: TextButtonThemeData(
                                            style: TextButton.styleFrom(
                                              primary: Colors.black,
                                              textStyle: ThemeTextStyle
                                                  .textStyle14w600
                                                  .copyWith(
                                                color: Colors.black,
                                              ),
                                            ),
                                          ),
                                        ),
                                        child: child!,
                                      );
                                    },
                                  );
                                  if (date != null) {
                                    _vmodel.incomeNumberDateController.text =
                                        DateFormat("yyyy-MM-dd").format(date);
                                  }
                                },
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Дата вх. номера",
                                      style: ThemeTextStyle.textStyle14w400
                                          .copyWith(
                                        color: ColorPalette.grey400,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 16,
                                    ),
                                    Flexible(
                                      child: AppTextField(
                                        focusNode: focusNode1,
                                        contentPadding: EdgeInsets.zero,
                                        capitalize: false,
                                        controller:
                                            _vmodel.incomeNumberDateController,
                                        readonly: true,
                                        textAlign: TextAlign.right,
                                        showErrorMessages: false,
                                        suffixIcon: Padding(
                                          padding:
                                              const EdgeInsets.only(left: 8.0),
                                          child: GestureDetector(
                                            onTap: () async {
                                              final DateTime? date =
                                                  await showDatePicker(
                                                context: context,
                                                initialDate: DateTime.now(),
                                                firstDate: DateTime(2019),
                                                lastDate: DateTime.now(),
                                                helpText:
                                                    "Дата входящего номера",
                                                builder: (context, child) {
                                                  return Theme(
                                                    data: Theme.of(context)
                                                        .copyWith(
                                                      colorScheme:
                                                          const ColorScheme
                                                              .light(
                                                        primary: ColorPalette
                                                            .greyDark,
                                                      ),
                                                      textTheme: TextTheme(
                                                        headline5: ThemeTextStyle
                                                            .textTitleDella24w400,
                                                        overline: ThemeTextStyle
                                                            .textStyle16w600,
                                                      ),
                                                      textButtonTheme:
                                                          TextButtonThemeData(
                                                        style: TextButton
                                                            .styleFrom(
                                                          primary: Colors.black,
                                                          textStyle:
                                                              ThemeTextStyle
                                                                  .textStyle14w600
                                                                  .copyWith(
                                                            color: Colors.black,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    child: child!,
                                                  );
                                                },
                                              );
                                              if (date != null) {
                                                _vmodel
                                                    .incomeNumberDateController
                                                    .text = DateFormat(
                                                  "yyyy-MM-dd",
                                                ).format(date);
                                              }
                                            },
                                            child: SvgPicture.asset(
                                              "assets/images/svg/calendar_circle_ic.svg",
                                              width: 24,
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        // const SizedBox(
                        //   height: 16,
                        // ),
                        // _vmodel.bin,
                        // const SizedBox(
                        //   height: 16,
                        // ),
                        // Container(
                        //   padding: const EdgeInsets.symmetric(horizontal: 12),
                        //   decoration: BoxDecoration(
                        //     color: ColorPalette.white,
                        //     borderRadius: BorderRadius.circular(16),
                        //   ),
                        //   child: BlocBuilder<countragents.CounteragentsCubit,
                        //       countragents.CounteragentState>(
                        //     builder: (context, state) {
                        //       return state.maybeWhen(
                        //         loadingState: () =>
                        //             const CircularProgressIndicator(
                        //           color: Colors.amber,
                        //         ),
                        //         loadedState: (counteragents) {
                        //           return SearchChoices.single(
                        //             padding: recipientId == -1 ? 14 : 7,
                        //             displayClearIcon: false,
                        //             closeButton: "Закрыть",
                        //             items: counteragents
                        //                 .map((e) => e.name)
                        //                 .toList()
                        //                 .map<DropdownMenuItem<String>>(
                        //                     (String? value) {
                        //               return DropdownMenuItem<String>(
                        //                 value: value,
                        //                 child: Text(
                        //                   "",
                        //                   style: ThemeTextStyle.textStyle14w400,
                        //                 ),
                        //               );
                        //             }).toList(),
                        //             value: recipient,
                        //             hint: "Получатель",
                        //             searchHint: "Получатель",
                        //             style: ThemeTextStyle.textStyle14w400,
                        //             onChanged: (String? newValue) {
                        //               recipient = newValue;
                        //               for (int i = 0;
                        //                   i < counteragents.length;
                        //                   i++) {
                        //                 if (recipient ==
                        //                         counteragents[i].name &&
                        //                     counteragents[i].id != -1) {
                        //                   recipientId = counteragents[i].id;
                        //                   _vmodel.recipientId = recipientId;
                        //                   log(_vmodel.recipientId.toString());
                        //                 }
                        //               }
                        //               setState(() {});
                        //             },
                        //             isExpanded: true,
                        //             icon: SvgPicture.asset(
                        //               "assets/images/svg/chevron_right.svg",
                        //             ),
                        //             underline: const SizedBox(),
                        //           );
                        //         },
                        //         orElse: () {
                        //           return const CircularProgressIndicator(
                        //             color: Colors.red,
                        //           );
                        //         },
                        //       );
                        //     },
                        //   ),
                        // ),
                        // const SizedBox(
                        //   height: 16,
                        // ),
                        // GestureDetector(
                        //   onTap: () async {
                        //     final DateTime? date = await showDatePicker(
                        //       context: context,
                        //       initialDate: DateTime.now(),
                        //       firstDate: DateTime(2019),
                        //       lastDate: DateTime.now(),
                        //       helpText: "Дата входящего номера",
                        //       builder: (context, child) {
                        //         return Theme(
                        //           data: Theme.of(context).copyWith(
                        //             colorScheme: const ColorScheme.light(
                        //               primary: ColorPalette.greyDark,
                        //             ),
                        //             textTheme: TextTheme(
                        //               headline5:
                        //                   ThemeTextStyle.textTitleDella24w400,
                        //               overline: ThemeTextStyle.textStyle16w600,
                        //             ),
                        //             textButtonTheme: TextButtonThemeData(
                        //               style: TextButton.styleFrom(
                        //                 primary: Colors.black,
                        //                 textStyle: ThemeTextStyle
                        //                     .textStyle14w600
                        //                     .copyWith(color: Colors.black),
                        //               ),
                        //             ),
                        //           ),
                        //           child: child!,
                        //         );
                        //       },
                        //     );
                        //     if (date != null) {
                        //       _vmodel.invoiceDate.text =
                        //           DateFormat("dd.MM.yyyy").format(date);
                        //     }
                        //   },
                        //   child: Container(
                        //     padding: const EdgeInsets.all(12),
                        //     decoration: BoxDecoration(
                        //       color: ColorPalette.white,
                        //       borderRadius: BorderRadius.circular(16),
                        //     ),
                        //     child: Row(
                        //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //       children: [
                        //         Text(
                        //           "Дата накладной",
                        //           style:
                        //               ThemeTextStyle.textStyle14w400.copyWith(
                        //             color: ColorPalette.grey400,
                        //           ),
                        //         ),
                        //         const SizedBox(
                        //           width: 16,
                        //         ),
                        //         Flexible(
                        //           child: AppTextField(
                        //             contentPadding: EdgeInsets.zero,
                        //             capitalize: false,
                        //             controller: _vmodel.invoiceDate,
                        //             readonly: true,
                        //             textAlign: TextAlign.right,
                        //             showErrorMessages: false,
                        //             suffixIcon: Padding(
                        //               padding: const EdgeInsets.only(left: 8.0),
                        //               child: GestureDetector(
                        //                 onTap: () async {
                        //                   final DateTime? date =
                        //                       await showDatePicker(
                        //                     context: context,
                        //                     initialDate: DateTime.now(),
                        //                     firstDate: DateTime(2019),
                        //                     lastDate: DateTime.now(),
                        //                     helpText: "Дата входящего номера",
                        //                     builder: (context, child) {
                        //                       return Theme(
                        //                         data:
                        //                             Theme.of(context).copyWith(
                        //                           colorScheme:
                        //                               const ColorScheme.light(
                        //                             primary:
                        //                                 ColorPalette.greyDark,
                        //                           ),
                        //                           textTheme: TextTheme(
                        //                             headline5: ThemeTextStyle
                        //                                 .textTitleDella24w400,
                        //                             overline: ThemeTextStyle
                        //                                 .textStyle16w600,
                        //                           ),
                        //                           textButtonTheme:
                        //                               TextButtonThemeData(
                        //                             style: TextButton.styleFrom(
                        //                               primary: Colors.black,
                        //                               textStyle: ThemeTextStyle
                        //                                   .textStyle14w600
                        //                                   .copyWith(
                        //                                 color: Colors.black,
                        //                               ),
                        //                             ),
                        //                           ),
                        //                         ),
                        //                         child: child!,
                        //                       );
                        //                     },
                        //                   );
                        //                   if (date != null) {
                        //                     _vmodel.invoiceDate.text =
                        //                         DateFormat("dd.MM.yyyy")
                        //                             .format(date);
                        //                   }
                        //                 },
                        //                 child: SvgPicture.asset(
                        //                   "assets/images/svg/calendar_circle_ic.svg",
                        //                   width: 24,
                        //                 ),
                        //               ),
                        //             ),
                        //           ),
                        //         )
                        //       ],
                        //     ),
                        //   ),
                        // ),
                        const Spacer(),
                        MaterialButton(
                          height: 40,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          color: ColorPalette.orange,
                          disabledColor: ColorPalette.orangeInactive,
                          padding: EdgeInsets.zero,
                          // onTap: _vmodel.incomeNumber.validated ? () {
                          //   AppRouter.push(context, DigitalSignatureLoadScreen());
                          // } : null,
                          ///todo

                          onPressed: () {
                            // if (_vmodel.incomeNumberController.text.length < 2) {
                            //   print(_vmodel.incomeNumberController.text.length);
                            //   buildErrorCustomSnackBar(context, 'Не все поля заполнены!!!');
                            // } else {
                            if (
                                _vmodel
                                    .incomeNumber.controller.text.isNotEmpty &&
                                _vmodel.incomeNumberDateController.text
                                    .isNotEmpty ) {
                              widget.isFromPharmacyPage
                                  ? BlocProvider.of<SignatureScreenCubit>(
                                      context,
                                    ).updatePharmacyOrderStatus(
                                      orderId: widget.isFromPharmacyPage
                                          ? widget.pharmacyOrder!.id
                                          : widget.warehouseOrder!.id,
                                      status: 3,
                                      incomingNumber: _vmodel.incomeNumber
                                              .controller.text.isEmpty
                                          ? null
                                          : _vmodel
                                              .incomeNumber.controller.text,
                                      incomingDate: _vmodel
                                              .incomeNumberDateController
                                              .text
                                              .isEmpty
                                          ? null
                                          : _vmodel
                                              .incomeNumberDateController.text,
                                      bin: _vmodel.bin.controller.text.isEmpty
                                          ? null
                                          : _vmodel.bin.controller.text,
                                      invoiceDate:
                                          _vmodel.invoiceDate.text.isEmpty
                                              ? null
                                              : _vmodel.invoiceDate.text,
                                      recipientId: _vmodel.recipientId == -1
                                          ? null
                                          : _vmodel.recipientId,
                                    )
                                  : BlocProvider.of<SignatureScreenCubit>(
                                      context,
                                    ).updateWarehouseOrderStatus(
                                      orderId: widget.isFromPharmacyPage
                                          ? widget.pharmacyOrder!.id
                                          : widget.warehouseOrder!.id,
                                      status: 3,
                                      incomingNumber: _vmodel.incomeNumber
                                              .controller.text.isEmpty
                                          ? null
                                          : _vmodel
                                              .incomeNumber.controller.text,
                                      incomingDate: _vmodel
                                              .incomeNumberDateController
                                              .text
                                              .isEmpty
                                          ? null
                                          : _vmodel
                                              .incomeNumberDateController.text,
                                      bin: _vmodel.bin.controller.text.isEmpty
                                          ? null
                                          : _vmodel.bin.controller.text,
                                      invoiceDate:
                                          _vmodel.invoiceDate.text.isEmpty
                                              ? null
                                              : _vmodel.invoiceDate.text,
                                      counteragentId: _vmodel.recipientId == -1
                                          ? null
                                          : _vmodel.recipientId,
                                    );
                            } else {
                              buildErrorCustomSnackBar(
                                context,
                                'Не все поля заполнены!!!',
                              );
                            }

                            // AppRouter.push(
                            //   context,
                            //   const DigitalSignatureLoadScreen(),
                            // );
                            // }
                          },
                          child: Center(
                            child: Text(
                              "ДАЛЕЕ",
                              style: ThemeTextStyle.textStyle14w600
                                  .copyWith(color: ColorPalette.white),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Future _bottomSheet(Widget widget) {
    return showModalBottomSheet(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
      ),
      context: context,
      enableDrag: true,
      isDismissible: false,
      isScrollControlled: true,
      builder: (context) {
        return widget;
      },
    );
  }
}

// class _TypeChooseBottomSheet extends StatelessWidget {
//   final bool isFromPharmacyPage;
//   final PharmacyOrderDTO? pharmacyOrder;
//   final WarehouseOrderDTO? warehouseOrder;
//   const _TypeChooseBottomSheet({
//     Key? key,
//     required this.isFromPharmacyPage,
//     this.pharmacyOrder,
//     this.warehouseOrder,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: MediaQuery.of(context).size.height * 0.3,
//       decoration: const BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.only(
//           topLeft: Radius.circular(10),
//           topRight: Radius.circular(10),
//         ),
//       ),
//       padding: const EdgeInsets.only(
//         right: 16,
//         left: 16,
//       ),
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           Container(
//             width: 40,
//             height: 4,
//             margin: const EdgeInsets.only(
//               top: 14,
//             ),
//             decoration: BoxDecoration(
//               color: const Color(0xffD9DBE9),
//               borderRadius: BorderRadius.circular(100),
//             ),
//           ),
//           const SizedBox(
//             height: 15,
//           ),
//           const Text(
//             'Выберите способ подтверждения ',
//             style: TextStyle(
//               color: Colors.black,
//               fontSize: 18,
//               fontWeight: FontWeight.w500,
//             ),
//           ),
//           const Spacer(),
//           MaterialButton(
//             height: 40,
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(8),
//             ),
//             color: ColorPalette.orange,
//             disabledColor: ColorPalette.orangeInactive,
//             padding: EdgeInsets.zero,
//             onPressed: () {
//               AppRouter.pushReplacement(
//                 context,
//                 DigitalSignatureLoadScreen(
//                   isFromPharmacyPage: isFromPharmacyPage,
//                   warehouseOrder: warehouseOrder,
//                   pharmacyOrder: pharmacyOrder,
//                 ),
//               );
//             },
//             child: Center(
//               child: Text(
//                 "Подписать с ЭЦП",
//                 style: ThemeTextStyle.textStyle14w600
//                     .copyWith(color: ColorPalette.white),
//               ),
//             ),
//           ),
//           const SizedBox(
//             height: 15,
//           ),
//           MaterialButton(
//             height: 40,
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(8),
//             ),
//             color: ColorPalette.orange,
//             disabledColor: ColorPalette.orangeInactive,
//             padding: EdgeInsets.zero,
//             onPressed: () {
//               AppRouter.pushReplacement(
//                 context,
//                 SignatureScreen(
//                   isFromPharmacyPage: isFromPharmacyPage,
//                   warehouseOrder: warehouseOrder,
//                   pharmacyOrder: pharmacyOrder,
//                 ),
//               );
//               // }
//             },
//             child: Center(
//               child: Text(
//                 "Подписать вручную",
//                 style: ThemeTextStyle.textStyle14w600
//                     .copyWith(color: ColorPalette.white),
//               ),
//             ),
//           ),
//           const SizedBox(
//             height: 15,
//           ),
//         ],
//       ),
//     );
//   }
// }
