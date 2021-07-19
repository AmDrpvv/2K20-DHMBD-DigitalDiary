import 'package:firebase_auth/firebase_auth.dart';
import 'package:hisabapp/Models/AppEntity.dart';
import 'package:hisabapp/Services/DatabaseService.dart';

class AuthService {
  final FirebaseAuth _auth =FirebaseAuth.instance;

  User createourUserfromFirebaseUser(FirebaseUser user){
    return user==null?null:User(uid: user.uid);
  }

  //User Stream when auth changes
  Stream<User> get userstreamforauthchange{
    return _auth.onAuthStateChanged
        .map((FirebaseUser user) => createourUserfromFirebaseUser(user));
  }


  //Sign In with email and password
  Future signInwithEmailandPassword(String username,String password) async{
    try{
      AuthResult _result= await _auth.signInWithEmailAndPassword(
          email: username,
          password: password);
      FirebaseUser _user =_result.user;
      return createourUserfromFirebaseUser(_user);
    }
    catch(e){
      print(e.toString());
      return null;
    }
  }
//Signing out
  Future signOut() async{
    try{
      return await _auth.signOut();
    }
    catch(e){
      print(e.toString());
      return null;
    }
  }
  //delete account

  

  //Register with email and password
  Future registerWithEmailandPassword(String username,String password,List<Product> defaultproductlist)async{
    try{
      AuthResult _result = await _auth.createUserWithEmailAndPassword(
          email: username,
          password: password);
      FirebaseUser _user = _result.user;
      //Creating database for this user
      if(_user!=null){
        await DatabaseService(uid: _user.uid).updateUserDatabase(username, defaultproductlist);
      }
      return createourUserfromFirebaseUser(_user);
    }catch(e){
      print(e.toString());
      return null;
    }
  }
}