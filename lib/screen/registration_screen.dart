import 'package:flashchat/components/buttomWidget.dart';
import 'package:flashchat/constants.dart';
import 'package:flashchat/screen/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class RegistrationScreen extends StatefulWidget {
  static String id = 'Registration';
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  bool setSpinner = false;
  final _auth = FirebaseAuth.instance;
  String? email;
  String? password;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: setSpinner,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Flexible(
                child: Hero(
                  tag: 'logo',
                  child: Container(
                    height: 200.0,
                    child: Image.asset('images/logo.png'),
                  ),
                ),
              ),
              SizedBox(
                height: 48.0,
              ),
              TextField(
                textAlign: TextAlign.center,
                keyboardType: TextInputType.emailAddress,
                onChanged: (value) {
                  //Do something with the user input.
                  email = value;
                },
                decoration:
                    kTextFieldDecoration.copyWith(hintText: 'Enter your email'),
              ),
              SizedBox(
                height: 8.0,
              ),
              TextField(
                textAlign: TextAlign.center,
                obscureText: true,
                onChanged: (value) {
                  //Do something with the user input.
                  password = value;
                },
                decoration: kTextFieldDecoration.copyWith(
                    hintText: 'Enter your password'),
              ),
              SizedBox(
                height: 24.0,
              ),
              ButtonWidget(
                Colors.blueAccent,
                () async {
                  setState(() {
                    setSpinner = true;
                  });
                  // print('$email $password');
                  try {
                    final newUser = await _auth.createUserWithEmailAndPassword(
                        email: email!, password: password!);
                    // ignore: unnecessary_null_comparison
                    if (newUser != null) {
                      Navigator.pushNamed(context, ChatScreen.id);
                    }
                    setState(() {
                      setSpinner = false;
                    });
                  } catch (e) {
                    print(e);
                  }
                },
                'Register',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
