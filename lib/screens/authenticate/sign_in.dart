import 'package:notting/services/auth.dart';
import 'package:notting/shared/const.dart';
import 'package:notting/shared/loading.dart';
import 'package:flutter/material.dart';

class Signin extends StatefulWidget {
  final Function toggleView;
  Signin({this.toggleView});
  @override
  _SigninState createState() => _SigninState();
}

class _SigninState extends State<Signin> {
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
              title: Text("Sign in to brew."),
              actions: <Widget>[
                FlatButton.icon(
                  icon: Icon(Icons.person),
                  label: Text('Register'),
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
                          validator: (val) =>
                              val.isEmpty ? 'Enter an email' : null,
                          onChanged: (val) {
                            setState(() {
                              email = val;
                            });
                          },
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        TextFormField(
                          decoration: textInputDecoration.copyWith(
                              hintText: "Password"),
                          obscureText: true,
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
                          child: Text("Sign in",
                              style: TextStyle(color: Colors.white)),
                          onPressed: () async {
                            if (_formKey.currentState.validate()) {
                              setState(() => loading = true);

                              dynamic result = await _auth
                                  .signInWithEmailAndPassword(email, password);
                              print(result);
                              if (result == null) {
                                setState(() {
                                  error =
                                      "could not sign in with those credentials.";
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
