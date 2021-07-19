import 'package:flutter/material.dart';
import 'package:hisabapp/Models/AppEntity.dart';
import 'package:hisabapp/Screens/Loading.dart';
import 'package:hisabapp/Services/DatabaseService.dart';
import 'EditableProductTile.dart';
import 'ShowDialog.dart';

class EditableDayContainer extends StatefulWidget {

  final UserData ourUserData;
  final DayProducts dayProductToBeEdit;
  final String totalBill;
  final String timeLine;

  const EditableDayContainer({Key key, this.dayProductToBeEdit,this.totalBill, this.timeLine,this.ourUserData}) : super(key: key);
  @override
  _EditableDayContainerState createState() => _EditableDayContainerState();
}

class _EditableDayContainerState extends State<EditableDayContainer> {
  DayProducts dayproduct;

  void initState()
  {
    dayproduct= new DayProducts(date: widget.dayProductToBeEdit.date,
        productlist: [],
        notes: widget.dayProductToBeEdit.notes
    );
    for(int i =0;i< widget.dayProductToBeEdit.productlist.length;i++)
      {
        dayproduct.productlist.add(
            new Product(
                quantity: widget.dayProductToBeEdit.productlist[i].quantity,
                price: widget.dayProductToBeEdit.productlist[i].price,
                name: widget.dayProductToBeEdit.productlist[i].name
            )
        );
      }
    super.initState();
  }
  @override
  void dispose() {
    dayproduct= new DayProducts(date: widget.dayProductToBeEdit.date,
        productlist: [],
        notes: widget.dayProductToBeEdit.notes
    );
    for(int i =0;i< widget.dayProductToBeEdit.productlist.length;i++)
    {
      dayproduct.productlist.add(
        new Product(
          quantity: widget.dayProductToBeEdit.productlist[i].quantity,
          price: widget.dayProductToBeEdit.productlist[i].price,
          name: widget.dayProductToBeEdit.productlist[i].name
        )
      );
    }
    super.dispose();
  }
  void editDayProduct(String _date , String _notes,List<Product> _productList)
  {

  }
  void addProduct(Product _product,int index,bool delete)
  {
    if(_product==null || delete==true)
      return null;
    dayproduct.productlist.add(_product);
  }

  void editProduct(Product _product,int index,bool delete)
  {
    if(delete==true)
    {
      deleteProduct(index);
      return null;
    }
    setState(() {
      dayproduct.productlist[index].price=_product.price??'0';
      dayproduct.productlist[index].quantity=_product.quantity??'0';
      dayproduct.productlist[index].name=_product.name?? '__error__';
    });
  }

  void deleteProduct(int index)
  {
    if(index >-1 && index < dayproduct.productlist.length)
      {
        setState(() {
          dayproduct.productlist.remove(dayproduct.productlist[index]);
        });
      }
  }

  @override
  Widget build(BuildContext context) {
    final _ouruserdata = widget.ourUserData;
    if(_ouruserdata==null)
      {
        return Loading();
      }
    else
      {
        return Scaffold(
          backgroundColor: Theme
              .of(context)
              .scaffoldBackgroundColor,
          appBar: AppBar(
              iconTheme: IconThemeData(
                 // color: Colors.white
              ),
              leading: IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: (){
                  Navigator.pop(context);
                },
              ),
              actions: [
                // Icon(Icons.attach_money),
                Container(
                  alignment: Alignment.center,
                  child: Text(widget.totalBill,
                    style: TextStyle(
                        fontSize: 18.0,
                      fontWeight: FontWeight.normal,
                      color: Theme.of(context).primaryColor,
                    ),),
                ),
                IconButton(
                  icon: Icon(Icons.receipt),
                  onPressed: (){
                  },
                ),
              ],
              elevation: 0.0,
              title: Text('Digital Diary', style: TextStyle(
                  fontSize: 20.0,
                fontWeight: FontWeight.normal,
                color: Theme.of(context).primaryColor,
              ),),
              flexibleSpace: Container(
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: <Color>[Theme
                          .of(context)
                          .scaffoldBackgroundColor,
                        Theme
                            .of(context)
                            .scaffoldBackgroundColor
                      ],
                    )
                ),
              )
          ),
          body: dayproduct==null ? Container(
            alignment: Alignment.center,
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
                fontWeight: FontWeight.w500,
              ),
            ),)
              :Column(
            children: [
              Container(
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: <Color>[Theme
                            .of(context)
                            .scaffoldBackgroundColor,
                          Theme
                              .of(context)
                              .scaffoldBackgroundColor
                        ]),
                    borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(25.0),
                        bottomLeft: Radius.circular(25.0))),
                height: 50.0,
                padding: EdgeInsets.only(right: 20.0),
                alignment: Alignment.topRight,
                child: Text(
                  widget.timeLine,
                  style: TextStyle(
                      fontSize: 14.0,
                    fontWeight: FontWeight.normal,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Container(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    child: Column(
                      children: [
                        Container(
                          color: Theme.of(context).scaffoldBackgroundColor,
                          alignment: Alignment.center,
                          child: Container(
                            margin: EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              color: Theme.of(context).scaffoldBackgroundColor,
                              boxShadow: [
                                BoxShadow(
                                  offset: Offset(0,0),
                                  color: Theme.of(context).accentColor,
                                  blurRadius: 4.0

                                )
                              ]
                            ),
                            padding: EdgeInsets.symmetric(vertical: 10.0,horizontal: 40.0),
                            child: Text('Edit your List', style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.w500,
                              color: Theme.of(context).primaryColor,
                            ),
                            ),
                          ),
                        ),

                        Container(
                          decoration: BoxDecoration(
                              color: Theme
                                  .of(context)
                                  .backgroundColor,
                              borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(35.0),
                                  topLeft: Radius.circular(35.0))),
                          padding: EdgeInsets.all(
                              MediaQuery
                                  .of(context)
                                  .size
                                  .width * 0.1),
                          child: GestureDetector(
                            onTap: ()
                            {
                              FocusScopeNode currentFocus =
                              FocusScope.of(context);

                              if (!currentFocus
                                  .hasPrimaryFocus) {
                                currentFocus.unfocus();
                              }
                            },
                            child: Column(
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
                                SizedBox(height: 10.0,),
                                Container(
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10.0),
                                      color: Theme.of(context).accentColor,
                                    ),
                                    child: FlatButton.icon(
                                        onPressed:() {
                                          showAlertDialog(context, _ouruserdata.uid, dayproduct, true);
                                        },
                                        icon: Icon(Icons.delete,
                                          color: Theme.of(context).scaffoldBackgroundColor,
                                          size: 26.0,
                                        ),
                                        label: Text('Delete List',
                                          style: TextStyle(
                                              color: Theme.of(context).scaffoldBackgroundColor,
                                              fontSize: 17.0
                                          ),
                                        ))
                                ),
                                for(int i=0;i<dayproduct.productlist.length;i++)
                                  EditableProductTile(product:dayproduct.productlist[i],index: i,editProduct: editProduct,),

                                SizedBox(height: 20.0,),
                                Container(
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10.0),
                                      color: Theme.of(context).accentColor,
                                    ),
                                    child: FlatButton.icon(
                                        onPressed: () {
                                          FocusScopeNode currentFocus =
                                          FocusScope.of(context);

                                          if (!currentFocus.hasPrimaryFocus) {
                                            currentFocus.unfocus();
                                          }
                                          showDialog(context: context,
                                              builder: (BuildContext context) =>
                                                  ShowCustomDialog(productToEdit:new Product(),index: -1,editProduct: addProduct, )
                                          );
                                        },
                                        icon: Icon(Icons.add_box,
                                          color: Theme.of(context).scaffoldBackgroundColor,
                                          size: 26.0,
                                        ),
                                        label: Text('Add More Item',
                                          style: TextStyle(
                                              color: Theme.of(context).scaffoldBackgroundColor,
                                              fontSize: 17.0
                                          ),
                                        ))
                                ),
                                SizedBox(height: 10.0,),
                                Container(
                                  margin: EdgeInsets.only(top: 20.0),
                                  padding: EdgeInsets.symmetric(
                                      vertical: 10.0, horizontal: 10.0),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.0),
                                    color: Theme.of(context).scaffoldBackgroundColor,
                                  ),
                                  child: Container(

                                    child: TextFormField(
                                        initialValue: dayproduct.notes,
                                        onChanged: (val) {
                                          dayproduct.notes = val ?? 'add ypur notes here';
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
                                SizedBox(height: 25.0,),
                                Container(
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10.0),
                                      color: Theme.of(context).primaryColor,
                                    ),
                                    child: FlatButton.icon(
                                        onPressed:() {
                                          showAlertDialog(context, _ouruserdata.uid, dayproduct,false);
                                        },
                                        icon: Icon(Icons.check,
                                          color: Theme.of(context).scaffoldBackgroundColor,
                                          size: 26.0,
                                        ),
                                        label: Text('Continue with Above List',
                                          style: TextStyle(
                                              color: Theme.of(context).scaffoldBackgroundColor,
                                              fontSize: 17.0
                                          ),
                                        ))
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          floatingActionButton:FloatingActionButton(
            backgroundColor: Theme
                .of(context)
                .accentColor,
            onPressed: (){
              Navigator.pop(context);
              dayproduct=widget.dayProductToBeEdit;
            },
            child: Icon(Icons.arrow_back,
              size: 30.0,
              color: Theme.of(context).scaffoldBackgroundColor,
            ),
          ) ,
        );
      }
  }

  showAlertDialog(BuildContext context,String uid ,DayProducts _dayProduct,bool delete ) {
    // set up the buttons
    Widget cancelButton = FlatButton(
      child: Text("Cancel"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
    Widget continueButton = FlatButton(
      child: Text("Continue"),
      onPressed: ()async {
        if(delete)
          {
            Navigator.of(context).pop();
            await DatabaseService(uid: uid).deleteDocumentDayProduct(dayproduct.date);
          }
        else
          {
            Navigator.of(context).pop();
            await DatabaseService(uid: uid).updateUserDatabaseProductList(
                _dayProduct.date, _dayProduct.productlist??[],_dayProduct.notes??'write your notes here');
          }
        Navigator.of(context).pop();

      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Hey User"),
      content:
      !delete ? Text("Would you like to save all your changes ?")
          :Text('Would you like to delete the selected item'),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
