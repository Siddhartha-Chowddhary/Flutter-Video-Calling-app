
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import './Login.dart';
import 'package:nice_button/nice_button.dart';

class SignUpPage extends StatefulWidget{

  @override
  State<StatefulWidget> createState() => new SignUpPageState();
}

class SignUpPageState extends State<SignUpPage> {

  final FormKey = new GlobalKey<FormState>();
  final SignUpPageController = TextEditingController();

  String Email;
  String Password;
//  String Username;
  var firstColor = Color(0xFF8EE9F6), secondColor = Color(0xFF083F61);

  Future<void>  SignUp() async {

    final LoginForm  = FormKey.currentState;
    if (LoginForm.validate()){
      LoginForm.save();

      try{
        AuthResult result =  await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: Email, password: Password
        );
        FirebaseUser user = result.user;

        await user.sendEmailVerification();

        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => LoginPage()),
        );

        showDialog(
          context: context,
          builder: (context)=>AlertDialog(
            title: Text("Please check your Mailbox for Email verification"),
            actions: <Widget>[
              FlatButton(
                child:Text("Ok",
                  style: TextStyle(
                    fontSize: 20,
                  ),

                ),
                onPressed: ()=> Navigator.pop(context, false),
              )
            ],
          ),

        );

      }
      catch(e){
        print(e.message);
        String ERROR_MSG = e.message;
        print(ERROR_MSG);
        return showDialog(
          context: context,
          builder: (context)=>AlertDialog(
            title: Text(ERROR_MSG),
            actions: <Widget>[
              FlatButton(
                child:Text("Ok",
                  style: TextStyle(
                    fontSize: 20,
                  ),

                ),
                onPressed: ()=> Navigator.pop(context, false),
              )
            ],
          ),

        );
      }
    }
  }
  /// if channel textField is validated to have error
  bool SignUpvalidateError = false;
  @override
  Widget build(BuildContext context){
    return new Scaffold(
        appBar: new AppBar(
          backgroundColor: Color(0xFF0780FF),

          title: Text('Sign Up page'),
          centerTitle: true,
        ),
        body:
        new Form(
          key : FormKey,
          child:
              Container(

                decoration: BoxDecoration(


                    gradient: new LinearGradient(colors: [const Color(0xFF1B2531),const Color(0xFF01466F)],
                      begin: FractionalOffset.topLeft,
                      end: FractionalOffset.bottomRight,
                      stops: [0.0,1.0],
                      tileMode: TileMode.clamp,

                    )
//
                ),
          child:Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              new Flexible(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: new TextFormField(
                    style: new TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                        icon: Icon(Icons.person),
                        hintText: 'Email',
                        hintStyle: new TextStyle(
                          color: Colors.lightBlueAccent,
                        )
                    ),
                    validator:(value){
                      if (value.isEmpty){
                        return ('Please Enter a valid Email');
                      }
                    },
                    onSaved: (value) => Email = value,
                  ),
                ),
              ),
//

              new Flexible(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: new TextFormField(
                    style: new TextStyle(color: Colors.white),

                    decoration: InputDecoration(
                        icon: Icon(Icons.ac_unit),
                        hintText: 'Password',
                        hintStyle: new TextStyle(
                          color: Colors.lightBlueAccent,
                        )
                    ),
                    obscureText: true,
                    validator:(value){
                      if (value.isEmpty){
                        return ('Please Enter a Password');
                      }
                    },
                    onSaved: (value) => Password = value,
                  ),
                ),
              ),
              NiceButton(
                onPressed: SignUp,
                width: 255,
                radius: 52.0,
                text: 'Sign Up',
                gradientColors: [secondColor, firstColor],
                textColor: Colors.white,
              ),

              FlatButton(
                onPressed:    (){
    Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => LoginPage()),
    );
    },

                child: Text('Already have an account ?',
                  style: TextStyle(fontSize: 20),
                ),
                textColor: Colors.lightBlueAccent,

              )


            ],
          ),

        )
    ),
    );
  }
}
