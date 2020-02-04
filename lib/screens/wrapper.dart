import 'package:notting/models/user.dart';
import 'package:notting/screens/authenticate/authenticate.dart';
import 'package:flutter/material.dart';
import 'package:notting/screens/home/home.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Return home or authenticate widget.
    final user = Provider.of<User>(context);

    return user != null ? Home() : Authenticate();
  }
}