import 'dart:async';
import 'dart:io' as io;
import 'package:audioplayers/audioplayers.dart';
import 'package:file/file.dart';
import 'package:file/local.dart';
import 'package:flutter/material.dart';
import 'package:flutter_audio_recorder/flutter_audio_recorder.dart';
import 'package:path_provider/path_provider.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:naya/localization/localizations_constants.dart';
import 'package:naya/Agentprofile/agentdashboard.dart';
import 'package:naya/widgets/ng_widgets.dart';
import 'package:naya/widgets/ng_drawer.dart';
class RecorderExample extends StatefulWidget {
  final LocalFileSystem localFileSystem;
RecorderExample({localFileSystem})
      : this.localFileSystem = localFileSystem ?? LocalFileSystem();
@override
  State<StatefulWidget> createState() => new RecorderExampleState();
}
class RecorderExampleState extends State<RecorderExample> {
  DatabaseReference ref = FirebaseDatabase.instance.reference();
  File audiofile;
  io.File audiodevice;
  int count;
  FlutterAudioRecorder _recorder;
  Recording _current;
  RecordingStatus _currentStatus = RecordingStatus.Unset;
  List<String> attachments = [];
  bool isHTML = false;
  String uid1,id,mail;
  @override
  void initState() {
    super.initState();
   _init();
    FirebaseAuth.instance.currentUser().then((user) {
var uid = user.uid;
print(uid);
setState(() {
  uid1=uid;
});
ref.once().then((value) {
var da=value.value;
mail=da['mail'];
setState(() {
  
});
});
//obtaning the details of the user
ref.child('VerifiedAgents').orderByChild('UID').equalTo('$uid').once().then((value){
var a=value.value.keys;
for(var i in a){
setState(() {
  id=i;
});
}
});
});
  }

String subjectController =  'Audio enquiry from';
String  bodyController = 'Mail body.';

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  Future<void> send() async {
    final Email email = Email(
      body: bodyController,
      subject: subjectController,
      recipients: [mail],
      attachmentPaths: attachments,
      isHTML: isHTML,
    );

    String platformResponse;

    try {
      await FlutterEmailSender.send(email);
      platformResponse = 'success';
    } catch (error) {
      platformResponse = error.toString();
    }
if (!mounted) return;
if(platformResponse=='success'){
  ref.child('VerifiedAgents').orderByChild('UID').equalTo('$uid1').once().then((value){
var a=value.value.keys;
for(var i in a){
setState(() {
  id=i;
});
 if(value.value!=null){
     var key=value.value.keys;
     var data1 = value.value;
     for(var j in key){
      count=data1[j]['audioenquires'];
      setState(() {
    });
    }
}
//updating the count
ref.child('VerifiedAgents').child('$i').update({
"audioenquires":count+1,
}).then((value){
Navigator.of(context).pushReplacement(
  new MaterialPageRoute(builder: (context) =>new AgentDashBoard()));
});
}
});

}
_scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text(platformResponse),
    ));
  }
@override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar:ngAppBar(getTranslated(context,'enq'), context),
      drawer: NGDrawer(),
      body:SingleChildScrollView(
      child:Container(
        padding: new EdgeInsets.all(30.0),
        child: new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              
          Text(
            getTranslated(context, 'guidelines'),
            style: ngSubHeadingTextStyle(),
          ),
          SizedBox(height: 10,),
          Text(
            getTranslated(context, 'guide_matter'),
            style: ngTextStyle(),
          ),
          SizedBox(height: 10,),
          Text(
          getTranslated(context, 'step1'),
            style: ngTextStyle(),
          ),
          SizedBox(height: 10,),
          Text(
            getTranslated(context, 'step2'),
            style: ngTextStyle(),
          ),
          SizedBox(height: 10,),
          Text(
            getTranslated(context, 'step3'),
            style: ngTextStyle(),
          ),
          SizedBox(height: 10,),
          Text(
            getTranslated(context, 'step4'),
            style: ngTextStyle(),
          ),
          SizedBox(height: 10,),
          Text(
            getTranslated(context, 'step5'),
            style: ngTextStyle(),
          ),
          SizedBox(height: 10,),
          ngProfileField("Note :-"),
          SizedBox(height: 10,),
          Text(
            getTranslated(context, 'warn'),
            style: ngTextStyle(),
          ),
          SizedBox(height: 20.0),
  new Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: new RaisedButton(
                      onPressed: () {
                        switch (_currentStatus) {
                          case RecordingStatus.Initialized:
                            {
                              _start();
                              break;
                            }
                          case RecordingStatus.Recording:
                            {
                              _pause();
                              break;
                            }
                          case RecordingStatus.Paused:
                            {
                              _resume();
                              break;
                            }
                          case RecordingStatus.Stopped:
                            {
                              _init();
                              break;
                            }
                          default:
                            break;
                        }
                      },
                      child: _buildText(_currentStatus),
                      color: Colors.red[700],
                    ),
                  ),
                  new RaisedButton(
                    onPressed:
                        _currentStatus != RecordingStatus.Unset ? _stop : null,
                    child:
                        new Text(getTranslated(context,'stop'), style: TextStyle(color: Colors.white)),
                    color: Colors.red[700],
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  new RaisedButton(
                    onPressed: onPlayAudio,
                    child:
                        new Text(getTranslated(context, 'play'), style: TextStyle(color: Colors.white)),
                    color: Colors.red[700],
                  ),],),
                  Row(
                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
               
                    children:<Widget>[
                      new SizedBox(width:5.0),
                  new RaisedButton(
                    onPressed:(){
                      upload();
                    },
                    child:
                        new Text(getTranslated(context, 'upload'),style: TextStyle(color: Colors.white)),
                    color: Colors.red[700],
                  ), 
                new RaisedButton(
                    onPressed:(){
                      uploadfromdevice();
                    },
                    child:
                        new Text(getTranslated(context, 'upload_device'), style: TextStyle(color: Colors.white)),
                    color: Colors.red[700],
                  ),]), 
            //new Text("File path of the record: ${_current?.path}"),
            ]),
      ),
    ));
  }
 _init() async {
    try {
      if (await FlutterAudioRecorder.hasPermissions) {
        String customPath = '/flutter_audio_recorder_';
        io.Directory appDocDirectory;
        if (io.Platform.isIOS) {
          appDocDirectory = await getApplicationDocumentsDirectory();
        } else {
          appDocDirectory = await getExternalStorageDirectory();
        }
        customPath = appDocDirectory.path +
            customPath +
            DateTime.now().millisecondsSinceEpoch.toString();
        _recorder =
            FlutterAudioRecorder(customPath, audioFormat: AudioFormat.AAC);
await _recorder.initialized;
                var current = await _recorder.current(channel: 0);
        print(current);
        setState(() {
          _current = current;
          _currentStatus = current.status;
          print(_currentStatus);
        });
      } else {
        Scaffold.of(context).showSnackBar(
            new SnackBar(content: new Text("You must accept permissions")));
      }
    } catch (e) {
      print(e);
    }
  }
_start() async {
    try {
      await _recorder.start();
      var recording = await _recorder.current(channel: 0);
      setState(() {
        _current = recording;
      });
const tick = const Duration(milliseconds: 50);
      new Timer.periodic(tick, (Timer t) async {
        if (_currentStatus == RecordingStatus.Stopped) {
          t.cancel();
        }
var current = await _recorder.current(channel: 0);
        // print(current.status);
        setState(() {
          _current = current;
          _currentStatus = _current.status;
        });
      });
    } catch (e) {
      print(e);
    }
  }
 _resume() async {
    await _recorder.resume();
    setState(() {});
  }
_pause() async {
    await _recorder.pause();
    setState(() {});
  }
_stop() async {
    var result = await _recorder.stop();
    print("Stop recording: ${result.path}");
    print("Stop recording: ${result.duration}");
    File file = widget.localFileSystem.file(result.path);
    print("File length: ${await file.length()}");
    setState(() {
      _current = result;
      _currentStatus = _current.status;
    });
    return getaudiourl(file);
  }
Widget _buildText(RecordingStatus status) {
    var text = "";
    switch (_currentStatus) {
      case RecordingStatus.Initialized:
        {
          text = getTranslated(context, 'start');
          break;
        }
      case RecordingStatus.Recording:
        {
          text = 'Pause';
          break;
        }
      case RecordingStatus.Paused:
        {
          text = 'Resume';
          break;
        }
      case RecordingStatus.Stopped:
        {
          text = 'Record again';
          break;
        }
      default:
        break;
    }
    return Text(text, style: TextStyle(color: Colors.white));
  }
void onPlayAudio() async {
    AudioPlayer audioPlayer = AudioPlayer();
    await audioPlayer.play(_current.path, isLocal: true);
  }
  getaudiourl(var p)async{
     setState((){
      audiofile = p;
    });
  }
  upload()async{
    if(audiofile==null){
      _showDialog();
    }
    else{
    setState(() {
      attachments.add(audiofile.path);
      subjectController=subjectController+id.toString();
      bodyController='This an audioenquiry from'+id.toString();
    });
    send();
    }
  }
  uploadfromdevice()async{
var audioFiledevice = await FilePicker.getFile(type: FileType.custom,allowedExtensions: ['mp3']);
setState(() {
  audiodevice=audioFiledevice;
  attachments.add(audiodevice.path);
  subjectController=subjectController+id.toString();
      bodyController='This an audioenquiry from'+id.toString();
});
send();
  }
void _showDialog() {
showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Text(getTranslated(context, 'alert')),
          content: new Text(getTranslated(context, 'audiotext')),
          shape: RoundedRectangleBorder(borderRadius: 
    BorderRadius.all(Radius.circular(15))),
          actions: <Widget>[
            ButtonTheme(
            minWidth: 120,
            child:new RaisedButton(
               onPressed: () {
            Navigator.pop(context);
            },
          shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0)),
        child: new Text(getTranslated(context, 'ok'),style: TextStyle(fontSize:18,),),
          color: Colors.redAccent,)),
           ],
        );
      },
    );
  }
}