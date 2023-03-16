import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:pharmacy_arrival/app/bloc/counteragent_cubit.dart'
    as countragents;
import 'package:pharmacy_arrival/core/styles/color_palette.dart';
import 'package:pharmacy_arrival/core/styles/text_styles.dart';
import 'package:pharmacy_arrival/data/model/counteragent_dto.dart';
import 'package:pharmacy_arrival/screens/move_data/vmodel/move_filter_vmodel.dart';
import 'package:pharmacy_arrival/widgets/custom_app_bar.dart';
import 'package:pharmacy_arrival/widgets/custom_button.dart';
import 'package:pharmacy_arrival/widgets/main_text_field/app_text_field.dart';
import 'package:provider/provider.dart';
import 'package:search_choices/search_choices.dart';

class MoveFilterPage extends StatefulWidget {
  final VoidCallback callback;
  const MoveFilterPage({super.key, required this.callback});

  @override
  State<MoveFilterPage> createState() => _MoveFilterPageState();
}

class _MoveFilterPageState extends State<MoveFilterPage> {
  TextEditingController dateController = TextEditingController();

  String? recipient;
  int recipientId = -1;
  String? sender;
  int senderId = -1;
  String sortType = "Не выбрана";

  List<DropdownMenuItem<String>> get dropdownItems {
    const List<DropdownMenuItem<String>> moveTypes = [
      DropdownMenuItem(value: "Не выбрана", child: Text("Не выбрана")),
      DropdownMenuItem(value: "Сначало новые", child: Text("Сначало новые")),
      DropdownMenuItem(value: "Сначало старые", child: Text("Сначало старые")),
    ];
    return moveTypes;
  }

  @override
  void initState() {
    final MoveFilterVmodel myProvider =
        Provider.of<MoveFilterVmodel>(context, listen: false);
    if (myProvider.sortType != null) {
      if (myProvider.sortType == 0) {
        sortType = 'Сначало новые';
      } else if (myProvider.sortType == 1) {
        sortType = 'Сначало старые';
      }
    }
    senderId = myProvider.sender?.id ?? -1;
    sender = myProvider.sender?.name;

    recipientId = myProvider.recipient?.id ?? -1;
    recipient = myProvider.recipient?.name;
    if (myProvider.date != null) {
      dateController.text = myProvider.date!;
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Consumer<MoveFilterVmodel>(
        builder: (BuildContext context, model, Widget? child) {
          return Scaffold(
            floatingActionButton: Padding(
              padding: const EdgeInsets.fromLTRB(32, 0, 0, 0),
              child: CustomButton(
                height: 44,
                onClick: () {
                  if (sortType != 'Не выбрана') {
                    model.sortType = (sortType == "Сначало новые") ? 0 : 1;
                  } else {
                    model.sortType = null;
                  }
                  if (senderId != -1) {
                    model.sender = CounteragentDTO(id: senderId, name: sender);
                  } else {
                    model.sender = null;
                  }
                  if (recipientId != -1) {
                    model.recipient =
                        CounteragentDTO(id: recipientId, name: recipient);
                  } else {
                    model.recipient = null;
                  }
                  if (dateController.text.isNotEmpty) {
                    model.date = dateController.text;
                  } else {
                    model.date = null;
                  }

                  model.filterCount = 0;
                  if (model.sortType != null) {
                    model.filterCount += 1;
                  }
                  if (model.sender != null) {
                    model.filterCount += 1;
                  }
                  if (model.date != null) {
                    model.filterCount += 1;
                  }
                  if (model.recipient != null) {
                    model.filterCount += 1;
                  }

                  widget.callback();
                  Navigator.pop(context);
                },
                body: const Text(
                  'Показать результаты',
                  style: TextStyle(),
                ),
                style: pinkButtonStyle(),
              ),
            ),
            appBar: CustomAppBar(
              title: "Фильтр".toUpperCase(),
            ),
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: ListView(
                  children: [
                    getFilterTitle(title: "Сортировака по датам"),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 4,
                        horizontal: 12,
                      ),
                      decoration: BoxDecoration(
                        color: ColorPalette.white,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Сортировка по датам",
                            style: ThemeTextStyle.textStyle14w400.copyWith(
                              color: ColorPalette.grey400,
                            ),
                          ),
                          DropdownButton(
                            icon: SvgPicture.asset(
                              "assets/images/svg/chevron_right.svg",
                            ),
                            underline: const SizedBox(),
                            value: sortType,
                            items: dropdownItems,
                            alignment: AlignmentDirectional.centerEnd,
                            onChanged: (String? value) {
                              sortType = value!;
                              setState(() {});
                            },
                          ),
                        ],
                      ),
                    ),
                    getDivider(),
                    getFilterTitle(title: "Отправитель"),
                    Container(
                      padding: sender != null
                          ? const EdgeInsets.symmetric(horizontal: 8)
                          : null,
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
                                displayClearIcon: sender != null,
                                clearIcon: const Icon(Icons.close),
                                onClear: sender != null
                                    ? () {
                                        sender = null;
                                        senderId = -1;
                                      }
                                    : null,
                                padding: senderId == -1 ? 14 : 7,
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
                                icon: sender != null
                                    ? null
                                    : const Icon(Icons.arrow_forward_ios),
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
                    getDivider(),
                    getFilterTitle(title: "Получатель"),
                    Container(
                      padding: recipient != null
                          ? const EdgeInsets.symmetric(horizontal: 8)
                          : null,
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
                                displayClearIcon: recipient != null,
                                clearIcon: const Icon(Icons.close),
                                onClear: recipient != null
                                    ? () {
                                        recipient = null;
                                        recipientId = -1;
                                      }
                                    : null,
                                padding: recipientId == -1 ? 14 : 7,
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
                                icon: recipient != null
                                    ? null
                                    : const Icon(Icons.arrow_forward_ios),
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
                    getDivider(),
                    getFilterTitle(title: 'Время отправления'),
                    _DatePicker(
                      controller: dateController,
                      hintText: "Дата отправления",
                      onClose: () {
                        dateController.clear();
                        model.date = null;
                      },
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Padding getFilterTitle({required String title}) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
      child: Text(
        title,
        style: ThemeTextStyle.textStyle15w300,
      ),
    );
  }

  Padding getDivider() {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: Divider(
        color: ColorPalette.borderGrey,
      ),
    );
  }
}

class _DatePicker extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final VoidCallback onClose;
  const _DatePicker({
    required this.controller,
    required this.hintText,
    required this.onClose,
  });

  @override
  State<_DatePicker> createState() => _DatePickerState();
}

class _DatePickerState extends State<_DatePicker> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        final DateTime? date = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(1950),
          lastDate: DateTime(2050),
          helpText: widget.hintText,
          builder: (context, child) {
            return Theme(
              data: Theme.of(context).copyWith(
                colorScheme: const ColorScheme.light(
                  primary: ColorPalette.greyDark,
                ),
                textTheme: TextTheme(
                  headlineSmall: ThemeTextStyle.textTitleDella24w400,
                  labelSmall: ThemeTextStyle.textStyle16w600,
                ),
                textButtonTheme: TextButtonThemeData(
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.black, textStyle: ThemeTextStyle.textStyle14w600
                        .copyWith(color: Colors.black),
                  ),
                ),
              ),
              child: child!,
            );
          },
        );
        if (date != null) {
          widget.controller.text = DateFormat("yyyy-MM-dd").format(date);
        }
        setState(() {});
      },
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: ColorPalette.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              widget.hintText,
              //"Выберите дату отправления",
              style: ThemeTextStyle.textStyle14w400.copyWith(
                color: ColorPalette.grey400,
              ),
            ),
            const SizedBox(
              width: 16,
            ),
            Flexible(
              child: AppTextField(
                contentPadding: EdgeInsets.zero,
                capitalize: false,
                controller: widget.controller,
                readonly: true,
                textAlign: TextAlign.right,
                showErrorMessages: false,
                suffixIcon: Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: GestureDetector(
                    onTap: widget.controller.text.isNotEmpty
                        ? () {
                            widget.onClose();

                            // if (searchController.text.isEmpty) {
                            //   // BlocProvider.of<ReturnOrderPageCubit>(
                            //   //         context)
                            //   //     .onRefreshOrders(
                            //   //   refundStatus: status,
                            //   // );
                            // } else {
                            //   // BlocProvider.of<ReturnOrderPageCubit>(
                            //   //         context)
                            //   //     .getOrdersBySearch(
                            //   //   incomingNumber: searchController.text,
                            //   // );
                            // }
                          }
                        : () async {
                            final DateTime? date = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(2019),
                              lastDate: DateTime.now(),
                              helpText: widget.hintText,
                              builder: (context, child) {
                                return Theme(
                                  data: Theme.of(context).copyWith(
                                    colorScheme: const ColorScheme.light(
                                      primary: ColorPalette.greyDark,
                                    ),
                                    textTheme: TextTheme(
                                      headlineSmall:
                                          ThemeTextStyle.textTitleDella24w400,
                                      labelSmall: ThemeTextStyle.textStyle16w600,
                                    ),
                                    textButtonTheme: TextButtonThemeData(
                                      style: TextButton.styleFrom(
                                        foregroundColor: Colors.black, textStyle: ThemeTextStyle
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
                              widget.controller.text =
                                  DateFormat("yyyy-MM-dd").format(date);
                            }
                            setState(() {});
                          },
                    child: widget.controller.text.isNotEmpty
                        ? const Icon(
                            Icons.close,
                            size: 24,
                            color: ColorPalette.grey400,
                          )
                        : SvgPicture.asset(
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
    );
  }
}
