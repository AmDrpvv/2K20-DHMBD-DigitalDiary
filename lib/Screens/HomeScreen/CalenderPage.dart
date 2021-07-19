import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hisabapp/Models/AppEntity.dart';
import 'package:hisabapp/Screens/HomeScreen/BillReceipt.dart';
import 'package:hisabapp/Screens/Loading.dart';
import 'package:hisabapp/Services/DatabaseService.dart';
import 'package:hisabapp/Widgets/DayContainer.dart';
import 'package:hisabapp/Widgets/EditableDayContainer.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';
import '../NavBarDrawer.dart';

class CalenderPage extends StatefulWidget {

  @override
  _CalenderPageState createState() => _CalenderPageState();
}

class _CalenderPageState extends State<CalenderPage> {
  static DateTime selectedDate;
  static CalendarController _controllerCalendar;
  static DateTime currentDate;
  String getFirstAndLastDate(Map<dynamic,dynamic> map)
  {
    if(map==null|| map.isEmpty)
      return null;

    String result = 'No data added';

    String maxDate=getDateFormat(DateTime.now().subtract(Duration(days: 2000)));
    String minDate=getDateFormat(DateTime.now().add(Duration(days: 2000)));
    map.forEach((key, value) {
      if(compareDateIsMax(key,maxDate))
          maxDate=key;
      if(compareDateIsMax(minDate, key))
          minDate=key;
    });

    if(minDate.substring(minDate.length-4) == maxDate.substring(maxDate.length-4))
      {
        minDate=minDate.substring(0,minDate.length-5);
        maxDate=maxDate.substring(0,maxDate.length-5);
      }

    result = "$minDate - $maxDate";
    return result;
  }

  String getTotalBill(Map<dynamic,dynamic> map)
  {
    if(map==null)
      return null;

    int amount=0;
    map.forEach((key, value) {
      if(value!=null)
        amount=amount + int.parse(value.getBill());
    });

    return amount.toString();
  }

  @override
  void initState()
  {
    _controllerCalendar =new CalendarController();
    currentDate=DateTime.now();
    selectedDate=currentDate;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
   final _ouruserdata = Provider.of<UserData>(context);
   Map<dynamic,dynamic> _mainUserMap = Provider.of<Map<dynamic,dynamic>>(context);
   if(_mainUserMap==null ||_ouruserdata==null)
      {
        return Loading();
      }
    else
      {
        return Scaffold(
          appBar: AppBar(
            iconTheme: IconThemeData(
             // color: Colors.white
            ),
              actions: [
                Container(
                  alignment: Alignment.center,
                  child: Text('Rs '+getTotalBill(_mainUserMap)??'Rs ---',
                    style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.normal,
                        color: Theme.of(context).primaryColor
                    ),),
                ),
                IconButton(
                  icon: Icon(Icons.receipt),
                  onPressed: (){
                    Navigator.push(context, MaterialPageRoute(
                        builder: (context)=>BillReceipt(
                          uid: _ouruserdata.uid,
                          userMap: _mainUserMap,
                          totalBill:'Rs '+getTotalBill(_mainUserMap)??'Rs ---',
                          timeLine:getFirstAndLastDate(_mainUserMap) ??
                              'No data added',
                        )));
                  },
                ),
              ],

              elevation: 0.0,
              title: Text('Digital Diary', style: TextStyle(
                  fontSize: 20.0,
                  color: Theme.of(context).primaryColor,
                fontWeight: FontWeight.w400
              ),),
              flexibleSpace: Container(
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: <Color>[Theme.of(context).scaffoldBackgroundColor,Theme.of(context).scaffoldBackgroundColor
                      ],
                    )
                ),
              )),
          drawer: NavBarDrawer(userdata: _ouruserdata),
          body: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: <Color>[
                          Theme.of(context).scaffoldBackgroundColor,
                          Theme.of(context).scaffoldBackgroundColor
                        ]),
                    borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(25.0),
                        bottomLeft: Radius.circular(25.0))),
                height: 50.0,
                padding: EdgeInsets.only(right: 20.0),
                alignment: Alignment.topRight,
                child: Text(
                  getFirstAndLastDate(_mainUserMap) ??
                      'No data added',
                  style: TextStyle(
                    fontWeight: FontWeight.normal,
                    color: Theme.of(context).primaryColor,
                    fontSize: 14.0,
                   // color: Colors.white
                ),
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Container(
//                    color: Theme.of(context).backgroundColor,
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.only(bottom: 20.0),
                          child: TableCalendar(
                            initialSelectedDay: currentDate,
                            calendarController: _controllerCalendar,
                            endDay: currentDate,
                            startDay: currentDate.subtract(Duration(
                                days: 15)),
                            initialCalendarFormat: CalendarFormat.week,
                            onDaySelected: (val,e,r) {
                              setState(() {
                                selectedDate = val;
                              });
                              },
                            headerStyle: HeaderStyle(
                                formatButtonShowsNext: false,
                                formatButtonDecoration: BoxDecoration(),
                                leftChevronIcon: Icon(
                                  Icons.chevron_left,
                                  color: Theme.of(context).primaryColor,
                                ),
                                rightChevronIcon: Icon(
                                  Icons.chevron_right,
                                  color: Theme.of(context).primaryColor,
                                ),
                                formatButtonTextStyle: TextStyle(
                                    color: Theme.of(context).backgroundColor,
                                ),
                                titleTextStyle: TextStyle(
                                    color: Theme.of(context).backgroundColor,
                                    fontSize: 20.0
                                )
                            ),
                            daysOfWeekStyle: DaysOfWeekStyle(
                              weekdayStyle: TextStyle(
                                  color: Theme.of(context).primaryColor,
                                  fontWeight: FontWeight.normal),
                              weekendStyle: TextStyle(
                                  color: Theme.of(context).primaryColor,
                                  fontWeight: FontWeight.normal),
                            ),
                            calendarStyle: CalendarStyle(
                              unavailableStyle: TextStyle(
                                  color: Theme.of(context).primaryColor.withAlpha(100),
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.w400),
                              selectedColor: Theme.of(context).accentColor,
                              todayColor: Theme.of(context).accentColor.withAlpha(100),

                              weekendStyle: TextStyle(
                                  color: Theme.of(context).backgroundColor,
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.normal),
                              weekdayStyle: TextStyle(
                                  color: Theme.of(context).backgroundColor,
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.normal),
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
                          padding: EdgeInsets.only(
                              top: MediaQuery.of(context).size.width * 0.1,
                            bottom: MediaQuery.of(context).size.width * 0.5,
                            left: MediaQuery.of(context).size.width * 0.1,
                            right: MediaQuery.of(context).size.width * 0.1,
                          ),
                          child: DayContainer(
                            dayproduct: _mainUserMap[getDateFormat(selectedDate)] ?? null,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          floatingActionButton: _mainUserMap.containsKey(getDateFormat(selectedDate))
              ? FloatingActionButton(
          backgroundColor: Theme
          .of(context)
          .primaryColor,
            onPressed: (){
              Navigator.push(context, MaterialPageRoute(
                  builder: (context)=>EditableDayContainer(
                    ourUserData: _ouruserdata,
                    dayProductToBeEdit:_mainUserMap[getDateFormat(selectedDate)] ?? null,
                    totalBill:'Rs '+getTotalBill(_mainUserMap)??'Rs ---',
                    timeLine:getFirstAndLastDate(_mainUserMap) ??
                        'No data added',
                  )));
            },
          child: Icon(Icons.edit,
            size: 20.0,
           // color: Colors.white,
          ),
        ) : FloatingActionButton(
            backgroundColor: Theme
                .of(context)
                .primaryColor,
            onPressed: () {

               showAlertDialog(context,_ouruserdata,selectedDate);

            },
            child: Icon(Icons.add,
              size: 30.0,
              //color: Colors.white,
            ),
          ),
        );
      }

  }
  showAlertDialog(BuildContext context,UserData _mainUserData ,DateTime date ) {
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
        Navigator.of(context).pop();
        await DatabaseService(uid: _mainUserData.uid).updateUserDatabaseProductList(
            getDateFormat(date), _mainUserData.defaultProductList,
            'write your notes here');

      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Hey User"),
      content:
      Text("Would you like to create new entry for this day ?"),
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
