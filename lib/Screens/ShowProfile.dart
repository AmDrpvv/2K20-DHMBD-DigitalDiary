import 'package:flutter/material.dart';
import 'package:hisabapp/Models/AppEntity.dart';
import 'package:hisabapp/Screens/UpdateProfile.dart';
import 'package:hisabapp/Widgets/ProductTile.dart';

class ShowProfile extends StatelessWidget {
  final UserData userdata;
  ShowProfile({this.userdata});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
          elevation: 0.0,
          title: Text('Digital Diary', style: TextStyle(
              fontSize: 20.0,
              color: Colors.white
          ),),
          flexibleSpace: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: <Color>[Theme
                      .of(context)
                      .primaryColor,
                    Theme
                        .of(context)
                        .accentColor
                  ],
                )
            ),
          )
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 40.0,),
                  Container(
                    alignment: Alignment.center,
                    child: CircleAvatar(
                      radius: 45.0,
                      backgroundColor: Colors.white,
                    ),
                  ),
                  SizedBox(height: 10.0,),
                  Container(
                    alignment: Alignment.center,
                    child: Text(
                      userdata.name,
                      style: TextStyle(
                        fontSize: 24.0,
                        color: Theme.of(context).primaryColor
                      ),
                    ),
                  ),
                  SizedBox(height: 20.0,),
                  Container(
                    alignment: Alignment.center,
                    child: Text(
                      'Default Item List',
                      style: TextStyle(
                          fontSize: 18.0,
                          color: Theme.of(context).accentColor
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal:
                        MediaQuery
                            .of(context)
                            .size
                            .width * 0.15),
                    child: Column(
                      children: [
                        for(int i=0;i<userdata.defaultProductList.length;i++)
                          ProductTile(product:userdata.defaultProductList[i]),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme
            .of(context)
            .primaryColor,
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(
              builder: (context)=>UpdateProfile(
                userdata: userdata,
              )));
        },
        child: Icon(Icons.edit,
          size: 20.0,
          color: Colors.white,
        ),
      )
    );
  }
}
