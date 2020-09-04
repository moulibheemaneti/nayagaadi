import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:naya/Landing.dart';
import 'package:naya/LoginScreen.dart';
class AuthService {
  //Handles Auth
  handleAuth() {
    return StreamBuilder(
        stream: FirebaseAuth.instance.onAuthStateChanged,
        builder: (BuildContext context, snapshot) {
          if (snapshot.hasData) {
            return LandingPage();
          } else {
            return LoginScreen();
          }
        });
  }

  //Sign out
  signOut() {
    FirebaseAuth.instance.signOut();
    print('user loggedout');
  }

  //SignIn
  signIn(AuthCredential authCreds) {
    FirebaseAuth.instance.signInWithCredential(authCreds);
  }

  signInWithOTP(smsCode, verId) async{
   AuthCredential authCreds = PhoneAuthProvider.getCredential(
        verificationId: verId, smsCode: smsCode);
        try {
var firebaseUser =
await FirebaseAuth.instance.signInWithCredential(authCreds);
print("Login Successful");
print(firebaseUser.user);

} catch (e) {
  print("Login not successful");
  print(e);
}
  
  }
}