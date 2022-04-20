import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../styles/color_palette.dart';
import '../../styles/text_styles.dart';
import 'debouncer.dart';
import 'vmodel/input_cubit.dart';

class AppTextField extends StatefulWidget {
  AppTextField({
    Key? key,
    this.textAlign,
    this.inputFormatters,
    bool obscureText = false,
    this.hintText,
    this.initial,
    this.onChanged,
    this.keyboardType,
    this.textInputAction,
    this.maxLength,
    this.maxLines = 1,
    this.minLines,
    this.fillColor,
    this.isVisibleObscureButton = false,
    EdgeInsetsGeometry? contentPadding,
    this.nextFocus,
    bool enabled = true,
    this.readonly = false,
    bool autovalidate = false,
    this.style,
    this.hintStyle,
    List<String> Function(String?)? validator,
    this.showErrorMessages = true,
    this.suffixIcon,
    this.prefixIcon,
    this.suffixText,
    this.onTap,
    this.onFieldSubmitted,
    this.textCapitalization = TextCapitalization.sentences,
    Duration? debounce,
    this.enabledBorder,
    this.disabledBorder,
    this.focusedBorder,
    this.autofocus,
    TextEditingController? controller,
    FocusNode? focusNode,
  })  : contentPadding = contentPadding ?? const EdgeInsets.all(17.0),
        controller = controller ?? TextEditingController(text: initial),
        focusNode = focusNode ?? FocusNode(),
        super(key: key) {
    cubit = InputCubit<String>(
      validator: validator,
      autovalidate: autovalidate,
    );
    _enabled.add(enabled);
    _obscureText.add(obscureText);
    _debounce = Debounce(duration: debounce);
  }

  final TextAlign? textAlign;
  final Function(String value)? onChanged;
  final void Function(TextEditingController)? onTap;
  final void Function(String)? onFieldSubmitted;
  final EdgeInsetsGeometry? contentPadding;
  final TextEditingController controller;
  late final InputCubit cubit;
  final InputBorder? disabledBorder;
  final InputBorder? enabledBorder;
  final FocusNode? focusNode;
  final Color? fillColor;
  final InputBorder? focusedBorder;
  final TextStyle? hintStyle;
  final String? hintText;
  final String? initial;
  final List<TextInputFormatter>? inputFormatters;
  final bool isVisibleObscureButton;
  final TextInputType? keyboardType;
  final int? maxLength;
  final int? maxLines;
  final int? minLines;
  final FocusNode? nextFocus;
  final bool readonly;
  final bool showErrorMessages;
  final TextStyle? style;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final TextCapitalization textCapitalization;
  final TextInputAction? textInputAction;
  final String? suffixText;
  final bool? autofocus;

  late final Debounce? _debounce;
  final _enabled = <bool>[];
  final _obscureText = <bool>[];

  @override
  _AppTextFieldState createState() => _AppTextFieldState();

  bool get obscureText => _obscureText.first;

  set obscureText(bool newValue) {
    _obscureText
      ..clear()
      ..add(newValue);
    cubit.rebuild();
  }

  bool get enabled => _enabled.first;

  set enabled(bool newValue) {
    _enabled.first = newValue;
    cubit.rebuild();
  }

  bool get validated => cubit.validate(controller.text);

  updateValidator(List<String> Function(dynamic) validator) {
    cubit.validator = validator;
  }

  Future<void> dispose() async {
    // focusNode.dispose();

    nextFocus?.dispose();
    await cubit.close();
    controller.dispose();
  }

  void get reset {
    controller.text = initial ?? '';
    cubit.reset();
  }
}

class _AppTextFieldState extends State<AppTextField> {
  bool firstRun = true;

  @override
  void initState() {
    widget.focusNode!.addListener(() {
      if (mounted &&
          widget.focusNode!.canRequestFocus &&
          !widget.focusNode!.hasFocus &&
          !firstRun) {
        widget.validated;
      }
      firstRun = false;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: widget.cubit,
      child: BlocBuilder<InputCubit, StateInputCubit>(
        builder: (context, state) {
          var errorMessages = <String>[];
          if (state is StateError) {
            errorMessages = state.messages;
          }
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                autofocus: widget.autofocus ?? false,
                textAlign: widget.textAlign ?? TextAlign.left,
                textCapitalization: widget.textCapitalization,
                readOnly: widget.readonly,
                controller: widget.controller,
                obscureText: widget.obscureText,
                enableSuggestions: !widget.obscureText,
                autocorrect: !widget.obscureText,
                enabled: widget.enabled,
                inputFormatters: widget.inputFormatters,
                keyboardType: widget.keyboardType,
                textInputAction: widget.nextFocus == null
                    ? widget.textInputAction
                    : TextInputAction.next,
                maxLength: widget.maxLength,
                minLines: widget.minLines,
                maxLines: widget.maxLines,
                focusNode: widget.focusNode,
                style: widget.style ?? ProjectTextStyles.ui_16Medium,
                buildCounter: (
                  context, {
                  required int currentLength,
                  required bool isFocused,
                  required int? maxLength,
                }) {
                  return const SizedBox.shrink();
                },
                decoration: InputDecoration(
                  suffixText: widget.suffixText,
                  suffixStyle: ProjectTextStyles.ui_16Medium,
                  suffixIcon: widget.isVisibleObscureButton
                      ? IconButton(
                          icon: widget.obscureText
                              ? SvgPicture.asset(
                                  "assets/images/svg/show_text.svg",
                                )
                              : const Icon(
                                  Icons.remove_red_eye,
                                  color: Color(0xFF83B1F4),
                                ),
                          onPressed: () {
                            widget.obscureText = !widget.obscureText;
                          },
                        )
                      : widget.suffixIcon,
                  suffixIconConstraints: const BoxConstraints(
                    minHeight: 24,
                    minWidth: 24,
                  ),
                  prefixIcon: widget.prefixIcon,
                  prefixIconConstraints: const BoxConstraints(
                    minHeight: 36.0,
                    minWidth: 36.0,
                  ),
                  fillColor: widget.fillColor ?? ColorPalette.lightGrey,
                  filled: true,
                  isDense: true,
                  contentPadding: widget.contentPadding,
                  hintStyle: widget.hintStyle ??
                      ProjectTextStyles.ui_16Medium.copyWith(
                        color: ColorPalette.commonGrey,
                      ),
                  hintText: widget.hintText,
                  counterText: '',
                  disabledBorder: widget.disabledBorder ??
                      OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                        borderSide: const BorderSide(
                          color: Colors.transparent,
                          width: 1.0,
                        ),
                        gapPadding: 0.0,
                      ),
                  enabledBorder: widget.enabledBorder ??
                      OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                        borderSide: BorderSide(
                          color: (state is StateError)
                              ? ColorPalette.errorRed
                              : Colors.transparent,
                        ),
                        gapPadding: 0.0,
                      ),
                  focusedBorder: widget.focusedBorder ??
                      OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                        borderSide: BorderSide(
                          color: (state is StateError)
                              ? ColorPalette.errorRed
                              : Colors.transparent,
                          width: 1.0,
                        ),
                        gapPadding: 0.0,
                      ),
                ),
                onChanged: (value) {
                  widget.cubit.autovalidate(value);
                  if (widget._debounce != null) {
                    widget._debounce!(() {
                      widget.onChanged?.call(value);
                    });
                  } else {
                    widget._debounce!(() {
                      widget.onChanged?.call(value);
                    });
                  }
                },
                onTap: () => widget.onTap?.call(widget.controller),
                onEditingComplete: () {
                  if (widget.validated) {
                    if (mounted &&
                        (widget.nextFocus?.canRequestFocus ?? false)) {
                      widget.nextFocus?.requestFocus();
                    } else {
                      widget.focusNode!.unfocus();
                    }
                  }
                },
                onFieldSubmitted: widget.onFieldSubmitted,
              ),
              if (widget.showErrorMessages)
                AnimatedSize(
                  duration: const Duration(milliseconds: 300),
                  child: (state is StateValidated)
                      ? const SizedBox(
                          width: double.maxFinite,
                          height: 1.0,
                        )
                      : Padding(
                          padding: const EdgeInsets.only(top: 2.0),
                          child:
                              Column(mainAxisSize: MainAxisSize.min, children: [
                            errorMessages.isEmpty
                                ? const SizedBox(
                                    width: 1.0,
                                    height: 1.0,
                                  )
                                : Column(
                                    children: errorMessages
                                        .map<Widget>(
                                          (error) => Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Flexible(
                                                child: Text(
                                                  error,
                                                  style: ProjectTextStyles
                                                      .ui_16Medium
                                                      .copyWith(
                                                          color: ColorPalette
                                                              .errorRed),
                                                ),
                                              ),
                                            ],
                                          ),
                                        )
                                        .toList(),
                                  ),
                          ]),
                        ),
                ),
            ],
          );
        },
      ),
    );
  }
}
