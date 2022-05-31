import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pharmacy_arrival/data/model/counteragent_dto.dart';
import 'package:pharmacy_arrival/main/counteragent_cubit/counteragent_cubit.dart'
    as countragents;
import 'package:pharmacy_arrival/main/organization_cubit/organization_cubit.dart'
    as organization;
import 'package:pharmacy_arrival/screens/barcode_scanner/barcode_scanner_screen.dart';
import 'package:pharmacy_arrival/screens/move_data/ui/_vmodel.dart';
import 'package:pharmacy_arrival/screens/move_data_scanned/move_data_scanned_screen.dart';
import 'package:pharmacy_arrival/styles/color_palette.dart';
import 'package:pharmacy_arrival/styles/text_styles.dart';
import 'package:pharmacy_arrival/utils/app_router.dart';
import 'package:pharmacy_arrival/widgets/custom_app_bar.dart';
import 'package:pharmacy_arrival/widgets/toast_service.dart';
import 'package:provider/provider.dart';

class MoveDataScreen extends StatefulWidget {
  const MoveDataScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<MoveDataScreen> createState() => _MoveDataScreenState();
}

class _MoveDataScreenState extends State<MoveDataScreen> {
  List<DropdownMenuItem<CounteragentDTO>> senders = [];

  String sender = 'Не выбран';
  int senderId = -1;
  String recipient = 'Не выбран';
  int recipientId = -1;
  String organizationName = "Организация не выбрана";
  int organizationId = -1;
  String moveType = "Между аптеками";

  List<DropdownMenuItem<String>> get dropdownItems {
    const List<DropdownMenuItem<String>> moveTypes = [
      DropdownMenuItem(value: "Между аптеками", child: Text("Между аптеками")),
      DropdownMenuItem(value: "Между складами", child: Text("Между складами")),
    ];
    return moveTypes;
  }

  TextEditingController numberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final MoveDataVModel _vmodel = context.read<MoveDataVModel>();
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: CustomAppBar(title: "Перемещение".toUpperCase()),
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 16.5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
                decoration: BoxDecoration(
                  color: ColorPalette.white,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Отправитель",
                          style: ThemeTextStyle.textStyle14w400.copyWith(
                            color: ColorPalette.grey400,
                          ),
                        ),
                        const SizedBox(
                          width: 16,
                        ),
                        BlocBuilder<countragents.CounteragentsCubit,
                            countragents.CounteragentState>(
                          builder: (context, state) {
                            return state.maybeWhen(
                              loadingState: () =>
                                  const CircularProgressIndicator(
                                color: Colors.amber,
                              ),
                              loadedState: (counteragents) {
                                return DropdownButton(
                                  underline: const SizedBox(),
                                  value: sender,
                                  alignment: AlignmentDirectional.centerEnd,
                                  icon: SvgPicture.asset(
                                    "assets/images/svg/chevron_right.svg",
                                  ),
                                  onChanged: (String? newValue) {
                                    sender = newValue!;
                                    for (int i = 0;
                                        i < counteragents.length;
                                        i++) {
                                      if (sender == counteragents[i].name &&
                                          counteragents[i].id != -1) {
                                        senderId = counteragents[i].id;
                                      }
                                    }
                                    setState(() {});
                                  },
                                  items: counteragents
                                      .map((e) => e.name)
                                      .toList()
                                      .map<DropdownMenuItem<String>>(
                                          (String? value) {
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
                    const Divider(
                      color: ColorPalette.borderGrey,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Получатель",
                          style: ThemeTextStyle.textStyle14w400.copyWith(
                            color: ColorPalette.grey400,
                          ),
                        ),
                        const SizedBox(
                          width: 16,
                        ),
                        BlocBuilder<countragents.CounteragentsCubit,
                            countragents.CounteragentState>(
                          builder: (context, state) {
                            return state.maybeWhen(
                              loadingState: () =>
                                  const CircularProgressIndicator(
                                color: Colors.amber,
                              ),
                              loadedState: (counteragents) {
                                return DropdownButton(
                                  underline: const SizedBox(),
                                  value: recipient,
                                  alignment: AlignmentDirectional.centerEnd,
                                  icon: SvgPicture.asset(
                                    "assets/images/svg/chevron_right.svg",
                                  ),
                                  onChanged: (String? newValue) {
                                    recipient = newValue!;
                                    for (int i = 0;
                                        i < counteragents.length;
                                        i++) {
                                      if (recipient == counteragents[i].name &&
                                          counteragents[i].id != -1) {
                                        recipientId = counteragents[i].id;
                                      }
                                    }
                                    setState(() {});
                                  },
                                  items: counteragents
                                      .map((e) => e.name)
                                      .toList()
                                      .map<DropdownMenuItem<String>>(
                                          (String? value) {
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
                  ],
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
                decoration: BoxDecoration(
                  color: ColorPalette.white,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Организация",
                      style: ThemeTextStyle.textStyle14w400.copyWith(
                        color: ColorPalette.grey400,
                      ),
                    ),
                    BlocBuilder<organization.OrganizationCubit,
                        organization.OrganizationState>(
                      builder: (context, state) {
                        return state.maybeWhen(
                          loadingState: () => const CircularProgressIndicator(
                            color: Colors.amber,
                          ),
                          loadedState: (organizations) {
                            return DropdownButton(
                              underline: const SizedBox(),
                              value: organizationName,
                              alignment: AlignmentDirectional.centerEnd,
                              icon: SvgPicture.asset(
                                "assets/images/svg/chevron_right.svg",
                              ),
                              onChanged: (String? newValue) {
                                organizationName = newValue!;
                                for (int i = 0; i < organizations.length; i++) {
                                  if (organizationName ==
                                          organizations[i].name &&
                                      organizations[i].id != -1) {
                                    organizationId = organizations[i].id;
                                  }
                                }
                                setState(() {});
                              },
                              items: organizations
                                  .map((e) => e.name)
                                  .toList()
                                  .map<DropdownMenuItem<String>>(
                                      (String? value) {
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
                padding:
                    const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
                decoration: BoxDecoration(
                  color: ColorPalette.white,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Вид перемещения",
                      style: ThemeTextStyle.textStyle14w400.copyWith(
                        color: ColorPalette.grey400,
                      ),
                    ),
                    DropdownButton(
                      icon: SvgPicture.asset(
                        "assets/images/svg/chevron_right.svg",
                      ),
                      underline: const SizedBox(),
                      value: moveType,
                      items: dropdownItems,
                      alignment: AlignmentDirectional.centerEnd,
                      onChanged: (String? value) {
                        moveType = value!;
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
                    AppRouter.push(
                      context,
                      BarcodeScannerScreen(
                        title: "Отсканируйте  товары".toUpperCase(),
                        callback: (code) {
                          toastServiceSuccess(code);
                          AppRouter.push(
                            context,
                            const MoveDataScannedScreen(),
                          );
                        },
                      ),
                    );
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
      ),
    );
  }
}
