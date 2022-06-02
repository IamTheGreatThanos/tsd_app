import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pharmacy_arrival/screens/barcode_scanner/barcode_scanner_screen.dart';
import 'package:pharmacy_arrival/screens/return_data/ui/_vmodel.dart';
import 'package:pharmacy_arrival/screens/return_data_scanned/return_data_scanned.dart';
import 'package:pharmacy_arrival/styles/color_palette.dart';
import 'package:pharmacy_arrival/styles/text_styles.dart';
import 'package:pharmacy_arrival/utils/app_router.dart';
import 'package:pharmacy_arrival/widgets/custom_alert_dialog.dart';
import 'package:pharmacy_arrival/widgets/custom_app_bar.dart';
import 'package:pharmacy_arrival/widgets/snackbar/custom_snackbars.dart';
import 'package:pharmacy_arrival/widgets/toast_service.dart';
import 'package:pharmacy_arrival/main/counteragent_cubit/counteragent_cubit.dart'
    as countragents;
import 'package:pharmacy_arrival/main/organization_cubit/organization_cubit.dart'
    as organization;

class ReturnDataScreen extends StatefulWidget {
  const ReturnDataScreen({Key? key}) : super(key: key);

  @override
  State<ReturnDataScreen> createState() => _ReturnDataScreenState();
}

class _ReturnDataScreenState extends State<ReturnDataScreen> {
  String fromCounteragent = 'Не выбран';
  int fromCounteragentId = -1;
  String counteragent = 'Не выбран';
  int counteragentId = -1;
  String organizationName = "Организация не выбрана";
  int organizationId = -1;
  String moveType = "Не выбрана";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Возврат".toUpperCase()),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 16.5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                color: ColorPalette.white,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      "Организация",
                      style: ThemeTextStyle.textStyle14w400.copyWith(
                        color: ColorPalette.grey400,
                      ),
                    ),
                  ),
                  BlocBuilder<organization.OrganizationCubit,
                      organization.OrganizationState>(
                    builder: (context, state) {
                      return state.maybeWhen(
                        loadingState: () => const CircularProgressIndicator(
                          color: Colors.amber,
                        ),
                        loadedState: (counteragents) {
                          return DropdownButton(
                            underline: const SizedBox(),
                            value: organizationName,
                            alignment: AlignmentDirectional.centerEnd,
                            icon: SvgPicture.asset(
                              "assets/images/svg/chevron_right.svg",
                            ),
                            onChanged: (String? newValue) {
                              organizationName = newValue!;
                              for (int i = 0; i < counteragents.length; i++) {
                                if (organizationName == counteragents[i].name &&
                                    counteragents[i].id != -1) {
                                  organizationId = counteragents[i].id;
                                }
                              }
                              setState(() {});
                            },
                            items: counteragents
                                .map((e) => e.name)
                                .toList()
                                .map<DropdownMenuItem<String>>((String? value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(
                                  "$value",
                                ),
                              );
                            }).toList(),
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
                ],
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
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      "Контрагент",
                      style: ThemeTextStyle.textStyle14w400.copyWith(
                        color: ColorPalette.grey400,
                      ),
                    ),
                  ),
                  BlocBuilder<countragents.CounteragentsCubit,
                      countragents.CounteragentState>(
                    builder: (context, state) {
                      return state.maybeWhen(
                        loadingState: () => const CircularProgressIndicator(
                          color: Colors.amber,
                        ),
                        loadedState: (counteragents) {
                          return DropdownButton(
                            underline: const SizedBox(),
                            value: counteragent,
                            alignment: AlignmentDirectional.centerEnd,
                            icon: SvgPicture.asset(
                              "assets/images/svg/chevron_right.svg",
                            ),
                            onChanged: (String? newValue) {
                              counteragent = newValue!;
                              for (int i = 0; i < counteragents.length; i++) {
                                if (counteragent == counteragents[i].name &&
                                    counteragents[i].id != -1) {
                                  counteragentId = counteragents[i].id;
                                }
                              }
                              setState(() {});
                            },
                            items: counteragents
                                .map((e) => e.name)
                                .toList()
                                .map<DropdownMenuItem<String>>((String? value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(
                                  "$value",
                                ),
                              );
                            }).toList(),
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
                ],
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
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      "Склад с которого делается возврат",
                      style: ThemeTextStyle.textStyle14w400.copyWith(
                        color: ColorPalette.grey400,
                      ),
                    ),
                  ),
                  BlocBuilder<countragents.CounteragentsCubit,
                      countragents.CounteragentState>(
                    builder: (context, state) {
                      return state.maybeWhen(
                        loadingState: () => const CircularProgressIndicator(
                          color: Colors.amber,
                        ),
                        loadedState: (counteragents) {
                          return DropdownButton(
                            underline: const SizedBox(),
                            value: fromCounteragent,
                            alignment: AlignmentDirectional.centerEnd,
                            icon: SvgPicture.asset(
                              "assets/images/svg/chevron_right.svg",
                            ),
                            onChanged: (String? newValue) {
                              fromCounteragent = newValue!;
                              for (int i = 0; i < counteragents.length; i++) {
                                if (fromCounteragent == counteragents[i].name &&
                                    counteragents[i].id != -1) {
                                  fromCounteragentId = counteragents[i].id;
                                }
                              }
                              setState(() {});
                            },
                            items: counteragents
                                .map((e) => e.name)
                                .toList()
                                .map<DropdownMenuItem<String>>((String? value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(
                                  "$value",
                                ),
                              );
                            }).toList(),
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
                ],
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
                        buildAlertDialog(context);
                  } else {
                    buildErrorCustomSnackBar(
                      context,
                      "Вы не выбрали все пункты!!!",
                    );
                  }
                  // AppRouter.push(
                  //   context,
                  //   BarcodeScannerScreen(
                  //     callback: (code) {
                  //       toastServiceSuccess(code);
                  //       AppRouter.push(
                  //           context, const ReturnDataScannedScreen());
                  //     },
                  //   ),
                  // );
                },
                child: Container(
                  padding: const EdgeInsets.all(28),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF87615),
                    borderRadius: BorderRadius.circular(100),
                    border: Border.all(color: const Color(0xFFd86814)),
                  ),
                  child: SvgPicture.asset("assets/images/svg/move_plus.svg"),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
