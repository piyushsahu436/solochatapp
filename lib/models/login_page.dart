import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'signup.dart';

class login extends StatefulWidget {
  const login({super.key});

  @override
  State<login> createState() => _loginState();
}

class _loginState extends State<login> {

  TextEditingController email=TextEditingController();
  TextEditingController password=TextEditingController();

  signIn()async{
    await FirebaseAuth.instance.signInWithEmailAndPassword(email: email.text, password: password.text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Login")),
      body: Padding(padding: EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextField(
              controller: email,
              decoration: InputDecoration(hintText: 'Enter email'),
            ),
            TextField(
              controller: password,
              decoration: InputDecoration(hintText: 'Enter password'),

            ),
            ElevatedButton(onPressed: (()=>signIn()), child: Text("Login")),
            SizedBox(height: 20,),
            // ElevatedButton(onPressed: (() =>Get.to(signup())), child: Text("SignUp")),
            // SizedBox(height: 20,),


          ],),
      ),);
  }
}