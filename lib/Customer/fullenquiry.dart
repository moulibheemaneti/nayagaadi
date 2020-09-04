import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:naya/models/Model.dart';
import 'package:naya/widgets/ng_widgets.dart';
import 'package:naya/widgets/ng_drawer.dart';
import 'package:naya/localization/localizations_constants.dart';
class Fullenquiry extends StatefulWidget {
  final String value;
  Fullenquiry({Key key, this.value}) : super(key: key);
  @override
  _FullenquiryState createState() => new _FullenquiryState();
}

class _FullenquiryState extends State<Fullenquiry> {
  List<Customerfulldetails>data=[];
  Map<String, IconData> iconMapping = {
  'completed' : Icons.check_circle,
  'inprogress' : Icons.hourglass_empty,
  'notprogressed' : Icons.cancel,
};
  @override
  void initState(){
    super.initState();
    FirebaseAuth.instance.currentUser().then((user) {
var uid = user.uid;
print(uid);
DatabaseReference ref = FirebaseDatabase.instance.reference();
//obtaning the details of the user
ref.child('VerifiedAgents').orderByChild('UID').equalTo('$uid').once().then((val){
var a=val.value.keys;
for(var i in a){
ref.child('VerifiedAgents').child('$i').child('FormEnquires').once().then((DataSnapshot s){
  if(s.value!=null){
     var data1 = s.value;
     var j=widget.value;
    var name=data1[j]['Name'];
    var date=data1[j]['Date'];
    var status=data1[j]['Status'];
    var vehicle=data1[j]['Vehicle'];
    var brand=data1[j]['Brand'];
    var model=data1[j]['Model'];
    var variant=data1[j]['Variant'];
   Customerfulldetails d1 = new Customerfulldetails(
    name,j,date,status,vehicle,brand,model,variant
    );
   data.add(d1);
   setState(() {
      });
     
}
});
}
});
});
  }
  
Widget build(BuildContext context) {
    return Scaffold(
      appBar: ngAppBar(getTranslated(context,'enq_hist'), context),
      drawer: NGDrawer(),
       body: new Container(
          child:new Center(
          child: data.length == 0
              ? new CircularProgressIndicator(backgroundColor:Colors.red,valueColor:AlwaysStoppedAnimation<Color>(Colors.white),)
              : new ListView.builder(
            itemCount: data.length,
            itemBuilder: (_, index) {
              return UI(
                data[index].customername,
                data[index].enid,
                data[index].endate,
                data[index].status,
                data[index].vehicle,
                data[index].brand,
                data[index].model,
                data[index].variant,
              );
            
            },
      )),
    )
    );
  }
   Widget UI(var name,var id,var date,var prog,var vehicle,var brand,var model,var variant) {
return new Container(
        padding: new EdgeInsets.only(top:180.0,left: 20.0,right:20.0),
        child: new Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
          Expanded(
            child:Column(
            crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[ 
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children:<Widget>[
      Icon(
      Icons.assignment_ind,
      color: Colors.black,
      size: 100.0,
    ),
    Column(
         crossAxisAlignment: CrossAxisAlignment.start,
      children :<Widget>[
    new Text('Name:',style:TextStyle(fontSize:20.0,fontWeight:FontWeight.bold),),
    new Text('Enq ID:',style:TextStyle(fontSize:20.0,fontWeight:FontWeight.bold),),
    new Text('Enq Date:',style:TextStyle(fontSize:20.0,fontWeight:FontWeight.bold),),
    new Text('Status:',style:TextStyle(fontSize:20.0,fontWeight:FontWeight.bold),),
      ]),
      Column(
         crossAxisAlignment: CrossAxisAlignment.start,
      children :<Widget>[
    new Text('$name',style:TextStyle(fontSize:20.0,fontWeight:FontWeight.bold),),
    new Text('$id',style:TextStyle(fontSize:20.0,fontWeight:FontWeight.bold),),
    new Text('$date',style:TextStyle(fontSize:20.0,fontWeight:FontWeight.bold),),
    new Text('$prog',style:TextStyle(fontSize:20.0,fontWeight:FontWeight.bold),),
      ]),
    
            ]),
            
                new SizedBox(height:20.0),
            Divider(
                 thickness: 5.0,
                  color: Colors.black,
                ),
                new SizedBox(height:40.0),
     Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children:<Widget>[
      Icon(
      Icons.directions_car,
      color: Colors.black,
      size: 100.0,
    ),
    Column(
         crossAxisAlignment: CrossAxisAlignment.start,
      children :<Widget>[
    new Text('Vehicle :',style:TextStyle(fontSize:20.0,fontWeight:FontWeight.bold),),
    new Text('Brand :',style:TextStyle(fontSize:20.0,fontWeight:FontWeight.bold),),
    new Text('Model :',style:TextStyle(fontSize:20.0,fontWeight:FontWeight.bold),),
    new Text('Variant :',style:TextStyle(fontSize:20.0,fontWeight:FontWeight.bold),),
      ]),
     new SizedBox(height:10.0), 
   Flexible(child:Column(
         crossAxisAlignment: CrossAxisAlignment.start,
      children :<Widget>[
    new Text('$vehicle',style:TextStyle(fontSize:20.0,fontWeight:FontWeight.bold),),
    new Text('$brand',style:TextStyle(fontSize:20.0,fontWeight:FontWeight.bold),),
    new Text('$model',style:TextStyle(fontSize:20.0,fontWeight:FontWeight.bold),),
    new Text('$variant',style:TextStyle(fontSize:20.0,fontWeight:FontWeight.bold),),
      ]),),
    
            ]),
          
])),
],
        ),
      );
  }
}
