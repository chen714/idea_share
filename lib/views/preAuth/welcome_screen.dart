import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:idea_share/services/auth_service.dart';
import 'package:idea_share/shared_components/shared_button_rectangle.dart';
import 'package:idea_share/views/preAuth/login_screen.dart';
import 'package:idea_share/views/preAuth/registration_screen.dart';

class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  AuthService _authService = AuthService();
  AnimationController controller;
  Animation animation;

  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(duration: Duration(seconds: 10), vsync: this);
    animation = ColorTween(
            begin: ThemeData.dark().primaryColor,
            end: ThemeData.dark().backgroundColor)
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
      appBar: AppBar(
        title: Text(
          'Idea Share',
          style: TextStyle(fontFamily: 'Pacifico', fontSize: 50),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
      ),
      backgroundColor: animation.value,
      body: ListView(children: <Widget>[
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Hero(tag: 'lightbulb', child: Image.asset('assets/lightbulb.png')),
            ScaleAnimatedTextKit(
                text: ["Express", "Your", "Ideas"],
                textStyle: TextStyle(fontSize: 70.0, fontFamily: "Pacifico"),
                textAlign: TextAlign.center,
                alignment: AlignmentDirectional.center // or Alignment.topLeft
                ),
            SizedBox(
              height: 40.0,
            ),
            SharedButtonRectangle(
              value: 'Log In',
              color: ThemeData.dark().buttonColor,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) {
                    return LoginScreen();
                  }),
                );
              },
            ),
            SharedButtonRectangle(
              value: 'Register',
              color: ThemeData.dark().buttonColor,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) {
                    return RegistrationScreen();
                  }),
                );
              },
            ),
          ],
        ),
      ]),
    );
  }
}
