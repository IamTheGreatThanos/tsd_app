import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class InputCubit<T> extends Cubit<StateInputCubit> {
  InputCubit({
    List<String> Function(T?)? validator,
    bool? autovalidate,
  }) : super(StateValidated()) {
    _validator = validator ?? _defaultValidator;
    _autovalidate = autovalidate ?? false;
  }

  late List<String> Function(T?) _validator;
  bool isAutovalidationOn = false;

  late bool _autovalidate;

  // ignore: avoid_setters_without_getters
  set validator(List<String> Function(T?) func) {
    _validator = func;
  }

  bool validate(T? value) {
    isAutovalidationOn = true;
    final errorMessages = _validator(value);
    if (errorMessages.isNotEmpty) {
      emit(
        StateError(
          messages: errorMessages,
          key: UniqueKey(),
        ),
      );
    } else {
      emit(
        StateValidated(
          key: UniqueKey(),
        ),
      );
    }
    return errorMessages.isEmpty;
  }

  void autovalidate(T? value) {
    if (_autovalidate && isAutovalidationOn) {
      validate(value);
    }
  }

  List<String> Function(T? value) get _defaultValidator {
    if (T == String) {
      return _defaultValidatorString;
    } else {
      return _defaultValidatorAny;
    }
  }

  List<String> _defaultValidatorAny(T? value) {
    final output = <String>[];
    if (value == null) {
      output.add('Input Error');
    }
    return output;
  }

  List<String> _defaultValidatorString(dynamic value) {
    final output = <String>[];
    if (value == null || value.isEmpty as bool) {
      output.add("Input Error");
    }
    return output;
  }

  void rebuild() {
    if (state is StateValidated) {
      emit(
        (state as StateValidated).copyWith(
          key: UniqueKey(),
        ),
      );
    }
    if (state is StateError) {
      emit(
        (state as StateError).copyWith(
          key: UniqueKey(),
        ),
      );
    }
  }

  void reset() {
    emit(
      StateValidated(
        key: UniqueKey(),
      ),
    );
  }
}

abstract class StateInputCubit {}

class StateValidated extends StateInputCubit {
  StateValidated({this.key});

  final Key? key;

  StateValidated copyWith({
    Key? key,
  }) {
    return StateValidated(
      key: key ?? this.key,
    );
  }
}

class StateError extends StateInputCubit {
  StateError({
    this.key,
    required this.messages,
  });

  final Key? key;
  final List<String> messages;

  StateError copyWith({
    Key? key,
    List<String>? messages,
  }) {
    return StateError(
      key: key ?? this.key,
      messages: messages ?? this.messages,
    );
  }
}
