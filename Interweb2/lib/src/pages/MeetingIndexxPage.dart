import 'dart:async';

import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';



import './Create_Meeting.dart';
import 'package:nice_button/nice_button.dart';
import './JoinMeeting.dart';


class meetingIndexPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => Index2State();
}

class Index2State extends State<meetingIndexPage> {
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
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
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
            padding: const EdgeInsets.symmetric(horizontal: 70),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[



                NiceButton(
                  onPressed: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => JoinMeeting()),
                    );
                  },
                  width: 255,
                  radius: 52.0,
                  text: 'Join Room',
                  gradientColors: [secondColor, firstColor],
                  textColor: Colors.white,
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10),
                ),
                NiceButton(

                  onPressed: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => CreateRoomPage()),
                    );
                  },
                  width: 255,
                  radius: 52.0,
                  text: 'Create Room',
                  gradientColors: [secondColor, firstColor],
                  textColor: Colors.white,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

//

}
