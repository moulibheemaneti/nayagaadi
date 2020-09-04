import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:naya/widgets/ng_widgets.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:naya/Dashboard.dart';
import 'authservice.dart';

class LoginScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => new _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>{

  final formKey = new GlobalKey<FormState>();

  String phoneNumber;
  String verificationId;
  String otpCode;

  bool codeSent = false;
  bool isLoading= false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red[100],
      body: Form(
        key: formKey,
        child: Padding(
          padding: EdgeInsets.only(left: 50.0, right: 50.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Container(
                alignment: Alignment.center,
                child: Text(
                  "Welcome to",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.red[700],
                    fontSize: 30.0,
                    fontWeight: FontWeight.bold,
                    // color: Colors.red[700],
                  ),
                ),
              ),

              Container(
                alignment: Alignment.center,
                child: Text(
                  "NAYAGAADI",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.red[700],
                    fontSize: 40.0,
                    fontWeight: FontWeight.bold,
                    //color: Colors.red[700],
                  ),
                ),
              ),
              SizedBox(height: 50.0,),

              TextFormField(
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
                onChanged: (value){
                  setState(() {
                    this.phoneNumber = "+91"+value;
                  });
                },
              ),

              SizedBox(height: 40.0,),

              codeSent ? TextFormField(
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  hoverColor: Colors.white,
                  fillColor: Colors.white,
                  focusColor: Colors.white,
                  labelText: 'Enter OTP',
                  hintText: 'Enter OTP',
                  labelStyle: TextStyle(
                    fontSize: 20.0,
                  ),
                ),
                onChanged: (value){
                  setState(() {
                    this.otpCode = value;
                  });
                },
              ) :Container(
                alignment: Alignment.center,
                child: Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: "By clicking verify button, I here by agree to the ",
                        style: ngTextStyle(),
                      ),
                      TextSpan(
                        text: "Terms & Conditions",
                        style: ngHyperLinkTextStyle(),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () async {
                            launch("https://www.nayagaadi.com/");
                          },
                      ),
                      TextSpan(
                          text: " of NayaGaadi"
                      )
                    ],
                  ),
                ),
              ),

              SizedBox(height: 20.0,),

              ButtonTheme(
                splashColor: Colors.red[300],
                padding: EdgeInsets.fromLTRB(35.0, 12.0, 35.0, 12.0),
                minWidth: 120,
                buttonColor: Colors.red[700],
                child: new RaisedButton(
                  elevation: 10.0,
                  textColor: Colors.white,
                  onPressed: (){
                    codeSent ? checkAuthuser(otpCode, verificationId):verifyPhone(phoneNumber);
                  },
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0),),

                  child: codeSent ? new Text("Verify",style: ngButtonTextStyle(),)
                      :new Text("Send OTP",style: ngButtonTextStyle(),),
                  color: Colors.red[700],
                ),
              ),
              SizedBox(height: 20.0,),
              codeSent? FlatButton(
                onPressed: (){
                  verifyPhone(phoneNumber);
                },
                child: Text(
                  "Resend OTP",
                  style: TextStyle(
                    fontSize: 20.0,
                  ),
                ),
              ):Container(),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> verifyPhone(phoneNo) async {
    final PhoneVerificationCompleted verified = (AuthCredential authResult) {
      AuthService().signIn(authResult);
    };

    final PhoneVerificationFailed verificationfailed =
        (AuthException authException) {
          
      print('${authException.message}');
    };

    final PhoneCodeSent smsSent = (String verId, [int forceResend]) {
      this.verificationId = verId;
      setState(() {
        this.codeSent = true;
      });
    };

    final PhoneCodeAutoRetrievalTimeout autoTimeout = (String verId) {
      this.verificationId = verId;
    };

    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: phoneNo,
        timeout: const Duration(seconds: 10),
        verificationCompleted: verified,
        verificationFailed: verificationfailed,
        codeSent: smsSent,
        codeAutoRetrievalTimeout: autoTimeout
    );
  }
checkAuthuser(smsCode,verId){
FirebaseAuth.instance.currentUser().then((user){
if(user!=null){
  Navigator.pushReplacement(context,MaterialPageRoute(builder:(context) =>Dashboard()));
}
else{
  AuthService().signInWithOTP(smsCode, verId);
}
});
}
}
