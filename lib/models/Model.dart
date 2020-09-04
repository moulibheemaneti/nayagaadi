import 'package:flutter/material.dart';
import 'package:naya/localization/localizations_constants.dart';
import 'package:naya/main.dart';
import 'dart:ui';
class myData{
  String name,accnum,code,accname,role,dis,state,uid,phn,mail,accnumber;
  int referalcount;
  myData(this.name,this.role,this.dis,this.state,this.accname,this.accnum,this.code,this.uid,this.referalcount,this.accnumber,this.mail,this.phn);
}
class AgentdDeatils{
  String name,gender,email,phn,aadharnum,dob,occupation,village,district,state,mandal,pin,accname,ifsc,count;
  AgentdDeatils(this.name,this.gender,this.email,this.phn,this.aadharnum,this.dob,this.occupation,this.village,this.district,this.state,this.mandal,this.pin,this.accname,this.ifsc,this.count);
}

class Customerdata{
  String customername;
  String date,status,id;
  Customerdata(this.customername,this.date,this.status,this.id);
}
class Earningsdata{
  String customername,date,id;
  int status;
  Earningsdata(this.customername,this.date,this.status,this.id);
}
class Customerfulldetails{
  String customername,enid,endate,status,vehicle,brand,model,variant;
  Customerfulldetails(this.customername,this.enid,this.endate,this.status,this.vehicle,this.brand,this.model,this.variant);
}

void changeLanguage(Language language,BuildContext context)async{
       Locale _temp=await setLocale(language.languageCode);
       MyApp.setLocale(context,_temp);
  }
class Language{
  final int id;
  final String name;
  final String languageCode;
  Language(this.id,this.name,this.languageCode);
  static List<Language> languageList(){
    return <Language>[
Language(1, 'English', 'en'),
Language(2, 'हिन्दी', 'hi'),
Language(3, 'తెలుగు','te'),
Language(4, 'தமிழ்', 'ta'),
Language(5, 'ಕೆನಡಾ', 'kn'),
Language(6, 'ಮಲಯಾಳಂ', 'ml'),


    ];
  }
  
}
Map<String, IconData> iconMapping = {
  'Successful' : Icons.check_circle,
  'Pending' : Icons.hourglass_empty,
  'UnSuccessful' : Icons.cancel,
};
Map<String, String> filterMapping = {
  'Customername' : 'customername',
  'Vehicle' : 'vehicle',
  'Date' : 'endate',
  'Progress':'status',
  'Enquiryid':'enid',
  'Brand':'brand',
  'Model':'model',
  'Variant':'variant',
};

class StateModel {
  String state;
  List<String> districts;

  StateModel({this.state, this.districts});

  StateModel.fromJson(Map<String, dynamic> json) {
    state = json['state'];
    districts = json['districts'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['state'] = this.state;
    data['districts'] = this.districts;
    return data;
  }
}

