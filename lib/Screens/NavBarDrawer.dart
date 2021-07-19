import 'package:flutter/material.dart';
import 'package:hisabapp/Models/AppEntity.dart';
import 'package:hisabapp/Screens/ShowProfile.dart';
import 'package:hisabapp/Services/auth_service.dart';

class NavBarDrawer extends StatelessWidget {

  final UserData userdata;
  NavBarDrawer({this.userdata});
  final AuthService authService = AuthService();
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.symmetric(horizontal:10.0,vertical: 20.0),
        children: <Widget>[
          DrawerHeader(
            child: Text('Welcome ${userdata.name}',
              style: TextStyle(
                  fontSize: 20.0,
                  color: Theme.of(context).primaryColor
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.verified_user,
            color: Theme.of(context).accentColor,),
            title: Text('Show Profile',
              style: TextStyle(
                  fontSize: 20.0,
                  color: Theme.of(context).primaryColor
              ),
            ),
            onTap: (){
              Navigator.of(context).pop();
              Navigator.push(context, MaterialPageRoute(
                  builder: (context)=>ShowProfile(
                    userdata: userdata,
                  )));
              },
          ),
          ListTile(
            leading: Icon(Icons.file_download,
              color: Theme.of(context).accentColor,),
            title: Text('Download Receipt',
              style: TextStyle(
                  fontSize: 18.0,
                  color: Theme.of(context).primaryColor
              ),
            ),
            onTap: () => {Navigator.of(context).pop()},
          ),
          ListTile(
            leading: Icon(Icons.border_color,
              color: Theme.of(context).accentColor,),
            title: Text('Feedback',
              style: TextStyle(
                  fontSize: 18.0,
                  color: Theme.of(context).primaryColor
              ),
            ),
            onTap: () => {Navigator.of(context).pop()},
          ),
          ListTile(
            leading: Icon(Icons.account_circle,
              color: Theme.of(context).accentColor,),
            title: Text('Your Accounts',
              style: TextStyle(
                  fontSize: 18.0,
                  color: Theme.of(context).primaryColor
              ),
            ),
          ),
          SizedBox(height: 20.0,),
          ListTile(
            leading: Icon(Icons.border_color,
              color: Theme.of(context).accentColor,),
            title: Text('Feedback',
              style: TextStyle(
                  fontSize: 18.0,
                  color: Theme.of(context).primaryColor
              ),
            ),
            onTap: () => {Navigator.of(context).pop()},
          ),
          SizedBox(height: 40.0,),
          ListTile(
            leading: Icon(Icons.exit_to_app,
              color: Theme.of(context).accentColor,),
            title: Text('Logout',
              style: TextStyle(
                  fontSize: 18.0,
                  color: Theme.of(context).primaryColor
              ),
            ),
            onTap: ()  async{
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: Text("Logout ?"),
                  actions: [
                    TextButton(
                      child: Text('Log Out'),
                      onPressed: () async{
                        await authService.signOut();
                        Navigator.of(context).pop();
                      },
                    ),
                    TextButton(
                      child: Text('Back'),
                      onPressed: (){
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
