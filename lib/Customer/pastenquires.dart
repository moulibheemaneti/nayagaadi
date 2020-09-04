import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:naya/models/Model.dart';
import 'package:naya/localization/localizations_constants.dart';
import 'package:naya/Agentprofile/agentdashboard.dart';
import 'package:naya/Customer/fullenquiry.dart';
import 'package:naya/widgets/ng_widgets.dart';
import 'package:naya/widgets/ng_drawer.dart';
class Pastenquires extends StatefulWidget {
  @override
  _PastenquiresState createState() => _PastenquiresState();
}
class _PastenquiresState extends State<Pastenquires> {
  bool isSearching=false;
  var langcode;
List filterlist=['Customername','Progress','Enquiryid','Vehicle','Brand','Date','Model','Variant'];
List<Customerfulldetails>data=[];
List<Customerfulldetails>filtereddata=[];
String selectedfilter='Customername';
final nameHolder=TextEditingController();
clearText(){
  nameHolder.clear();
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
      Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => AgentDashBoard()));

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
  void _showDialog1(String x) {
showDialog(
      context: context,
           barrierDismissible:false,
      builder: (BuildContext context) {
      return AlertDialog(
        
          title: new Text(getTranslated(context, 'alert'),textAlign: TextAlign.center,),
          content: new Text("$x",style: TextStyle(fontSize:18.0,fontStyle:FontStyle.italic),),
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
         Navigator.of(context).pop();
                        clearText();
                        setState(() {
                          filtereddata=data;
                        });
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
  void initState() {
  super.initState();
FirebaseAuth.instance.currentUser().then((user) {
var uid = user.uid;
print(uid);
DatabaseReference ref = FirebaseDatabase.instance.reference();
//obtaning the details of the user
ref.child('VerifiedAgents').orderByChild('UID').equalTo('$uid').once().then((value){
var a=value.value.keys;
for(var i in a){
ref.child('VerifiedAgents').child('$i').child('FormEnquires').once().then((DataSnapshot s){
  if(s.value!=null){
     var key=s.value.keys;
     var data1 = s.value;
     for(var i in key){
     var name=data1[i]['Name'];
    var date=data1[i]['Date'];
    var status=data1[i]['Status'];
    var vehicle=data1[i]['Vehicle'];
    var brand=data1[i]['Brand'];
    var model=data1[i]['Model'];
    var variant=data1[i]['Variant'];
   ref.child('VerifiedAgents').child('$i').child('FormEnquires').once().then((DataSnapshot s){
  
   });
     Customerfulldetails d1 = new Customerfulldetails(
       name,i,date,status,vehicle,brand,model,variant
    
       );
  data.add(d1);
  filtereddata=data;
   setState(() {
      });
    
     }
}
else{
 _showDialog("You did not create a enquiry to view it");
}
});
}
});
});
}
void filtername(String value){
  if(value==null){
    setState(() {
      filtereddata=data;
    });
  }
  var x=filterMapping[selectedfilter];

if(x=='vehicle'){
setState(() {
  filtereddata=filtereddata.where((element) => element.vehicle.toLowerCase().contains(value.toLowerCase())).toList();
  if(filtereddata.length==0){
    print('no customer');
    _showDialog1('No vehicle with "$value"');
  }
});

}
else if(x=='endate'){
  setState(() {
  filtereddata=data.where((element) => element.endate.toLowerCase().contains(value.toLowerCase())).toList();
if(filtereddata.length==0){
    print('No Enquiry found on "$value" ');
    _showDialog1("no enquiry date");
  }
});
}
else if(x=='enid'){
  print('you opted id');
  setState(() {
  filtereddata=data.where((element) => element.enid.toLowerCase().contains(value.toLowerCase())).toList();
if(filtereddata.length==0){
    print('no customer');
    _showDialog1('No EnquiryID with "$value"');
  }
});
}
else if(x=='status'){
  print('you opted id');
  setState(() {
  filtereddata=data.where((element) => element.status.toLowerCase().contains(value.toLowerCase())).toList();
if(filtereddata.length==0){
    print('no customer');
    _showDialog1('No enquires which are "$value"');
  }
});
}
else if(x=='model'){
  print('you opted id');
  setState(() {
  filtereddata=data.where((element) => element.model.toLowerCase().contains(value.toLowerCase())).toList();
   if(filtereddata.length==0){
    print('no customer');
    _showDialog1("No model with $value");
  }
});
}
else if(x=='brand'){
  print('you opted id');
  setState(() {
  filtereddata=data.where((element) => element.brand.toLowerCase().contains(value.toLowerCase())).toList();
   if(filtereddata.length==0){
    print('no customer');
    _showDialog1('No Brand with "$value"');
  }
});
}
else if(x=='variant'){
  print('you opted variant');
  setState(() {
  filtereddata=data.where((element) => element.variant.toLowerCase().contains(value.toLowerCase())).toList();
   if(filtereddata.length==0){
    print('no customer');
    _showDialog1('No variant with "$value" ');
  }
});
}
else if(x=='customername'){
  print('you opted customer name');
  setState(() {
  filtereddata=data.where((element) => element.customername.toLowerCase().contains(value.toLowerCase())).toList();
  if(filtereddata.length==0){
    print('no customer');
    _showDialog1('No Customer with name "$value"');
  }
});

}

}

void foo() async {
   final x = await getLocale();
langcode=x.languageCode;
setState(() {
  
});
}
Widget build(BuildContext context) {
    return Scaffold(
      appBar:ngAppBar(getTranslated(context,'enq_hist'), context),
      drawer: NGDrawer(),
       body: new Container(

         padding: EdgeInsets.all(20),
          child:Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children:<Widget>[
              
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
             textDirection: TextDirection.rtl,
              children:<Widget>[
                     Expanded(
                       child:   DropdownButtonFormField<String>(
                   decoration: InputDecoration(
                     enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                            borderSide: BorderSide(color: Colors.grey[200])
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                            borderSide: BorderSide(color: Colors.grey[300])
                        ),
                        
                        filled: true,
                        fillColor: Colors.grey[100],
                       ),
                   hint: Text("sort by"),
                      isDense: true,
                       validator:(value) =>value==null?'field required':null,
                items: filterlist.map<DropdownMenuItem<String>>((value){
                         return DropdownMenuItem<String>(
                           value: value,
                           child: Text(value),);
                       }).toList(),
                       value:selectedfilter,
                        onChanged: (newvalue){
                        setState(() {
                           selectedfilter=newvalue;
                           clearText();
                           filtereddata=data;
                          });},),
                       ),
                         new SizedBox(width:20.0),
              Expanded(
                child:TextField(
                  controller: nameHolder,
                  onChanged: (value){
                    filtername(value);
                  },
                  decoration: InputDecoration(
                  prefixIcon:Icon(Icons.search),
                     enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                            borderSide: BorderSide(color: Colors.grey[200])
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                            borderSide: BorderSide(color: Colors.grey[300])
                        ),
                        hintText: getTranslated(context, 'serach'),
                        filled: true,
                        fillColor: Colors.grey[100],
                        
                       ),
                       )
                       ),]),
                     new SizedBox(
                        height: 20.0,
                     ) ,
              
            new Flexible(
          child: data.length == 0
              ? new CircularProgressIndicator(backgroundColor:Colors.red,valueColor:AlwaysStoppedAnimation<Color>(Colors.white),)
              : new ListView.builder(
            itemCount: filtereddata.length,
            itemBuilder: (_, index) {
              return UI(
                filtereddata[index].customername,
                filtereddata[index].endate,
                filtereddata[index].status,
                filtereddata[index].enid,
                index,
              );
            
            },
      )),]),
    ));
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
new Text('Status:',style:TextStyle(fontSize:20.0,fontWeight:FontWeight.bold),),
Icon(iconMapping [prog]),
new SizedBox(height:2.0),])
             ],
        ),
      ),
  )));
  }
  Widget UI2(var x){
    return Center(child: Text('$x'),);
  }

}