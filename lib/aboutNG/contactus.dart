import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:naya/localization/localizations_constants.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import 'package:naya/widgets/ng_drawer.dart';
import 'package:naya/widgets/ng_widgets.dart';


class Services{
  void callUs(){
    String phoneNumber = '+919900151719';
    launch("tel:$phoneNumber");
  }
  void textUs(){
    String phoneNumber = '+919900151719';
    launch("sms:$phoneNumber");
  }
  void mailUs(){
    String mailId = 'nayagaadi@gmail.com';
    launch("mailto:$mailId");
  }
  void whatsappUs(){
    String whatsappNo = '+919900151719';
    launch("whatsapp://send?phone=$whatsappNo");
  }
}

class ContactUs extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => new _ContactUs();
}

class _ContactUs extends State<ContactUs>{
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return Navigator.canPop(context);
      },child:Scaffold(
      appBar: ngAppBar(getTranslated(context,"con_ng"),context),
      drawer: NGDrawer(),
      body: ListView(
        padding: EdgeInsets.only(left: 40.0, right: 40.0, top: 30.0),
        children: <Widget>[

          // Registered Office

          Text(
            getTranslated(context, "con_off"),
            textAlign: TextAlign.center,
            style: ngSubHeadingTextStyle(),
          ),
          SizedBox(height: 10.0,),
          Text(
            getTranslated(context, "off_add"),
            textAlign: TextAlign.center,
            style: ngTextStyle(),
          ),
          SizedBox(height: 20.0,),

          // Working Hours

          Text(
            getTranslated(context, "work_hours"),
            textAlign: TextAlign.center,
            style: ngSubHeadingTextStyle(),
          ),
          SizedBox(height: 10.0,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                getTranslated(context, "days"),
                textAlign: TextAlign.left,
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 17.0,
                  letterSpacing: 1.0,
                )
              ),

              Text(
                getTranslated(context, "mon_to_fri"),
                style: ngTextStyle(),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                  getTranslated(context, "work_hours"),
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 17.0,
                    letterSpacing: 1.0,
                  )
              ),

              Text(
                getTranslated(context, "open_time"),
                style: ngTextStyle(),
              ),
            ],
          ),
          SizedBox(height: 10.0,),
          Text(
            getTranslated(context, "lmtd_supp"),
            textAlign: TextAlign.center,
            style: ngTextStyle(),
          ),

          // Reach out us

          SizedBox(height: 20.0,),
          Text(
            getTranslated(context, "reach_us"),
            textAlign: TextAlign.center,
            style: ngSubHeadingTextStyle(),
          ),
          SizedBox(height: 10.0,),
          RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              children: [
                TextSpan(
                  text: getTranslated(context, "cnt_para1"),
                  style: ngTextStyle(),
                ),
                TextSpan(
                  style: ngHyperLinkTextStyle(),
                  text: getTranslated(context, "cnt_para2"),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () async {
                      final url = 'https://www.nayagaadi.com';
                      if (await canLaunch(url)) {
                        await launch(
                          url,
                          forceSafariVC: false,
                        );
                      }
                    },
                ),
              ]
            ),
          ),
          SizedBox(height: 20.0,),

          // Communication Buttons

          // call us
          ButtonTheme(
            splashColor: Colors.red[300],
            padding: EdgeInsets.fromLTRB(35.0, 12.0, 35.0, 12.0),
            minWidth: 120,
            buttonColor: Colors.red[700],
            child: new RaisedButton(
              textColor: Colors.white,
              onPressed: (){
                Services().callUs();
              },
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0),),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  new Icon(Icons.phone,color: Colors.white,),
                  new SizedBox(width: 10.0,),
                  new Text(getTranslated(context, "call_us"),
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0,
                      letterSpacing: 1.0,
                    ),
                  )
                ],
              ),
              color: Colors.red[700],
            ),
          ),
          SizedBox(height: 20.0,),

          // whats app us
          ButtonTheme(
            splashColor: Colors.red[300],
            padding: EdgeInsets.fromLTRB(35.0, 12.0, 35.0, 12.0),
            minWidth: 120,
            buttonColor: Colors.red[700],
            child: new RaisedButton(
              textColor: Colors.white,
              onPressed: (){
                Services().whatsappUs();
              },
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0),),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  new Icon(MdiIcons.whatsapp,color: Colors.white,),
                  new SizedBox(width: 10.0,),
                  new Text(getTranslated(context, "whatsapp_us"),
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0,
                      letterSpacing: 1.0,
                    ),
                  )
                ],
              ),
              color: Colors.red[700],
            ),
          ),
          SizedBox(height: 20.0,),

          // text us
          ButtonTheme(
            splashColor: Colors.red[300],
            padding: EdgeInsets.fromLTRB(35.0, 12.0, 35.0, 12.0),
            minWidth: 120,
            buttonColor: Colors.red[700],
            child: new RaisedButton(
              textColor: Colors.white,
              onPressed: (){
                Services().textUs();
              },
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0),),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  new Icon(Icons.sms,color: Colors.white,),
                  new SizedBox(width: 10.0,),
                  new Text(getTranslated(context, "text_us"),
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0,
                      letterSpacing: 1.0,
                    ),
                  )
                ],
              ),
              color: Colors.red[700],
            ),
          ),
          SizedBox(height: 20.0,),

          // email us
          ButtonTheme(
            splashColor: Colors.red[300],
            padding: EdgeInsets.fromLTRB(35.0, 12.0, 35.0, 12.0),
            minWidth: 120,
            buttonColor: Colors.red[700],
            child: new RaisedButton(
              textColor: Colors.white,
              onPressed: (){
                Services().mailUs();
              },
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0),),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  new Icon(Icons.mail,color: Colors.white,),
                  new SizedBox(width: 10.0,),
                  new Text(getTranslated(context, "mail_us"),
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0,
                      letterSpacing: 1.0,
                    ),
                  )
                ],
              ),
              color: Colors.red[700],
            ),
          ),
          SizedBox(height: 20.0,),

          // Disclaimer

          Text(
            getTranslated(context, "cnt_para3"),
            textAlign: TextAlign.center,
            style: ngSubHeadingTextStyle(),
          ),
          SizedBox(height: 10.0,),
          Text(
            getTranslated(context, "cnt_para4"),
            textAlign: TextAlign.center,
            style: ngTextStyle(),
          ),
          SizedBox(height: 30.0,),

          // Copyrights
          Text(
            "@2020 NayaGaadi Online Marketplace Pvt. Ltd. All rights Reserved.",
            textAlign: TextAlign.center,
            style: ngDashBoardTextStyle(),
          ),
          SizedBox(height: 40.0,),
        ],

      ),
    ));
  }
}