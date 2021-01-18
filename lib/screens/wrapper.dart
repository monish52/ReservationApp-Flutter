import 'package:reservation/models/user.dart';
import 'package:reservation/screens/authenticate/authenticate.dart';
import 'package:reservation/screens/home/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserId>(context);
    //return either home or authenticate widget
    if (user == null) {
      return Authenticate();
    } else {
      return Home();
    }
  }
}
