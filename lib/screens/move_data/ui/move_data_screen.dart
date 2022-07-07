import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pharmacy_arrival/data/model/move_data_dto.dart';
import 'package:pharmacy_arrival/data/model/product_dto.dart';
import 'package:pharmacy_arrival/main/counteragent_cubit/counteragent_cubit.dart'
    as countragents;
import 'package:pharmacy_arrival/main/organization_cubit/organization_cubit.dart'
    as organization;
import 'package:pharmacy_arrival/screens/move_data/move_cubit/move_cubit.dart';
import 'package:pharmacy_arrival/screens/move_data/move_data_cubit/move_data_screen_cubit.dart';
import 'package:pharmacy_arrival/screens/move_data/ui/move_barcode_screen.dart';
import 'package:pharmacy_arrival/screens/move_data/ui/move_products_screen.dart';
import 'package:pharmacy_arrival/styles/color_palette.dart';
import 'package:pharmacy_arrival/styles/text_styles.dart';
import 'package:pharmacy_arrival/utils/app_router.dart';
import 'package:pharmacy_arrival/widgets/app_loader_overlay.dart';
import 'package:pharmacy_arrival/widgets/custom_app_bar.dart';
import 'package:pharmacy_arrival/widgets/snackbar/custom_snackbars.dart';
import 'package:search_choices/search_choices.dart';

class MoveDataScreen extends StatefulWidget {
  const MoveDataScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<MoveDataScreen> createState() => _MoveDataScreenState();
}

class _MoveDataScreenState extends State<MoveDataScreen> {
  @override
  void initState() {
    BlocProvider.of<MoveCubit>(context).checkMoveDataOrder();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<MoveCubit, MoveState>(
        builder: (BuildContext context, state) {
          return state.when(
            initialState: () {
              return const Center(
                child: CircularProgressIndicator(color: Colors.amber),
              );
            },
            loadingState: () {
              return const Center(
                child: CircularProgressIndicator(color: Colors.amber),
              );
            },
            activeState: (MoveDataDTO moveDataDTO, List<ProductDTO> product) {
              return const Center(
                child: CircularProgressIndicator(color: Colors.amber),
              );
            },
            passiveState: () {
              return const _BuildMoveScreenBody();
            },
          );
        },
        listener: (BuildContext context, state) {
          state.maybeWhen(
            activeState: (MoveDataDTO moveDataDTO, List<ProductDTO> products) {
              AppRouter.pushReplacement(
                context,
                MoveProductsScreen(
                  moveDataDTO: moveDataDTO,
                ),
              );
            },
            passiveState: () {
              return const _BuildMoveScreenBody();
            },
            orElse: () {
              return const Center(
                child: CircularProgressIndicator(color: Colors.amber),
              );
            },
          );
        },
      ),
    );
  }
}

class _BuildMoveScreenBody extends StatefulWidget {
  const _BuildMoveScreenBody({Key? key}) : super(key: key);

  @override
  State<_BuildMoveScreenBody> createState() => __BuildMoveScreenBodyState();
}

class __BuildMoveScreenBodyState extends State<_BuildMoveScreenBody> {
  String? sender;
  int senderId = -1;
  String? recipient;
  int recipientId = -1;
  String? organizationName;
  int organizationId = -1;
  String moveType = "Не выбрана";

  List<DropdownMenuItem<String>> get dropdownItems {
    const List<DropdownMenuItem<String>> moveTypes = [
      DropdownMenuItem(value: "Не выбрана", child: Text("Не выбрана")),
      DropdownMenuItem(value: "Между аптеками", child: Text("Между аптеками")),
      DropdownMenuItem(value: "Между складами", child: Text("Между складами")),
    ];
    return moveTypes;
  }

  TextEditingController numberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AppLoaderOverlay(
      child: BlocConsumer<MoveDataScreenCubit, MoveDataScreenState>(
        listener: (context, state) {
          state.when(
            initialState: () {
              context.loaderOverlay.hide();
            },
            loadingState: () {
              context.loaderOverlay.show();
            },
            loadedState: (MoveDataDTO moveDataDTO) {
              AppRouter.pushReplacement(
                context,
                MoveBarcodeScreen(
                  moveDataDTO: moveDataDTO,
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
          return Scaffold(
            appBar: CustomAppBar(title: "Перемещение".toUpperCase()),
            body: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 15.0, horizontal: 16.5),
              child: ListView(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                    ),
                    decoration: BoxDecoration(
                      color: ColorPalette.white,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      children: [
                        BlocBuilder<countragents.CounteragentsCubit,
                            countragents.CounteragentState>(
                          builder: (context, state) {
                            return state.maybeWhen(
                              loadingState: () =>
                                  const CircularProgressIndicator(
                                color: Colors.amber,
                              ),
                              loadedState: (counteragents) {
                                return SearchChoices.single(
                                  padding: senderId == -1 ? 14 : 7,
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
                                  value: sender,
                                  hint: "Отправитель",
                                  searchHint: "Отправитель",
                                  style: ThemeTextStyle.textStyle14w400,
                                  onChanged: (String? newValue) {
                                    sender = newValue;
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
                                  isExpanded: true,
                                  icon: SvgPicture.asset(
                                    "assets/images/svg/chevron_right.svg",
                                  ),
                                  underline: const SizedBox(),
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
                                        style:
                                            const TextStyle(color: Colors.red),
                                      )
                                    ],
                                  ),
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
                        const Divider(
                          color: ColorPalette.borderGrey,
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
                                return SearchChoices.single(
                                  padding: recipientId == -1 ? 14 : 7,
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
                                  value: recipient,
                                  hint: "Получатель",
                                  searchHint: "Получатель",
                                  style: ThemeTextStyle.textStyle14w400,
                                  onChanged: (String? newValue) {
                                    recipient = newValue;
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
                                  isExpanded: true,
                                  icon: SvgPicture.asset(
                                    "assets/images/svg/chevron_right.svg",
                                  ),
                                  underline: const SizedBox(),
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
                                        style:
                                            const TextStyle(color: Colors.red),
                                      )
                                    ],
                                  ),
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
                          loadedState: (organizations) {
                            return SearchChoices.single(
                              padding: organizationId == -1 ? 14 : 7,
                              displayClearIcon: false,
                              closeButton: "Закрыть",
                              items: organizations
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
                              hint: "Получатель",
                              searchHint: "Получатель",
                              style: ThemeTextStyle.textStyle14w400,
                              onChanged: (String? newValue) {
                                organizationName = newValue;
                                for (int i = 0; i < organizations.length; i++) {
                                  if (organizationName ==
                                          organizations[i].name &&
                                      organizations[i].id != -1) {
                                    organizationId = organizations[i].id;
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
                            setState(() {});
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
                        if (senderId == -1 ||
                            recipientId == -1 ||
                            organizationId == -1 ||
                            moveType == "Не выбрана") {
                          buildErrorCustomSnackBar(
                            context,
                            "Вы не выбрали все пункты!!!",
                          );
                        } else {
                          BlocProvider.of<MoveDataScreenCubit>(context)
                              .createMovingOrder(
                            senderId: senderId,
                            recipientId: recipientId,
                            organizationId: organizationId,
                            movingType: moveType == "Между аптеками" ? 1 : 2,
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
            ),
          );
        },
      ),
    );
  }
}
