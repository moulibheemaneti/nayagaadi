import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:naya/localization/demo_localization.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:naya/localization/localizations_constants.dart';
import 'package:naya/spalshscreen.dart';

void main() => runApp(new MyApp());

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  static void setLocale(BuildContext context,Locale locale){
    _MyAppState state=context.findAncestorStateOfType< _MyAppState>();
    state.setLocale(locale);
  }
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  DatabaseReference ref=FirebaseDatabase.instance.reference();

    
  Locale _locale;
  void setLocale(Locale locale){
    setState(() {
      _locale=locale;
    });
  }
  @override
  void didChangeDependencies(){
    getLocale().then((locale){
setState(() {
  this._locale=locale;
});
    });
    super.didChangeDependencies();
  }
  @override
  Widget build(BuildContext context) {
   if(_locale==null){
     return Container(
       child:Center(
         child:CircularProgressIndicator(),
       ),
     );
   }
   else{
      return MaterialApp(
      locale:_locale,
      supportedLocales: [
        Locale('en','US'),
        Locale('hi','IN'),
        Locale('te','IN'),
        Locale('ta','IN'),
        Locale('kn','IN'),
        Locale('ml','IN'),
      ],
      localizationsDelegates: [
   // ... app-specific localization delegate[s] here
   DemoLocalization.delegate,
   GlobalMaterialLocalizations.delegate,
   GlobalWidgetsLocalizations.delegate,
   GlobalCupertinoLocalizations.delegate,
 ],
 localeResolutionCallback: (deviceLocale,supportedLocales){
   for(var loacle in supportedLocales){
     if(loacle.languageCode==deviceLocale.languageCode && loacle.countryCode==deviceLocale.countryCode){
       return deviceLocale;
     }

   }
   return supportedLocales.first;
 },
       
      debugShowCheckedModeBanner: false,
      home: NGSplashScreen(),
    );
   }
  }
}