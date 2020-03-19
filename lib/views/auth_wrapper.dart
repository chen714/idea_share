import 'package:flutter/material.dart';
import 'package:idea_share/views/postAuth/home_screen.dart';
import 'package:idea_share/views/preAuth/welcome_screen.dart';
import 'package:provider/provider.dart';
import 'package:idea_share/models/user.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:io';

class AuthWrapper extends StatefulWidget {
  @override
  _AuthWrapperState createState() => _AuthWrapperState();
}

void checkIfInternet() async {
  try {
    final result = await InternetAddress.lookup('example.com');
  } on SocketException catch (_) {
    Fluttertoast.showToast(
        msg:
            "An error has occured while trying to connect to the internet. \nInternet connection is required to use this application. \nPlease try again later. ",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.CENTER,
        timeInSecForIos: 3,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);
  }
}

class _AuthWrapperState extends State<AuthWrapper> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkIfInternet();
  }

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
