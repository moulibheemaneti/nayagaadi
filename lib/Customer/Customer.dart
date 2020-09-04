import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:naya/localization/localizations_constants.dart';
import 'package:naya/Agentprofile/agentdashboard.dart';
import 'package:intl/intl.dart';
import 'package:naya/states/india.dart';
import 'package:naya/states/indianDistrictCode.dart';
import 'package:naya/states/indianStateCode.dart';
import 'package:naya/widgets/ng_widgets.dart';
import 'package:naya/widgets/ng_drawer.dart';
import 'dart:collection';
import 'package:naya/vehicleinfo.dart';
class Customer extends StatefulWidget {
  @override
  _CustomerState createState() => _CustomerState();
}
class _CustomerState extends State<Customer> {
  GlobalKey<FormState> _key = new GlobalKey();
  bool _autovalidate = false;
  String id='NGE_';
  String name,number,mail,cid,stab,c,enquiryid;
  List paymentlist=['Test Drive','Pre-Order Booking','Down Payment','Full Payment','Loan Required','Vechile Exchange','Other Services'];
  List occupationlst=['Student','Housewife','Farmer','Govt employee','Industrialist','Shop Keeper','Others'];
 
  VehiclesInfo vehiclesInfo = VehiclesInfo();
  List<String> _vehicles = [];
  List<String> _vehicleBrands = [];
  List<String> _vehicleModels = [];
  List<String> _vehicleVariants = [];

  String _selectedVehicle;
  String _selectedVehicleBrand;
  String _selectedVehicleModel;
  String _selectedVehicleVariant;
  BuildContext context;
  var stateslist=stateCodes.keys;
  var districtlist=districtCodes.keys;
  String selectedpayment,selectedoccupation;
  TextEditingController dateCtl = TextEditingController();
  List count=[];
  Repoistry repo=Repoistry();
  List<String>_states=["Select State"];
  List<String>_district=["Select District"];
  String selectedDis="Select District";
  String selectedRegion="Select State";

  void _showDialog1(BuildContext context) {
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
     print(stateslist);
     _vehicles = List.from(_vehicles)..addAll(vehiclesInfo.getVehicles());
    _vehicles = LinkedHashSet<String>.from(_vehicles).toList();
    super.initState();
     FirebaseAuth.instance.currentUser().then((user) {
        if (user != null) {
          user.getIdToken().then((token) {
            Map<dynamic,dynamic> tokenMap = token.claims;
           var uid=tokenMap['sub'];
            print(uid);
            DatabaseReference ref=FirebaseDatabase.instance.reference();
ref.child('VerifiedAgents').once().then((value){
  if(value.value!=null){
   var key=value.value.keys;
   print(key);
   for(var i in key){
     ref.child('VerifiedAgents').child('$i').child('FormEnquires').once().then((snap){
       if(snap.value!=null){
       var key2=snap.value.keys;
       for(var j in key2){
         count.add(j);
         setState(() {
           
         });
       }
       }
     });
   }
  }
});
});
        }
     });
      }
      void onSelectedState(String value){
        setState(() {
          selectedDis='Select District';
          _district=['Select District'];
          selectedRegion=value;
          _district=List.from(_district)..addAll(repo.getLocaleByState(value));
        });
      }
      void onSelectedLGA(String value){
        setState(() {
          selectedDis=value;
        });
      }
       void _onSelectedVehicle(String value){
    setState(() {
      _selectedVehicle = value;
      _selectedVehicleBrand = null;
      _selectedVehicleModel = null;
      _selectedVehicleVariant = null;
      _vehicleBrands.clear();
      _vehicleModels.clear();
      _vehicleVariants.clear();
      _vehicleBrands = List.from(_vehicleBrands)..addAll(vehiclesInfo.getVehicleBrand(value));
      _vehicleBrands = LinkedHashSet<String>.from(_vehicleBrands).toList();
    
    });
  }

  void _onSelectedVehicleBrand(String brand){
    setState(() {
      _selectedVehicleBrand = brand;
      _selectedVehicleModel = null;
      _selectedVehicleVariant = null;
      _vehicleModels.clear();
      _vehicleVariants.clear();
      _vehicleModels = List.from(_vehicleModels)..addAll(vehiclesInfo.getVehicleModel(_selectedVehicle, brand));
      _vehicleModels = LinkedHashSet<String>.from(_vehicleModels).toList();
      _vehicleModels.sort();
    });
  }

  void _onSelectedVehicleModel(value){
    setState(() {
      _selectedVehicleModel = value;
      _selectedVehicleVariant = null;
      _vehicleVariants.clear();
      _vehicleVariants = List.from(_vehicleVariants)..addAll(vehiclesInfo.getVehicleVariant(_selectedVehicle, _selectedVehicleBrand, value));
      _vehicleVariants = LinkedHashSet<String>.from(_vehicleVariants).toList();
      _vehicleVariants.sort();
    });
  }

  void _onSelectedVehicleVariant(value){
    setState(() {
      _selectedVehicleVariant = value;
    });
  }
Widget build(BuildContext context) {
        return Scaffold(
      appBar: ngAppBar(getTranslated(context,'enq'), context),
      drawer: NGDrawer(),
      body:SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(20.0),
          child:Form(
            key: _key,
            autovalidate: _autovalidate,
        child: Column(
           mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment:CrossAxisAlignment.center,
          children: <Widget>[
            new SizedBox(height:20.0),
             Center(child:Text(getTranslated(context,'cust_info'),style:TextStyle(fontSize:26),)),
            new SizedBox(height:10.0),
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
                        hintText: getTranslated(context, 'name_hint')
                      ),
                  validator: (val){
                    return val.length==0 ?getTranslated(context,'name_valid'):null;
                  },
                  onSaved: (val) {
                     name = val;
                },),
                      new SizedBox(height: 10.0),
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
                        hintText: getTranslated(context, 'phn')
                      ),
                  validator: (val){
                    if(val.length!=10 && val.length!=0){
                      return getTranslated(context, 'phn_valid');
                    
                    }
                    else if(val.length==0){
                      return getTranslated(context, 'phn_valid');
                    }
                    return null;
                  },
                  onSaved: (val) {
                     number = val;
                     
                },),
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
                        hintText: getTranslated(context, 'mail')
                      ),
                  validator: (val){
                    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    
  if(val.length!=0 && !val.contains(regex))
      return getTranslated(context, 'email_valid');
    else
      return null;
                  },
                  onSaved: (val) {
                     mail = val;
                },),
                      new SizedBox(height: 10.0),
                      TextFormField(
       controller: dateCtl,
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
              firstDate:DateTime(1900),
              lastDate: DateTime.now());
              var date1=DateTime.parse(date.toString());
dateCtl.text ="${date1.day}-${date1.month}-${date1.year}";
},
validator: (val){
  if(val==null)
    return "Enter dob first";
  else
    return null;
},
      onSaved: (value) {
        dateCtl.text= value;
      },),
      new SizedBox(height: 20.0,),
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
                            
                         }); },),
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
                        onChanged: (value) => onSelectedState(value),
                        value:selectedRegion,
                       validator:(value) =>value==null || value=='Select State'?getTranslated(context,'field'):null,
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
                        fillColor: Colors.grey[100]
                   ),
                   hint: Text(getTranslated(context, 'dis_hint')),
                     
                       isDense: true,
                       onChanged: (value) => onSelectedLGA(value),
                       value:selectedDis,
                       validator:(value) =>value==null || value=='Select District'?getTranslated(context,'field'):null,
                  items: _district.map<DropdownMenuItem<String>>((value){
                         return DropdownMenuItem<String>(
                           value: value,
                           child: Text(value),);
                       }).toList(),),
                 new SizedBox(height:20.0),  
             DropdownButtonFormField<String>(
                   decoration: InputDecoration(
                     enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                            borderSide: BorderSide(color: Colors.grey[200])
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                            borderSide: BorderSide(color: Colors.blue)
                        ),
                        filled: true,
                        fillColor: Colors.grey[100],
                      ),
                   hint: Text(getTranslated(context, 'vehicle')),
                      isDense: true,
                       validator:(value) =>value==null?getTranslated(context,'field'):null,
                    items: _vehicles.map<DropdownMenuItem<String>>((value){
                         return DropdownMenuItem<String>(
                           value: value,
                           child: Text(value),);
                       }).toList(),
                 onChanged: (value) => _onSelectedVehicle(value),
                value: _selectedVehicle,
                      ),
          new SizedBox(height:10.0),
          //brands
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
                   hint: Text(getTranslated(context, 'Brand')),
                      isDense: true,
                       validator:(value) =>value==null?getTranslated(context,'field'):null,
                  items: _vehicleBrands.map<DropdownMenuItem<String>>((value){
                         return DropdownMenuItem<String>(
                           value: value,
                           child: Text(value),);
                       }).toList(),
                       onChanged: (value) => _onSelectedVehicleBrand(value),
                value: _selectedVehicleBrand,
  ),
                      new SizedBox(height:10.0),
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
                   hint: Text(getTranslated(context, 'model')),
                      isDense: true,
                       validator:(value) =>value==null?getTranslated(context,'field'):null,
                    items: _vehicleModels.map<DropdownMenuItem<String>>((value){
                         return DropdownMenuItem<String>(
                           value: value,
                           child: Text(value),);
                       }).toList(),
                       onChanged: (value) => _onSelectedVehicleModel(value),
                value: _selectedVehicleModel,
                     ),
                      new SizedBox(height:10.0),
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
                   hint: Text(getTranslated(context, 'variant')),
                      isDense: true,
                       validator:(value) =>value==null?getTranslated(context,'field'):null,
                    items: _vehicleVariants.map<DropdownMenuItem<String>>((value){
                         return DropdownMenuItem<String>(
                           value: value,
                           child: Text(value),);
                       }).toList(),
                       onChanged: (value) => _onSelectedVehicleVariant(value),
                value: _selectedVehicleVariant,

                     ),
                      new SizedBox(height:10.0),
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
                   hint: Text(getTranslated(context, 'payment')),
                      isDense: true,
                       validator:(value) =>value==null?getTranslated(context,'field'):null,
                items: paymentlist.map<DropdownMenuItem<String>>((value){
                         return DropdownMenuItem<String>(
                           value: value,
                           child: Text(value),);
                       }).toList(),
                       value:selectedpayment,
                        onChanged: (newvalue){
                        setState(() {
                           selectedpayment=newvalue;
                          });},),
                          new SizedBox(height:20.0),
                          ButtonTheme(
  splashColor: Colors.red[300],
  padding: EdgeInsets.fromLTRB(35.0, 12.0, 35.0, 12.0),
  minWidth: 120,
  buttonColor: Colors.red[700],
  child: new RaisedButton(
    elevation: 10.0,
    textColor: Colors.white,
    onPressed: (){
      _sendserver(count.length,context);
    },
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0),),
    child: new Text(getTranslated(context, 'sub_hint'),
      style: TextStyle(
        fontSize: 20.0,
        letterSpacing: 1.0,
      ),
    ),
    color: Colors.red[700],
  ),
)
],
        ),)
      ))
    );
  }
  _sendserver(var count1,BuildContext context)async{
   final _auth=FirebaseAuth.instance;
    final FirebaseUser user = await _auth.currentUser();
    var uid = user.uid;
if(_key.currentState.validate()){
        _key.currentState.save();
        _showDialog1(context);
        var now = new DateTime.now();
    var timestamp=new DateFormat("dd-MM-yyyy").format(now);
    var data={
      "Name":name,
      "Mobile number":number,
      "e-mail":mail,
      "DOB":dateCtl.text,
      "Occupation":selectedoccupation,
      "District":selectedDis,
      "State":selectedRegion,
      "Vehicle":_selectedVehicle,
      "Model":_selectedVehicleModel,
      "Brand":_selectedVehicleBrand,
      "Variant":_selectedVehicleVariant,
      "Payment":selectedpayment,
      "Date":timestamp,
      "Status":'Pending',
      "Earnings":0,
    };
    for(var i in stateslist){
      if(i==selectedRegion){
         stab=stateCodes[selectedRegion];
      }
    }
    for(var i in districtlist){
      if(i==selectedDis){
         c=districtCodes[selectedDis];
      }
    }
    print(stab);
    print(c);
    var count3=count1+1;
    enquiryid=id+stab+'_'+c+count3.toString();
    print(enquiryid);
var re=FirebaseDatabase.instance.reference();
 re.child('VerifiedAgents').orderByChild('UID').equalTo('$uid').once().then((value){
 var a=value.value.keys;
 for(var i in a){
re.child('VerifiedAgents').child('$i').child('FormEnquires').child('$enquiryid').set(data).then((value){
_key.currentState.reset();


Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => AgentDashBoard()));
});

 }
 });
}
  else{
     setState(() {
          _autovalidate=true;
        });
       
  }
  }
  
    

  }
 

