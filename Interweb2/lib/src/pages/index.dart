import 'dart:async';

import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import './call.dart';
import './Login.dart';
import './Singup.dart';
import 'package:nice_button/nice_button.dart';

class IndexPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => IndexState();
}

class IndexState extends State<IndexPage> {
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
          padding: const EdgeInsets.symmetric(horizontal: 70),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[



              NiceButton(
                onPressed: (){
                          Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => LoginPage()),
                          );
                        },
                width: 255,
                radius: 52.0,
                text: 'Sign In',
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
                          MaterialPageRoute(builder: (context) => SignUpPage()),
                        );
                      },
                width: 255,
                radius: 52.0,
                      text: 'Sign Up',
                gradientColors: [secondColor, firstColor],
                      textColor: Colors.white,
                    ),
            ],
          ),
        ),
      ),
    );
  }


}
