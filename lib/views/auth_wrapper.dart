import 'package:flutter/material.dart';
import 'package:idea_share/views/postAuth/home_screen.dart';
import 'package:idea_share/views/preAuth/welcome_screen.dart';
import 'package:provider/provider.dart';
import 'package:idea_share/models/user.dart';
import 'package:flutter/scheduler.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class AuthWrapper extends StatefulWidget {
  @override
  _AuthWrapperState createState() => _AuthWrapperState();
}

class _AuthWrapperState extends State<AuthWrapper> {
  @override
  Widget build(BuildContext context) {
    final currentUser = Provider.of<User>(context);

    if (currentUser == null) {
      return WelcomeScreen();
    } else {
      return HomeScreen();

    }
  }
}
