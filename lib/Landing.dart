import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:naya/Agentprofile/agent.dart';
import 'package:naya/Dashboard.dart';
import 'package:naya/Agentprofile/agentdashboard.dart';
class LandingPage extends StatefulWidget {
  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
 String verify,notverify;
 DatabaseReference ref=FirebaseDatabase.instance.reference();

 @override
void initState(){
  super.initState();
  FirebaseAuth.instance.currentUser().then((user) {
var uid = user.uid;
DatabaseReference ref = FirebaseDatabase.instance.reference();
//obtaning the details of the user
ref.child('VerifiedAgents').orderByChild('UID').equalTo('$uid').once().then((value){
if(value.value!=null){
  setState(() {
   verify='true';  
  });
}
else{
  setState(() {
    verify='false';
  });
}
});
ref.child('NotVerifiedAgents').child('$uid').child('Profile').once().then((v){
if(v.value!=null){
  setState(() {
    notverify='true';
  });
}
else{
  setState(() {
    notverify='false';
  });
}
});
 });

}
check()async{
  final _auth=FirebaseAuth.instance;
     final FirebaseUser user = await _auth.currentUser();
     if(user!=null && verify=='true' && notverify=='false'){
        Navigator.of(context).pushReplacement(
        new MaterialPageRoute(builder: (context) => new AgentDashBoard()));
     }
     else if(user!=null && verify=='false' && notverify=='false'){
        Navigator.of(context).pushReplacement(
        new MaterialPageRoute(builder: (context) => new AgentForm()));
     }
     else if(user!=null && verify=='false' && notverify=='true'){
        Navigator.of(context).pushReplacement(
        new MaterialPageRoute(builder: (context) => new Dashboard()));
     }
}

Widget build(BuildContext context) {
  check();
 
   return Scaffold(
      appBar: new AppBar(
        centerTitle: true,
        title: new Text('WELCOME TO NAYAGADI AGENT'),
        backgroundColor: Colors.red[700],
      ),
      body:
 Column(
   mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
   children:<Widget>[
      Center(
        child: CircularProgressIndicator(backgroundColor:Colors.red,valueColor:AlwaysStoppedAnimation<Color>(Colors.white),),
        ),
        Center(child: Text('Please wait & Make sure you have \n good internet connection',style: TextStyle(fontSize:18.0),),),

    
        
   ]));
  }
  
}
