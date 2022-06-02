import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pharmacy_arrival/screens/move_data/ui/_vmodel.dart';
import 'package:pharmacy_arrival/screens/move_data/ui/move_data_screen.dart';
import 'package:pharmacy_arrival/screens/pharmacy_arrival/ui/pharmacy_arrival_screen.dart';
import 'package:pharmacy_arrival/screens/return_data/ui/_vmodel.dart';
import 'package:pharmacy_arrival/screens/return_data/ui/return_data_screen.dart';
import 'package:pharmacy_arrival/screens/warehouse_arrival/ui/warehouse_arrival_screen.dart';
import 'package:pharmacy_arrival/styles/color_palette.dart';
import 'package:pharmacy_arrival/styles/text_styles.dart';
import 'package:pharmacy_arrival/utils/app_router.dart';
import 'package:pharmacy_arrival/widgets/main_text_field/app_text_field.dart';
import 'package:provider/provider.dart';

import '../goods_list/ui/goods_list_screen.dart';

class MainMenuScreen extends StatefulWidget {
  const MainMenuScreen({Key? key}) : super(key: key);

  @override
  State<MainMenuScreen> createState() => _MainMenuScreenState();
}

class _MainMenuScreenState extends State<MainMenuScreen> {
  late final OutlineInputBorder inputBorder;
  final searchController = TextEditingController();

  @override
  void initState() {
    inputBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(16.0),
      borderSide: BorderSide(
        color: ColorPalette.white.withOpacity(0.32),
      ),
    );
    super.initState();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorPalette.purpleLight,
      body: Stack(
        children: [
          Image.asset(
            "assets/images/png/noise.png",
            width: double.infinity,
            fit: BoxFit.cover,
          ),
          Positioned(
            top: 55,
            left: 12,
            right: 12,
            child: Column(
              children: [
                AppTextField(
                  controller: searchController,
                  hintText: "Искать по номеру заказа",
                  hintStyle: ThemeTextStyle.textStyle14w400
                      .copyWith(color: ColorPalette.white),
                  fillColor: ColorPalette.white.withOpacity(0.24),
                  prefixIcon: SvgPicture.asset("assets/images/svg/search.svg"),
                  contentPadding:
                      const EdgeInsets.only(top: 17, bottom: 17, left: 13),
                  disabledBorder: inputBorder,
                  enabledBorder: inputBorder,
                  focusedBorder: inputBorder,
                ),
                const SizedBox(
                  height: 8,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Шевченко 90",
                      style: ThemeTextStyle.textStyle16w600,
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    SvgPicture.asset(
                      "assets/images/svg/chevrone_down.svg",
                      color: ColorPalette.black,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 150,
                ),
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _BuildMenuOption(
                          icon: "stock_arrival_logo",
                          title: "Приход\n на склад",
                          color: const Color(0xFFD73A49).withOpacity(0.52),
                          onTap: () => AppRouter.push(
                            context,
                            const WarehouseArrivalScreen(),
                          ),
                          pad: true,
                        ),
                        _BuildMenuOption(
                          icon: "pharmacy_arrival_logo",
                          title: "Приход\nАптека",
                          color: const Color(0xFF28A745).withOpacity(0.52),
                          onTap: () => AppRouter.push(
                            context,
                            const PharmacyArrivalScreen(),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _BuildMenuOption(
                          icon: "move_logo",
                          title: "Перемещение",
                          color: const Color(0xFFFFD33D).withOpacity(0.52),
                          onTap: () => AppRouter.push(
                            context,
                            ChangeNotifierProvider(
                              create: (context) => MoveDataVModel()..init(),
                              child: const MoveDataScreen(),
                            ),
                          ),
                          pad: true,
                        ),
                        _BuildMenuOption(
                          icon: "return_logo",
                          title: "Возврат",
                          color: const Color(0xFF6F42C1).withOpacity(0.52),
                          onTap: () => AppRouter.push(
                            context,
                            ChangeNotifierProvider(
                              create: (context) => ReturnDataVModel()..init(),
                              child: const ReturnDataScreen(),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                // SizedBox(
                //   width: MediaQuery.of(context).size.width,
                //   height: MediaQuery.of(context).size.height,
                //   child: Stack(
                //     children: [
                //       Positioned(
                //           top: 30,
                //           left: 60,
                //           child: SvgPicture.asset(
                //             "assets/images/svg/move_vector.svg",
                //           )),
                //       Positioned(
                //           top: 84,
                //           right: 26,
                //           child: SvgPicture.asset(
                //             "assets/images/svg/pharmacy_arrival_vector.svg",
                //           )),
                //       Positioned(
                //           top: 154,
                //           left: 33,
                //           child: SvgPicture.asset(
                //             "assets/images/svg/arrival_stock_vector.svg",
                //           )),
                //       Positioned(
                //           top: 240,
                //           right: 71,
                //           child: SvgPicture.asset(
                //             "assets/images/svg/return_vector.svg",
                //           )),
                //       Positioned(
                //           top: 320,
                //           left: 38,
                //           child: SvgPicture.asset(
                //             "assets/images/svg/order_history_vector.svg",
                //           )),
                //     ],
                //   ),
                // ),
              ],
            ),
          ),
          SizedBox.expand(
            child: DraggableScrollableSheet(
              initialChildSize: 0.24,
              minChildSize: 0.2,
              maxChildSize: 0.9,
              builder: (context, controller) {
                return ClipPath(
                  clipper: MyClipper(
                    maxHeight: MediaQuery.of(context).size.height,
                  ),
                  child: Container(
                    padding:
                        const EdgeInsets.only(top: 45, left: 16, right: 16),
                    decoration: const BoxDecoration(
                      color: ColorPalette.white,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Наши аптеки",
                          style: ThemeTextStyle.textStyle20w600,
                        ),
                        Expanded(
                          child: ListView.builder(
                            shrinkWrap: true,
                            controller: controller,
                            itemCount: 9,
                            itemBuilder: (context, index) {
                              return Center(
                                child: Text(
                                  "Аптека $index",
                                  style: ThemeTextStyle.textStyle16w400,
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _BuildMenuOption extends StatelessWidget {
  final String icon;
  final String title;
  final Color color;
  final bool pad;
  final VoidCallback onTap;

  const _BuildMenuOption({
    Key? key,
    required this.icon,
    required this.title,
    required this.color,
    required this.onTap,
    this.pad = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: pad ? 8.0 : 0, bottom: 8),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: 148,
          width: MediaQuery.of(context).size.width / 2 - 20,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset("assets/images/png/$icon.png"),
              const SizedBox(
                height: 8,
              ),
              Text(
                title,
                style: ThemeTextStyle.textStyle16w600
                    .copyWith(color: ColorPalette.white),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MyClipper extends CustomClipper<Path> {
  final double maxHeight;

  MyClipper({required this.maxHeight});

  @override
  Path getClip(Size size) {
    final path = Path();

    path.moveTo(0, size.height * 0.01);

    path.quadraticBezierTo(
      size.width / 2,
      0,
      size.width,
      (maxHeight - size.height) * 0.1,
    );

    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);

    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
