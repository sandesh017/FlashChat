import 'package:flashchat/screen/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:flashchat/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_core/firebase_core.dart';// old version

import 'package:cloud_firestore/cloud_firestore.dart';

final _fireStore = FirebaseFirestore.instance;
User? loggedInUser;

class ChatScreen extends StatefulWidget {
  static String id = 'chat';
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final messageTextCOntroller = TextEditingController();
  String? messageText;

  final _auth = FirebaseAuth.instance;
  //FirebaseUser loggedInUser; firbaseUser is changed into User.

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  void getCurrentUser() async {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        loggedInUser = user;
        // print(loggedInUser!.email);
      }
    } catch (e) {
      print(e);
    }
  }

  // void getMessage() async {
  //   final message = await _fireStore.collection('message').get();
  //   for (var msg in message.documents) {
  //     print(msg.data);
  //   }
  // }
//For Concept of STREAM
  // void messageStream() async {
  //   await for (var snapshot in _fireStore.collection('message').snapshots()) {
  //     for (var msg in snapshot.docs) {
  //       print(msg.data());
  //     }
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: null,
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.logout),
              onPressed: () {
                //Implement logout functionality
                _auth.signOut();
                Navigator.popUntil(
                    context, ModalRoute.withName(WelcomeScreen.id));
                // messageStream();
              }),
        ],
        title: Text('⚡️Chat'),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            MessageStream(),
            Container(
              decoration: kMessageContainerDecoration,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller: messageTextCOntroller,
                      onChanged: (value) {
                        //Do something with the user input.
                        messageText = value;
                      },
                      decoration: kMessageTextFieldDecoration,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      messageTextCOntroller.clear();
                      //Implement send functionality.
                      _fireStore.collection('message').add({
                        'text': messageText,
                        'email': loggedInUser!.email,
                      });
                    },
                    child: Text(
                      'Send',
                      style: kSendButtonTextStyle,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MessageStream extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      //snapshot.data is dynamic and we can use QuerySnapshot properties
      stream: _fireStore.collection('message').snapshots(),
      builder: (BuildContext context, snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.lightBlueAccent,
            ),
          );
        }
        final message = snapshot.data!.docs.reversed;
        List<MessageBubble> messageBubble = [];
        for (var msg in message) {
          final msgText = msg['text'];
          final msgSender = msg['email'];
          final currentUser = loggedInUser!.email;

          
          final msgBubble = MessageBubble(msgText, msgSender, currentUser==msgSender);// return bool value
          messageBubble.add(msgBubble);
          // print(messageWidget);
        }
        return Expanded(
          child: ListView(
            reverse: true,
            padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
            children: messageBubble,
          ),
        );
      },
    );
  }
}

class MessageBubble extends StatelessWidget {
  MessageBubble(this.text, this.sender, this.isMe);
  final String sender;
  final String text;
  final bool isMe;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Text(
            sender,
            style: TextStyle(
              fontSize: 12.0,
              color: Colors.black54,
            ),
          ),
          Material(
            borderRadius: isMe ? BorderRadius.only(
                topLeft: Radius.circular(30.0),
                bottomLeft: Radius.circular(30.0),
                bottomRight: Radius.circular(30.0)) : BorderRadius.only(bottomLeft: Radius.circular(30.0), bottomRight: Radius.circular(30.0),topRight: Radius.circular(30.0)),
            elevation: 5.0,
            color: isMe ? Colors.lightBlueAccent : Colors.white,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
              child: Text(
                '$text',
                style: TextStyle(
                  color: isMe ? Colors.white : Colors.black54,
                   fontSize: 15.0),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
