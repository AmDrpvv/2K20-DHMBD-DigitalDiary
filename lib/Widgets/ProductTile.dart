import 'package:flutter/material.dart';
import 'package:hisabapp/Models/AppEntity.dart';

class ProductTile extends StatelessWidget {
  final Product product;
  ProductTile({this.product});
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(top: 20.0),
        padding: EdgeInsets.symmetric(
            vertical: 10.0, horizontal: 10.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.0),
          color: Theme.of(context).primaryColor//Colors.white,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SizedBox(
              width: 10.0,
            ),
            CircleAvatar(
              radius: 30.0,
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                child: Text(product.price,
                  overflow: TextOverflow.clip,
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontSize: 18.0,
                    fontWeight: FontWeight.normal,
                  ),
                )
            ),
            SizedBox(
              width: 10.0,
            ),
            Expanded(child: Text(product.name,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: Theme.of(context).scaffoldBackgroundColor,
                fontSize: 16.0,
                fontWeight: FontWeight.w500,
              ),
            )
            ),
            SizedBox(
              width: 10.0,
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  decoration: BoxDecoration(
                    //color: Colors.red,
                      shape: BoxShape.circle
                  ),
                  child: Icon(
                    Icons.keyboard_arrow_up,
                    size: 28.0,
                    color: Theme.of(context).scaffoldBackgroundColor,
                  ),
                ),
                Flexible(
                  child: Text(product.quantity,
                    style: TextStyle(
                      color: Theme.of(context).scaffoldBackgroundColor,
                      fontSize: 18.0,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    //color: Colors.red,
                      shape: BoxShape.circle
                  ),
                  child: Icon(
                    Icons.keyboard_arrow_down,
                    size: 28.0,
                    color: Theme.of(context).scaffoldBackgroundColor,
                  ),
                ),
              ],
            ),
            SizedBox(
              width: 10.0,
            ),
          ],
        ));
  }
}
