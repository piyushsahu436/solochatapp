


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:solocaht/components/chat_bubble.dart';
import 'package:solocaht/components/my_textfield.dart';

import '../services/auth/auth_service.dart';
import '../services/chat/chat_service.dart';

class ChatPage extends StatefulWidget {
  final String   receiverEmail;
  final String receiverID;

  ChatPage({super.key, required this.receiverEmail, required this.receiverID});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  // text controller
  final TextEditingController _messageController = TextEditingController();

  // chat and auth services
  final ChatService _chatServices = ChatService();
  final AuthService _authService = AuthService();
// for textfield focus
  FocusNode myFocusNode=FocusNode();
  @override
  void initState() {
    super.initState();
    // add listener to focus node
    myFocusNode.addListener(() {
      if(myFocusNode.hasFocus){
        // cause a delay so that the keyboard has time to show up
        // then the amount of remaining space will be calculated,
        // then scroll down
        Future.delayed(Duration(milliseconds: 500),
              () => scrollDown,);
      }
    });

    // wait a bit for listview to be built
    Future.delayed(Duration(milliseconds: 500),
          () =>scrollDown() ,);
  }
  @override
  void dispose() {
    myFocusNode.dispose();
    _messageController.dispose();
    super.dispose();
  }
// scroll controller
  final ScrollController _scrollController =ScrollController();
  void scrollDown(){
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      duration: Duration(seconds: 1),
      curve:Curves.fastOutSlowIn,);
  }

// send message
  void sendMessage() async {
    // if there is something inside the textfield
    if (_messageController.text.isNotEmpty) {
      // send the message
      await _chatServices.sendMessage(widget.receiverID , _messageController.text);
      //clear text controller
      _messageController.clear();
    }
    scrollDown();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.receiverEmail)),
      body: Column(
        children: [
          //display all messages
          Expanded(child: _buildMessageList()),

          // user input
          _buildUserInput(),
        ],
      ),
    );
  }

  // build message list
  Widget _buildMessageList() {
    String senderID = _authService.getCurrentUser()!.uid;
    return StreamBuilder(
        stream: _chatServices.getMessage(widget.receiverID, senderID),
        builder: (context, snapshot) {
          // if error occur
          if (snapshot.hasError) {
            return Text("error");
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Text("Loading.....");
          }
          else if(snapshot.hasData){
            return ListView(
              controller: _scrollController,
              children: snapshot.data!.docs
                  .map((doc) => _buildMessageItem(doc))
                  .toList(),
            );
          }
          return Text('');
        }
    );
  }

  // build message item
  Widget _buildMessageItem(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
// is current user
    bool isCurrentUser =data['senderID']== _authService.getCurrentUser()!.uid;

// align message to the right if sender is the current user, otherwise left
    var alignment=isCurrentUser? Alignment.centerRight:Alignment.centerLeft;
    return Container(
        alignment: alignment,
        child: Column(
          crossAxisAlignment: isCurrentUser? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            // Text(data["message"]),
            ChatBubble(message: data["message"],
                isCurrentUser: isCurrentUser)
          ],
        ));
  }

  // build message input
  Widget _buildUserInput() {
    return Padding(
      padding: const EdgeInsets.only(bottom:50.0),
      child: Row(
        children: [
          // textfield should be take up the most of the space
          Expanded(
              child: MyTextField(
                  hintText: "Type a message ",
                  obscureText: false,
                  focusNode: myFocusNode,
                  controller: _messageController)),
          // send button
          Container(
            decoration:BoxDecoration(
                color: Colors.green,
                shape: BoxShape.circle
            ) ,
            margin: EdgeInsets.only(right: 25),
            child: IconButton(onPressed: sendMessage,
              icon: Icon(
                Icons.arrow_upward,
                color: Colors.white,),
            ),
          )
        ],
      ),
    );
  }
}