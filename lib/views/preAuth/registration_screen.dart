import 'package:password_compromised/password_compromised.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:flutter/material.dart';
import 'package:idea_share/services/auth_service.dart';
import 'package:flutter/services.dart';
import 'package:idea_share/shared_components/shared_button_rectangle.dart';
import 'package:idea_share/shared_components/constants.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:wc_form_validators/wc_form_validators.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class RegistrationScreen extends StatefulWidget {
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  var _formKey = GlobalKey<FormState>();
  final AuthService _auth = AuthService();

  final _passwordController = TextEditingController();
  bool showSpinner = false;
  String _email;
  String _password;
  String _name;

  void _submit() async {
    final _formState = _formKey.currentState;
    if (_formState.validate()) {
      _formState.save();
      _passwordController.clear();
      setState(() => showSpinner = true);
      dynamic result;
      if (await isPasswordCompromised(_password)) {
        _showPwdCompromisedDialog(context);
      } else {
        result =
            await _auth.registerWithEmailAndPassword(_email, _password, _name);
      }
      setState(() => showSpinner = false);
      if (result != null) {
        Navigator.pop(context);
      }
    }
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
        body: showSpinner
            ? SpinKitWanderingCubes(
                color: ThemeData.dark().primaryColorLight, size: 250)
            : ListView(
                children: <Widget>[
                  Form(
                    key: _formKey,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 24.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Flexible(
                            child: Hero(
                                tag: 'lightbulb',
                                child: Image.asset('assets/lightbulb.png')),
                          ),
                          Flexible(
                            child: ScaleAnimatedTextKit(
                                text: ["Express", "Your", "Ideas"],
                                textStyle: TextStyle(
                                    fontSize: 70.0, fontFamily: "Pacifico"),
                                textAlign: TextAlign.center,
                                alignment: AlignmentDirectional
                                    .center // or Alignment.topLeft
                                ),
                          ),
                          SizedBox(
                            height: 30.0,
                          ),
                          //TextFormField enables us to apply the validation layer on our text field
                          TextFormField(
                            keyboardType: TextInputType.text,
                            textAlign: TextAlign.center,
                            textCapitalization: TextCapitalization.words,
                            validator: Validators.compose([
                              Validators.required('Please enter your name'),
                              Validators.maxLength(
                                  30, 'Name can only be 30 characters'),
                              Validators.minLength(
                                  3, 'Name can only be minium 2 characters'),
                              Validators.patternRegExp(RegExp("^[A-Za-z ]+\$"),
                                  'Only alphabets are allowed')
                            ]),
                            onSaved: (value) => _name = value,
                            decoration: textFieldDecoration.copyWith(
                                hintText: 'Enter your name'),
                          ),
                          SizedBox(
                            height: 8.0,
                          ),
                          //TextFormField enables us to apply the validation layer on our text field
                          TextFormField(
                            keyboardType: TextInputType.emailAddress,
                            textAlign: TextAlign.center,
                            validator: Validators.compose([
                              Validators.required(
                                  'Please enter an email address'),
                              Validators.email('Invalid email address'),
                              Validators.maxLength(
                                  254, 'Email exceeds max length')
                            ]),
                            onSaved: (value) => _email = value,
                            decoration: textFieldDecoration.copyWith(
                                hintText: 'Enter your email'),
                          ),
                          SizedBox(
                            height: 8.0,
                          ),
                          TextFormField(
                            controller: _passwordController,
                            obscureText: true,
                            textAlign: TextAlign.center,
                            validator: Validators.compose([
                              Validators.required('no password entered'),
                              Validators.minLength(
                                  8, 'password needs to be 8 characters'),
                              Validators.maxLength(128, 'password too long'),
                              Validators.patternString(
                                  '(?=.*[A-Z])', 'uppercase required'),
                              Validators.patternString(
                                  '(?=.*\\d)', 'a number required'),
                              Validators.patternString(
                                  '(?=.*[a-z])', 'lowercase required'),
                              Validators.patternString('(?=.*[@#%&,.])',
                                  'Your password must contain at least 1 of the \nfollowing characters [@, #, % , . , & or ,]')
                            ]),
                            decoration: textFieldDecoration.copyWith(
                                hintText: 'Enter your password'),
                          ),
                          SizedBox(
                            height: 8.0,
                          ),
                          TextFormField(
                            obscureText: true,
                            textAlign: TextAlign.center,
                            // ignore: missing_return
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Please confirm your password';
                              } else if (value != _passwordController.text) {
                                return 'passwords do not match';
                              }
                            },
                            onSaved: (value) => _password = value,
                            decoration: textFieldDecoration.copyWith(
                                hintText: 'Retype password'),
                          ),
                          SizedBox(
                            height: 24.0,
                          ),
                          SharedButtonRectangle(
                              value: 'Register',
                              color: ThemeData.dark().buttonColor,
                              onPressed: _submit),
                        ],
                      ),
                    ),
                  ),
                ],
              ));
  }

  _showPwdCompromisedDialog(context) {
    Alert(
            context: context,
            title: "Password Compromised!",
            desc:
                "The password that you have choosen have appeared on pwned password databases meaning that its insecure and can be easily compromised, please change account password to something else.")
        .show();
  }
}
