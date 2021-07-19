import 'package:flutter/material.dart';
import 'package:hisabapp/Models/AppEntity.dart';
import 'package:hisabapp/Screens/Authentication/AuthenticationScreen.dart';
import 'package:hisabapp/Screens/HomeScreen/MainHomePage.dart';
import 'package:provider/provider.dart';

class WrapperClass extends StatefulWidget {
  @override
  _WrapperClassState createState() => _WrapperClassState();
}

class _WrapperClassState extends State<WrapperClass> {
  @override
  Widget build(BuildContext context) {
    final _user = Provider.of<User>(context);

    if(_user==null) {
      return AuthenticationScreen();
    }
    else {
        return MainHomePage();
    }
  }
}
