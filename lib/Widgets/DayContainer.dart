import 'package:flutter/material.dart';
import 'package:hisabapp/Models/AppEntity.dart';
import 'package:hisabapp/Widgets/ProductTile.dart';

class DayContainer extends StatelessWidget {
  final DayProducts dayproduct;

  DayContainer({this.dayproduct});
  @override
  Widget build(BuildContext context) {
    return dayproduct==null ? Container(
      alignment: Alignment.center,
      margin: EdgeInsets.only(bottom: MediaQuery.of(context).size.height*0.5),
      padding: EdgeInsets.symmetric(
          vertical: 12.0, horizontal: 10.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: Theme.of(context).accentColor,
      ),
      child: Text('No data found for this Day',
        overflow: TextOverflow.clip,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Theme.of(context).scaffoldBackgroundColor,
          fontSize: 20.0,
          fontWeight: FontWeight.w400,
        ),
      ),
    )
        :Column(
      children: [
        Row(
          children: [
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(
                    vertical: 10.0, horizontal: 10.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: Theme.of(context).primaryColor,
                ),
                child: Text(dayproduct.date,
                  overflow: TextOverflow.clip,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    fontSize: 20.0,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ),
            ),
          ],
        ),
        for(int i=0;i<dayproduct.productlist.length;i++)
          ProductTile(product:dayproduct.productlist[i]),

        Container(
          margin: EdgeInsets.only(top: 20.0),
          padding: EdgeInsets.symmetric(
              vertical: 10.0, horizontal: 10.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            color:Theme.of(context).primaryColor //Colors.white,
          ),
          child: Row(
            children: [
              Expanded(
                child: Text(dayproduct.notes,
                  overflow: TextOverflow.clip,
                  style: TextStyle(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    fontSize: 15.0,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
