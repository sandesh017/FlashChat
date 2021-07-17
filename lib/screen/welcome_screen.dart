import 'package:flashchat/screen/login_screen.dart';
import 'package:flashchat/screen/registration_screen.dart';
import 'package:flutter/material.dart';

class WelcomeScreen extends StatefulWidget {
  static String id = 'welcome';
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  AnimationController? controller;
  Animation? animation;

  @override
  void initState() {
    controller = AnimationController(
      duration: Duration(seconds: 1),
      vsync: this,
      // upperBound: 100.0, since Curved Animation cannot exceed 1. Its range is 0 to 1.
    );
    // animation = CurvedAnimation(parent: controller!, curve: Curves.easeInCirc);
    // controller!.forward();
    // animation!.addStatusListener((status) {

    //     if (status == AnimationStatus.completed) {
    //       controller!.reverse(from: 1.0);
    //     } else if (status == AnimationStatus.dismissed) {
    //       controller!.forward();
    //     }
    // });
    animation = ColorTween(begin: Colors.lightBlueAccent, end: Colors.cyanAccent)
        .animate(controller!);
    controller!.forward();
    controller!.addListener(() {
      setState(() {
        // print(controller!.value);
        print(animation!.value);
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    controller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: animation!.value,
      // Colors.red.withOpacity(controller!.value),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              children: <Widget>[
                Hero(
                  tag: 'logo',
                  child: Container(
                    child: Image.asset('images/logo.png'),
                    height: 60.0,
                  ),
                ),
                Text(
                  // '${controller!.value.toInt()}%', for the loading screen shown in percentages
                  'Flash Chat',
                  style: TextStyle(
                    fontSize: 45.0,
                    fontWeight: FontWeight.w900,
                    color: Colors.blueGrey,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 48.0,
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 16.0),
              child: Material(
                elevation: 5.0,
                color: Colors.lightBlueAccent,
                borderRadius: BorderRadius.circular(30.0),
                child: MaterialButton(
                  onPressed: () {
                    //Go to login screen.
                    Navigator.pushNamed(context, LoginScreen.id);
                  },
                  minWidth: 200.0,
                  height: 42.0,
                  child: Text(
                    'Log In',
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 16.0),
              child: Material(
                color: Colors.blueAccent,
                borderRadius: BorderRadius.circular(30.0),
                elevation: 5.0,
                child: MaterialButton(
                  onPressed: () {
                    //Go to registration screen.
                    Navigator.pushNamed(context, RegistrationScreen.id);
                  },
                  minWidth: 200.0,
                  height: 42.0,
                  child: Text(
                    'Register',
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
