import 'package:flutter/material.dart';
import 'package:naya/models/Model.dart';
ngAppBar(String screenTitle,BuildContext context){
  return AppBar(
    backgroundColor: Colors.red[700],
    title: Text(screenTitle),
    centerTitle: true,
     actions: <Widget>[
          Padding(padding: EdgeInsets.all(10.0),
          child: DropdownButton(
            onChanged: (Language language){
              changeLanguage(language,context);
              print(language.languageCode);
            },
            underline: SizedBox(),
            icon: Icon(Icons.language,
            color:Colors.white
            ),
items:Language.languageList().map<DropdownMenuItem<Language>>((lang)=>DropdownMenuItem(
  value: lang,
  child:Text(lang.name), 
  )).toList()
          ),
          )
        ],
  );
}
ngHeadingText(String string){
  return Text(
    string,
    textAlign: TextAlign.center,
    style: ngHeadingTextStyle(),
  );
}

ngHeadingTextStyle(){
  return TextStyle(
    fontWeight: FontWeight.bold,
    color: Colors.black,
    fontSize: 30.0
  );
}

ngSubHeadingTextStyle(){
  return TextStyle(
    fontWeight: FontWeight.bold,
    color: Colors.black,
    fontSize: 23.0
  );
}
ngMiniHeadingTextStyle(){
  return TextStyle(
    color: Colors.black,
    fontSize: 19.0,
    fontWeight: FontWeight.bold,
    letterSpacing: 1.1,
    decoration: TextDecoration.underline,
  );
}
ngBoldTextStyle(){
  return TextStyle(
    color: Colors.black,
    fontSize: 17.0,
    fontWeight: FontWeight.bold,
    //letterSpacing: 1.1,
  );
}
ngHyperLinkTextStyle(){
  return TextStyle(
    color: Colors.red[700],
    fontSize: 17.0,
    fontWeight: FontWeight.bold,
    letterSpacing: 1.1,
  );
}
ngTextStyle(){
  return TextStyle(
    color: Colors.black,
    fontSize: 18.0,
    letterSpacing: 1.0,
  );
}
ngQuestion(String string){
  return Text(
    string,
    textAlign: TextAlign.start,
    style: ngBoldTextStyle(),
  );
}

ngAnswer(String string){
  return Text(
    string,
    textAlign: TextAlign.left,
    style: ngTextStyle(),
  );
}
ngButtonTextStyle(){
  return TextStyle(
    color: Colors.white,
    fontWeight: FontWeight.bold,
    fontSize: 20.0,
    letterSpacing: 1.0,
  );
}

ngDashBoardTextStyle(){
  return TextStyle(
    fontSize: 15.0,
    letterSpacing: 1.0,
  );
}

ngAboutTextStyle(){
  return TextStyle(
    color: Colors.black,
    fontSize: 17.0,
    letterSpacing: 1.0,
  );
}

ngButtonTheme(){
  return ButtonTheme(
    splashColor: Colors.red[300],
    padding: EdgeInsets.fromLTRB(35.0, 12.0, 35.0, 12.0),
    minWidth: 120,
    buttonColor: Colors.red[700],
    child: new RaisedButton(
      elevation: 10.0,
      textColor: Colors.white,
      onPressed: (){

      },
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0),),
      child: new Text("Button",
        style: TextStyle(
          fontSize: 20.0,
          letterSpacing: 1.0,
        ),
      ),
      color: Colors.red[700],
    ),
  );
}
ngFormFields(){
  return TextFormField(
    keyboardType: TextInputType.phone,
    decoration: InputDecoration(
      hoverColor: Colors.white,
      fillColor: Colors.white,
      focusColor: Colors.white,
      labelText: 'Phone Number',
      labelStyle: TextStyle(
        fontSize: 20.0,
      ),
      prefixText: "+91 ",
      prefixStyle: TextStyle(
        fontSize: 18.0,
      ),
    ),
    validator: (value){
      if(value.length != 10){
        return "Enter valid Phone Number";
      }
      return null;
    },
    // autovalidate: true,
  );
}


ngProfileField(String string){
  return Text(
    string,
    style: TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 18.0,

    ),
  );
}
ngProfileField1(String string){
  return Text(
    string,textAlign: TextAlign.center,
    style: TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 18.0,
      
    ),
  );
}
ngEnquiryField(String string,int x,String string2,String string3){
  return Text(
    '$string \n $string2\n $x $string3',
    style: TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 18.0,
    ),
  );
}
ngEnquiryField1(String string,String string2){
  return Text(
    '$string \n $string2',
    style: TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 18.0,
    ),
  );
}
ngProfileFieldValue(String string){
  return Text(

    string,
//    textAlign: TextAlign.left,
    style: TextStyle(
      fontSize: 18.0,
      fontWeight: FontWeight.w400,
    ),
  );
}