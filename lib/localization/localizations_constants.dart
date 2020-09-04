import 'package:flutter/material.dart';
import 'package:naya/localization/demo_localization.dart';
import 'package:shared_preferences/shared_preferences.dart';

String getTranslated(BuildContext context,String key){
  return DemoLocalization.of(context).getTranslatedValue(key);
}
const String english='en';
const String telugu='te';
const String Tamil='ta';
const String Hindi='hi';
const String kanada='kn';
const String malyalam='ml';
const String LANGUAGE_CODE='languageCode';

Future<Locale> setLocale(String languageCode)async{
  SharedPreferences _prefs=await SharedPreferences.getInstance();
  await _prefs.setString(LANGUAGE_CODE, languageCode);
  return  _locale(languageCode);
}
Locale _locale(String languageCode){
   Locale _temp;
    switch(languageCode){
      case 'en':
      _temp=Locale(languageCode,'US');
      break;
      case 'hi':
      _temp=Locale(languageCode,'IN');
      break;
      case 'te':
      _temp=Locale(languageCode,'IN');
      break;
      case 'ta':
      _temp=Locale(languageCode,'IN');
      break;
      case 'kn':
      _temp=Locale(languageCode,'IN');
      break;
      case 'ml':
      _temp=Locale(languageCode,'IN');
      break;
      
      default:
      _temp=Locale(languageCode,'Us');
    }
    return _temp;

}
Future<Locale>getLocale()async{
  SharedPreferences _prefs=await SharedPreferences.getInstance();
  String languageCode=_prefs.getString(LANGUAGE_CODE)??'en';
  return _locale(languageCode);
}