import 'package:flutter/material.dart';
import 'package:hisabapp/Models/AppEntity.dart';

class ShowCustomDialog extends StatefulWidget {
  final Product productToEdit;
  final Function editProduct;
  final index;
  ShowCustomDialog({this.productToEdit,this.editProduct,this.index});


  @override
  _ShowCustomDialogState createState() => _ShowCustomDialogState();
}

GlobalKey<FormState> _globalkey=GlobalKey<FormState>();
class _ShowCustomDialogState extends State<ShowCustomDialog> {
  Product tempProduct;
  void initState()
  {
    tempProduct=widget.productToEdit;
    _globalkey= GlobalKey<FormState>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      child: Container(
     //  height: MediaQuery.of(context).size.height*0.5,
        padding: EdgeInsets.all(15.0),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(
                Radius.circular(15.0))),
        child: Form(
          key: _globalkey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                decoration: BoxDecoration(
                    color: Theme.of(context)
                        .primaryColor,
                    borderRadius:
                    BorderRadius.all(
                        Radius.circular(
                            10.0))),
                alignment: Alignment.center,
                child: FlatButton.icon(
                    onPressed:() {
                      FocusScopeNode currentFocus =
                      FocusScope.of(context);

                      if (!currentFocus
                          .hasPrimaryFocus) {
                        currentFocus.unfocus();
                      }
                      widget.editProduct(tempProduct,widget.index,true);
                      Navigator.pop(context);
                    },
                    icon: Icon(Icons.delete,color: Colors.white,
                      size: 25.0,
                    ),
                    label: Text('Delete this Item',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 14.0
                      ),
                    )
                )
              ),
              SizedBox(
                height: 20.0,
              ),
              Text(
                'Edit your Item',
                style: TextStyle(
                  fontSize:18.0,
                  color: Theme.of(context)
                      .primaryColor,
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              Row(
                children: [
                  Container(
                    width: MediaQuery.of(context)
                        .size
                        .width *
                        0.2,
                    margin: EdgeInsets.only(
                        right: 10.0),
                    child: TextFormField(

                      initialValue: widget.productToEdit.price,
                        keyboardType:
                        TextInputType.number,
                        validator: (val) =>
                        val.isEmpty ||
                            val.length > 2 ? "price" : null,
                        onChanged: (val) {
                            tempProduct.price = val ?? widget.productToEdit.price;
                        },
                        decoration:
                        InputDecoration(
                          hintStyle: TextStyle(
                              color: Theme.of(
                                  context)
                                  .accentColor),
                          hintText: "price",
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  width: 2.0,
                                  color: Theme.of(
                                      context)
                                      .primaryColor)),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  width: 2.0,
                                  color: Theme.of(
                                      context)
                                      .accentColor)),
                        )),
                  ),
                  Expanded(
                    child: Container(
                      width:
                      MediaQuery.of(context)
                          .size
                          .width *
                          0.2,
                      child: TextFormField(
                          initialValue: widget.productToEdit.name,
                          validator: (val) => val
                              .isEmpty ||
                              val.length > 19
                              ? "0<name.len<20"
                              : null,
                          onChanged: (val) {
                            tempProduct.name = val ?? widget.productToEdit.name;
                          },
                          decoration:
                          InputDecoration(
                            hintStyle: TextStyle(
                                color: Theme.of(
                                    context)
                                    .accentColor),
                            hintText: "Name",
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    width: 2.0,
                                    color: Theme.of(
                                        context)
                                        .primaryColor)),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    width: 2.0,
                                    color: Theme.of(
                                        context)
                                        .accentColor)),
                          )),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context)
                        .size
                        .width *
                        0.2,
                    margin: EdgeInsets.only(
                        left: 10.0),
                    child: TextFormField(
                        initialValue: widget.productToEdit.quantity,
                        keyboardType:
                        TextInputType.number,
                        validator: (val) => val
                            .isEmpty ||
                            val.length > 2
                            ? "0<quantity.len<3"
                            : null,
                        onChanged: (val) {
                          tempProduct.quantity = val ?? widget.productToEdit.quantity;
                        },
                        decoration:
                        InputDecoration(
                          hintStyle: TextStyle(
                              color: Theme.of(
                                  context)
                                  .accentColor),
                          hintText: "quantity",
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  width: 2.0,
                                  color: Theme.of(
                                      context)
                                      .primaryColor)),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  width: 2.0,
                                  color: Theme.of(
                                      context)
                                      .accentColor)),
                        )),
                  ),
                ],
              ),

              SizedBox(height: 10.0,),
              GestureDetector(
                onTap: () {
                  FocusScopeNode currentFocus =
                  FocusScope.of(context);

                  if (!currentFocus
                      .hasPrimaryFocus) {
                    currentFocus.unfocus();
                  }
                  if(_globalkey.currentState.validate())
                  {
                    widget.editProduct(tempProduct,widget.index,false);
                    Navigator.pop(context);
                  }

                },
                child: Container(
                  padding: EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                      color: Theme.of(context)
                          .accentColor,
                      borderRadius:
                      BorderRadius.all(
                          Radius.circular(
                              10.0))),
                  alignment: Alignment.center,
                  child: Text(
                    'Continue',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.0,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 15.0,
              ),
              GestureDetector(
                onTap: () {
                  FocusScopeNode currentFocus =
                  FocusScope.of(context);

                  if (!currentFocus
                      .hasPrimaryFocus) {
                    currentFocus.unfocus();
                  }
                  Navigator.pop(context);
                },
                child: Container(
                  padding: EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                      color: Theme.of(context)
                          .primaryColor,
                      borderRadius:
                      BorderRadius.all(
                          Radius.circular(
                              10.0))),
                  alignment: Alignment.center,
                  child: Text(
                    'Cancel',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.0,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
