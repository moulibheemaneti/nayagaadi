import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:naya/localization/localizations_constants.dart';
import 'package:naya/widgets/ng_drawer.dart';
import 'package:naya/widgets/ng_widgets.dart';

class Home extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return Navigator.canPop(context);
      },
      child:Scaffold(
      appBar: ngAppBar(getTranslated(context,'home'),context),
      drawer: NGDrawer(),
      body: ListView(
        padding: EdgeInsets.fromLTRB(40.0, 30.0, 40.0, 20.0),
        children: <Widget>[
          Text(
            getTranslated(context, "about_us"),
            textAlign: TextAlign.center,
            style: ngSubHeadingTextStyle(),
          ),

          Text(
            getTranslated(context, "about_para1"),
            style: ngTextStyle(),
          ),

          Text(
            getTranslated(context, "about_para2"),
            style: ngTextStyle(),
          ),

          Text(
            getTranslated(context, "about_para3"),
            textAlign: TextAlign.left,
            style: ngTextStyle(),
          ),

          Text(
            getTranslated(context, "about_para4"),
            style: ngTextStyle(),
          ),
        ],
      ),
    )
    );
  }
}