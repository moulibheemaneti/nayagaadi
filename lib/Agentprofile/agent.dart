import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:naya/localization/localizations_constants.dart';
import 'package:naya/Dashboard.dart';
import 'package:jiffy/jiffy.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:naya/widgets/ng_widgets.dart';
import 'package:naya/states/india.dart';
class AgentForm extends StatefulWidget {
  @override
  _AgentFormState createState() => _AgentFormState();
}
class _AgentFormState extends State<AgentForm> {
  
  GlobalKey<FormState> _key = new GlobalKey();
  
  DatabaseReference re=FirebaseDatabase.instance.reference();
  FirebaseMessaging firebaseMessaging=FirebaseMessaging();
  String pin,district,state,name,accNumber,ifscCode,referlCode;
  String notificationToken;
  bool _autoValidate = false;
  List refercodes=[];
  bool uploaded=false;
   Repoistry repo=Repoistry();
  List<String>_states=["Select State"];
  List<String>_district=["Select District"];
  String selectedDistrict="Select District";
  String selectedRegion="Select State";
  TextEditingController dateController = TextEditingController();
  String selectedgender,selectedoccupation,agentname,occupation,aadharnumber,mail,dob;
 List occupationlst=['Student','Housewife','Farmer','Govt employee','Industrialist','Shop Keeper','Others'];
 List genderlst=['Male','Female'];
 
//when details are uploaded
void _showDialog1() {
showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Text(getTranslated(context, 'please_wait')),
          content: new Text(getTranslated(context,'dialog_text')),
          shape: RoundedRectangleBorder(borderRadius: 
    BorderRadius.all(Radius.circular(15))),
          actions: <Widget>[
          ],
        );
      },
    );
  }
 @override
  void initState(){
     _states=List.from(_states)..addAll(repo.getStates());
  super.initState();
re.child('VerifiedAgents').once().then((value){
  if(value.value!=null){
var codes=value.value.keys;
for(var i in codes){
  refercodes.add(i);
}
setState(() {
  
});
  }
});
firebaseMessaging.configure(
     onLaunch: (Map<String,dynamic>msg)async{
       print('onLaunch called');
     },
     onResume: (Map<String,dynamic>msg)async{
       print('onResume called');
     },
     onMessage: (Map<String,dynamic>msg)async{
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
    firebaseMessaging.getToken().then((token) {
    notificationToken=token;
      setState(() {
        
      });
    });
}
  void onSelectedState(String value){
        setState(() {
          selectedDistrict='Select District';
          _district=['Select District'];
          selectedRegion=value;
          _district=List.from(_district)..addAll(repo.getLocaleByState(value));
        });
      }
      void onSelectedLGA(String value){
        setState(() {
          selectedDistrict=value;
        });
      }

  Widget build(BuildContext context) {
  
  return Scaffold(
      appBar: ngAppBar(getTranslated(context, 'title'), context),
      body:
      SingleChildScrollView(
        child:Container(
          padding: EdgeInsets.all(20),
          //Form
          child:Form(
             key: _key,
            autovalidate: _autoValidate,
            child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment:CrossAxisAlignment.center,
          children: <Widget>[
            new SizedBox(height:20.0),
            Center(child:Text( getTranslated(context, 'personal_info'),
   style:TextStyle(fontSize:26),)),
            new SizedBox(height: 10.0),
       //name
              TextFormField(
                 keyboardType: TextInputType.text,
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
                        hintText:  getTranslated(context, 'name_hint')
                      ),
                      onSaved: (val) {
                     agentname = val;
                     },
                validator: (val){
                  return val.length == 0 ? getTranslated(context, 'name_valid') : null;

                },
                ),
                 //aadarnumber
                 new SizedBox(height:20.0),  
                     TextFormField(
                        keyboardType: TextInputType.phone,
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
                        hintText: getTranslated(context, 'aadar_hint')
                      ),
                    validator: (val){
                      if (val.length != 12)
      return getTranslated(context, 'aadhar_valid');
    else if(val.length == 0)
    return getTranslated(context, 'aadhar_valid1');
    else 
    return null;
                    },
                  onSaved: (val) {
                     aadharnumber = val;
                },), 
  new SizedBox(height:20.0),
              //Gender        
              DropdownButtonFormField<String>(
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
                   hint: Text(getTranslated(context, 'gender_hint')),
                     isDense: true,
                       validator:(value) =>value==null?getTranslated(context,'field'):null,
                  items: genderlst.map<DropdownMenuItem<String>>((value){
                         return DropdownMenuItem<String>(
                           value: value,
                           child: Text(value),);
                       }).toList(),
                       value:selectedgender,
                        onChanged: (newvalue){
                        setState(() {
                           selectedgender=newvalue;
                          }); },
                      ),
                      new SizedBox(height:20.0),
                      //DOB
                       TextFormField(
       controller: dateController,
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
              labelText: getTranslated(context, 'Dob'),
       hintText: "Ex. Insert your dob",), 
       onTap: () async{
DateTime date = DateTime(1900);
FocusScope.of(context).requestFocus(new FocusNode());
date = await showDatePicker(
              context: context, 
              initialDate:DateTime.now(),
              firstDate:Jiffy(DateTime.now()).subtract(years: 100),
              lastDate: DateTime.now());
var date1=DateTime.parse(date.toString());
dateController.text ="${date1.day}-${date1.month}-${date1.year}";

},
validator: (val){
  if(val==null)
    return "Enter dob first";
  else
    return null;
},
      onSaved: (value) {
        dateController.text= value;
      }, ),
              new SizedBox(height:20.0),
              //MAIL
                      TextFormField(
                 keyboardType: TextInputType.emailAddress,
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
                        hintText: getTranslated(context, 'mail')
                      ),
                      validator: (val){
                        Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    
  if(val.length!=0 && !val.contains(regex))
      return 'Enter Valid Email';
    else
      return null;
                      },
                  onSaved: (val) {
                     mail = val;
                },),
                new SizedBox(height: 20.0,),
                //Ocuupation
                     DropdownButtonFormField(
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
                   hint: Text(getTranslated(context, 'Occ')),
                       isDense: true,
                        validator:(value) =>value==null?getTranslated(context,'field'):null,
            items: occupationlst.map<DropdownMenuItem<String>>((value){
                         return DropdownMenuItem<String>(
                           value: value,
                           child: Text(value),);
                       }).toList(),
                      value:selectedoccupation,
                       onChanged: (newvalue){
                        setState(() {
                           selectedoccupation=newvalue;
                            });
                            },),
                      new SizedBox(height:20.0),
                      //Residential details
            Center(child:Text(getTranslated(context, 'res_info'),style:TextStyle(fontSize:26),)),
            new SizedBox(height: 10.0),
             
                       new SizedBox(height:20.0),
               
                 DropdownButtonFormField<String>(
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
                   hint: Text(getTranslated(context, 'stat_hint')),
                       isDense: true,
                       onChanged:(value)=>onSelectedState(value),
                     value:selectedRegion,
                      
                       validator:(value) =>value==null?getTranslated(context, 'field'):null,
                  items: _states.map<DropdownMenuItem<String>>((value){
                         return DropdownMenuItem<String>(
                           value: value,
                           child: Text(value),);
                       }).toList(),
                       ),
                       new SizedBox(height:20.0),  
                         DropdownButtonFormField<String>(
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
                   hint: Text(getTranslated(context, 'dis_hint')),
                   
                       isDense: true,
                       onChanged:(value) => onSelectedLGA(value),
                               value:selectedDistrict,
                       validator:(value) =>value==null?getTranslated(context,'field'):null,
                    items: _district.map<DropdownMenuItem<String>>((value){
                         return DropdownMenuItem<String>(
                           value: value,
                           child: Text(value),);
                       }).toList(),
                       ),
                 
                       new SizedBox(height:20.0),
                       TextFormField(
                 keyboardType: TextInputType.phone,
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
                        hintText: getTranslated(context, 'pin')
                      ),
                      validator: (val){
                        if(val.length==0){
    return getTranslated(context, 'pin_valid');}
    else if(val.length!=6){
      return getTranslated(context, 'pin_valid1');
    }
    else{
      return null;
    }
                      },
                  onSaved: (val) {
                     pin = val;
                },),
                      new SizedBox(height:20.0),
            Center(child:Text(getTranslated(context, 'bank_info'),style:TextStyle(fontSize:26),)),
            new SizedBox(height: 10.0),
            TextFormField(
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
                        hintText: getTranslated(context,'ac_name')
                      ),
                  validator: (val){
                    return val.length == 0 ? getTranslated(context, 'acc_valid') : null;
                  },
                  onSaved: (val) {
                     name = val;
                },
                      ),
                 new SizedBox(height:20.0),     
              TextFormField(
                keyboardType:TextInputType.phone,
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
                        hintText: getTranslated(context, 'ac_num')
                      ),
                      validator: (val){
                        if(val.length==0){
    return getTranslated(context, 'accnum_valid');}
    else if(val.length<9 && val.length>18){
      return getTranslated(context, 'accnum_valid1');
    }
    else{
      return null;
    }
                      },
                  onSaved: (val) {
                     accNumber = val;
                     
                },
              
                      ),
                      new SizedBox(height:20.0),
              TextFormField(decoration: InputDecoration(
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
                        hintText: getTranslated(context, 'code'),
                      ),
                      validator: (val){
                        if(val.length==0){
    return getTranslated(context,'code_valid');
                        }
    else if(val.length!=11){
      return getTranslated(context,'code_valid1');;
    }
    else{
      return null;
    }
                      },
                  onSaved: (val) {
                     ifscCode = val;
                },
              
                      ),
                new SizedBox(height:20.0),
              TextFormField(decoration: InputDecoration(
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
                        hintText: getTranslated(context, 'referal')
                      ),
                      validator: (val){
                         if(val.length!=0){
        print(val);
    if(refercodes.contains(val)){
    return null;
    }
    else{
      return getTranslated(context, 'referal_valid');
    }
      }
    else{
      return null;
    }
                      },
                  onSaved: (val) {
                     referlCode = val;
                },
              
                      ),

                      Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment:CrossAxisAlignment.center,
          children: <Widget>[
           ButtonTheme(
  splashColor: Colors.red[300],
  padding: EdgeInsets.fromLTRB(35.0, 12.0, 35.0, 12.0),
  minWidth: 120,
  buttonColor: Colors.red[700],
  child: new RaisedButton(
    elevation: 10.0,
    textColor: Colors.white,
    onPressed: (){
      _sendToServer(notificationToken);
    },
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0),),
    child: new Text(getTranslated(context,'sub_hint'),
      style: TextStyle(
        fontSize: 20.0,
        letterSpacing: 1.0,
      ),
    ),
    color: Colors.red[700],
  ),
)

           ],)
          ],
        )),
      ))
    );

  }
   _sendToServer(var token1) async {
     //obtaining uid
     print(refercodes);
     final _auth=FirebaseAuth.instance;
     final FirebaseUser user = await _auth.currentUser();
    var uid = user.uid;
    var phn=user.phoneNumber;
if(_key.currentState.validate()){
        _key.currentState.save();
        _showDialog1();
var data={
     "Name": agentname,
      "Gender":selectedgender,
      "E-mail":mail,
      "Phone number":phn,
      "Aadhar number":aadharnumber,
      "Date-of-Birth":dateController.text,
      "Occupation":selectedoccupation,
       "District":selectedDistrict,
       "State":selectedRegion,
       "pincode":pin,
      "Name of Account holder": name,
      "Account numer":accNumber,
      "IFSC code":ifscCode,
      "Verification":"no",
      "Role":"Agent",
      "uid":uid,
      "device_token":token1,
      "refereedby":referlCode,
      "referalcount":0,
};
//sending data to firebase
re.child('NotVerifiedAgents').child('$uid').child('Profile').set(data).then((v){
   _key.currentState.reset();
    Navigator.of(context).pushReplacement(
        new MaterialPageRoute(builder: (context) => new Dashboard()));
});

}
else{
  setState(() {
          _autoValidate=true;
        });
      } 
   
}


}