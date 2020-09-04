import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:naya/localization/localizations_constants.dart';

import 'package:naya/aboutNG/contactus.dart';
import 'package:naya/widgets/ng_drawer.dart';
import 'package:naya/widgets/ng_widgets.dart';

class PrivacyPolicy extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return Navigator.canPop(context);
      },child:Scaffold(
      appBar: ngAppBar(getTranslated(context, 'priv_pol'),context),
      drawer: NGDrawer(),
      body: Padding(
        padding: EdgeInsets.fromLTRB(30.0, 10.0, 20.0, 20.0),
        child: ListView(
          children: <Widget>[
            Opacity(
              opacity: 0.5,
              child: Text(
                getTranslated(context, "pp_text1"),
                style: ngTextStyle(),
              ),
            ),

            SizedBox(height: 10.0,),
            Text(
                getTranslated(context, "pp_text1"),
              style: ngTextStyle(),
            ),
            Text(
              getTranslated(context, "pp_text2"),
              style: ngTextStyle(),
            ),
            Text(
              getTranslated(context, "pp_text3"),
              style: ngTextStyle(),
            ),

            Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: getTranslated(context, "pp_text4"),
                    style: ngBoldTextStyle()
                  ),
                  TextSpan(
                    text: getTranslated(context, "pp_text5"),
                    style: ngTextStyle()
                  ),
                ]
              )
            ),
            SizedBox(height: 10.0,),

            Text(
              getTranslated(context, "pp_text6"),
              style: ngTextStyle(),
            ),

            Text(
              getTranslated(context, "pp_text7"),
              style: ngTextStyle(),
            ),

            Text(
              getTranslated(context, "pp_text8"),
              style: ngSubHeadingTextStyle(),
            ),

            Text(
              getTranslated(context, "pp_text9"),
              style: ngTextStyle(),
            ),

            Text(
              getTranslated(context, "pp_text10"),
              style: ngTextStyle(),
            ),

            Text(
              getTranslated(context, "pp_text11"),
              style: ngTextStyle(),
            ),

            Text(
              getTranslated(context, "pp_text12"),
              style: ngTextStyle(),
            ),

            Text(
              getTranslated(context, "pp_text13"),
              style: ngTextStyle(),
            ),

            Text(
              getTranslated(context, "pp_text14"),
              style: ngTextStyle(),
            ),

            Text(
              getTranslated(context, "pp_text15"),
              style: ngTextStyle(),
            ),

            // subheading 2
            Text(
              getTranslated(context, "pp_text16"),
              style: ngSubHeadingTextStyle(),
            ),

            Text(
              getTranslated(context, "pp_text17"),
              style: ngTextStyle(),
            ),

            Text(
              getTranslated(context, "pp_text18"),
              style: ngTextStyle(),
            ),

            // subheading 3
            Text(
              getTranslated(context, "pp_text19"),
              style: ngSubHeadingTextStyle(),
            ),

            Text(
              getTranslated(context, "pp_text20"),
              style: ngTextStyle(),
            ),

            Text(
              getTranslated(context, "pp_text21"),
              style: ngTextStyle(),
            ),

            Text(
              getTranslated(context, "pp_text22"),
              style: ngTextStyle(),
            ),

            // subheading 4
            Text(
              getTranslated(context, "pp_text23"),
              style: ngSubHeadingTextStyle(),
            ),

            Text(
              getTranslated(context, "pp_text24"),
              style: ngTextStyle(),
            ),

            // subheading 5
            Text(
              getTranslated(context, "pp_text25"),
              style: ngSubHeadingTextStyle(),
            ),
            Text(
              getTranslated(context, "pp_text26"),
              style: ngTextStyle(),
            ),

            // subheading 6
            Text(
              getTranslated(context, "pp_text27"),
              style: ngSubHeadingTextStyle(),
            ),

            Text.rich(
                TextSpan(
                    children: [
                      TextSpan(
                          text: getTranslated(context, "pp_text28"),
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
                      TextSpan(
                          text: getTranslated(context, "pp_text29"),
                          style: ngTextStyle()
                      ),
                    ]
                )
            ),
            Text(getTranslated(context, "pp_text30")),

            // subheading 7
            Text(
              getTranslated(context, "pp_text31"),
              style: ngSubHeadingTextStyle(),
            ),
            Text(
              getTranslated(context, "pp_text32"),
              style: ngTextStyle(),
            ),

            // subheading 8
            Text(
              getTranslated(context, "pp_text33"),
              style: ngSubHeadingTextStyle(),
            ),
            Text(
              getTranslated(context, "pp_text34"),
              style: ngTextStyle(),
            ),

            // subheading 9
            Text(
              getTranslated(context, "pp_text35"),
              style: ngSubHeadingTextStyle(),
            ),
            Text(
              getTranslated(context, "pp_text36"),
              style: ngTextStyle(),
            ),

            // Grievance office

            Text(
              getTranslated(context, "pp_text37"),
              style: ngTextStyle(),
            ),

            Opacity(
              opacity: 0.5,
              child: Text(
                getTranslated(context, "pp_text38"),
                style: ngTextStyle(),
              ),
            ),

            // Time
            Opacity(
              opacity: 0.5,
              child: Text.rich(
                  TextSpan(
                      children: [
                        TextSpan(
                            text: getTranslated(context, "pp_text39"),
                            style: ngBoldTextStyle()
                        ),
                        TextSpan(
                          text: getTranslated(context, "pp_text40"),
                          style: ngTextStyle(),
                        ),
                      ],
                  ),
              ),
            ),

            // email
            Opacity(
              opacity: 0.5,
              child: Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                          text: getTranslated(context, "pp_text41"),
                          style: ngBoldTextStyle()
                      ),
                      TextSpan(
                        text: "NayaGaadi@gmail.com",
                        style: ngTextStyle(),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () async {
                          Services().mailUs();
                          },
                      ),
                    ],
                  ),
              ),
            ),

            SizedBox(height: 30,),
          ],
        ),
      ),
    ));
  }
}