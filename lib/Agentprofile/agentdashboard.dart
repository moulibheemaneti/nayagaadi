import 'package:flutter/material.dart';
import 'package:naya/Agentprofile/profiledetails.dart';
import 'package:naya/widgets/ng_drawer.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:naya/Customer/enquiry.dart';
import 'package:naya/Customer/pastenquires.dart';
import 'package:naya/states/indianDistrictCode.dart';
import 'package:naya/states/indianStateCode.dart';
import 'package:naya/widgets/ng_widgets.dart';
import 'package:naya/localization/localizations_constants.dart';
import 'package:naya/Customer/earnings.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:naya/offers.dart';
class AgentDashBoard extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => new _AgentDashBoard();
}
class _AgentDashBoard extends State<AgentDashBoard>{
   DatabaseReference ref=FirebaseDatabase.instance.reference();
    FirebaseMessaging firebaseMessaging=new FirebaseMessaging();
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin=new FlutterLocalNotificationsPlugin();

String id='NGA_';
var x=stateCodes.keys;
var y=districtCodes.keys;
@override
  void initState(){
  String b,c,agentid;
    super.initState();
    var android=new AndroidInitializationSettings('mipmap/icon');
    var ios=new IOSInitializationSettings();
    var platform=new InitializationSettings(android, ios);
    flutterLocalNotificationsPlugin.initialize(platform);
    firebaseMessaging.configure(
     
     onLaunch: (Map<String,dynamic>msg)async{
      

     },
     onResume: (Map<String,dynamic>msg)async{
        
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
    
    //obtaining uid
 FirebaseAuth.instance.currentUser().then((user) {
   var uid = user.uid;
          ref.child('NotVerifiedAgents').child('$uid').child('Profile').once().then((DataSnapshot snap){
            //checking if node has data or not
            if(snap.value!=null){
            var dat=snap.value;
            var dis=dat['District'];
            var stt=dat['State'];
            //obtaining state code
            for(var i in x ){
              if(i==stt){
                 b=stateCodes[stt];
                 print(b);
                 //subscribing to a topic
                  firebaseMessaging.subscribeToTopic('$b');
                 }
            }
            //obtaining district code
              for(var j in y){
              if(j==dis)
              {c=districtCodes[dis];
              
              }
            }
            //creating agent id
            agentid=id+b+'_'+c;
          export(dat,agentid,uid);
              }
              else{
                print('no data to assignid');
              }
          });
          });
     }
      showNotification(Map<String,dynamic>msg)async{
    var android=new AndroidNotificationDetails('channel_id', "CHANNEL NAME", "channelDescription");
    var iOS=new IOSNotificationDetails();
    var platform=new NotificationDetails(android, iOS);
    flutterLocalNotificationsPlugin.show(0,msg['notification']['title'],msg['notification']['body'], platform);
    
      }
  export(var data,var agentid,var uid){
    int i=1;
    ref.child('VerifiedAgents').once().then((s){
if(s.value==null){
  var id1=agentid+i.toString();
  //craeting data in verifiedagents
 ref.child('VerifiedAgents').child('$id1').child('Profile').set(data);
 ref.child('VerifiedAgents').child('$id1').update({
'UID':uid,
'audioenquires':0,
 });
}
else{
  //assigning serial count to id
  var count=[];
  var datav=s.value.keys;
  for(var i in datav){
    count.add(i);
  }
var a2=count.length+1;
var a1=agentid+a2.toString();
ref.child('VerifiedAgents').child('$a1').child('Profile').set(data);
ref.child('VerifiedAgents').child('$a1').update({
'UID':uid,
'audioenquires':0,
 });
}
});
//deleting data in not verified agents
ref.child('NotVerifiedAgents').child('$uid').remove();
}
Future<bool> _onBackPressed(){
  return showDialog(
    context: context,
    barrierDismissible:false,
  builder: (context) => AlertDialog(
    title: Text(getTranslated(context,'back')),
    actions: <Widget>[
                  ButtonTheme(
  splashColor: Colors.red[300],
  padding: EdgeInsets.fromLTRB(35.0, 12.0, 35.0, 12.0),
  minWidth: 120,
  buttonColor: Colors.red[700],
  child: new RaisedButton(
    elevation: 10.0,
    textColor: Colors.white,
    onPressed: (){
        Navigator.of(context).pop(false);
    },
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0),),
    child: new Text(getTranslated(context,'no'),
      style: TextStyle(
        fontSize: 20.0,
        letterSpacing: 1.0,
      ),
    ),
    color: Colors.red[700],
  ),
),
            ButtonTheme(
  splashColor: Colors.red[300],
  padding: EdgeInsets.fromLTRB(35.0, 12.0, 35.0, 12.0),
  minWidth: 120,
  buttonColor: Colors.red[700],
  child: new RaisedButton(
    elevation: 10.0,
    textColor: Colors.white,
    onPressed: (){
        Navigator.of(context).pop(true);
    },
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0),),
    child: new Text(getTranslated(context,'yes'),
      style: TextStyle(
        fontSize: 20.0,
        letterSpacing: 1.0,
      ),
    ),
    color: Colors.red[700],
  ),
),
    ],
    ),
  );

}
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onBackPressed,
      child:Scaffold(
      appBar:ngAppBar(getTranslated(context, 'dashboard'), context
      ),
      drawer: NGDrawer(),
      body: ListView(
        padding: EdgeInsets.only(left: 10.0, right: 10.0),
        children: <Widget>[

          // create enquiry
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            elevation: 8.0,
            child: GestureDetector(
              onTap: (){
                       Navigator.of(context).push(
        new MaterialPageRoute(builder: (context) => new Verified()));   
              },
              child: Padding(
                padding: EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(Icons.add_box, size: 60.0,color: Colors.red[700]),
                    SizedBox(height: 5.0,),
                    Text(
                      getTranslated(context,'enq'),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 25.0,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // my profile
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            elevation: 8.0,
            child: GestureDetector(
              onTap: (){
 Navigator.of(context).push(
        new MaterialPageRoute(builder: (context) => new AgentProfile()));
              },
              child: Padding(
                padding: EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(Icons.account_circle, size: 60.0,color: Colors.red[700]),
                    SizedBox(height: 5.0,),
                  
                    Text(
                      getTranslated(context,'profile')
                      ,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 25.0,
                      ),
                    ),
                  ],
                ),
              ),
            ),

          ),

          // enquiry history
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            elevation: 8.0,
            child: GestureDetector(
              onTap: (){
Navigator.of(context).push(
        new MaterialPageRoute(builder: (context) => new Pastenquires()));
 
              },
              child: Padding(
                padding: EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(Icons.assignment, size: 60.0,color: Colors.red[700]),
                    SizedBox(height: 5.0,),
                    Text(
                      getTranslated(context,'enq_hist'),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 25.0,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // earnings
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            elevation: 8.0,
            child: GestureDetector(
              onTap: (){
                Navigator.of(context).push(
        new MaterialPageRoute(builder: (context) => new Earnings()));
 

                },
              child: Padding(
                padding: EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(Icons.account_balance, size: 60.0,color: Colors.red[700]),
                    SizedBox(height: 5.0,),
                    Text(
                      getTranslated(context,'earnings'),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 25.0,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Card(
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(10.0),
  ),
  elevation: 8.0,
  child: GestureDetector(
    onTap: (){
 Navigator.of(context).push(
        new MaterialPageRoute(builder: (context) => new Offer()));
 

    },
    child: Padding(
      padding: EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(Icons.local_offer, size: 60.0,color: Colors.red[700]),
          SizedBox(height: 5.0,),
          Text(
            getTranslated(context,'offer'),
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 25.0,
            ),
          ),
        ],
      ),
    ),
  ),

),  
        ],
      ),
    ));
  }

}