import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pharmacy_arrival/core/styles/color_palette.dart';
import 'package:pharmacy_arrival/core/styles/text_styles.dart';
import 'package:pharmacy_arrival/core/utils/app_router.dart';
import 'package:pharmacy_arrival/data/model/product_dto.dart';
import 'package:pharmacy_arrival/screens/refund_containers/bloc/refund_container_cubit.dart';
import 'package:pharmacy_arrival/screens/refund_containers/ui/refund_container_barcode_screen.dart';
import 'package:pharmacy_arrival/widgets/app_loader_overlay.dart';
import 'package:pharmacy_arrival/widgets/custom_app_bar.dart';
import 'package:pharmacy_arrival/widgets/custom_button.dart';
import 'package:pharmacy_arrival/widgets/snackbar/custom_snackbars.dart';

class RefundContainersPage extends StatefulWidget {
  const RefundContainersPage({super.key});

  @override
  State<RefundContainersPage> createState() => _RefundContainersPageState();
}

class _RefundContainersPageState extends State<RefundContainersPage> {
  List<ProductDTO> containers = [];

  @override
  Widget build(BuildContext context) {
    return AppLoaderOverlay(
      child: WillPopScope(
        onWillPop: () async {
          showDialog(
            context: context,
            builder: (context) => const OnPopAlert(),
          );
          return true;
        },
        child: Scaffold(
          floatingActionButton: Padding(
            padding: const EdgeInsets.fromLTRB(32, 0, 0, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SizedBox(
                  height: 80,
                  width: 80,
                  child: FloatingActionButton(
                    child: Image.asset(
                      'assets/images/png/scan_floating.png',
                    ),
                    onPressed: () {
                      AppRouter.push(
                        context,
                        RefundContainerBarcodeScreen(
                          onScanned: (p0) {
                            containers.add(ProductDTO(id: 0, name: p0));
                            setState(() {});
                          },
                        ),
                      );
                    },
                  ),
                ),
                BlocListener<RefundContainerCubit, RefundContainerState>(
                  listener: (context, state) {
                    state.maybeWhen(
                      loadedState: (message) {
                        context.loaderOverlay.hide();
                        buildSuccessCustomSnackBar(context, message);
                        Navigator.pop(context);
                      },
                      loadingState: () {
                        context.loaderOverlay.show();
                      },
                      errorState: (message) {
                        context.loaderOverlay.hide();
                        buildErrorCustomSnackBar(context, message);
                      },
                      orElse: () {
                        context.loaderOverlay.hide();
                      },
                    );
                  },
                  child: CustomButton(
                    height: 44,
                    onClick: () {
                      BlocProvider.of<RefundContainerCubit>(context)
                          .refundContainer(
                        names: containers.map((e) => e.name ?? "").toList(),
                      );
                    },
                    body: const Text(
                      'Завершить',
                      style: TextStyle(),
                    ),
                    style: pinkButtonStyle(),
                  ),
                ),
              ],
            ),
          ),
          backgroundColor: ColorPalette.main,
          appBar: CustomAppBar(
            onBackTap: () {
              showDialog(
                context: context,
                builder: (context) => const OnPopAlert(),
              );
            },
            title: "Возврат контейнеров".toUpperCase(),
            showLogo: false,
          ),
          body: Column(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          vertical: 5,
                          horizontal: 12,
                        ),
                        decoration: BoxDecoration(
                          color: ColorPalette.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          children: [
                            Text(
                              "Контейнеры",
                              style: ThemeTextStyle.textStyle14w500
                                  .copyWith(color: ColorPalette.grayText),
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 6),
                              decoration: BoxDecoration(
                                color: ColorPalette.borderGrey,
                                borderRadius: BorderRadius.circular(100),
                              ),
                              child: Text(
                                "${containers.length}",
                                style: ThemeTextStyle.textStyle12w600.copyWith(
                                  color: ColorPalette.black,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                        shrinkWrap: true,
                        padding: const EdgeInsets.only(
                          left: 12.5,
                          right: 12.5,
                          top: 20,
                        ),
                        itemCount: containers.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {},
                            child: _BuildGoodDetails(
                              container: containers[index],
                              onDelete: () {
                                containers.removeAt(index);
                                setState(() {});
                              },
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 50,
              )
            ],
          ),
        ),
      ),
    );
  }
}

class OnPopAlert extends StatelessWidget {
  const OnPopAlert({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Подтвердить навигацию'),
      content: const Text(
        'Вы потеряете всю несохраненную работу. \n\nВы уверены, что хотите покинуть эту страницу?',
      ),
      actions: [
        TextButton(
          child: const Text('Остаться на этой странице'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        TextButton(
          child: const Text(
            'Покинуть эту страницу',
            style: TextStyle(color: Colors.red),
          ),
          onPressed: () {
            Navigator.of(context).pop();
            Navigator.of(context).pop();
          },
        )
      ],
    );
  }
}

class _BuildGoodDetails extends StatefulWidget {
  final ProductDTO container;
  final Function() onDelete;

  const _BuildGoodDetails({
    required this.container,
    required this.onDelete,
  });

  @override
  State<_BuildGoodDetails> createState() => _BuildGoodDetailsState();
}

class _BuildGoodDetailsState extends State<_BuildGoodDetails> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: ColorPalette.white,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: widget.container.status != 0
                          ? ColorPalette.lightGreen
                          : ColorPalette.lightYellow,
                      border: Border.all(
                        color: widget.container.status != 0
                            ? ColorPalette.borderGreen
                            : ColorPalette.borderYellow,
                      ),
                      borderRadius: BorderRadius.circular(100),
                    ),
                    padding:
                        const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                    child: Center(
                      child: Text(
                        widget.container.status != 0
                            ? "Подтвержден"
                            : "Не подтвержден",
                        style: ThemeTextStyle.textStyle12w600.copyWith(
                          color: widget.container.status != 0
                              ? ColorPalette.textGreen
                              : ColorPalette.textYellow,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    children: [
                      const Text(
                        'Контейнер:',
                        overflow: TextOverflow.fade,
                        style: ThemeTextStyle.textStyle24w600,
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Expanded(
                        child: Text(
                          '${widget.container.name} ',
                          overflow: TextOverflow.fade,
                          style: ThemeTextStyle.textStyle20w600,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  CustomButton(
                    body: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(
                          Icons.delete,
                          size: 20,
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        Text('Удалить'),
                      ],
                    ),
                    onClick: widget.onDelete,
                    style: redButtonStyle(),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
