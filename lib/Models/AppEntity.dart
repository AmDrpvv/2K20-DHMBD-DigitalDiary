import 'package:flutter/material.dart';

List<String> monthName=['January','Feburary','March','April','May','June'
  ,'July','August','September','October','November','December'];

String getDateFormat(DateTime _date){
  if(_date.day>9)
    {
      return "${_date.day} ${monthName[_date.month-1]} ${_date.year}".toString();
    }
  else
    {
      return "0${_date.day} ${monthName[_date.month-1]} ${_date.year}".toString();
    }

}
Map<String,int> monthNumber = {'January':1,'Feburary':2,'March':3,'April':4,'May':5,'June':6
  ,'July':7,'August':8,'September':9,'October':10,'November':11,'December':12};
bool compareDateIsMax(String _date1,String _date2)
{
  if(_date1==null ||_date2==null)
    return false;
  int year1 = int.parse(_date1.substring(_date1.length-4));
  int month1 = monthNumber[_date1.substring(3,_date1.length-5)];
  int day1 = int.parse(_date1.substring(0,2));

  int year2 = int.parse(_date2.substring(_date2.length-4));
  int month2 = monthNumber[_date2.substring(3,_date2.length-5)];
  int day2 = int.parse(_date2.substring(0,2));

  if(year1>year2)
    return true;
  else if(year1==year2 && month1>month2)
    return true;
  else if(year1==year2 && month1==month2 && day1>day2)
    return true;
  else
    return false;
}


class Product{
  String quantity;
  String name;
  String price;


  Product({this.name,this.price,this.quantity});

  String getBillAmount()
  {
    return (int.parse(price)*int.parse(quantity)).toString();
  }

  String toStringList()
  {
    if(quantity.length==1)
      {
        if(price.length==1)
          return '0$quantity'+'0$price$name';
        else
          return '0$quantity$price$name';
      }
    else
      {
        if(price.length==1)
          return '$quantity'+'0$price$name';
        else
          return '$quantity$price$name';
      }
  }
}

class User{
  final String uid;
  User({@required this.uid});

}
class UserData{
  final String uid;
  String name;
  List<Product> defaultProductList;
 // Map<dynamic,dynamic> dailyProductMap;
  UserData({@required this.uid, this.name,this.defaultProductList});

}
class DailyProductsList{
  final String uid;
  Map<DateTime,DayProducts> mapDailyProducts;
  DailyProductsList({this.uid,this.mapDailyProducts});
}

class DayProducts{
  final String date;
  List<Product> productlist;
  String notes;

  DayProducts({@required this.date, this.productlist, this.notes});

  String getBill()
  {
    int amount=0;
    for(int  i=0;i<productlist.length;i++)
      {
        amount = amount + int.parse(productlist[i].getBillAmount());
      }
    return amount.toString();
  }

}

List<Product> defaultProducts=[
  Product(
    name: 'Amul Full Cream',
    quantity: '02',
    price: '28'
  ),
  Product(
      name: 'Amul Lassi',
      quantity: '01',
      price: '10'
  ),
  Product(
      name: 'Bread',
      quantity: '02',
      price: '20'
  ),
  Product(
      name: 'biscuits',
      quantity: '04',
      price: '10'
  ),
  Product(
      name: 'Namkeen',
      quantity: '02',
      price: '10'
  ),
];