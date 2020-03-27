import 'package:flutter/material.dart';
import 'package:flash_chat/screens/welcome_screen.dart';
import 'package:flash_chat/screens/login_screen.dart';
import 'package:flash_chat/screens/registration_screen.dart';
import 'package:flash_chat/screens/chat_screen.dart';
import 'utilities/routes.dart';
import 'utilities/constants.dart';
import 'auth/auth_change_notifier.dart';
import 'package:provider/provider.dart';

void main() => runApp(FlashChat());

class FlashChat extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthChangeNotifier>(
            create: (_) => AuthChangeNotifier()),
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData.dark().copyWith(
            primaryColor: kPrimaryColor,
            primaryColorDark: kPrimaryColorDark,
            buttonColor: kButtonColor,
            accentColor: kAccentColor,
            primaryColorLight: kPrimaryColorLight,
            dividerColor: kDividerColor,
            textTheme: TextTheme(
              body1: TextStyle(color: kTextColor),
            ),
          ),
          initialRoute: Routes.login,
          routes: {
            Routes.welcome: (context) => WelcomeScreen(),
            Routes.login: (context) => LoginScreen(),
            Routes.register: (context) => RegistrationScreen(),
            Routes.chat: (context) => ChatScreen(),
          }),
    );
  }
}
