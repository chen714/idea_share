import 'package:flutter/material.dart';
import 'package:idea_share/views/auth_wrapper.dart';
import 'package:provider/provider.dart';
import 'services/auth_service.dart';
import 'models/user.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    AuthService _auth = AuthService();
    return StreamProvider<User>.value(
      value: AuthService().user,
      child: MaterialApp(
        title: 'Idea Share 💡',
        theme: ThemeData.dark(),
        home: AuthWrapper(),
      ),
    );
  }
}
