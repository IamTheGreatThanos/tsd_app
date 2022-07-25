import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:pharmacy_arrival/styles/color_palette.dart';
import 'package:pharmacy_arrival/styles/text_styles.dart';
import 'package:pharmacy_arrival/widgets/custom_app_bar.dart';
import 'package:pharmacy_arrival/widgets/custom_button.dart';
import 'package:pharmacy_arrival/widgets/main_text_field/app_text_field.dart';
import 'package:pharmacy_arrival/main/counteragent_cubit/counteragent_cubit.dart'
    as countragents;
import 'package:search_choices/search_choices.dart';

class PharmacyFilterPage extends StatefulWidget {
  const PharmacyFilterPage({Key? key}) : super(key: key);

  @override
  State<PharmacyFilterPage> createState() => _PharmacyFilterPageState();
}

class _PharmacyFilterPageState extends State<PharmacyFilterPage> {
  TextEditingController departureDateController = TextEditingController();
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
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Padding(
        padding: const EdgeInsets.fromLTRB(32, 0, 0, 0),
        child: CustomButton(
          height: 44,
          onClick: () {},
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
                              .map<DropdownMenuItem<String>>((String? value) {
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
                            for (int i = 0; i < counteragents.length; i++) {
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
              getFilterTitle(title: 'Номер документа'),
              AppTextField(
                hintText: "Введите номер документа",
              ),
              getDivider(),
              getFilterTitle(title: 'Время отправления'),
              GestureDetector(
                onTap: () async {
                  final DateTime? date = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(1950),
                    lastDate: DateTime(2050),
                    helpText: "Дата входящего номера",
                    builder: (context, child) {
                      return Theme(
                        data: Theme.of(context).copyWith(
                          colorScheme: const ColorScheme.light(
                            primary: ColorPalette.greyDark,
                          ),
                          textTheme: TextTheme(
                            headline5: ThemeTextStyle.textTitleDella24w400,
                            overline: ThemeTextStyle.textStyle16w600,
                          ),
                          textButtonTheme: TextButtonThemeData(
                            style: TextButton.styleFrom(
                              primary: Colors.black,
                              textStyle: ThemeTextStyle.textStyle14w600
                                  .copyWith(color: Colors.black),
                            ),
                          ),
                        ),
                        child: child!,
                      );
                    },
                  );
                  if (date != null) {
                    setState(() {
                      // BlocProvider.of<ReturnOrderPageCubit>(context)
                      //     .getOrdersBySearch(
                      //   incomingNumber: searchController.text,
                      //   incomingDate: DateFormat("yyyy-MM-dd").format(date),
                      // );
                    });
                    departureDateController.text =
                        DateFormat("yyyy-MM-dd").format(date);
                  }
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
                        "Выберите дату отправления",
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
                          controller: departureDateController,
                          readonly: true,
                          textAlign: TextAlign.right,
                          showErrorMessages: false,
                          suffixIcon: Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: GestureDetector(
                              onTap: departureDateController.text.isNotEmpty
                                  ? () {
                                      departureDateController.clear();
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
                                      setState(() {});
                                    }
                                  : () async {
                                      final DateTime? date =
                                          await showDatePicker(
                                        context: context,
                                        initialDate: DateTime.now(),
                                        firstDate: DateTime(2019),
                                        lastDate: DateTime.now(),
                                        helpText: "Дата входящего номера",
                                        builder: (context, child) {
                                          return Theme(
                                            data: Theme.of(context).copyWith(
                                              colorScheme:
                                                  const ColorScheme.light(
                                                primary: ColorPalette.greyDark,
                                              ),
                                              textTheme: TextTheme(
                                                headline5: ThemeTextStyle
                                                    .textTitleDella24w400,
                                                overline: ThemeTextStyle
                                                    .textStyle16w600,
                                              ),
                                              textButtonTheme:
                                                  TextButtonThemeData(
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
                                        setState(() {
                                          // BlocProvider.of<ReturnOrderPageCubit>(
                                          //   context,
                                          // ).getOrdersBySearch(
                                          //   incomingNumber:
                                          //       searchController.text,
                                          //   incomingDate:
                                          //       DateFormat("yyyy-MM-dd")
                                          //           .format(date),
                                          // );
                                        });
                                        departureDateController.text =
                                            DateFormat("yyyy-MM-dd")
                                                .format(date);
                                      }
                                    },
                              child: departureDateController.text.isNotEmpty
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
              ),
              getDivider(),
              getFilterTitle(title: "Сумма"),
              Row(
                children: [
                  Expanded(
                    child: AppTextField(
                      hintText: "От",
                      keyboardType: TextInputType.number,
                    ),
                  ),
                  const SizedBox(
                    width: 25,
                  ),
                  Expanded(
                    child: AppTextField(
                      hintText: "До",
                      keyboardType: TextInputType.number,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
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
