import 'package:flutter/material.dart';
import 'package:hisabapp/Models/AppEntity.dart';
import 'package:hisabapp/Screens/HomeScreen/HomeScreen.dart';
import 'package:hisabapp/Services/DatabaseService.dart';
import 'package:provider/provider.dart';

class MainHomePage extends StatefulWidget {
  @override
  _MainHomePageState createState() => _MainHomePageState();
}

class _MainHomePageState extends State<MainHomePage> {
  @override
  Widget build(BuildContext context) {
    final _ouruser = Provider.of<User>(context);
    return StreamProvider.value(
      value: DatabaseService(uid: _ouruser.uid).userdataStream,
        child: HomeScreen()
    );
  }
}
