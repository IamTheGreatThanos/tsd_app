import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:pharmacy_arrival/core/styles/color_palette.dart';
import 'package:pharmacy_arrival/core/styles/text_styles.dart';
import 'package:pharmacy_arrival/data/model/move_data_dto.dart';
import 'package:pharmacy_arrival/screens/move_data/move_products_cubit/move_products_screen_cubit.dart';
import 'package:pharmacy_arrival/widgets/custom_app_bar.dart';
import 'package:pharmacy_arrival/widgets/main_text_field/app_text_field.dart';
import 'package:pharmacy_arrival/widgets/snackbar/custom_snackbars.dart';

class MoveOrderFinishPage extends StatefulWidget {
  final MoveDataDTO? orderData;
  const MoveOrderFinishPage({super.key, required this.orderData})
     ;

  @override
  State<MoveOrderFinishPage> createState() => _MoveOrderFinishPageState();
}

class _MoveOrderFinishPageState extends State<MoveOrderFinishPage> {
  TextEditingController commentController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  FocusNode focusNode1 = FocusNode();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: CustomAppBar(
          title: '№.${widget.orderData?.id}',
        ),
        body: BlocConsumer<MoveProductsScreenCubit, MoveProductsScreenState>(
          listener: (context, state) {
            state.maybeWhen(
              finishedState: () {
                Navigator.pop(context);
                buildSuccessCustomSnackBar(context, "Успешно завершен");
              },
              orElse: () {},
            );
          },
          builder: (context, state) {
            return state.maybeWhen(
              loadingState: () {
                return const Center(
                  child: CircularProgressIndicator(color: Colors.amber),
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
                return Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 15.0,
                    horizontal: 16.5,
                  ),
                  child: CustomScrollView(
                    slivers: [
                      SliverFillRemaining(
                        hasScrollBody: false,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Заполните поля",
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
                                  AppTextField(
                                    contentPadding: EdgeInsets.zero,
                                    capitalize: false,
                                    showErrorMessages: false,
                                    maxLines: 2,
                                    controller: commentController,
                                    hintText:
                                        'Добавьте коментарий(необязательно)',
                                    hintStyle:
                                        ThemeTextStyle.textStyle14w400.copyWith(
                                      color: ColorPalette.grey400,
                                    ),
                                  ),
                                  const Padding(
                                    padding: EdgeInsets.symmetric(vertical: 4),
                                    child: Divider(
                                      color: ColorPalette.borderGrey,
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () async {
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
                                                headlineSmall: ThemeTextStyle
                                                    .textTitleDella24w400,
                                                labelSmall: ThemeTextStyle
                                                    .textStyle16w600,
                                              ),
                                              textButtonTheme:
                                                  TextButtonThemeData(
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
                                        dateController.text =
                                            DateFormat("yyyy-MM-dd")
                                                .format(date);
                                      }
                                    },
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Дата перемещения",
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
                                            controller: dateController,
                                            readonly: true,
                                            textAlign: TextAlign.right,
                                            showErrorMessages: false,
                                            suffixIcon: Padding(
                                              padding: const EdgeInsets.only(
                                                left: 8.0,
                                              ),
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
                                                            primary:
                                                                ColorPalette
                                                                    .greyDark,
                                                          ),
                                                          textTheme: TextTheme(
                                                            headlineSmall:
                                                                ThemeTextStyle
                                                                    .textTitleDella24w400,
                                                            labelSmall: ThemeTextStyle
                                                                .textStyle16w600,
                                                          ),
                                                          textButtonTheme:
                                                              TextButtonThemeData(
                                                            style: TextButton
                                                                .styleFrom(
                                                              foregroundColor: Colors.black, textStyle:
                                                                  ThemeTextStyle
                                                                      .textStyle14w600
                                                                      .copyWith(
                                                                color: Colors
                                                                    .black,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        child: child!,
                                                      );
                                                    },
                                                  );
                                                  if (date != null) {
                                                    dateController.text =
                                                        DateFormat(
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
                                if(dateController.text.isNotEmpty){
                                   BlocProvider.of<MoveProductsScreenCubit>(
                                  context,
                                ).updateMovingOrderStatus(
                                  moveOrderId: widget.orderData?.id ?? 0,
                                  status: 1,
                                  send: 1,
                                  date: dateController.text,
                                  comment: commentController.text.isEmpty
                                      ? null
                                      : commentController.text,
                                );
                                }else{
                                  buildErrorCustomSnackBar(context, 'Выберите дату перемещения');
                                }
                               
                              },
                              child: Center(
                                child: Text(
                                  "ЗАКОНЧИТЬ",
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
                );
              },
            );
          },
        ),
      ),
    );
  }
}
