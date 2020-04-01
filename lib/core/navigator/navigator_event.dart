part of 'navigator_bloc.dart';

@immutable
abstract class NavigatorEvent {
  const NavigatorEvent();
}

class NavigateToLogin extends NavigatorEvent {
  @override
  String toString() {
    return 'Navigate to Login screen';
  }
}

class NavigateToRegister extends NavigatorEvent {
  @override
  String toString() {
    return 'Navigate to Register screen';
  }
}

class NavigatorPop extends NavigatorEvent {
  @override
  String toString() {
    return 'Navigate Pop';
  }
}
