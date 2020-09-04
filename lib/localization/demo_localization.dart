import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:convert';
class DemoLocalization{
  final Locale locale;

  DemoLocalization(this.locale);
  static DemoLocalization of(BuildContext context){
    return Localizations.of<DemoLocalization>(context, DemoLocalization);
  }
  Map<String,String>_localizedvalues;



  Future load()async{
    String jsonStringValues=await rootBundle.loadString('lib/lang/${locale.languageCode}.json');
    Map<String,dynamic>mappedJson=json.decode(jsonStringValues);
    _localizedvalues=mappedJson.map((key,value) => MapEntry(key, value));
  }
String getTranslatedValue(String key){
  return _localizedvalues[key];
}

static const LocalizationsDelegate<DemoLocalization>delegate=_DemoLocalizationDelegate();
 }
 class _DemoLocalizationDelegate extends LocalizationsDelegate<DemoLocalization>{
   const _DemoLocalizationDelegate();
  @override
  bool isSupported(Locale locale) {
    return ['en','hi','kn','ml','te','ta',].contains(locale.languageCode);
  }

  @override
  Future<DemoLocalization> load(Locale locale)async {
    DemoLocalization localization=new DemoLocalization(locale);
    await localization.load();
    return localization;
  }

  @override
  bool shouldReload(LocalizationsDelegate<DemoLocalization> old) =>false;

  


 }