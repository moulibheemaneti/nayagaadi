import 'package:flutter/material.dart';
import 'package:naya/widgets/ng_drawer.dart';
import 'package:naya/localization/localizations_constants.dart';
import 'package:naya/widgets/ng_widgets.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:naya/Customer/fullenquiry.dart';
import 'package:naya/Agentprofile/agentdashboard.dart';
import 'package:naya/models/Model.dart';
class Earnings extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => new _Earnings();

}
class _Earnings extends State<Earnings>{
  List<Earningsdata>data=[];

  void _showDialog() {
showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Text(getTranslated(context, 'alert'),textAlign:TextAlign.center,),
          content: new Text("You did not create a enquiry to view it"),
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
        Navigator.of(context).pushReplacement(
        new MaterialPageRoute(builder: (context) => new AgentDashBoard()));
    },
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0),),
    child: new Text(getTranslated(context, 'ok'),
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
  @override
  void initState(){
    super.initState();
    FirebaseAuth.instance.currentUser().then((user) {
var uid = user.uid;
DatabaseReference ref = FirebaseDatabase.instance.reference();
//obtaning the details of the user
ref.child('VerifiedAgents').orderByChild('UID').equalTo('$uid').once().then((value){
var a=value.value.keys;
for(var i in a){
ref.child('VerifiedAgents').child('$i').child('FormEnquires').once().then((DataSnapshot s){
  if(s.value!=null){
     var key=s.value.keys;
     print(key);
     var data1 = s.value;
     print(data1);
     for(var i in key){
       print(i);
    var name=data1[i]['Name'];
    var role=data1[i]['Vehicle'];
    var status=data1[i]['Earnings'];
 Earningsdata d1 = new Earningsdata(
       name,role,status,i
       );
  data.add(d1);
   setState(() {
      });
     }
}
else{
 _showDialog();
}
});
}
});
});
  }
  Widget build(BuildContext context){
    return Scaffold(
 appBar:ngAppBar(getTranslated(context, 'earnings'), context
      ),
      
      drawer: NGDrawer(),
          body:new Center(
          child: data.length == 0
              ? new CircularProgressIndicator(backgroundColor:Colors.red,valueColor:AlwaysStoppedAnimation<Color>(Colors.white),)
              : new ListView.builder(
            itemCount: data.length,
            itemBuilder: (_, index) {
              return UI(
                data[index].customername,
                data[index].date,
                data[index].status,
                data[index].id,
                index,
              );
            
            },
      )
    )
    );
  }
    Widget UI(var humidity,var moisture,var prog,var id,var index) {
  return new GestureDetector(
onTap: (){
  print(index);
  print(id);
  Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Fullenquiry(value: id),
                ),
              );
},
  child: SingleChildScrollView(
    child:new Card(
      elevation: 10.0,
      child: new Container(
        padding: new EdgeInsets.all(20.0),
        child: new Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[ 
          new Text('$humidity',style:TextStyle(fontSize:20.0,fontWeight:FontWeight.bold),),
          new Text('$moisture',style:TextStyle(fontSize:20.0,fontWeight:FontWeight.bold),),
]),
Column(
  children:<Widget>[
  new SizedBox(width: 50.0,),
new Text('Rs:',style:TextStyle(fontSize:20.0,fontWeight:FontWeight.bold),),
new Text('$prog'),
new SizedBox(height:2.0),])

             ],
        ),
      ),
   ) ));
  }
}