import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:my_social/sceens/auth/login_screen.dart';
import 'package:my_social/sceens/home/home.dart';
import 'package:my_social/services/auth.dart';
import 'package:my_social/util/utils.dart';

class RegisterScreen extends StatefulWidget {
  static String id = "registration_screen";

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

  String _name = "";
  String _email = "";
  String _password = "";
  String _phone = "none";

  bool showProgress = false;

  void _onPressed(BuildContext context) async {
    setState(() {
      showProgress = true;
    });
    if (_formKey.currentState.validate()) {
      try {
        dynamic result = await _auth.register(
            _email.trim(), _password.trim(), _name.trim(), _phone.trim());
        if (result != null) {
          Navigator.of(context).pushNamedAndRemoveUntil(
              Home.id, (Route<dynamic> route) => false);
        }
        setState(() => showProgress = false);
      } catch (e) {
        setState(() => showProgress = false);
        Scaffold.of(context).showSnackBar(SnackBar(
          content: Text("Something went worng"),
        ));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Register"),
        backgroundColor: Colors.blue[700],
      ),
      body: Builder(
        builder: (BuildContext context) {
          return ModalProgressHUD(
            inAsyncCall: showProgress,
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
              child: ListView(
                children: <Widget>[
                  Form(
                    key: _formKey,
                    child: Column(
                      children: <Widget>[
                        SizedBox(height: 20.0),
                        Container(
                          width: 300.0,
                          child: TextFormField(
                            keyboardType: TextInputType.text,
                            decoration:
                                textInputDecoration.copyWith(labelText: "Name"),
                            validator: (value) =>
                                value.isEmpty ? "Enter your name" : null,
                            onChanged: (value) => _name = value,
                          ),
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        Container(
                          width: 300.0,
                          child: TextFormField(
                            keyboardType: TextInputType.emailAddress,
                            decoration: textInputDecoration.copyWith(
                                labelText: "Email"),
                            validator: (value) =>
                                value.isEmpty ? "Enter your email" : null,
                            onChanged: (value) => _email = value,
                          ),
                        ),
                        SizedBox(height: 20.0),
                        Container(
                          width: 300.0,
                          child: TextFormField(
                            decoration: textInputDecoration.copyWith(
                                labelText: "Password"),
                            obscureText: true,
                            validator: (value) => value.length < 6
                                ? "password must be more than 6 charachters"
                                : null,
                            onChanged: (value) => _password = value,
                          ),
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        Container(
                          width: 300.0,
                          child: TextFormField(
                            keyboardType: TextInputType.number,
                            decoration: textInputDecoration.copyWith(
                                labelText: "Phone Number (Optional)"),
                            onChanged: (value) => _phone = value,
                          ),
                        ),
                        SizedBox(height: 40.0),
                        ButtonTheme(
                          minWidth: 300.0,
                          height: 46.0,
                          child: RaisedButton(
                            color: Colors.green,
                            child: Text(
                              "Register Account",
                              style: TextStyle(color: Colors.white),
                            ),
                            onPressed: () => _onPressed(context),
                          ),
                        ),
                        SizedBox(height: 20.0),
                        ButtonTheme(
                          buttonColor: Colors.white,
                          minWidth: 300.0,
                          height: 46.0,
                          child: RaisedButton(
                            color: Colors.white,
                            child: Text(
                              "Login",
                              style: TextStyle(color: Colors.green),
                            ),
                            onPressed: () {
                              Navigator.of(context).pushNamedAndRemoveUntil(
                                  LoginScreen.id,
                                  (Route<dynamic> route) => false);
                            },
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(2.0),
                              side: BorderSide(color: Colors.green),
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
