import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:naya/Customer/Customer.dart';
import 'package:naya/localization/localizations_constants.dart';
import 'package:naya/Customer/audiotrail.dart';
import 'package:intl/intl.dart';
import 'package:jiffy/jiffy.dart';
import 'package:naya/widgets/ng_widgets.dart';
import 'package:naya/widgets/ng_drawer.dart';
class Verified extends StatefulWidget {
  @override
_VerifiedState createState() => _VerifiedState();
}
class _VerifiedState extends State<Verified> {
DatabaseReference ref = FirebaseDatabase.instance.reference();
var countaudio=[1];
int limit;
@override
void initState(){
super.initState();
FirebaseAuth.instance.currentUser().then((user) {
if (user != null) {
user.getIdToken().then((token) {
Map<dynamic,dynamic> tokenMap = token.claims;
var uid=tokenMap['sub'];
ref.once().then((v){
var da=v.value;
limit=da['audioenquirylimit'];
setState(() {
  
});
});
ref.child('VerifiedAgents').orderByChild('UID').equalTo('$uid').once().then((value){
var a=value.value.keys;
for(var i in a){
ref.child('VerifiedAgents').child('$i').once().then((DataSnapshot s){
      var da = s.value;
      var count=da['audioenquires'];
      countaudio.add(count);
      setState(() {
});
});
}
});
});
}
});
}
void _showDialog() {
showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Text(getTranslated(context, 'alert'),textAlign:TextAlign.center,),
          content: new Text("You have used your 4 chances"),
          shape: RoundedRectangleBorder(borderRadius: 
    BorderRadius.all(Radius.circular(15))),
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
        Navigator.pop(context);
    },
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0),),
    child: new Text("OK",
      style: TextStyle(
        fontSize: 20.0,
        letterSpacing: 1.0,
      ),
    ),
    color: Colors.red[700],
  ),
),

        
           ],
        );
      },
    );
  }
Widget build(BuildContext context){
    return Scaffold(
      appBar: ngAppBar(getTranslated(context,'enq'), context),
      drawer: NGDrawer(),
      body:Container(
        height: 300,
        margin: EdgeInsets.only(top:150.0,left: 20.0,right: 20.0),
      padding: EdgeInsets.only(top:30.0,left: 20.0,right: 20.0),
        decoration: BoxDecoration(
    border: Border.all(color: Colors.grey),
    borderRadius: BorderRadius.all(
      Radius.circular(20),
    )
  ),
    child: Column(
children: <Widget>[
  ngProfileField1(getTranslated(context, 'choose_method')),
  Divider(thickness: 1.0,
      color: Colors.grey,
    ),
     Expanded(
       child:Row(
    mainAxisAlignment: MainAxisAlignment.start,
    children: <Widget>[
      Expanded(child:Column(
        children: <Widget>[
    IconButton(
              iconSize: 50.0,
      icon:Icon(Icons.mic),
      color: Colors.red[700],
      onPressed:(){
       direct();
      }
    ),
    
    new SizedBox(height: 20.0,),
     new Flexible(
          child: countaudio.length == 1
              ? new CircularProgressIndicator(backgroundColor:Colors.white,valueColor:AlwaysStoppedAnimation<Color>(Colors.red[700]),)
              : new ListView.builder(
              itemCount: 1,
            itemBuilder: (_, index) {
              return UI(
                countaudio.last
               );
            },
      )),
 ])),
    //new SizedBox(width:20.0),
     VerticalDivider(
                 thickness: 1.0,
                  color: Colors.grey,
                ),
          //new SizedBox(width:500),
                Column(
                  children: <Widget>[
    IconButton(
              iconSize: 50.0,
      icon:Icon(Icons.assignment),
      color: Colors.red[700],
      onPressed:(){
         Navigator.of(context).push(
        new MaterialPageRoute(builder: (context) => new Customer()));
      }
    ),
    new SizedBox(height: 20.0,),
    ngEnquiryField1(getTranslated(context, 'manual_form'),getTranslated(context, 'manually')),
 
    ])
    ,])),
  ],
  ) )
      );
}
direct()async{
 final _auth=FirebaseAuth.instance;
final FirebaseUser user = await _auth.currentUser();
var uid = user.uid;
ref.child('VerifiedAgents').orderByChild('UID').equalTo('$uid').once().then((value){
var a=value.value.keys;
for(var i in a){
ref.child('VerifiedAgents').child('$i').child('Profile').once().then((DataSnapshot s){
     //var key=s.value.keys;
      var da = s.value;
      var time=da['timestamp'];
    return uploadaudio(time);
});

}
  });
    
  }
uploadaudio(var time)async{
    final _auth=FirebaseAuth.instance;
      final FirebaseUser user = await _auth.currentUser();
    var uid = user.uid;
    var now = new DateTime.now();
    var date=new DateFormat("yyyyMMdd").format(now);
    DateTime formateddate=DateTime.parse(date);
    DateTime formatedtimestamp=DateTime.parse(time);
    var updatedtime=Jiffy(formatedtimestamp).add(days: 30);
final difference = formateddate.difference(formatedtimestamp).inDays;
  ref.child('VerifiedAgents').orderByChild('UID').equalTo('$uid').once().then((value){
var a=value.value.keys;
for(var i in a){
ref.child('VerifiedAgents').child('$i').once().then((DataSnapshot s){
      var da = s.value;
      var count=da['audioenquires'];
  if(difference>=30){
    var diff=difference-30;
    var exud=Jiffy(updatedtime).subtract(days:diff);
    var updateddate=new DateFormat("yyyyMMdd").format(exud);
    ref.child('VerifiedAgents').child('$i').update({
       "audioenquires":0
    });
    ref.child('VerifiedAgents').child('$i').child('Profile').update({
     "timestamp":updateddate,
    }).then((value){
 Navigator.of(context).pushReplacement(
    new MaterialPageRoute(builder: (context) => new RecorderExample()));
    });
  }
  else if(difference<30 && count<limit){
    Navigator.of(context).pushReplacement(
    new MaterialPageRoute(builder: (context) => new RecorderExample()));
}
else if(difference<30 && count>=limit){
    _showDialog();
  }
});
}
});
}
  Widget UI(var count) {
    int x=limit-count;
  return ngEnquiryField(getTranslated(context, 'voice_mssg'), x,getTranslated(context,'chance_1'),getTranslated(context, 'chance_2'));
  }
}
