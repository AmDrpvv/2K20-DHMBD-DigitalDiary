import 'package:flutter/material.dart';
import 'package:hisabapp/Models/AppEntity.dart';
import 'package:hisabapp/Services/DatabaseService.dart';
import 'package:hisabapp/Screens/Loading.dart';

class UpdateProfile extends StatefulWidget {
  final UserData userdata;
  UpdateProfile({this.userdata});
  @override
  _UpdateProfileState createState() => _UpdateProfileState();
}
GlobalKey<FormState> _formkey = GlobalKey<FormState>();
List<GlobalKey<FormState>> globalkeyList;
class _UpdateProfileState extends State<UpdateProfile> {

  bool showFillDefaultListScreen = false;
  String username = '';

  String error = '';
  bool isLoading = false;
  List<bool> isAdded;
  int defaultlistlength;
  List<Product> defaultproductslist;
  @override
  void initState() {
    error = '';
    isLoading = false;
    globalkeyList = [GlobalKey<FormState>()];
    defaultlistlength = 1;
    isAdded = [false];
    defaultproductslist = [Product()];

    username = '';
    _formkey = GlobalKey<FormState>();
    showFillDefaultListScreen = false;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return isLoading? Loading():Scaffold(
      appBar: AppBar(
        toolbarHeight: 70.0,
        flexibleSpace: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: <Color>[Theme.of(context).primaryColor
                  , Theme.of(context).accentColor],
              )),
        ),
        title: Text('Digital Diary'),
      ),
      body: GestureDetector(
        onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);

          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.unfocus();
          }
        },
        child: ListView(
          children: [
            Container(
              padding: EdgeInsets.all(40.0),
              child: Column(
                children: [
                  SizedBox(
                    height: 20.0,
                  ),
                  Container(
                    alignment: Alignment.center,
                    child: Text(
                      'Update your Profile',
                      style: TextStyle(
                        fontSize: 20.0,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Form(
                    key: _formkey,
                    child: Column(
                      children: [
                        SizedBox(
                          height: 20.0,
                        ),
                        TextFormField(
                          initialValue: widget.userdata.name,
                            keyboardType: TextInputType.emailAddress,
                            validator: (val) =>
                            val.isEmpty ? "enter valid Name" : null,
                            onChanged: (val) {
                              username = val;
                            },
                            decoration: InputDecoration(
                              labelStyle: TextStyle(
                                  color: Theme.of(context).primaryColor),
                              labelText:
                              "enter new username",
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Theme.of(context)
                                          .primaryColor)),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color:
                                      Theme.of(context).accentColor)),
                            )),
                        SizedBox(
                          height: 20.0,
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        Container(
                          child: FlatButton(
                            color: Theme.of(context).primaryColor,
                            child: Text(
                              'Continue',
                              style: TextStyle(color: Colors.white),
                            ),
                            onPressed: () {
                              FocusScopeNode currentFocus =
                              FocusScope.of(context);

                              if (!currentFocus.hasPrimaryFocus) {
                                currentFocus.unfocus();
                              }
                              if (_formkey.currentState.validate()) {
                                setState(() {
                                  showFillDefaultListScreen = true;
                                });
                              }
                            },
                          ),
                        ),
                        SizedBox(
                          height: 5.0,
                        ),
                        Text(
                          error,
                          style: TextStyle(
                              color: Colors.red, fontSize: 15.0),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            !showFillDefaultListScreen
                ? Container()
                : Container(
              padding: EdgeInsets.all(30.0),
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(15.0),
                    decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.all(
                            Radius.circular(12.0))),
                    alignment: Alignment.center,
                    child: Text(
                      'Add your Default Item List',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22.0,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30.0,
                  ),
                  Column(
                    children: [
                      for (int i = 0; i < defaultlistlength; i++)
                        Container(
                          margin: EdgeInsets.only(top: 30.0),
                          padding: EdgeInsets.all(15.0),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.all(
                                  Radius.circular(15.0))),
                          child: Form(
                            key: globalkeyList[i],
                            child: Column(
                              children: [
                                Text(
                                  'Product ${i + 1}',
                                  style: TextStyle(
                                    fontSize: 20.0,
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
                                          keyboardType:
                                          TextInputType.number,
                                          validator: (val) =>
                                          val.isEmpty ||
                                              val.length > 2 ? "price" : null,
                                          onChanged: (val) {
                                            defaultproductslist[i]
                                                .price = val ?? '0';
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
                                            validator: (val) => val
                                                .isEmpty ||
                                                val.length > 19
                                                ? "0<name.len<20"
                                                : null,
                                            onChanged: (val) {
                                              defaultproductslist[i]
                                                  .name =
                                                  val ?? 'Untitled';
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
                                          keyboardType:
                                          TextInputType.number,
                                          validator: (val) => val
                                              .isEmpty ||
                                              val.length > 2
                                              ? "0<quantity.len<3"
                                              : null,
                                          onChanged: (val) {
                                            defaultproductslist[i]
                                                .quantity =
                                                val ?? '0';
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
                                    if (globalkeyList[i]
                                        .currentState
                                        .validate()) {
                                      setState(() {
                                        isAdded[i] = true;
                                      });
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
                                      'Add to List',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18.0,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      SizedBox(
                        height: 25.0,
                      ),
                      !isAdded[defaultlistlength - 1]
                          ? Container()
                          : FloatingActionButton(
                        backgroundColor: Theme.of(context).primaryColor,
                        onPressed: () {
                          FocusScopeNode currentFocus =
                          FocusScope.of(context);

                          if (!currentFocus.hasPrimaryFocus) {
                            currentFocus.unfocus();
                          }
                          setState(() {
                            globalkeyList
                                .add(GlobalKey<FormState>());
                            defaultproductslist
                                .add(Product());
                            isAdded.add(false);
                            defaultlistlength++;
                          });
                        },
                        child: Icon(
                          Icons.add,
                          size: 30.0,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(
                        height: 25.0,
                      ),
                      !isAdded[defaultlistlength - 1]
                          ? Container()
                          : GestureDetector(
                        onTap: () async{
                          FocusScopeNode currentFocus =
                          FocusScope.of(context);

                          if (!currentFocus.hasPrimaryFocus) {
                            currentFocus.unfocus();
                          }
                          setState(() {
                            error = '';
                            isLoading = true;
                          });

                          await DatabaseService(uid: widget.userdata.uid).updateUserDatabase(
                              username.length<1? widget.userdata.name:username,
                              defaultproductslist);
                          Navigator.pop(context);
                          Navigator.pop(context);

                        },
                        child: Container(
                          padding: EdgeInsets.all(12.0),
                          decoration: BoxDecoration(
                              color: Theme.of(context)
                                  .accentColor,
                              borderRadius: BorderRadius.all(
                                  Radius.circular(12.0))),
                          alignment: Alignment.center,
                          child: Text(
                            'Continue With Above List',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 24.0,
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      )
    );
  }
}
