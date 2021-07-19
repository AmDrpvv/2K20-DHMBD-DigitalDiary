import 'package:flutter/material.dart';
import 'package:hisabapp/Screens/Authentication/Register.dart';
import 'SignIn.dart';


class AuthenticationScreen extends StatefulWidget {
  @override
  _AuthenticationScreenState createState() => _AuthenticationScreenState();
}

class _AuthenticationScreenState extends State<AuthenticationScreen> {
  bool isSignIn=true;
  toggleScreen(){
    setState(() {
      isSignIn=!isSignIn;
    });
  }
  @override
  Widget build(BuildContext context) {

    return isSignIn? SignIn(toggleScreen: toggleScreen,)
        :Register(toggleScreen: toggleScreen,);

  }
}
