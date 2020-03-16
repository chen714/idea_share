import 'package:flutter/material.dart';
import 'package:idea_share/views/postAuth/home_screen.dart';
import 'package:idea_share/views/preAuth/welcome_screen.dart';
import 'package:provider/provider.dart';
import 'package:idea_share/models/user.dart';

class AuthWrapper extends StatelessWidget {
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
