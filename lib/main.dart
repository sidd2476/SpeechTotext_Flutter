import 'package:flutter/material.dart';
import 'package:speech_recognition/speech_recognition.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: VoiceHome(),
    );
  }
}

class VoiceHome extends StatefulWidget {
  @override
  _VoiceHomeState createState() => _VoiceHomeState();
}

class _VoiceHomeState extends State<VoiceHome> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  SpeechRecognition _speechRecognition;
  bool _isAvailable = false;
  bool _isListening = false;

  String resultText = "";
  //TextEditingController _controller = TextEditingController(text: );
  @override
  void initState() {
    super.initState();
    initSpeechRecognizer();
    
  }
  
      

  

  void initSpeechRecognizer() {
    _speechRecognition = SpeechRecognition();

    _speechRecognition.setAvailabilityHandler(
          (bool result) => setState(() => _isAvailable = result),
    );

    _speechRecognition.setRecognitionStartedHandler(
          () => setState(() => _isListening = true),
        
    );

    _speechRecognition.setRecognitionResultHandler(
          (String speech) => setState(() => resultText = speech),
    );

    _speechRecognition.setRecognitionCompleteHandler(
          () => setState(() => _isListening = false),
    );

    _speechRecognition.activate().then(
          (result) => setState(() => _isAvailable = result),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
              Align(
                alignment: Alignment.topCenter,
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(6.0),
                  ),
                  padding: EdgeInsets.symmetric(
                    vertical: 8.0,
                    horizontal: 12.0,
                  ),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                                            child: TextField(
                          controller: TextEditingController(text: resultText),
                          //resultText,
                          style: TextStyle(fontSize: 24.0),
                          decoration: InputDecoration(
                            
                          ),
                          
                        ),
                      ),
                       Expanded(
                                              child: IconButton(icon: Icon(Icons.mic),
                                              
                            onPressed: (){
                              if(_isAvailable || !_isListening)
                                    showDialog(
                                      context: context,
                                      builder:(context){
                                        Future.delayed(Duration(seconds: 5),(){
                                          Navigator.of(context).pop(true);
                                        });
                                      
                                      return Align(
                                        alignment: Alignment.bottomCenter,
                                
                                child: AnimatedContainer(
                                  
                                  
                                  height: MediaQuery.of(context).size.height/4,
                                  width: MediaQuery.of(context).size.width * 0.8,
                                  
                                  decoration: new BoxDecoration(
                                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                  color: Color(0xFFFE4E74),
                                  ),
                                  //width: MediaQuery.of(context).size.width,
                                  
                                  
                                  duration: Duration(seconds: 10),
                                  child: Column(
                                    children: <Widget>[
                                      
                                      Container(
                  margin: EdgeInsets.all(20),
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      border: Border.all(width: 2, color: Colors.white)),
                  child: Icon(
                    Icons.mic,
                    color: Colors.white,
                  ),
                ),
                                    

                                      Text('Listening...',style: TextStyle(color: Colors.black,fontSize: 20),),
                                      
                                    ]
                                  ),
                                ),
                                      );
                                      });
                              // Scaffold.of(context).showBottomSheet((context) => Container(
                              //   child: new Text(';dgdrgtd'),
                              // ));
                                _speechRecognition
                                    .listen(locale: "en_US")
                                    .then((result) => print('$result'))
                                    ;
      
                            
    
                            
               
                              
                            },),
                       )
                    ],
                  ),
                ),
              ),
            
          ],
        ),
      ),
    );
  }
}
