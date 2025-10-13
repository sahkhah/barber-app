// ignore_for_file: use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  String? email;
  TextEditingController controller = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  resetPassword() async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email!);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Password reset email has been sent')),
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('No user found for that email')));
      }else{
         ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(e.code)));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        //padding: const EdgeInsets.only(left: 20.0, right: 20.0),
        child: Column(
          children: [
            const SizedBox(height: 70.0),
            Container(
              alignment: Alignment.topCenter,
              child: Text(
                'Password Recovery',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 25.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 20.0),
            Text(
              'Enter your email',
              style: TextStyle(
                color: Colors.white,
                fontSize: 25.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20.0),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20.0),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.white70, width: 2.0),
                borderRadius: BorderRadius.circular(20),
              ),
              child: TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter email';
                  }
                  return null;
                },
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  prefixIcon: Icon(
                    Icons.mail_outline,
                    color: Colors.white,
                    size: 30.0,
                  ),
                  hintText: 'Email',
                  hintStyle: TextStyle(color: Colors.white, fontSize: 18.0),
                ),
              ),
            ),
            const SizedBox(height: 50.0),
            GestureDetector(
              onTap: () async {
                if (_formKey.currentState!.validate()) {
                  setState(() {
                    email = controller.text;
                  });
                  resetPassword();
                }
              },
              child: Container(
                padding: EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: Color(0xffFE8F33),
                ),
                child: Text(
                  'Send email',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 20.0,
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
