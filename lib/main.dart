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
      theme: ThemeData.dark().copyWith(
        textTheme: TextTheme(
          bodyText1: TextStyle(color: Colors.black54),
        ),
      ),
      initialRoute: 'welcome',
      routes: {
        'welcome':(context) =>WelcomeScreen(),
        'login':(context) =>LoginScreen(),
        'chat':(context) =>ChatScreen(),
        'registration':(context) =>RegistrationScreen(),
      },
    );
  }
}
