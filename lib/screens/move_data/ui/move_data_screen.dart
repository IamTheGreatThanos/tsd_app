import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pharmacy_arrival/app/bloc/counteragent_cubit.dart'
    as countragents;
import 'package:pharmacy_arrival/app/bloc/counteragent_cubit.dart';
import 'package:pharmacy_arrival/app/bloc/counteragent_of_user_cubit.dart';
import 'package:pharmacy_arrival/core/styles/color_palette.dart';
import 'package:pharmacy_arrival/core/styles/text_styles.dart';
import 'package:pharmacy_arrival/core/utils/app_router.dart';
import 'package:pharmacy_arrival/data/model/move_data_dto.dart';
import 'package:pharmacy_arrival/screens/move_data/move_data_cubit/move_data_screen_cubit.dart';
import 'package:pharmacy_arrival/screens/move_data/ui/move_barcode_screen.dart';
import 'package:pharmacy_arrival/widgets/app_loader_overlay.dart';
import 'package:pharmacy_arrival/widgets/custom_app_bar.dart';
import 'package:pharmacy_arrival/widgets/snackbar/custom_snackbars.dart';
import 'package:search_choices/search_choices.dart';

class MoveDataScreen extends StatefulWidget {
  const MoveDataScreen({
    super.key,
  });

  @override
  State<MoveDataScreen> createState() => _MoveDataScreenState();
}

class _MoveDataScreenState extends State<MoveDataScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: _BuildMoveScreenBody(),
    );
  }
}

class _BuildMoveScreenBody extends StatefulWidget {
  const _BuildMoveScreenBody();

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

  TextEditingController reciverController = TextEditingController();

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
                        BlocBuilder<CounteragentOfUserCubit, CounteragentOfUserState>(
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
                                    if (newValue == recipient) {
                                      buildErrorCustomSnackBar(
                                        context,
                                        "Вы не можете сделать перемещение на свой адрес, пожалуйста, выберите другой адрес",
                                      );
                                    } else {
                                      sender = newValue;
                                      for (int i = 0;
                                          i < counteragents.length;
                                          i++) {
                                        if (sender == counteragents[i].name &&
                                            counteragents[i].id != -1) {
                                          senderId = counteragents[i].id;
                                        }
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
                        // AppTextField(
                        //   controller: reciverController,
                        //   hintText: "Получатель",
                        //   hintStyle: ThemeTextStyle.textStyle14w400
                        //       .copyWith(color: ColorPalette.grey400),
                        //   fillColor: ColorPalette.white,
                        //   contentPadding: const EdgeInsets.only(
                        //     top: 18,
                        //     bottom: 18,
                        //     left: 13,
                        //   ),
                        // )
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
                                    if (newValue == sender) {
                                      buildErrorCustomSnackBar(
                                        context,
                                        "Вы не можете сделать перемещение на свой адрес, пожалуйста, выберите другой адрес",
                                      );
                                    } else {
                                      recipient = newValue;
                                      for (int i = 0;
                                          i < counteragents.length;
                                          i++) {
                                        if (recipient ==
                                                counteragents[i].name &&
                                            counteragents[i].id != -1) {
                                          recipientId = counteragents[i].id;
                                        }
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
                    height: 32,
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: GestureDetector(
                      onTap: () {
                        if (senderId == -1 || recipientId == -1) {
                          buildErrorCustomSnackBar(
                            context,
                            "Вы не выбрали все пункты!!!",
                          );
                        } else {
                          BlocProvider.of<MoveDataScreenCubit>(context)
                              .createMovingOrder(
                            senderId: senderId,
                            recipientId: recipientId,
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
