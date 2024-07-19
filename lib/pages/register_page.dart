




import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:solocaht/components/my_button.dart';
import 'package:solocaht/components/my_textfield.dart';
import 'package:solocaht/services/auth/auth_service.dart';

class RegisterPage extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _confirmController = TextEditingController();
  final TextEditingController _pwController = TextEditingController();

  final void Function()? onTap;

  RegisterPage({super.key, required this.onTap});

  void register(BuildContext context) {
    //get the auth service
    final _auth = AuthService();
    //password match then create the user
    // ignore: unrelated_type_equality_checks
    if (_pwController.text == _confirmController.text) {
      try {
        _auth.signUpWithEmailAndPassword(
            _emailController.text, _pwController.text);
      } catch (e) {
        showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text(e.toString()),
            ));
      }
    } else {
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text("Password don't match"),
          ));
    }
    // password don't match show error to the user
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.message,
              size: 60,
              color: Theme.of(context).colorScheme.primary,
            ),
            SizedBox(height: 50),
            Text(
              "Welcome back, you have been missed",
              style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
                fontSize: 16,
              ),
            ),
            SizedBox(height: 20),
            MyTextField(
              hintText: "Email",
              obscureText: true,
              controller: _emailController,
            ),
            MyTextField(
              hintText: "Password",
              obscureText: true,
              controller: _pwController,
            ),
            MyTextField(
              hintText: "Confirm Password",
              obscureText: true,
              controller: _confirmController,
            ),
            SizedBox(height: 20),
            MyButton(
              text: "Register",
              onTap: () => register(context),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Already have an account?"),
                GestureDetector(
                  onTap: onTap,
                  child: Text(
                    "Login now",
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
