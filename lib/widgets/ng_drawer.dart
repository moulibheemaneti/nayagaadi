import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:naya/aboutNG/visitorpolicy.dart';
import 'package:share/share.dart';
import 'package:naya/authservice.dart';
import 'package:naya/aboutNG/aboutus.dart';
import 'package:naya/aboutNG/dealership.dart';
import 'package:naya/aboutNG/faqs.dart';
import 'package:naya/aboutNG/privacypolicy.dart';
import 'package:naya/aboutNG/terms.dart';
import 'package:naya/Agentprofile/agentdashboard.dart';
import 'package:naya/aboutNG/contactus.dart';
import 'package:naya/widgets/ng_widgets.dart';
import 'package:naya/localization/localizations_constants.dart';
import 'package:naya/notverifieddash.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:naya/loginscreen.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
class NGDrawer extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => new _NGDrawerState();
}

class _NGDrawerState extends State<NGDrawer>{
DatabaseReference ref=FirebaseDatabase.instance.reference();
bool isverified=false;
String link1,uid,refercode,_linkMessage;
 bool isCreatingLink = false;
@override
  void initState(){
    super.initState();
    initDynamicLinks();
      FirebaseAuth.instance.currentUser().then((user) {
        if (user != null) {
          user.getIdToken().then((token) {
            Map<dynamic,dynamic> tokenMap = token.claims;
           var uid=tokenMap['sub'];
            ref.child('VerifiedAgents').orderByChild('UID').equalTo('$uid').once().then((value){
var a =value.value.keys;
for(var i in a){
  print(i);
  refercode=i;
  
setState(() {
   
 });
}
 });
ref.child('NotVerifiedAgents').child('$uid').child('Profile').once().then((DataSnapshot snap){
    if(snap.value!=null){
            var dat=snap.value;
            var a1=dat['Verification'];
            print(a1);
            if(a1=='no'){
}
else if(a1=='yes'){
          print('verified');
          isverified=true;
          setState(() {
            
          });
            }
            }
        else{
          isverified=true;
}});
          });
        }
     });



}
void initDynamicLinks() async {
    final PendingDynamicLinkData data =
        await FirebaseDynamicLinks.instance.getInitialLink();
    final Uri deepLink = data?.link;

    if (deepLink != null) {
      Navigator.pushNamed(context, deepLink.path);
    }

    FirebaseDynamicLinks.instance.onLink(
        onSuccess: (PendingDynamicLinkData dynamicLink) async {
      final Uri deepLink = dynamicLink?.link;

      if (deepLink != null) {
        Navigator.pushNamed(context, deepLink.path);
      }
    }, onError: (OnLinkErrorException e) async {
      print('onLinkError');
      print(e.message);
    });
    _createDynamicLink(true);
  }
  
  Future<void> _createDynamicLink(bool short) async {
    setState(() {
      isCreatingLink = true;
    });
    final DynamicLinkParameters parameters = DynamicLinkParameters(
      uriPrefix: 'https://nayagaadi.page.link',
      link: Uri.parse("https://play.google.com/store/apps/details?id=com.nayagaadi.agentapp"),
      androidParameters: AndroidParameters(
        packageName: 'com.example.naya',
        minimumVersion: 0,
      ),
      dynamicLinkParametersOptions: DynamicLinkParametersOptions(
        shortDynamicLinkPathLength: ShortDynamicLinkPathLength.short,
      ),
      iosParameters: IosParameters(
        bundleId: 'com.google.FirebaseCppDynamicLinksTestApp.dev',
        minimumVersion: '0',
      ),
    );

    Uri url;
    if (short) {
      final ShortDynamicLink shortLink = await parameters.buildShortLink();
      url = shortLink.shortUrl;
    } else {
      url = await parameters.buildUrl();
    }

    if(mounted) {
  
setState(() {
      _linkMessage = url.toString();
      isCreatingLink = false;
    });
    }
  }
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          DrawerHeader(
            child: Center(
              child: Container(
                child: Image.asset("assets/drawericon.png")
              ),
            ),
            
          ),

          // home
          ListTile(
            title: Text(
              getTranslated(context, 'home'),
              style: ngDashBoardTextStyle(),
            ),
            leading: Icon(Icons.home,color: Colors.red[700],),
            onTap: (){
              Navigator.pop(context);

              Navigator.push(context,MaterialPageRoute(builder: (context) => Home()));
            },
          ),

          Divider(
            color: Colors.black,
            height: 1,
          ),

          // dashboard
          ListTile(
            title: Text(
              getTranslated(context,'dashboard'),
              style: ngDashBoardTextStyle(),
            ),
            leading: Icon(Icons.dashboard,color: Colors.red[700],),
            onTap: (){
              if(isverified==true){
              Navigator.pop(context);
              Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => AgentDashBoard()));
              }
              else{
                Navigator.pop(context);
              Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => NotVerified()));
              }
            },
          ),
          Divider(
            color: Colors.black,
            height: 1,
          ),

          // FAQs
          ListTile(
            title: Text(
              getTranslated(context, 'faqs'),
              style: ngDashBoardTextStyle(),
            ),
            leading: Icon(Icons.help,color: Colors.red[700]),
            onTap: (){
              Navigator.pop(context);

              Navigator.push(context,MaterialPageRoute(builder: (context) => FAQ()));
            },
          ),
          Divider(
            color: Colors.black,
            height: 1,
          ),

          // Policies
          ExpansionTile(
            title: Text(
              getTranslated(context, 'policies'),
              style: ngDashBoardTextStyle(),
            ),

            leading: Icon(MdiIcons.fileDocumentOutline,color: Colors.red[700]),
            children: <Widget>[
              // Privacy Policy
              ListTile(
                title: Text(
    
    
                  getTranslated(context,'privacy_policy'),
                  style: ngDashBoardTextStyle(),
                ),

                onTap: (){
                  Navigator.pop(context);

                  Navigator.push(context,MaterialPageRoute(builder: (context) => PrivacyPolicy()));
                },
              ),

              // Visitor Policy
              ListTile(
                title: Text(
                  getTranslated(context, 'visitor_policy'),
                  style: ngDashBoardTextStyle(),
                ),
                onTap: (){
                  
                  Navigator.pop(context);

                  Navigator.push(context,MaterialPageRoute(builder: (context) => VisitorPolicy()));
                },
              ),

              // Terms and conditions
              ListTile(
                title: Text(
                  getTranslated(context, 'terms_and_conditions'),
                  style: ngDashBoardTextStyle(),
                ),
                onTap: (){
                  Navigator.pop(context);

                  Navigator.push(context,MaterialPageRoute(builder: (context) => TermsAndConditions()));
                },
              ),

            ],
          ),

          Divider(
            color: Colors.black,
            height: 1,
          ),

          // Dealer ship
          ListTile(
            title: Text(
              getTranslated(context,'dealer'),
              style: ngDashBoardTextStyle(),
            ),
            leading: Icon(MdiIcons.handshake,color: Colors.red[700]),
            onTap: (){
              Navigator.pop(context);

              Navigator.push(context,MaterialPageRoute(builder: (context) => NGDealership()));
            },
          ),
          Divider(
            color: Colors.black,
            height: 1,
          ),

          // contact ng
          ListTile(
            title: Text(
              getTranslated(context,'contact'),
              style: ngDashBoardTextStyle(),
            ),
            leading: Icon(Icons.contacts,color: Colors.red[700]),
            onTap: (){
              Navigator.pop(context);

              Navigator.push(context,MaterialPageRoute(builder: (context) => ContactUs()));

            },
          ),
          Divider(
            color: Colors.black,
            height: 1,
          ),

          // share app
          ListTile(
            title: Text(getTranslated(context,'share'),style: ngDashBoardTextStyle(),),
            leading: Icon(Icons.share,color: Colors.red[700],),
            onTap: (){
              if(_linkMessage!=null){
              Share.share("Hey.! I'm using the Nayagadi app and earning money by just sitting t home.I also suggest you to try this app.And don't forget to use my referal code:-$refercode\n $_linkMessage");
              }
          
              Navigator.pop(context);
              // Navigator.push(context,MaterialPageRoute(builder: (context) => New()));
            
            },
          ),
          Divider(
            color: Colors.black,
            height: 1,
          ),

          // log out
          ListTile(
            title: Text(getTranslated(context, 'logout'),style: ngDashBoardTextStyle(),),
            leading: Icon(Icons.power_settings_new,color: Colors.red[700],),
            onTap: (){
              //Navigator.pop(context);
              AuthService().signOut();
              Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => LoginScreen()));

               //Share.share("Do you want to earn money at your own comfort? Then this is the right place to join then. Do check this app www.nayagaadi.com");
            },
          ),
          Divider(
            color: Colors.black,
            height: 1,
          ),

        ],
      ),
    );
  }
}