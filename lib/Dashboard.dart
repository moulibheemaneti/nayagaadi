import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:naya/localization/localizations_constants.dart';
import 'package:naya/notverifieddash.dart';
import 'package:naya/Agentprofile/agentdashboard.dart';
import 'package:intl/intl.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:naya/widgets/ng_widgets.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  DatabaseReference ref=FirebaseDatabase.instance.reference();
  FirebaseMessaging firebaseMessaging=new FirebaseMessaging();
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin=new FlutterLocalNotificationsPlugin();

  @override
  void initState(){
    super.initState();
    checkuser();
    var android=new AndroidInitializationSettings('mipmap/icon');
    var ios=new IOSInitializationSettings();
    var platform=new InitializationSettings(android, ios);
    flutterLocalNotificationsPlugin.initialize(platform);

    firebaseMessaging.configure(
     onLaunch: (Map<String,dynamic>msg)async{
       print('onLaunch called');
     },
     onResume: (Map<String,dynamic>msg)async{
       print('onResume called');
     },
     onMessage: (Map<String,dynamic>msg)async{
       print(msg);
       showNotification(msg);
       print('onMeasage called');
     },
    );
    firebaseMessaging.requestNotificationPermissions(
      const IosNotificationSettings(
        sound:true,
        alert:true,
        badge:true,
      )
    );
    firebaseMessaging.onIosSettingsRegistered.listen((IosNotificationSettings settings){
        print('IOS settings Registered');
    });
    
 
    
  }
  showNotification(Map<String,dynamic>msg)async{
    var android=new AndroidNotificationDetails('channel_id', "CHANNEL NAME", "channelDescription");
    var iOS=new IOSNotificationDetails();
    var platform=new NotificationDetails(android, iOS);
    flutterLocalNotificationsPlugin.show(0,msg['notification']['title'],msg['notification']['body'], platform);


  }
  checkuser(){
       FirebaseAuth.instance.currentUser().then((user) {
        if (user != null) {
          user.getIdToken().then((token) {
            Map<dynamic,dynamic> tokenMap = token.claims;
           var uid=tokenMap['sub'];
           print('cc');
            print(uid);
            ref.child('NotVerifiedAgents').child('$uid').child('Profile').once().then((DataSnapshot snap){
              if(snap.value!=null){
            var dat=snap.value;
            var a1=dat['Verification'];
            print(a1);
            if(a1=='no'){
 Navigator.of(context).pushReplacement(
        new MaterialPageRoute(builder: (context) => new NotVerified()));
            }
            else if(a1=='yes'){
          print('verified');
              var now = new DateTime.now();
               var timestamp=new DateFormat("yyyyMMdd").format(now);
              ref.child('NotVerifiedAgents').child('$uid').child('Profile').update({
               "timestamp":timestamp,
              }).then((value){
 Navigator.of(context).pushReplacement(
        new MaterialPageRoute(builder: (context) => new AgentDashBoard()));
        });
            }
            }
            else{
              print('ooooooooooooo');
              Navigator.of(context).pushReplacement(
        new MaterialPageRoute(builder: (context) => new AgentDashBoard()));
}
            });
          });
        }
     });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar:ngAppBar(getTranslated(context,'title'), context),
      body:Container(
      padding:EdgeInsets.all(20.0),
      child:Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children:<Widget>[
      Center(child:CircularProgressIndicator(backgroundColor:Colors.white,valueColor:AlwaysStoppedAnimation<Color>(Colors.red[700]),),),
        Center(child: Text('Please wait & Make sure you have \n good internet connection',style: TextStyle(fontSize:18.0),),),
      
         ] )
      )
    );
  }
}
