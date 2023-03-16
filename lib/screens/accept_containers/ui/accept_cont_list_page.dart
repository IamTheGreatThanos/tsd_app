import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pharmacy_arrival/core/styles/color_palette.dart';
import 'package:pharmacy_arrival/core/styles/text_styles.dart';
import 'package:pharmacy_arrival/core/utils/app_router.dart';
import 'package:pharmacy_arrival/data/model/product_dto.dart';
import 'package:pharmacy_arrival/screens/accept_containers/bloc/accept_cont_list_cubit/accept_cont_list_cubit.dart';
import 'package:pharmacy_arrival/screens/accept_containers/ui/accept_conts_barcode_screen.dart';
import 'package:pharmacy_arrival/widgets/app_loader_overlay.dart';
import 'package:pharmacy_arrival/widgets/custom_alert_dialog.dart';
import 'package:pharmacy_arrival/widgets/custom_app_bar.dart';
import 'package:pharmacy_arrival/widgets/custom_button.dart';
import 'package:pharmacy_arrival/widgets/snackbar/custom_snackbars.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class AcceptContListPage extends StatefulWidget {
  const AcceptContListPage({super.key});

  @override
  State<AcceptContListPage> createState() => _AcceptContListPageState();
}

class _AcceptContListPageState extends State<AcceptContListPage> {
  final ScrollController _controller = ScrollController();

  void _animateToIndex(int index, double height) {
    _controller.animateTo(
      index * height,
      duration: const Duration(seconds: 2),
      curve: Curves.linear,
    );
  }

  FocusNode focusNode = FocusNode();
  String _currentScan = '';
  TextEditingController searchController = TextEditingController();
  @override
  void initState() {
    BlocProvider.of<AcceptContListCubit>(context).getContainers();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AppLoaderOverlay(
      child: RawKeyboardListener(
        autofocus: true,
        focusNode: focusNode,
        onKey: (event) async {
          if (event.logicalKey.keyLabel != 'Enter') {
            _currentScan += event.logicalKey.keyLabel;
          } else if (_currentScan.isNotEmpty) {
            _currentScan = _currentScan.replaceAll('Shift Left', '');
            log('Current Scan: $_currentScan');
            var scanResult = '';
            for (var i = 0; i < _currentScan.length; i++) {
              if (i.isEven) {
                scanResult += _currentScan[i];
              }
            }

            scanResult = scanResult.replaceAll(' ', '').toLowerCase();
            setState(() {
              _currentScan = '';
            });
            BlocProvider.of<AcceptContListCubit>(context).refundScannerBarCode(
              scanResult,
            );
          }
        },
        child: Scaffold(
          floatingActionButton:
              BlocConsumer<AcceptContListCubit, AcceptContListState>(
            listener: (context, state) {
              state.maybeWhen(
                orElse: () {
                  context.loaderOverlay.hide();
                },
                initialState: () {
                  context.loaderOverlay.hide();
                },
                loadingState: () {
                  context.loaderOverlay.show();
                },
                acceptFinishState: () {
                  context.loaderOverlay.hide();
                  buildSuccessCustomSnackBar(context, "Успешно завершен!");
                  Navigator.pop(context);
                },
                errorState: (String message) {
                  buildErrorCustomSnackBar(context, message);
                },
              );
            },
            builder: (context, state) {
              return Padding(
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
                            const AcceptContsBarcodeScreen(),
                          );
                        },
                      ),
                    ),
                    CustomButton(
                      height: 44,
                      onClick: () {
                        BlocProvider.of<AcceptContListCubit>(context)
                            .finishAcceptContainer();
                      },
                      body: const Text(
                        'Завершить',
                        style: TextStyle(),
                      ),
                      style: pinkButtonStyle(),
                    ),
                  ],
                ),
              );
            },
          ),
          backgroundColor: ColorPalette.main,
          appBar: CustomAppBar(
            title: "Контейнеры".toUpperCase(),
            actions: [
              IconButton(
                onPressed: () {
                  buildAlertDialog(context);
                },
                icon: const Icon(
                  Icons.document_scanner_rounded,
                  color: Colors.black,
                ),
              )
            ],
          ),
          body: Column(
            children: [
              Expanded(
                child: BlocConsumer<AcceptContListCubit, AcceptContListState>(
                  builder: (context, state) {
                    return state.maybeWhen(
                      loadingState: () {
                        return const Center(
                          child: CircularProgressIndicator(
                            color: Colors.amber,
                          ),
                        );
                      },
                      loadedState: (
                        List<ProductDTO> containers,
                        ProductDTO selectedContainer,
                      ) {
                        return _BuildBody(
                          scrollController: _controller,
                          searchController: searchController,
                          containers: containers,
                          selectedContainer: selectedContainer,
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
                        return const Center(
                          child: CircularProgressIndicator(
                            color: Colors.red,
                          ),
                        );
                      },
                    );
                  },
                  listener: (context, state) {
                    state.when(
                      initialState: () {},
                      loadingState: () {},
                      acceptFinishState: () {},
                      successScannedState: (String message) {
                        buildSuccessCustomSnackBar(context, message);
                      },
                      loadedState: (
                        containers,
                        selectedProductId,
                      ) {
                        for (int i = 0; i < containers.length; i++) {
                          if (containers[i].id == selectedProductId.id) {
                            _animateToIndex(
                              i,
                              MediaQuery.of(context).size.height * 0.5,
                            );
                          }
                        }
                      },
                      errorState: (String message) {
                        buildErrorCustomSnackBar(context, message);
                      },
                    );
                  },
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

class _BuildBody extends StatefulWidget {
  final ScrollController scrollController;
  final TextEditingController searchController;
  final ProductDTO selectedContainer;
  final List<ProductDTO> containers;
  const _BuildBody({
    required this.containers,
    required this.selectedContainer,
    required this.searchController,
    required this.scrollController,
  });

  @override
  State<_BuildBody> createState() => _BuildBodyState();
}

class _BuildBodyState extends State<_BuildBody> {
  RefreshController controller = RefreshController();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 12),
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
                  padding: const EdgeInsets.symmetric(horizontal: 6),
                  decoration: BoxDecoration(
                    color: ColorPalette.borderGrey,
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: Text(
                    "${widget.containers.length}",
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
          child: SmartRefresher(
            onRefresh: () {
              BlocProvider.of<AcceptContListCubit>(context).getContainers();
            },
            controller: controller,
            child: ListView.builder(
              controller: widget.scrollController,
              shrinkWrap: true,
              padding: const EdgeInsets.only(left: 12.5, right: 12.5, top: 20),
              itemCount: widget.containers.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    // if (currentIndex == 0) {
                    //   AppRouter.push(
                    //     context,
                    //     DefectScreen(
                    //       product: widget.unscannedProducts[index],
                    //       orderId: widget.orderId,
                    //     ),
                    //   );
                    // }
                  },
                  child: _BuildGoodDetails(
                    searchController: widget.searchController,
                    container: widget.containers[index],
                    selectedProduct: widget.selectedContainer,
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}

class _BuildGoodDetails extends StatefulWidget {
  final TextEditingController searchController;
  final ProductDTO container;
  final ProductDTO selectedProduct;
  const _BuildGoodDetails({
    required this.container,
    required this.selectedProduct,
    required this.searchController,
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
          color: widget.container.id == widget.selectedProduct.id
              ? const Color.fromARGB(255, 183, 244, 215)
              : ColorPalette.white,
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
                  Text(
                    '${widget.container.name}',
                    overflow: TextOverflow.fade,
                    style: ThemeTextStyle.textStyle20w600,
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
