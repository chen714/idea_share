import 'package:flutter/material.dart';
import 'package:idea_share/views/auth_wrapper.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:idea_share/services/local_auth_service.dart';
import 'package:idea_share/views/preAuth/error_screen.dart';
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
        home: FutureBuilder<bool>(
          future: LocalAuthService().authorizeNow(),
          builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
            if (!snapshot.hasData) {
              return Container(
                  child: SpinKitWanderingCubes(
                      color: ThemeData.dark().primaryColorLight, size: 250));
            } else {
              if (snapshot.data == true) {
                return AuthWrapper();
              }

              return ErrorScreen();
            }
          },
        ),
      ),
    );
  }
}
