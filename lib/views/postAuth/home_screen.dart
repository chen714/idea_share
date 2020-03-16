import 'package:flutter/material.dart';
import 'package:idea_share/services/auth_service.dart';
import 'package:idea_share/shared_components/shared_button_rectangle.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    AuthService _auth = AuthService();
    return Container(
      child: Column(
        children: <Widget>[
          Text('welcome screen'),
          SharedButtonRectangle(
              value: 'sign out',
              color: ThemeData.dark().buttonColor,
              onPressed: () {
                _auth.signOut();
              })
        ],
      ),
    );
  }
}
