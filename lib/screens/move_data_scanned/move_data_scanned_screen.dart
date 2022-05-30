import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pharmacy_arrival/network/models/dto_models/response/dto_move_data.dart';
import 'package:pharmacy_arrival/screens/fill_move_details/fill_number.dart';
import 'package:pharmacy_arrival/screens/move_data_scanned/bloc/bloc_move_data_bloc.dart';
import 'package:pharmacy_arrival/styles/color_palette.dart';
import 'package:pharmacy_arrival/styles/text_styles.dart';
import 'package:pharmacy_arrival/utils/app_router.dart';
import 'package:pharmacy_arrival/widgets/app_loader_overlay.dart';
import 'package:pharmacy_arrival/widgets/custom_app_bar.dart';

class MoveDataScannedScreen extends StatelessWidget {
  const MoveDataScannedScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppLoaderOverlay(
      child: Scaffold(
        appBar: CustomAppBar(
          title: "Отсканированные".toUpperCase(),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 12.0),
              child: GestureDetector(
                child: SvgPicture.asset("assets/images/svg/delete_scanned.svg"),
              ),
            ),
          ],
        ),
        body: BlocConsumer<BlocMoveData, StateBlocMoveData>(
          listener: (context, state) {
            if (state is StateMoveDataLoading) {
              context.loaderOverlay.show();
            } else {
              context.loaderOverlay.hide();
            }
          },
          buildWhen: (p, c) => c is StateMoveDataLoadData,
          builder: (context, state) {
            if (state is StateMoveDataLoadData) {
              return Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12.0,
                  vertical: 27.0,
                ),
                child: Column(
                  children: [
                    ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 16.0),
                          child: _BuildGoodDetails(
                            good: state.goods[index],
                            index: index,
                          ),
                        );
                      },
                      itemCount: state.goods.length,
                      shrinkWrap: true,
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
                      onPressed: () {},
                      child: Center(
                        child: Text(
                          "Завершить",
                          style: ThemeTextStyle.textStyle14w600
                              .copyWith(color: ColorPalette.white),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}

class _BuildGoodDetails extends StatefulWidget {
  final DTOMoveData good;
  final int index;

  const _BuildGoodDetails({
    Key? key,
    required this.good,
    required this.index,
  }) : super(key: key);

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
          children: [
            Stack(
              children: [
                SizedBox(
                  width: 104,
                  height: 104,
                  child: Image.network(
                    widget.good.image ?? 'null',
                    errorBuilder: (context, child, stacktrace) {
                      return const Center(
                        child: Icon(Icons.error),
                      );
                    },
                  ),
                ),
                Positioned(
                  bottom: 8,
                  left: 8,
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: ColorPalette.white,
                      border: Border.all(
                        color: ColorPalette.green,
                      ),
                    ),
                    child: Text(
                      "${widget.good.totalCount} шт.",
                      style: ThemeTextStyle.textStyle12w600.copyWith(
                        color: ColorPalette.green,
                      ),
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(
              width: 12,
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "${widget.good.scanCount!}x",
                        style: ThemeTextStyle.textStyle14w400
                            .copyWith(color: ColorPalette.black),
                      ),
                      Text(
                        widget.good.series ?? 'null',
                        style: ThemeTextStyle.textStyle14w600
                            .copyWith(color: ColorPalette.grayText),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Text(
                    '${widget.good.name}',
                    overflow: TextOverflow.fade,
                    style: ThemeTextStyle.textStyle20w600,
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Text(
                    "${widget.good.producer}",
                    style: ThemeTextStyle.textStyle14w400.copyWith(
                      color: ColorPalette.grayText,
                    ),
                  ),
                  const SizedBox(
                    height: 14,
                  ),
                  if (widget.good.id == 1)
                    GestureDetector(
                      onTap: () {
                        AppRouter.push(
                          context,
                          FillNumberScreen(
                            moveData: widget.good,
                            index: widget.index,
                          ),
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15.5, vertical: 6),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF3F6FB),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          'Ввести серию',
                          style: ThemeTextStyle.textStyle14w600
                              .copyWith(color: const Color(0xFF5CA7FF)),
                        ),
                      ),
                    )
                  else
                    const SizedBox()
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Future _bottomSheet(Widget widget) {
    return showModalBottomSheet(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
      ),
      context: context,
      enableDrag: true,
      isDismissible: false,
      isScrollControlled: true,
      builder: (context) {
        return widget;
      },
    );
  }
}
