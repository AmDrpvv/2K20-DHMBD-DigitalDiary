import 'package:flutter/material.dart';
import 'package:hisabapp/Screens/Loading.dart';
import 'package:hisabapp/Services/auth_service.dart';

class SignIn extends StatefulWidget {
  final Function toggleScreen;
  SignIn({this.toggleScreen});
  @override
  _SignInState createState() => _SignInState();
}
final _formkey = GlobalKey<FormState>();
class _SignInState extends State<SignIn> {
  bool isLoading =false;

  final AuthService authService = AuthService();
  String username='';
  String password='';
  String error='';
  Widget build(BuildContext context) {
    return isLoading? Loading(): Scaffold(
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
          title: Container(
            alignment: Alignment.center,
            child: Text('Digital Diary',
                style: TextStyle(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    fontWeight: FontWeight.w400
                )
            ),
          ),
        ),
        body: GestureDetector(
          onTap: () {
            FocusScopeNode currentFocus = FocusScope.of(context);

            if (!currentFocus.hasPrimaryFocus) {
              currentFocus.unfocus();
            }
          },
          child: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.all(40.0),
              child: Column(
                children: [
                  Container(
                    alignment: Alignment.centerRight,
                    child: FlatButton.icon(onPressed: (){
                      widget.toggleScreen();
                    },
                        icon: Icon(Icons.person,
                          size: 20.0,
                          color: Theme.of(context).accentColor,
                        ),
                        label: Text(
                          'Register',
                          style: TextStyle(
                            fontSize: 15.0,
                            color: Theme.of(context).accentColor
                          ),
                        ),),
                  ),
                  SizedBox(height: 20.0,),
                  Container(
                    alignment: Alignment.center,
                    child: Text(
                      'Log In',
                      style: TextStyle(
                        fontSize: 30.0,
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
                            keyboardType: TextInputType.emailAddress,
                            validator: (val) =>
                                val.isEmpty ? "enter valid username" : null,
                            onChanged: (val) {
                              username=val;
                            },
                            decoration: InputDecoration(
                              labelStyle: TextStyle(
                                  color: Theme.of(context).primaryColor),
                              labelText: "enter username",
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Theme.of(context).primaryColor)),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Theme.of(context).accentColor)),
                            )),
                        SizedBox(
                          height: 20.0,
                        ),
                        TextFormField(
                            obscureText: true,
                            validator: (val) => val.length < 6
                                ? "enter valid password of atleast 6 digits"
                                : null,
                            onChanged: (val) {
                              password=val;
                            },
                            decoration: InputDecoration(
                              labelStyle: TextStyle(
                                  color: Theme.of(context).primaryColor),
                              labelText: "enter password",
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Theme.of(context).primaryColor)),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Theme.of(context).accentColor)),
                            )),
                        SizedBox(
                          height: 20.0,
                        ),
                        Container(
                          child: FlatButton(
                            color: Theme.of(context).primaryColor,
                            child: Text(
                              'Log in',
                              style: TextStyle(color: Colors.white),
                            ),
                            onPressed: () async{
                              FocusScopeNode currentFocus = FocusScope.of(context);

                              if (!currentFocus.hasPrimaryFocus) {
                                currentFocus.unfocus();
                              }
                              if(_formkey.currentState.validate()){
                                setState(() {
                                  error='';
                                  isLoading=true;
                                });
                                dynamic result =await authService.signInwithEmailandPassword(username, password);
                                if(result==null){
                                  setState(() {
                                    error='could not sign in with those credentials';
                                    isLoading=false;
                                  });
                                }
                              }
                            },
                          ),
                        ),
                        SizedBox(
                          height: 5.0,
                        ),
                        Text(
                          error,
                          style: TextStyle(color: Colors.red,fontSize: 15.0),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        )
    );
  }
}
