import 'package:flutter/material.dart';
import 'package:naya/widgets/ng_drawer.dart';
import 'package:naya/widgets/ng_widgets.dart';
import 'package:naya/localization/localizations_constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:naya/Agentprofile/agentdashboard.dart';
class Offer extends StatefulWidget {
  @override
  _OfferState createState() => _OfferState();
}
class _OfferState extends State<Offer> {
  var url;
  String selectedstate;
  DatabaseReference ref = FirebaseDatabase.instance.reference();
  List offerdata=[];
  @override
  void initState(){
    super.initState();
    FirebaseAuth.instance.currentUser().then((user) {
      var uid = user.uid;
      print('ooooooooooo');
      print(uid);
      DatabaseReference ref = FirebaseDatabase.instance.reference();
//obtaning the details of the user
      ref.child('VerifiedAgents').orderByChild('UID').equalTo('$uid').once().then((value){
        var a=value.value.keys;
        for(var i in a){
          print(i);
          ref.child('VerifiedAgents').child('$i').child('Profile').once().then((snap){
            var data=snap.value;
            var state=data['State'];
            print(state);
            setState(() {
              selectedstate=state;
            });
          });
        }
      });
    });
    ref.child('Notifications').once().then((value){
      if(value.value!=null){
        var a=value.value.keys;
        for(var i in a){
          print(i);
          ref.child('Notifications').child('$i').once().then((value){
            var f=value.value;
            var d=f['url1'];

            offerdata.add(d);
          });
        }
      }
      else{
        _showDialog('No offers yet');

      }
    });
  }

  Widget build(BuildContext context){
    return Scaffold(
        appBar:ngAppBar(getTranslated(context, 'offer'), context
        ),

        drawer: NGDrawer(),
        body:new Center(
            child: offerdata.length == 0
                ? new CircularProgressIndicator(backgroundColor:Colors.red,valueColor:AlwaysStoppedAnimation<Color>(Colors.white),)
                : new ListView.builder(
              itemCount: offerdata.length,
              itemBuilder: (_, index) {
                return UI(
                  offerdata[index],
                  index,
                );

              },
            )
        )
    );
  }
  Widget UI(var x,var y){
    return new GestureDetector(
      onTap: (){

      },
      child: SingleChildScrollView(
        child:Container(
          child:new Card(
              clipBehavior: Clip.antiAlias,
              child:Column(
                  children:<Widget>[ClipRRect(
                      child: x!=null?Image.network(x,
                        fit: BoxFit.cover,
                      ):CircularProgressIndicator(backgroundColor:Colors.red,valueColor:AlwaysStoppedAnimation<Color>(Colors.white),),
                  ),
                  ],
              ),
          ),
          // child: new Container(
          //   padding: new EdgeInsets.only(top:40.0,left:10.0,right:10.0),
          //   child: new Column(
          //     crossAxisAlignment: CrossAxisAlignment.center,
          //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //     children: <Widget>[
          //    new SizedBox(
          //           width:180.0,
          //           height:180.0,
          //           child:x!=null?Image.network(x,
          //           ):CircularProgressIndicator(backgroundColor:Colors.red,valueColor:AlwaysStoppedAnimation<Color>(Colors.white),)
          //       )
          //],
        ), ),
    );

  }
  void _showDialog(String x) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Text(getTranslated(context, 'alert'),textAlign: TextAlign.center,),
          content: new Text("$x"),
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
            )
          ],
        );
      },
    );
  }
}

