import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pharmacy_arrival/core/utils/app_router.dart';
import 'package:pharmacy_arrival/data/model/pharmacy_order_dto.dart';
import 'package:pharmacy_arrival/screens/history/history_cubit.dart/history_cubit.dart';
import 'package:pharmacy_arrival/screens/return_data/return_data_cubit/return_data_screen_cubit.dart';
import 'package:pharmacy_arrival/screens/return_data/ui/return_detail_page.dart';
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
