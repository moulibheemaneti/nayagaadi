import 'package:flutter/material.dart';
import 'package:naya/localization/localizations_constants.dart';
import 'package:naya/widgets/ng_drawer.dart';
import 'package:naya/widgets/ng_widgets.dart';
import 'package:firebase_database/firebase_database.dart';
class NotVerified extends StatefulWidget {
   final String value,value1,value2;
  NotVerified({Key key, this.value,this.value1,this.value2}) : super(key: key);
  @override
  _NotVerifiedState createState() => _NotVerifiedState();
}

class _NotVerifiedState extends State<NotVerified> {
  DatabaseReference ref=FirebaseDatabase.instance.reference();
  @override
  void initState(){
    super.initState();

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
      appBar: ngAppBar(getTranslated(context,'title'), context),
      drawer: NGDrawer(),
      body: ListView(
      padding: EdgeInsets.fromLTRB(40.0, 40.0, 40.0, 10.0),
      children: <Widget>[
        Icon(Icons.hourglass_empty,color: Colors.red[700],size: 100.0,),
        Container(
          padding: EdgeInsets.all(30.0),
          child: Text(
            getTranslated(context, 'not verified'),
            //"Your details are under verification.\n\nSoon you will get a call from our staff.\n\nYou can access this dashboard once you are verified.\n\nThanks for your patience.",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 24.0,
            ),
          ),
        ),
      ],
    ),
 
    ));
  }
}
