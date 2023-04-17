import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pharmacy_arrival/app/bloc/auth_bloc.dart';
import 'package:pharmacy_arrival/app/bloc/profile_cubit.dart';
import 'package:pharmacy_arrival/core/styles/color_palette.dart';
import 'package:pharmacy_arrival/core/styles/text_styles.dart';
import 'package:pharmacy_arrival/core/utils/app_router.dart';
import 'package:pharmacy_arrival/screens/accept_containers/ui/accept_cont_launch_page.dart';
import 'package:pharmacy_arrival/screens/auth/bloc/sign_in_cubit.dart';
import 'package:pharmacy_arrival/screens/history/ui/history_screen.dart';
import 'package:pharmacy_arrival/screens/move_data/ui/_vmodel.dart';
import 'package:pharmacy_arrival/screens/move_data/ui/move_orders_page.dart';
import 'package:pharmacy_arrival/screens/pharmacy_arrival/ui/pharmacy_arrival_screen.dart';
import 'package:pharmacy_arrival/screens/refund_containers/ui/refund_containers_page.dart';
import 'package:pharmacy_arrival/screens/return_data/ui/_vmodel.dart';
import 'package:pharmacy_arrival/screens/return_data/ui/return_orders_page.dart';
import 'package:pharmacy_arrival/screens/warehouse_arrival/ui/warehouse_arrival_screen.dart';
import 'package:pharmacy_arrival/widgets/custom_button.dart';
import 'package:provider/provider.dart';

//TODO Главная страница
class MainMenuScreen extends StatefulWidget {
  const MainMenuScreen();

  @override
  State<MainMenuScreen> createState() => _MainMenuScreenState();
}

class _MainMenuScreenState extends State<MainMenuScreen> {
  late final OutlineInputBorder inputBorder;
  final searchController = TextEditingController();
  List<String> images = [
    'https://st.europharma.kz/blog/5f117b9c9a837.png',
    'https://st.europharma.kz/blog/5f117b7497b14.png',
    'https://st.europharma.kz/blog/5f117b9c9a837.png',
    'https://st.europharma.kz/blog/5f117b7497b14.png',
    'https://st.europharma.kz/blog/5f117b9c9a837.png',
    'https://st.europharma.kz/blog/5f117b7497b14.png',
    'https://st.europharma.kz/blog/5f117b9c9a837.png',
    'https://st.europharma.kz/blog/5f117b7497b14.png',
  ];

  @override
  void initState() {
    inputBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(16.0),
      borderSide: BorderSide(
        color: ColorPalette.white.withOpacity(0.32),
      ),
    );
    BlocProvider.of<SignInCubit>(context).getUserFromCache();
    BlocProvider.of<ProfileCubit>(context).getProfile();
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
      backgroundColor: ColorPalette.backgroundColor,
      body: SafeArea(
        child: Stack(
          children: [
            Positioned(
              top: 0,
              child: SvgPicture.asset(
                "assets/images/svg/logo-e.svg",
                fit: BoxFit.cover,
              ),
            ),
            Positioned(
              top: 0,
              bottom: 0,
              left: 12,
              right: 12,
              child: ListView(
                children: [
                  BlocBuilder<ProfileCubit, ProfileState>(
                    builder: (context, state) {
                      return ListTile(
                        contentPadding: const EdgeInsets.fromLTRB(16, 0, 6, 0),
                        leading: const Icon(
                          Icons.person,
                          color: ColorPalette.gray,
                          size: 60,
                        ),
                        title: Transform.translate(
                          offset: const Offset(-10, 0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      state.whenOrNull(
                                            loadedState: (user) => user.name,
                                          ) ??
                                          "",
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    Text(
                                      state.whenOrNull(
                                            loadedState: (user) => user.login,
                                          ) ??
                                          "",
                                    ),
                                  ],
                                ),
                              ),
                              CustomButton(
                                width: 100,
                                style: pinkButtonStyle(),
                                onClick: () {
                                  BlocProvider.of<AuthBloc>(context)
                                      .add(LogOutEvent());
                                },
                                body: Row(
                                  children: const [
                                    Text("Выйти"),
                                    Icon(
                                      Icons.exit_to_app_outlined,
                                      color: ColorPalette.white,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        subtitle: Transform.translate(
                          offset: const Offset(-10, 0),
                          child: Text(
                            state.whenOrNull(
                                  loadedState: (user) => user.warehouseName,
                                ) ??
                                "",
                            style: const TextStyle(color: Colors.black),
                          ),
                        ),
                      );
                    },
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 9,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const SizedBox(
                            height: 45,
                          ),
                          _BuildMenuOption(
                            icon: "stock_arrival_logo",
                            title: "Приход\n на склад",
                            color: const Color(0xFFD73A49),
                            onTap: () => AppRouter.push(
                              context,
                              const WarehouseArrivalScreen(),
                            ),
                            pad: true,
                          ),
                          _BuildMenuOption(
                            icon: "open-24-hours",
                            title: "История\nзаказов",
                            color: const Color.fromARGB(255, 24, 102, 229),
                            onTap: () =>
                                AppRouter.push(context, const HistoryScreen()),
                          ),
                          _BuildMenuOption(
                            icon: "move_logo",
                            title: "Перемещение",
                            color: const Color(0xFFFFD33D),
                            onTap: () => AppRouter.push(
                              context,
                              ChangeNotifierProvider(
                                create: (context) => MoveDataVModel()..init(),
                                child: const MoveOrdersPage(),
                              ),
                            ),
                            pad: true,
                          ),
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _BuildMenuOption(
                            icon: "pharmacy_arrival_logo",
                            title: "Приход\nАптека",
                            color: const Color(0xFF28A745),
                            onTap: () => AppRouter.push(
                              context,
                              const PharmacyArrivalScreen(),
                            ),
                          ),
                          _BuildMenuOption(
                            icon: "return_logo",
                            title: "Возврат",
                            color: const Color(0xFF6F42C1),
                            onTap: () => AppRouter.push(
                              context,
                              ChangeNotifierProvider(
                                create: (context) => ReturnDataVModel()..init(),
                                child: const ReturnOrdersPage(),
                              ),
                            ),
                          ),
                          _BuildMenuOption(
                            icon: "box-png-icon",
                            title: "Прием\nконтейнеров",
                            color: const Color.fromARGB(255, 24, 229, 198),
                            onTap: () => AppRouter.push(
                              context,
                              const AcceptContLauchPage(),
                            ),
                          ),
                          _BuildMenuOption(
                            icon: "return_logo",
                            title: "Возврат \nконтейнеров",
                            color: const Color.fromARGB(255, 3, 19, 238),
                            onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    const RefundContainersPage(),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _BuildMenuOption extends StatelessWidget {
  final String? icon;
  final String title;
  final Color color;
  final bool pad;
  final VoidCallback onTap;

  const _BuildMenuOption({
    this.icon,
    required this.title,
    required this.color,
    required this.onTap,
    this.pad = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: pad ? 8.0 : 0, bottom: 8),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          width: MediaQuery.of(context).size.width / 2 - 20,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (icon == null)
                  const SizedBox()
                else
                  Image.asset(
                    "assets/images/png/$icon.png",
                    color: ColorPalette.white,
                    height: 64,
                    width: 64,
                  ),
                const SizedBox(
                  height: 8,
                ),
                Text(
                  title.toUpperCase(),
                  style: ThemeTextStyle.textStyle16w500
                      .copyWith(color: ColorPalette.white),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
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
