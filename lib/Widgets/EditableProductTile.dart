import 'package:flutter/material.dart';
import 'package:hisabapp/Models/AppEntity.dart';
import 'package:hisabapp/Widgets/ShowDialog.dart';

class EditableProductTile extends StatefulWidget {
  final Product product;
  final int index;
  final Function editProduct;
  EditableProductTile({this.product,this.index,this.editProduct});

  @override
  _EditableProductTileState createState() => _EditableProductTileState();
}

class _EditableProductTileState extends State<EditableProductTile> {


  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(top: 20.0),
        padding: EdgeInsets.symmetric(
            vertical: 10.0, horizontal: 10.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.0),
          color: Theme.of(context).primaryColor,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [

            CircleAvatar(
                radius: 18.0,
                backgroundColor: Theme
                    .of(context)
                    .scaffoldBackgroundColor,
                child: IconButton(
                  onPressed: () {
                    showDialog(context: context,
                        builder: (BuildContext context) =>
                            ShowCustomDialog(productToEdit:widget.product,editProduct: widget.editProduct,index: widget.index, )
                    );
                  },
                  icon: Icon(Icons.edit,
                    color: Theme.of(context).primaryColor,
                    size: 20.0,
                  ),
                )
            ),
            SizedBox(
              width: 8.0,
            ),
            CircleAvatar(
                radius: 30.0,
                backgroundColor: Theme
                    .of(context)
                    .scaffoldBackgroundColor,
                child: Text(widget.product.price,
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
            Expanded(child: Text(widget.product.name,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: Theme.of(context).scaffoldBackgroundColor,
                fontSize: 15.0,
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
                GestureDetector(
                  onTap: () {
                    int quantity = int.parse(widget.product.quantity);
                    if (quantity < 99) {
                      setState(() {
                        quantity = quantity + 1;
                        widget.editProduct(new Product(
                          name: widget.product.name,
                          quantity: quantity.toString(),
                          price: widget.product.price
                        ),widget.index,false);
                      });
                    }
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        shape: BoxShape.circle
                    ),
                    child: Icon(
                      Icons.keyboard_arrow_up,
                      size: 28.0,
                      color: Theme.of(context).scaffoldBackgroundColor,
                    ),
                  ),
                ),
                Flexible(
                  child: Text(widget.product.quantity,
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.normal,
                      color: Theme.of(context).scaffoldBackgroundColor,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    int quantity = int.parse(widget.product.quantity);
                    if (quantity > 0) {
                      setState(() {
                        quantity = quantity - 1;
                        widget.editProduct(new Product(
                            name: widget.product.name,
                            quantity: quantity.toString(),
                            price: widget.product.price
                        ),widget.index,false);
                      });
                    }
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        shape: BoxShape.circle
                    ),
                    child: Icon(
                      Icons.keyboard_arrow_down,
                      color: Theme.of(context).scaffoldBackgroundColor,
                      size: 28.0,
                    ),
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