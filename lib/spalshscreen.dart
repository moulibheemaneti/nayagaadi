import 'package:flutter/material.dart';
import 'package:custom_splash/custom_splash.dart';
import 'package:naya/authservice.dart';
//import 'package:nayagaadi/screens/menuscreens/aboutNG/contactus.dart';

class NGSplashScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return CustomSplash(
      imagePath: "assets/icon.png",
      animationEffect: 'fade-in',
      logoSize: 200,
      duration: 10,
      //backGroundColor: Colors.red[700],
      home: AuthService().handleAuth(),
      //type: CustomSplashType.StaticDuration,
    );
  }
}