import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hisabapp/Models/AppEntity.dart';
import 'package:hisabapp/Services/auth_service.dart';
import 'package:provider/provider.dart';

import 'Screens/Wrapper.dart';

void main() {

  runApp(MyApp());
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return  StreamProvider<User>.value(
      value: AuthService().userstreamforauthchange,
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: ThemeData(
            //primaryColor: Colors.black,
              primaryColor: Color(0xFF7C7B7B),
            accentColor: Color(0xFF7C7B7B),
            //accentColor: Color(0xFF5DADE2),
            //backgroundColor: Colors.grey[800],
              backgroundColor:Color(0xFF4E4E4E),
            //scaffoldBackgroundColor: Colors.black,
              scaffoldBackgroundColor: Color(0xFFF8F8F8),
            //brightness: Brightness.dark,
            // brightness: Brightness.light,
            iconTheme: IconThemeData(
              color: Color(0xFF4E4E4E),
            ),

          ),
          home: WrapperClass(),
        ),
    );
  }
}


