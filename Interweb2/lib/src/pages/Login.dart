import 'package:Interweb/src/pages/Singup.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import './index.dart';
import './Singup.dart';
import './MeetingIndexxPage.dart';
import 'package:nice_button/nice_button.dart';

class LoginPage extends StatefulWidget{

  @override
  State<StatefulWidget> createState() => new LoginPageState();
}

class LoginPageState extends State<LoginPage> {

  final LoginFormFormKey = new GlobalKey<FormState>();
  final LogInPageController = TextEditingController();

  String LoginFormEmail;
  String LoginFormPassword;
//  String LoginFormUsername;
  var firstColor = Color(0xFF8EE9F6), secondColor = Color(0xFF083F61);

  Future<void>  SignIn() async {

    final LoginForm  = LoginFormFormKey.currentState;
    if (LoginForm.validate()){
      LoginForm.save();
      try{
        AuthResult result =  await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: LoginFormEmail, password: LoginFormPassword
        );

        FirebaseUser Loginuser = result.user;
        if (Loginuser.isEmailVerified) {
          print('User Loged In');
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) =>  meetingIndexPage()),
          );
        }
        else if (!Loginuser.isEmailVerified){
          return showDialog(
            context: context,
            builder: (context)=>AlertDialog(
              title: Text("Please verify your email before login"),
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
      catch(e){
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
  bool LoginvalidateError = false;
  @override
  Widget build(BuildContext context){
    return new Scaffold(

        appBar: new AppBar(
          backgroundColor: Color(0xFF0780FF),

          title: Text('Login page'),
          centerTitle: true,
        ),
        body:
        new Form(

          key : LoginFormFormKey,
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
          child: Column(

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
                    validator: (value){
                      if (value.isEmpty){
                        return ('Please Enter a valid Email');
                      }
                    },
                    onSaved: (value) => LoginFormEmail = value,
                  ),
                ),
              ),
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
                    validator: (value){
                      if (value.isEmpty){
                        return ('Please Enter a Password');
                      }
                    },
                    onSaved: (value) => LoginFormPassword = value,

                  ),
                ),
              ),

              NiceButton(
                onPressed: SignIn,
                width: 255,
                radius: 52.0,
                text: 'Sign In',
                gradientColors: [secondColor, firstColor],
                textColor: Colors.white,
              ),

              FlatButton(
                onPressed:    (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SignUpPage()),
                  );
                },

                child: Text('Dont have an account ?',
                style: TextStyle(fontSize: 20),
                ),
                textColor: Colors.lightBlueAccent,

              )


            ],
          ),




        )


)



    );
  }
}
