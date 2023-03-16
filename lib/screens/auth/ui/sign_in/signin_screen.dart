import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pharmacy_arrival/app/main/login_bloc/login_bloc.dart';
import 'package:pharmacy_arrival/core/styles/color_palette.dart';
import 'package:pharmacy_arrival/core/styles/text_styles.dart';
import 'package:pharmacy_arrival/data/model/user.dart';
import 'package:pharmacy_arrival/screens/auth/bloc/sign_in_cubit.dart';
import 'package:pharmacy_arrival/screens/auth/ui/_vmodel.dart';
import 'package:pharmacy_arrival/widgets/app_loader_overlay.dart';
import 'package:pharmacy_arrival/widgets/main_button/main_button.dart';
import 'package:pharmacy_arrival/widgets/snackbar/custom_snackbars.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  late final SignInVModel _vmodel;

  @override
  void initState() {
    _vmodel = SignInVModel();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AppLoaderOverlay(
      child: Scaffold(
        body: BlocConsumer<SignInCubit, SignInState>(
          listener: (context, state) {
            state.when(
              initialState: () {
                context.loaderOverlay.hide();
              },
              loadedState: (User user) async {
                context.loaderOverlay.hide();
                context.read<LoginBloc>().add(LogInEvent());
              },
              loadingState: () {
                context.loaderOverlay.show();
              },
              errorState: (String message) {
                context.loaderOverlay.hide();
                state.mapOrNull();
                buildErrorCustomSnackBar(context, message);
              },
            );
          },
          builder: (context, state) {
            return Padding(
              padding: const EdgeInsets.only(top: 88, left: 16, right: 16),
              child: ListView(
               // crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SvgPicture.asset("assets/images/svg/europharm_logo.svg"),
                  const SizedBox(
                    height: 44,
                  ),
                  Text(
                    "С возвращением!".toUpperCase(),
                    style: ThemeTextStyle.textTitleDella24w400,
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  const Text(
                    "Логин аптеки",
                    style: ThemeTextStyle.textStyle12w600,
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  _vmodel.login,
                  const SizedBox(
                    height: 16,
                  ),
                  const Text(
                    "Пароль",
                    style: ThemeTextStyle.textStyle12w600,
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  _vmodel.password,
                  const SizedBox(
                    height: 32,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: MainButton(
                          color: ColorPalette.white,
                          // width: 204,
                          icon: "assets/images/svg/scan.svg",
                          title: "Сканировать QR",
                          borderRadius: 8,
                          textColor: Colors.black,
                          onTap: () {},
                        ),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      MainButton(
                        color: ColorPalette.orange,
                        width: 120,
                        onTap: () {
                          _vmodel.login.validated;
                          _vmodel.password.validated;
                          if (_vmodel.isValidated) {
                            context.read<SignInCubit>().signIn(
                                  phone: _vmodel.login.controller.text,
                                  password: _vmodel.password.controller.text,
                                );
                            // context.read<BlocAuth>().add(
                            //       EventSignIn(
                            //         login: _vmodel.login.controller.text,
                            //         password: _vmodel.password.controller.text,
                            //       ),
                            //     );
                          }
                        },
                        borderRadius: 8,
                        title: "Войти",
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
