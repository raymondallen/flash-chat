import 'package:flash_chat/utilities/constants.dart';
import 'package:flutter/material.dart';
import '../utilities/routes.dart';
import '../components/rounded_button.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import '../components/logo.dart';

class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation animation;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      duration: Duration(
        seconds: 1,
      ),
      vsync: this,
      upperBound: 1.0,
    );

    animation = ColorTween(begin: Color(0xff9E9E9E), end: Colors.black)
        .animate(controller);

    controller.forward();
    controller.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: animation.value,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              children: <Widget>[
                Hero(
                  tag: kLogoTag,
                  child: Container(
                    child: Logo(),
                    height: 60.0,
                  ),
                ),
                SizedBox(
                  width: 10.0,
                ),
                TypewriterAnimatedTextKit(
                  text: ['Flash Chat'],
                  totalRepeatCount: 1,
                  textStyle: TextStyle(
                    color: Colors.white,
                    fontSize: 45.0,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 48.0,
            ),
            RoundedButton(
                label: 'Log In',
                color: Theme.of(context).primaryColor,
                onTap: () {
                  Navigator.pushNamed(context, Routes.login);
                }),
            RoundedButton(
                label: 'Register',
                color: Theme.of(context).accentColor,
                onTap: () {
                  Navigator.pushNamed(context, Routes.register);
                }),
          ],
        ),
      ),
    );
  }
}
