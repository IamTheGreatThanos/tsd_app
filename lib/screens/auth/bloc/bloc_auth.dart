import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'events.dart';
part 'states.dart';
part 'parts/_login.dart';

class BlocAuth extends Bloc<EventBlocAuth, StateBlocAuth> {
  BlocAuth() : super(StateAuthLoading()) {
    on<EventSignIn>(_signIn);
  }
}
