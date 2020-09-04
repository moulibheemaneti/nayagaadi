import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:naya/localization/localizations_constants.dart';
import 'package:naya/aboutNG/contactus.dart';

import 'package:naya/widgets/ng_drawer.dart';
import 'package:naya/widgets/ng_widgets.dart';
import 'package:url_launcher/url_launcher.dart';

class FAQ extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return Navigator.canPop(context);
      },child:Scaffold(
      appBar: ngAppBar( getTranslated(context,'faqs'),context),
      drawer: NGDrawer(),
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(30.0, 10.0, 30.0, 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            ngQuestion(getTranslated(context, "faq_text1")),
            ngAnswer(getTranslated(context, "faq_text2")),
            SizedBox(height: 10,),

            ngQuestion(getTranslated(context, "faq_text3")),
            ngAnswer(getTranslated(context, "faq_text4")),
            SizedBox(height: 10,),

            ngQuestion(getTranslated(context, "faq_text5")),
            ngAnswer(getTranslated(context, "faq_text6")),
            Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                      text: getTranslated(context, "faq_text7"),
                      style: ngTextStyle()
                  ),
                  TextSpan(
                    text: getTranslated(context, "faq_text8"),
                    style: ngHyperLinkTextStyle(),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () async {
                        launch("http://nayagaadi.com/dealers_signup/");
                      },
                  ),
                ],
              ),
            ),
            ngAnswer(" "),
            Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                      text: getTranslated(context, "faq_text9"),
                      style: ngTextStyle()
                  ),
                  TextSpan(
                    text: getTranslated(context, "faq_text10"),
                    style: ngHyperLinkTextStyle(),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () async {
                        launch("http://nayagaadi.com/sales_agent/");
                      },
                  ),
                ],
              ),
            ),
            SizedBox(height: 10,),

            ngQuestion(getTranslated(context, "faq_text11")),
            ngAnswer(getTranslated(context, "faq_text12")),
            SizedBox(height: 10,),

            ngQuestion(getTranslated(context, "faq_text13")),
            ngAnswer(getTranslated(context, "faq_text14")),
            SizedBox(height: 10,),

            ngQuestion(getTranslated(context, "faq_text15")),
            ngAnswer(getTranslated(context, "faq_text16")),
            SizedBox(height: 10,),

            ngQuestion(getTranslated(context, "faq_text17")),
            ngAnswer(getTranslated(context, "faq_text18")),
            SizedBox(height: 10,),

            ngQuestion(getTranslated(context, "faq_text19")),
            ngAnswer(getTranslated(context, "faq_text20")),
            ngAnswer(getTranslated(context, "faq_text21")),
            SizedBox(height: 10,),

            ngQuestion(getTranslated(context, "faq_text22")),
            ngAnswer(getTranslated(context, "faq_text23")),
            ngAnswer(getTranslated(context, "faq_text24")),
            SizedBox(height: 10,),

            ngQuestion(getTranslated(context, "faq_text25")),
            ngAnswer(getTranslated(context, "faq_text26")),
            SizedBox(height: 10,),

            ngQuestion(getTranslated(context, "faq_text27")),
            ngAnswer(getTranslated(context, "faq_text28")),
            SizedBox(height: 10,),

            ngQuestion(getTranslated(context, "faq_text29")),
            ngAnswer(getTranslated(context, "faq_text30")),
            Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                      text: getTranslated(context, "faq_text31"),
                      style: ngTextStyle()
                  ),
                  TextSpan(
                    text: getTranslated(context, "faq_text32"),
                    style: ngBoldTextStyle(),
                  ),
                  TextSpan(
                    text: getTranslated(context, "faq_text33"),
                    style: ngTextStyle(),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10,),

            ngQuestion(getTranslated(context, "faq_text34")),
            ngAnswer(getTranslated(context, "faq_text35")),
            SizedBox(height: 10,),

            ngQuestion(getTranslated(context, "faq_text36")),
            ngAnswer(getTranslated(context, "faq_text37")),
            SizedBox(height: 10,),

            ngQuestion(getTranslated(context, "faq_text38")),
            ngAnswer(getTranslated(context, "faq_text39")),
            ngAnswer(getTranslated(context, "faq_text40")),
            ngAnswer(getTranslated(context, "faq_text41")),
            SizedBox(height: 10,),

            ngQuestion(getTranslated(context, "faq_text42")),
            ngAnswer(getTranslated(context, "faq_text43")),
            ngAnswer(getTranslated(context, "faq_text44")),
            SizedBox(height: 10,),

            ngQuestion(getTranslated(context, "faq_text45")),
            ngAnswer(getTranslated(context, "faq_text46")),
            SizedBox(height: 10,),

            ngQuestion(getTranslated(context, "faq_text47")),
            ngAnswer(getTranslated(context, "faq_text48")),
            ngAnswer(getTranslated(context, "faq_text49")),
            SizedBox(height: 10,),

            ngQuestion(getTranslated(context, "faq_text50")),
            ngAnswer(getTranslated(context, "faq_text51")),
            SizedBox(height: 10,),

            ngQuestion(getTranslated(context, "faq_text52")),
            ngAnswer(getTranslated(context, "faq_text53")),
            ngAnswer(getTranslated(context, "faq_text54")),
            Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                      text: getTranslated(context, "faq_text55"),
                      style: ngTextStyle()
                  ),
                  TextSpan(
                    text: getTranslated(context, "faq_text56"),
                    style: ngBoldTextStyle(),
                  ),
                  TextSpan(
                    text: getTranslated(context, "faq_text57"),
                    style: ngTextStyle(),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10,),

            ngQuestion(getTranslated(context, "faq_text58")),
            ngAnswer(getTranslated(context, "faq_text59")),
            ngAnswer(getTranslated(context, "faq_text60")),
            ngAnswer(getTranslated(context, "faq_text61")),
            ngAnswer(getTranslated(context, "faq_text62")),
            Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                      text: getTranslated(context, "faq_text63"),
                      style: ngTextStyle()
                  ),
                  TextSpan(
                    text: "NayaGaadi@gmail.com",
                    style: ngHyperLinkTextStyle(),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () async {
                        Services().mailUs();
                      },
                  ),
                ],
              ),
            ),
            SizedBox(height: 20.0,),
          ],
        ),
      ),
     ) );
  }
}
