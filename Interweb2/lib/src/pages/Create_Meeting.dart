import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'Login.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:Interweb/src/Services/Database.dart';
class CreateRoomPage extends StatefulWidget{

  @override
  State<StatefulWidget> createState() => new CreateRoomPageState();
}

class CreateRoomPageState extends State<CreateRoomPage> {

  final FormKey = new GlobalKey<FormState>();
  final SignUpPageController = TextEditingController();

  String MeetingID;
//  String Username;
 /// if channel textField is validated to have error
bool SignUpvalidateError = false;

  Future<void>  CreateRoom() async {
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    print(user.uid);
    await DataBaseServices(UID: user.uid).updateUserData(MeetingID);

  }



@override
  Widget build(BuildContext context){
    return new Scaffold(
        appBar: new AppBar(
          title: Text('Create Meeting Room'),
          centerTitle: true,
        ),
        body:
        new Form(
          key : FormKey,
          child:
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              new Flexible(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: new TextFormField(

                    decoration: InputDecoration(
                      hintText: 'MeetingID',
                    ),
                    validator:(value){
                      if (value.isEmpty){
                        return ('Please Enter a valid MeetingID');
                      }
                    },
                    onSaved: (value) => MeetingID = value
                  ),
                ),
              ),
//


              RaisedButton(
                onPressed:() {
                  print(MeetingID);
                  CreateRoom();
                },
                child: Text('Create'),
                color: Colors.red,
                textColor: Colors.white,
              )
            ],
          ),

        )
    );
  }
}
