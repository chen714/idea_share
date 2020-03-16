import 'package:flutter/material.dart';
import 'package:idea_share/services/auth_service.dart';
import 'package:flutter/services.dart';
import 'package:idea_share/shared_components/shared_button_rectangle.dart';
import 'package:idea_share/shared_components/constants.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:wc_form_validators/wc_form_validators.dart';

class RegistrationScreen extends StatefulWidget {
  static const String id = 'registration_screen';

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

  void _submit() async {
    final _formState = _formKey.currentState;
    if (_formState.validate()) {
      _formState.save();
      setState(() => showSpinner = true);
      _passwordController.clear();
      dynamic result =
          await _auth.registerWithEmailAndPassword(_email, _password);

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
                          SizedBox(
                            height: 50,
                          ),
                          Flexible(
                            child: Hero(
                              tag: 'lightbulb',
                              child: Text(
                                '💡',
                                style: TextStyle(fontSize: 50),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 30.0,
                          ),
                          //TextFormField enables us to apply the validation layer on our text field
                          TextFormField(
                            keyboardType: TextInputType.emailAddress,
                            textAlign: TextAlign.center,
                            validator: Validators.compose([
                              Validators.required(
                                  'Please enter an email address'),
                              Validators.email('Invalid email address')
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
//                              Validators.patternString('(?=.*[@#%&])',
//                                  'Your password must contain at least 1 special character - [@, #, % or &]')
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
}
