import 'package:flutter/material.dart';
import 'screen/chat_screen.dart';
import 'screen/login_screen.dart';
import 'screen/registration_screen.dart';
import 'screen/welcome_screen.dart';

void main() {
  runApp(FlashChat());
}

class FlashChat extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // theme: ThemeData.dark().copyWith(
      //   textTheme: TextTheme(
      //     bodyText1: TextStyle(color: Colors.black54),
      //   ),
      //),
      initialRoute: WelcomeScreen.id,
      routes: {
        WelcomeScreen.id:(context) =>WelcomeScreen(),
        LoginScreen.id:(context) =>LoginScreen(),
        ChatScreen.id:(context) =>ChatScreen(),
        RegistrationScreen.id:(context) =>RegistrationScreen(),
      },
    );
  }
}
