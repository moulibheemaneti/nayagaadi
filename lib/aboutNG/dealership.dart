import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:naya/localization/localizations_constants.dart';
import 'package:naya/widgets/ng_drawer.dart';
import 'package:naya/widgets/ng_widgets.dart';

class NGDealership extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return Navigator.canPop(context);
      },child:Scaffold(
      appBar: ngAppBar(getTranslated(context, 'dealership'),context),
      drawer: NGDrawer(),
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(30.0, 10.0, 30.0, 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(getTranslated(context,"ds_text1")
              ,
              textAlign: TextAlign.center,
              style: ngSubHeadingTextStyle(),
            ),

            SizedBox(height: 20.0,),

            // Join Nayagaadi Dealer Platform
            Text(getTranslated(context, "ds_text2"),textAlign:TextAlign.center,style: ngMiniHeadingTextStyle(),),
            SizedBox(height: 20.0,),

            Text(getTranslated(context, "ds_text3"),style: ngTextStyle(),),
            Text(getTranslated(context, "ds_text4"),style: ngTextStyle(),),
            Text(getTranslated(context, "ds_text5"),style: ngTextStyle(),),
            Text(getTranslated(context, "ds_text6"),style: ngTextStyle(),),
            Text(getTranslated(context, "ds_text7"),style: ngTextStyle(),),
            Text(getTranslated(context, "ds_text8"),style: ngTextStyle(),),
            Text(getTranslated(context, "ds_text9"),style: ngTextStyle(),),

            SizedBox(height: 20.0,),

            // Benefits of NayaGaadi Technology Driven Online Marketplace platform
            Text(getTranslated(context, "ds_text10"),textAlign:TextAlign.center,style: ngMiniHeadingTextStyle(),),
            SizedBox(height: 20.0,),

            Text(getTranslated(context, "ds_text11"),style: ngBoldTextStyle(),),
            Text(getTranslated(context, "ds_text12"),style: ngTextStyle(),),
            SizedBox(height: 10,),

            Text(getTranslated(context, "ds_text13"),style: ngBoldTextStyle(),),
            Text(getTranslated(context, "ds_text14"),style: ngTextStyle(),),
            SizedBox(height: 10,),
            Text(getTranslated(context, "ds_text15"),style: ngTextStyle(),),
            SizedBox(height: 10,),

            Text(getTranslated(context, "ds_text16"),style: ngBoldTextStyle(),),
            Text(getTranslated(context, "ds_text17"),style: ngTextStyle(),),
            SizedBox(height: 10,),

            Text(getTranslated(context, "ds_text18"),style: ngBoldTextStyle(),),
            Text(getTranslated(context, "ds_text19"),style: ngTextStyle(),),
            SizedBox(height: 10,),

            Text(getTranslated(context, "ds_text20"),style: ngBoldTextStyle(),),
            Text(getTranslated(context, "ds_text21"),style: ngTextStyle(),),
            SizedBox(height: 10,),
            Text(getTranslated(context, "ds_text22"),style: ngTextStyle(),),
            SizedBox(height: 10,),

            Text(getTranslated(context, "ds_text23"),style: ngBoldTextStyle(),),
            Text(getTranslated(context, "ds_text24"),style: ngTextStyle(),),
            SizedBox(height: 10,),

            Text(getTranslated(context, "ds_text25"),style: ngBoldTextStyle(),),
            Text(getTranslated(context, "ds_text26"),style: ngTextStyle(),),
            SizedBox(height: 10,),

          ],
        ),
      ),
    ));
  }
}