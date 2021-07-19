import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height*0.8,
      color: Colors.white,
      child: SpinKitSquareCircle(
        color: Theme.of(context).primaryColor,
        size: 50.0,
      ),
    );
  }
}
