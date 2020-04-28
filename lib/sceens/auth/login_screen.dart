import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:my_social/sceens/home/home.dart';
import 'package:my_social/services/auth.dart';
import 'package:my_social/util/utils.dart';

class LoginScreen extends StatefulWidget {
  static String id = "login_screen";

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

  String _email = "";
  String _password = "";
  String _error = "";

  bool showLoading = false;

  void _onPressed(BuildContext context) async {
    setState(() {
      showLoading = true;
    });
    if (_formKey.currentState.validate()) {
      setState(() {
        //TODO set the loading state
      });
      try {
        dynamic result = await _auth.login(_email.trim(), _password.trim());
        if (result != null) {
          Navigator.of(context).pushNamedAndRemoveUntil(
              Home.id, (Route<dynamic> route) => false,
              arguments: {'id': _auth});
        }
        setState(() => showLoading = false);
      } catch (e) {
        setState(() => showLoading = false);
        _error = "couldn't sign in with those credentials";
        print(_error);
        Scaffold.of(context).showSnackBar(SnackBar(
          content: Text("Somthing went wrong"),
        ));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.blue[700],
        title: Text("Log in"),
        elevation: 4.0,
      ),
      body: Builder(
        builder: (BuildContext context) {
          return ModalProgressHUD(
            inAsyncCall: showLoading,
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
              child: ListView(
                children: <Widget>[
                  Form(
                    key: _formKey,
                    child: Column(
                      children: <Widget>[
                        SizedBox(height: 40.0),
                        Container(
                          width: 300.0,
                          child: TextFormField(
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
                        SizedBox(height: 40.0),
                        ButtonTheme(
                          minWidth: 300.0,
                          height: 46.0,
                          child: RaisedButton(
                            color: Colors.green,
                            child: Text(
                              "Log in",
                              style: TextStyle(color: Colors.white),
                            ),
                            onPressed: () => _onPressed(context),
                          ),
                        ),
                        SizedBox(height: 20.0),
                        ButtonTheme(
                          minWidth: 300.0,
                          height: 46.0,
                          child: RaisedButton(
                            color: Colors.white,
                            child: Text(
                              "Register",
                              style: TextStyle(color: Colors.green),
                            ),
                            onPressed: () {
                              Navigator.pushNamed(
                                  context, "registration_screen");
                              //widget.toggleAuth();
                            },
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(2.0),
                                side: BorderSide(color: Colors.green)),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
