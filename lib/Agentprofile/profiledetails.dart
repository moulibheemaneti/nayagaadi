import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:naya/models/Model.dart';
import 'package:naya/localization/localizations_constants.dart';
import 'package:naya/widgets/ng_widgets.dart';
import 'package:naya/widgets/ng_drawer.dart';
class AgentProfile extends StatefulWidget {
  @override
  _AgentProfileState createState() => _AgentProfileState();
}
class _AgentProfileState extends State<AgentProfile> {
List compeletedcount=[];
List inprogresscount=[];
List notprogressedcount=[];
List<myData>allData=[];
DatabaseReference ref = FirebaseDatabase.instance.reference();

@override
  void initState() {
  super.initState();

FirebaseAuth.instance.currentUser().then((user) {
var uid = user.uid;
print(uid);
//obtaning the details of the user
ref.child('VerifiedAgents').orderByChild('UID').equalTo('$uid').once().then((value){
var a=value.value.keys;
for(var i in a){
ref.child('VerifiedAgents').child('$i').child('Profile').once().then((DataSnapshot s)async{
     var data = s.value;
    var name=data['Name'];
     var role=data['Role'];
    var district=data['District'];
    var state=data['State'];
    var accNumber=data['Account numer'];
    var code=data['IFSC code'];
    var aanum=data['Aadhar number'];
    var accnum=data['Account numer'];
    var mail=data['E-mail'];
    var phn=data['Phone number'];
    var id=i;
    var refer=data['referalcount'];
    print(refer);
    myData d = new myData(
        name,role,district,state,aanum,accNumber,code,id,refer,accnum,mail,phn
       );
             allData.add(d);
      setState(() {
      });

    ref.child('VerifiedAgents').child('$i').child('FormEnquires').once().then((snap){
    if(snap.value!=null){
      print('ooooo');
    var key=snap.value.keys;
    for(var j in key){
      ref.child('VerifiedAgents').child('$i').child('FormEnquires').child('$j').orderByKey().equalTo('Status').once().then((va){
        var sort=va.value;
        if(sort['Status']=='Successful'){
          compeletedcount.add(j);
         setState(() {
           
         });
        }
        if(sort['Status']=='Pending'){
          inprogresscount.add(j);
         setState(() {
           
         });
        }
        else if(sort['Status']=='Unsuccessful'){
          notprogressedcount.add(j);
         setState(() {
           
         });
        }
      });
       }
    
    }else{
      print('no enquires');
    }
      });
    
});
}
});
});
}

Widget build(BuildContext context) {
  return Scaffold(
      appBar: ngAppBar(getTranslated(context,'profile'), context
      ),
      drawer: NGDrawer(),
       body: new Container(
     child:new Center(
          child: allData.length == 0
              ? new CircularProgressIndicator(backgroundColor:Colors.red,valueColor:AlwaysStoppedAnimation<Color>(Colors.white),)
              : new ListView.builder(
            itemCount: 1,
            itemBuilder: (_, index) {
              return UI(
                allData[index].name,
                allData[index].role,
                allData[index].dis,
                allData[index].state,
                allData[index].accname,
                allData[index].accnum,
                allData[index].code,
                allData[index].uid,
                allData[index].referalcount,
                allData[index].accnumber,
                allData[index].mail,
                allData[index].phn,
                compeletedcount.length,
                inprogresscount.length,
                notprogressedcount.length,
              );
            },
      )),
    )
    );
  }
  Widget UI(var name,var role,var dis,var state,var acnam,var accnum,var code,var id,var referal,var accountnumber,var mail,var phone,var completedcount,var inprogresscount,var notprogressedcount){
     
    return SingleChildScrollView(
      padding: EdgeInsets.only(left: 10.0, right: 10.0, top: 50.0),
      child: Column(
      children: <Widget>[ 
           
  Icon(Icons.account_circle, size: 160.0,color: Colors.red[700]),
    new SizedBox(height:10.0),
          // profile details
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround, 
            children: <Widget>[
              // Fields
              Column(
                crossAxisAlignment: CrossAxisAlignment.start, 
                children: <Widget>[
                  ngProfileField('Name'),
                  new SizedBox(height:5.0),
                  ngProfileField('Agent ID'),
                  new SizedBox(height:5.0),
                  ngProfileField('Mobile Number'),
                  new SizedBox(height:5.0),
                  ngProfileField('E Mail ID'),
                  new SizedBox(height:5.0),
                  ngProfileField('District'),
                  new SizedBox(height:5.0),
                  ngProfileField('State'),
                  new SizedBox(height:5.0),
                  ngProfileField('Role'),
                  new SizedBox(height:5.0),
                  ngProfileField('Successful Enquiries'),
                  new SizedBox(height:5.0),
                  ngProfileField('Pending Enquiries'),
                  new SizedBox(height:5.0),
                  ngProfileField('Unsuccessful Enquiries'),
                  new SizedBox(height:5.0),
                  ngProfileField('No.of Referrals'),
                  new SizedBox(height:5.0),
                  ngProfileField('Account Number'),
                  new SizedBox(height:5.0),
                  ngProfileField('IFSC code'),
                  new SizedBox(height:5.0),
                  ngProfileField('Aadhaar Number'),

                ],
              ),

              // :-
              Column(
                children: <Widget>[
                  ngProfileField(': '),
                  new SizedBox(height:5.0),
                  ngProfileField(': '),
                  new SizedBox(height:5.0),
                  ngProfileField(': '),
                  new SizedBox(height:5.0),
                  ngProfileField(': '),
                  new SizedBox(height:5.0),
                  ngProfileField(': '),
                  new SizedBox(height:5.0),
                  ngProfileField(': '),
                  new SizedBox(height:5.0),
                  ngProfileField(': '),
                  new SizedBox(height:5.0),
                  ngProfileField(': '),
                  new SizedBox(height:5.0),
                  ngProfileField(': '),
                  new SizedBox(height:5.0),
                  ngProfileField(': '),
                  new SizedBox(height:5.0),
                  ngProfileField(': '),
                  new SizedBox(height:5.0),
                  ngProfileField(': '),
                  new SizedBox(height:5.0),
                  ngProfileField(': '),
                  new SizedBox(height:5.0),
                  ngProfileField(': '),
                  new SizedBox(height:5.0),
                  
                ],
               ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
      
                  ngProfileFieldValue('$name'),
                  new SizedBox(height:5.0),
                  ngProfileFieldValue('$id'),
                  new SizedBox(height:5.0),
                  ngProfileFieldValue('$phone'),
                  new SizedBox(height:5.0),
                  ngProfileFieldValue('$mail'),
                  new SizedBox(height:5.0),
                  ngProfileFieldValue('$dis'),
                  new SizedBox(height:5.0),
                  ngProfileFieldValue('$state'),
                  new SizedBox(height:5.0),
                  ngProfileFieldValue('$role'),
                  new SizedBox(height:5.0),
                  ngProfileFieldValue('$completedcount'),
                  new SizedBox(height:5.0),
                  ngProfileFieldValue('$inprogresscount'),
                  new SizedBox(height:5.0),
                  ngProfileFieldValue('$notprogressedcount'),
                  new SizedBox(height:5.0),
                  ngProfileFieldValue('$referal'),
                  new SizedBox(height:5.0),
                  ngProfileFieldValue('$accountnumber'),
                  new SizedBox(height:5.0),
                  ngProfileFieldValue('$code'),
                  new SizedBox(height:5.0),
                  ngProfileFieldValue('$acnam'),
                ],
              ),
            ],
          ), 
          SizedBox(height: 20,),
        ],
      ),
    );
  }
  
  }