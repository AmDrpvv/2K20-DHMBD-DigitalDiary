import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hisabapp/Screens/DownloadPDFscreen.dart';
import 'package:hisabapp/Screens/Loading.dart';
import 'package:hisabapp/Services/DatabaseService.dart';

class BillReceipt extends StatefulWidget {
  final String uid;
  final Map<dynamic,dynamic> userMap;
  final String totalBill;
  final String timeLine;
  BillReceipt({this.uid,this.userMap,this.totalBill,this.timeLine});
  @override
  _BillReceiptState createState() => _BillReceiptState();
}

class _BillReceiptState extends State<BillReceipt> {
  bool isLoading=false;
  @override
  void initState() {
    isLoading=false;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    Map<dynamic,dynamic> ourUserMap = widget.userMap;
    return isLoading ? Loading():Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        actions: [
          GestureDetector(
            onTap: ()
            {
              if(ourUserMap.isNotEmpty)
              {
                Navigator.push(context, MaterialPageRoute(
                    builder: (context)=>PDFscreen(timeLine: widget.timeLine,
                      totalBill: widget.totalBill,
                      ourUserMap: ourUserMap,
                    )
                ));
              }
            },
            child: Icon(
              Icons.file_download,
              color: Colors.white,
            ),
          ),
          FlatButton.icon(
            label: Text(
                'Clear Bill',
                style:TextStyle(
                    color: Colors.white
                )
            ),
            icon: Icon(
              Icons.clear_all_sharp,
              color: Colors.white,
            ),
            onPressed: (){
              if(ourUserMap.isNotEmpty)
              {
                showAlertDialog(context, widget.uid);
              }
            },
          ),
        ],
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
      body: ourUserMap.isEmpty ? Center(
        child: Text('No Data Found', style: TextStyle(
            fontSize: 30.0,
            color: Colors.blueGrey),
        ),
      )
          :Stack(
        children: [
          Column(
            children: [
              Container(
                color: Colors.white,
                child: Container(
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
                          ]),
                      borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(25.0),
                          bottomLeft: Radius.circular(25.0))),
                  //height: 50.0,
                  alignment: Alignment.center,
                  padding: EdgeInsets.all(20.0),
                  child: Text('Bill Receipt', style: TextStyle(
                      fontSize: 22.0,
                      color: Colors.white
                  ),
                  ),
                ),
              ),

              Expanded(
                child: ListView.builder(
                    itemCount: ourUserMap.length,
                    itemBuilder: (context,index){
                      String key =ourUserMap.keys.elementAt(index);
                      return Container(
                        margin: EdgeInsets.symmetric(vertical: 10.0),
                        decoration: BoxDecoration(
                            border: Border(
                                bottom: BorderSide(
                                    width: 1.0,
                                    color: Colors.blueGrey
                                )
                            )
                        ),
                        child: Column(
                          children: [
                            Container(
                              child: Text(key,
                                style: TextStyle(
                                    color: Theme.of(context).primaryColor,
                                    fontSize: 20.0),
                              ),
                              padding: EdgeInsets.all(10.0),
                              alignment: Alignment.center,
                            ),
                            Container(
                              padding: EdgeInsets.only(top: 10.0,bottom: 0.0,left: 10.0,right: 10.0),
                              child: Row(
                                children: [
                                  Container(
                                    child: Text('S.No',
                                      style: TextStyle(
                                          color: Theme.of(context).accentColor,
                                          fontSize: 15.0),
                                    ),
                                    alignment: Alignment.center,
                                    width: MediaQuery.of(context).size.width*0.15,
                                  ),
                                  Expanded(
                                    child: Container(
                                      child: Text('Product Name',
                                        style: TextStyle(
                                            color: Theme.of(context).accentColor,
                                            fontSize: 15.0),
                                      ),
                                      alignment: Alignment.centerLeft,
                                    ),
                                  ),
                                  Container(
                                    child: Text('Price',
                                      style: TextStyle(
                                          color: Theme.of(context).accentColor,
                                          fontSize: 15.0),
                                    ),
                                    alignment: Alignment.center,
                                    width: MediaQuery.of(context).size.width*0.15,
                                  ),
                                  Container(
                                    child: Text('quantity',
                                      style: TextStyle(
                                          color: Theme.of(context).accentColor,
                                          fontSize: 15.0),
                                    ),
                                    alignment: Alignment.center,
                                    width: MediaQuery.of(context).size.width*0.15,
                                  ),
                                  Container(
                                    child: Text('Total',
                                      style: TextStyle(
                                          color: Theme.of(context).accentColor,
                                          fontSize: 15.0),
                                    ),
                                    alignment: Alignment.center,
                                    width: MediaQuery.of(context).size.width*0.15,
                                  ),
                                ],
                              ),
                            ),
                            for(int i=0;i<ourUserMap[key].productlist.length;i++)
                              Container(
                                padding: EdgeInsets.only(bottom:10.0,left: 10.0,right: 10.0,top:0.0),
                                child: Row(
                                  children: [
                                    Container(
                                      child: Text((i+1).toString(),
                                        style: TextStyle(
                                            fontSize: 15.0),
                                      ),
                                      alignment: Alignment.center,
                                      width: MediaQuery.of(context).size.width*0.15,
                                    ),
                                    Expanded(
                                      child: Container(
                                        child: Text(ourUserMap[key].productlist[i].name,
                                          style: TextStyle(
                                              fontSize: 15.0),
                                        ),
                                        alignment: Alignment.centerLeft,
                                      ),
                                    ),
                                    Container(
                                      child: Text(ourUserMap[key].productlist[i].price,
                                        style: TextStyle(
                                            fontSize: 15.0),
                                      ),
                                      alignment: Alignment.center,
                                      width: MediaQuery.of(context).size.width*0.15,
                                    ),
                                    Container(
                                      child: Text(ourUserMap[key].productlist[i].quantity,
                                        style: TextStyle(
                                            fontSize: 15.0),
                                      ),
                                      alignment: Alignment.center,
                                      width: MediaQuery.of(context).size.width*0.15,
                                    ),
                                    Container(
                                      child: Text(ourUserMap[key].productlist[i].getBillAmount(),
                                        style: TextStyle(
                                            fontSize: 15.0),
                                      ),
                                      padding: EdgeInsets.all(10.0),
                                      alignment: Alignment.center,
                                      width: MediaQuery.of(context).size.width*0.15,
                                    ),
                                  ],
                                ),
                              ),
                            Container(
                              child: Text('Total bill - Rs '+ourUserMap[key].getBill(),
                                style: TextStyle(
                                    color: Theme.of(context).accentColor,
                                    fontSize: 18.0),
                              ),
                              padding: EdgeInsets.all(10.0),
                              margin: EdgeInsets.only(bottom: 5.0),
                              alignment: Alignment.center,
                            ),
                          ],
                        ),
                      );
                    }
                ),
              ),
              Container(
                color: Colors.white,
                height: 100.0,
                ),
            ],
          ),
          Positioned(
            bottom: 0.0,
            left: 0.0,
            right: 0.0,
            child:Container(
                margin: EdgeInsets.symmetric(horizontal: 5.0,vertical: 10.0),
                padding: EdgeInsets.all(15.0),
                decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.all(
                        Radius.circular(15.0)
                    )
                ),
                alignment: Alignment.center,
                child:Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(widget.timeLine,
                      style: TextStyle(
                          fontSize: 16.0,
                          color: Colors.white
                      ),),
                    SizedBox(height: 10.0,),
                    Text(widget.totalBill,
                      style: TextStyle(
                          fontSize: 22.0,
                          color: Colors.white
                      ),),
                  ],
                )
            ),
          ),
        ],

          ),
    );
  }

  showAlertDialog(BuildContext context, String uid ) {
    // set up the buttons
    Widget downloadpdf = FlatButton(
      child: Text("Download PDF"),
      onPressed: () {
        Navigator.of(context).pop();
        Navigator.push(context, MaterialPageRoute(
            builder: (context)=>PDFscreen(timeLine: widget.timeLine,
              totalBill: widget.totalBill,
              ourUserMap: widget.userMap,
            )
        ));
      },
    );
    Widget cancelButton = FlatButton(
      child: Text("Cancel"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
    Widget continueButton = FlatButton(
      child: Text("Continue"),
      onPressed: ()async {
        Navigator.of(context).pop();
        setState(() {
          isLoading=true;
        });
        await DatabaseService(uid: uid).deleteDailyProductSubCollection();
        setState(() {
          isLoading=false;
        });
        Navigator.of(context).pop();
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Warning"),
      content:
      Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start
        ,
        children: [
          Text("Would you like delete all the collection of your Items?"),
          Text("you can not undo this action !!!"),
          Text("PS please download your collections PDF"),
        ],
      ),

      actions: [
        cancelButton,
        continueButton,
        downloadpdf,
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
