import 'dart:async';

import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import './call.dart';
import './Login.dart';
import './Singup.dart';
import 'package:nice_button/nice_button.dart';

class JoinMeeting extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => JoinMeetingState();
}

class JoinMeetingState extends State<JoinMeeting> {
  /// create a channelController to retrieve text value
  final _channelController = TextEditingController();
  var firstColor = Color(0xFF8EE9F6), secondColor = Color(0xFF083F61);

  /// if channel textField is validated to have error
  bool _validateError = false;

  @override
  void dispose() {
    // dispose input controller
    _channelController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF0780FF),
        title: Text('NetraDamini'),
      ),
      body: Center(
        child: Container(
          decoration: BoxDecoration(
              gradient: new LinearGradient(colors: [const Color(0xFF1B2531),const Color(0xFF01466F)],
                begin: FractionalOffset.topLeft,
                end: FractionalOffset.bottomRight,
                stops: [0.0,1.0],
                tileMode: TileMode.clamp,

              )
//
//            image: DecorationImage(
//              image: AssetImage("assets/bg.jpg"),
//
//              fit: BoxFit.cover,
//            ),
//
          ),
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Expanded(
                      child: TextField(
                        controller: _channelController,
                        style: new TextStyle(color: Colors.white),

                        decoration: InputDecoration(
                          icon: Icon(Icons.room),
                          hintText: 'Room name',
                          hintStyle: new TextStyle(
                            color: Colors.lightBlueAccent,
                          ),
                          errorText:
                          _validateError ? 'Channel name is mandatory' : null,
                          border: UnderlineInputBorder(
                            borderSide: BorderSide(width: 1),
                          ),
                        ),
                      ))
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: NiceButton(
                        onPressed: onJoin,
                        width: 255,
                        radius: 52.0,
                        text: 'Join Room',
                        gradientColors: [secondColor, firstColor],
                        textColor: Colors.white,
                      ),
                    ),

                  ],
                ),
              ),


            ],
          ),
        ),
      ),
    );
  }

  Future<void> onJoin() async {
    // update input validation
    setState(() {
      _channelController.text.isEmpty
          ? _validateError = true
          : _validateError = false;
    });
    if (_channelController.text.isNotEmpty) {
      // await for camera and mic permissions before pushing video page
      await _handleCameraAndMic();
      // push video page with given channel name
      await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CallPage(
            channelName: _channelController.text,
          ),
        ),
      );
    }
  }

  Future<void> _handleCameraAndMic() async {
    await PermissionHandler().requestPermissions(
      [PermissionGroup.camera, PermissionGroup.microphone],
    );
  }
}
