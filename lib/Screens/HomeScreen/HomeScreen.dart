import 'package:flutter/material.dart';
import 'package:hisabapp/Models/AppEntity.dart';
import 'package:hisabapp/Screens/HomeScreen/CalenderPage.dart';
import 'package:hisabapp/Screens/Loading.dart';
import 'package:hisabapp/Services/DatabaseService.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final _ouruser = Provider.of<UserData>(context);
    if(_ouruser==null)
      {
        return Loading();
      }
    else
      {
        return StreamProvider<Map<dynamic,dynamic>>.value(
          value: DatabaseService(uid: _ouruser.uid).userdataDailyProductStream,
          child: CalenderPage(),
        );
      }
  }
}
