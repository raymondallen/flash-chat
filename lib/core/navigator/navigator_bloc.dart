import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'navigator_event.dart';

class NavigatorBloc extends Bloc<NavigatorEvent, dynamic> {
  final GlobalKey<NavigatorState> _navigatorKey;

  NavigatorBloc({@required GlobalKey navigatorKey})
      : assert(navigatorKey != null),
        _navigatorKey = navigatorKey;

  @override
  dynamic get initialState => 0;

  @override
  Stream<NavigatorState> mapEventToState(
    NavigatorEvent event,
  ) async* {
    if (event is NavigatorPop) {
      _navigatorKey.currentState.pop();
    } else if (event is NavigateToLogin) {
      _navigatorKey.currentState.pushNamed('/login');
    } else if (event is NavigateToRegister) {
      _navigatorKey.currentState.pushNamed('/register');
    }
  }
}
