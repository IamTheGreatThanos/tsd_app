import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pharmacy_arrival/data/model/refund_data_dto.dart';
import 'package:pharmacy_arrival/main/counteragent_cubit/counteragent_cubit.dart'
    as countragents;
import 'package:pharmacy_arrival/main/organization_cubit/organization_cubit.dart'
    as organization;
import 'package:pharmacy_arrival/screens/return_data/return_data_cubit/return_data_screen_cubit.dart';
import 'package:pharmacy_arrival/screens/return_data/ui/return_barcode_screen.dart';
import 'package:pharmacy_arrival/styles/color_palette.dart';
import 'package:pharmacy_arrival/styles/text_styles.dart';
import 'package:pharmacy_arrival/utils/app_router.dart';
import 'package:pharmacy_arrival/widgets/app_loader_overlay.dart';
import 'package:pharmacy_arrival/widgets/custom_app_bar.dart';
import 'package:pharmacy_arrival/widgets/snackbar/custom_snackbars.dart';
import 'package:search_choices/search_choices.dart';

class ReturnDataScreen extends StatefulWidget {
  const ReturnDataScreen({Key? key}) : super(key: key);

  @override
  State<ReturnDataScreen> createState() => _ReturnDataScreenState();
}

class _ReturnDataScreenState extends State<ReturnDataScreen> {
  String? fromCounteragent;
  int fromCounteragentId = -1;
  String? counteragent;
  int counteragentId = -1;
  String? organizationName;
  int organizationId = -1;
  String moveType = "Не выбрана";

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
              loadedState: (RefundDataDTO refundDataDTO) {
                AppRouter.pushReplacement(
                  context,
                  const ReturnBarcodeScreen(
                    isFromProductsPage: false,
                  ),
                );
                context.loaderOverlay.hide();
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
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                    ),
                    decoration: BoxDecoration(
                      color: ColorPalette.white,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: BlocBuilder<organization.OrganizationCubit,
                        organization.OrganizationState>(
                      builder: (context, state) {
                        return state.maybeWhen(
                          loadingState: () => const CircularProgressIndicator(
                            color: Colors.amber,
                          ),
                          loadedState: (counteragents) {
                            return SearchChoices.single(
                              padding: organizationId == -1 ? 14 : 7,
                              displayClearIcon: false,
                              closeButton: "Закрыть",
                              items: counteragents
                                  .map((e) => e.name)
                                  .toList()
                                  .map<DropdownMenuItem<String>>(
                                      (String? value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(
                                    "$value",
                                    style: ThemeTextStyle.textStyle14w400,
                                  ),
                                );
                              }).toList(),
                              value: organizationName,
                              hint: "Организация",
                              searchHint: "Организация",
                              style: ThemeTextStyle.textStyle14w400,
                              onChanged: (String? newValue) {
                                organizationName = newValue;
                                for (int i = 0; i < counteragents.length; i++) {
                                  if (organizationName ==
                                          counteragents[i].name &&
                                      counteragents[i].id != -1) {
                                    organizationId = counteragents[i].id;
                                  }
                                }
                                setState(() {});
                              },
                              isExpanded: true,
                              icon: SvgPicture.asset(
                                "assets/images/svg/chevron_right.svg",
                              ),
                              underline: const SizedBox(),
                            );
                          },
                          orElse: () {
                            return const CircularProgressIndicator(
                              color: Colors.red,
                            );
                          },
                        );
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                    ),
                    decoration: BoxDecoration(
                      color: ColorPalette.white,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: BlocBuilder<countragents.CounteragentsCubit,
                        countragents.CounteragentState>(
                      builder: (context, state) {
                        return state.maybeWhen(
                          loadingState: () => const CircularProgressIndicator(
                            color: Colors.amber,
                          ),
                          loadedState: (counteragents) {
                            return SearchChoices.single(
                              padding: counteragentId == -1 ? 14 : 7,
                              displayClearIcon: false,
                              closeButton: "Закрыть",
                              items: counteragents
                                  .map((e) => e.name)
                                  .toList()
                                  .map<DropdownMenuItem<String>>(
                                      (String? value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(
                                    "$value",
                                    style: ThemeTextStyle.textStyle14w400,
                                  ),
                                );
                              }).toList(),
                              value: counteragent,
                              hint: "Контрагент",
                              searchHint: "Контрагент",
                              style: ThemeTextStyle.textStyle14w400,
                              onChanged: (String? newValue) {
                                counteragent = newValue;
                                for (int i = 0; i < counteragents.length; i++) {
                                  if (counteragent == counteragents[i].name &&
                                      counteragents[i].id != -1) {
                                    counteragentId = counteragents[i].id;
                                  }
                                }
                                setState(() {});
                              },
                              isExpanded: true,
                              icon: SvgPicture.asset(
                                "assets/images/svg/chevron_right.svg",
                              ),
                              underline: const SizedBox(),
                            );
                          },
                          orElse: () {
                            return const CircularProgressIndicator(
                              color: Colors.red,
                            );
                          },
                        );
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                      color: ColorPalette.white,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: BlocBuilder<countragents.CounteragentsCubit,
                        countragents.CounteragentState>(
                      builder: (context, state) {
                        return state.maybeWhen(
                          loadingState: () => const CircularProgressIndicator(
                            color: Colors.amber,
                          ),
                          loadedState: (counteragents) {
                            return SearchChoices.single(
                              padding: fromCounteragentId == -1 ? 14 : 7,
                              displayClearIcon: false,
                              closeButton: "Закрыть",
                              items: counteragents
                                  .map((e) => e.name)
                                  .toList()
                                  .map<DropdownMenuItem<String>>(
                                      (String? value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(
                                    "$value",
                                    style: ThemeTextStyle.textStyle14w400,
                                  ),
                                );
                              }).toList(),
                              value: fromCounteragent,
                              hint: "Склад с которого делается возврат",
                              searchHint: "Склад с которого делается возврат",
                              style: ThemeTextStyle.textStyle14w400,
                              onChanged: (String? newValue) {
                                fromCounteragent = newValue;
                                for (int i = 0; i < counteragents.length; i++) {
                                  if (fromCounteragent ==
                                          counteragents[i].name &&
                                      counteragents[i].id != -1) {
                                    fromCounteragentId = counteragents[i].id;
                                  }
                                }
                                setState(() {});
                              },
                              isExpanded: true,
                              icon: SvgPicture.asset(
                                "assets/images/svg/chevron_right.svg",
                              ),
                              underline: const SizedBox(),
                            );
                          },
                          orElse: () {
                            return const CircularProgressIndicator(
                              color: Colors.red,
                            );
                          },
                        );
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 32,
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: GestureDetector(
                      onTap: () {
                        if (counteragentId != -1 &&
                            fromCounteragentId != -1 &&
                            organizationId != -1) {
                          BlocProvider.of<ReturnDataScreenCubit>(context)
                              .createRefundOrder(
                            counteragentId: counteragentId,
                            fromCounteragentId: fromCounteragentId,
                            organizationId: organizationId,
                          );
                        } else {
                          buildErrorCustomSnackBar(
                            context,
                            "Вы не выбрали все пункты!!!",
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
