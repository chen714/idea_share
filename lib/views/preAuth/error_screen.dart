import 'package:flutter/material.dart';

class ErrorScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown[50],
      appBar: AppBar(
        title: Text(
          'Idea Share',
          style: TextStyle(fontFamily: 'Pacifico', fontSize: 50),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
      ),
      body: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  alignment: Alignment.center,
                  fit: BoxFit.fitWidth,
                  image: AssetImage('assets/error.png'))),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Text(
                "Biometrics required to use this application, Please close the application and try again.",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Colors.black,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 120,
              )
            ],
          )),
    );
  }
}
