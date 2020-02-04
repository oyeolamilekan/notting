import 'package:notting/services/auth.dart';
import 'package:notting/shared/const.dart';
import 'package:notting/shared/loading.dart';
import 'package:flutter/material.dart';

class Register extends StatefulWidget {
  final Function toggleView;
  Register({this.toggleView});

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

  String email = "";
  String password = "";
  String error = "";
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            backgroundColor: Colors.brown[100],
            appBar: AppBar(
              backgroundColor: Colors.brown[400],
              elevation: 0.0,
              title: Text("Register to brew."),
              actions: <Widget>[
                FlatButton.icon(
                  icon: Icon(Icons.person),
                  label: Text('Sign in'),
                  onPressed: () {
                    widget.toggleView();
                  },
                )
              ],
            ),
            body: Container(
                padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
                child: Container(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          height: 20.0,
                        ),
                        TextFormField(
                          decoration:
                              textInputDecoration.copyWith(hintText: "Email"),
                          onChanged: (val) {
                            setState(() {
                              email = val;
                            });
                          },
                          validator: (val) =>
                              val.isEmpty ? 'Enter an email' : null,
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        TextFormField(
                          obscureText: true,
                          decoration: textInputDecoration.copyWith(
                              hintText: "Password"),
                          onChanged: (val) {
                            setState(() {
                              password = val;
                            });
                          },
                          validator: (val) => val.length < 6
                              ? 'Enter a password 6+ word char long'
                              : null,
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        RaisedButton(
                          color: Colors.pink[400],
                          child: Text(
                            "Register",
                            style: TextStyle(color: Colors.white),
                          ),
                          onPressed: () async {
                            if (_formKey.currentState.validate()) {
                              setState(() => loading = true);
                              dynamic result =
                                  await _auth.registerWithEmailAndPassword(
                                      email, password);
                              if (result == null) {
                                setState(() {
                                  error = "Please supply a valid email";
                                  loading = false;
                                });
                              }
                            }
                          },
                        ),
                        SizedBox(
                          height: 12,
                        ),
                        Text(
                          error,
                          style: TextStyle(color: Colors.red),
                        )
                      ],
                    ),
                  ),
                )),
          );
  }
}
