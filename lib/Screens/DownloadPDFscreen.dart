import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class PDFscreen extends StatelessWidget {
  final Map<dynamic,dynamic> ourUserMap;
  final String totalBill;
  final String timeLine;
  PDFscreen({this.timeLine,this.totalBill,this.ourUserMap});
  final pdf = pw.Document();
  void generateBillPDF() async
  {
    pdf.addPage(pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return <pw.Widget>[
            for(var j=0,i=0,key =ourUserMap.keys.elementAt(i);i<ourUserMap.length;i++,i<ourUserMap.length?key =ourUserMap.keys.elementAt(i):j++)
              pw.Container(
                margin: pw.EdgeInsets.symmetric(vertical: 4.0),
                decoration: pw.BoxDecoration(
                ),
                child: pw.Column(
                  children: [
                    pw.Container(
                      child: pw.Text(key,
                        style: pw.TextStyle(
                            fontSize: 20.0),
                      ),
                      padding: pw.EdgeInsets.all(10.0),
                      alignment: pw.Alignment.center,
                    ),
                        pw.Container(
                          padding: pw.EdgeInsets.only(top: 5.0,bottom: 0.0,left: 10.0,right: 10.0),
                          child: pw.Row(
                            mainAxisSize: pw.MainAxisSize.max,
                            mainAxisAlignment: pw.MainAxisAlignment.spaceAround,
                            children: [
                              pw.Container(
                                child: pw.Text('S.No',
                                  style: pw.TextStyle(
                                      fontSize: 15.0),
                                ),
                                alignment: pw.Alignment.center,
                                width: 80.0,
                              ),
                              pw.Expanded(
                                child: pw.Container(
                                  child: pw.Text('Product Name',
                                    style: pw.TextStyle(

                                        fontSize: 15.0),
                                  ),
                                  alignment: pw.Alignment.centerLeft,
                                ),
                              ),
                              pw.Container(
                                child: pw.Text('Price',
                                  style: pw.TextStyle(

                                      fontSize: 15.0),
                                ),
                                alignment: pw.Alignment.center,
                                width: 80.0,
                              ),
                              pw.Container(
                                child: pw.Text('quantity',
                                  style: pw.TextStyle(
                                      fontSize: 15.0),
                                ),
                                alignment: pw.Alignment.center,
                                width: 80.0,
                              ),
                              pw.Container(
                                child: pw.Text('Total',
                                  style: pw.TextStyle(

                                      fontSize: 15.0),
                                ),
                                alignment: pw.Alignment.center,
                                width: 80.0,
                              ),
                            ],
                          ),
                        ),
                    for(int i=0;i<ourUserMap[key].productlist.length;i++)
                      int.parse(ourUserMap[key].productlist[i].quantity)==0? pw.SizedBox(height: 1.0):pw.Container(
                        padding: pw.EdgeInsets.only(bottom:5.0,left: 10.0,right: 10.0,top:0.0),
                        child: pw.Row(
                          mainAxisSize: pw.MainAxisSize.max,
                          mainAxisAlignment: pw.MainAxisAlignment.spaceAround,
                          children: [
                            pw.Container(
                              child: pw.Text((i+1).toString(),
                                style: pw.TextStyle(
                                    fontSize: 15.0),
                              ),
                              alignment: pw.Alignment.center,
                              width: 80.0,
                            ),
                            pw.Expanded(
                              child: pw.Container(
                                child: pw.Text(ourUserMap[key].productlist[i].name,
                                  style: pw.TextStyle(
                                      fontSize: 15.0),
                                ),
                                alignment: pw.Alignment.centerLeft,
                              ),
                            ),
                            pw.Container(
                              child: pw.Text(ourUserMap[key].productlist[i].price,
                                style: pw.TextStyle(
                                    fontSize: 15.0),
                              ),
                              alignment: pw.Alignment.center,
                              width: 80.0,
                            ),
                            pw.Container(
                              child: pw.Text(ourUserMap[key].productlist[i].quantity,
                                style: pw.TextStyle(
                                    fontSize: 15.0),
                              ),
                              alignment: pw.Alignment.center,
                              width: 80.0,
                            ),
                            pw.Container(
                              child: pw.Text(ourUserMap[key].productlist[i].getBillAmount(),
                                style: pw.TextStyle(
                                    fontSize: 12.0),
                              ),
                              padding: pw.EdgeInsets.all(10.0),
                              alignment: pw.Alignment.center,
                              width: 80.0,
                            ),
                          ],
                        ),
                      ),
                    pw.Container(
                      child: pw.Text('Total bill - Rs '+ourUserMap[key].getBill(),
                        style: pw.TextStyle(

                            fontSize: 16.0),
                      ),
                      padding: pw.EdgeInsets.all(4.0),
                      margin: pw.EdgeInsets.only(bottom: 4.0),
                      alignment: pw.Alignment.center,
                    ),
                  ],
                ),
              )
//            pw.Expanded(
//              child: pw.Container(
//                child: pw.Container(
//                child: pw.ListView.builder(
//                    itemCount: ourUserMap.length,
//                    itemBuilder: (context,index){
//                      String key =ourUserMap.keys.elementAt(index);
//                      return ;
//                    }
//                ),
//          ),
//              ),
//            )
          ];
        }
        )
    );// Page

    final output = await getExternalStorageDirectory();
    String path = output.path + '/'+timeLine+totalBill+'.pdf';
    File outputFile = File(path);
    outputFile.writeAsBytes(pdf.save());

    print(path);



  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
      body:Center(
        child: Container(
          height: MediaQuery.of(context).size.height*0.3,
            margin: EdgeInsets.symmetric(horizontal: 20.0,vertical: 20.0),
            padding: EdgeInsets.all(15.0),
            decoration: BoxDecoration(
                color: Theme.of(context).accentColor,
                borderRadius: BorderRadius.all(
                    Radius.circular(15.0)
                )
            ),
            alignment: Alignment.center,
            child:Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Total amount generated is '+totalBill,
                  style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.white
                  ),),
                SizedBox(height: 10.0,),
                Text('Download Bill PDF for timeline : '+timeLine,
                  style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.white
                  ),),
                SizedBox(height: 10.0,),
                FlatButton.icon(onPressed: () {
                  generateBillPDF();
                  Navigator.pop(context);
                  },
                    icon: Icon(Icons.file_download),
                    label: Text('Download PDF'))
              ],
            )
        ),
      )
    );
  }
}
