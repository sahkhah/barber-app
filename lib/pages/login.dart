// ignore_for_file: use_build_context_synchronously

import 'package:barber_booking_app/Admin/admin_login.dart';
import 'package:barber_booking_app/pages/forget_password.dart';
import 'package:barber_booking_app/pages/homepage.dart';
import 'package:barber_booking_app/pages/signup.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
    LoginPage();

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String? email, password;
  bool obscure = true;

  TextEditingController mailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  userLogin() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email!,
        password: password!,
      );
      Navigator.push(
        // ignore: use_build_context_synchronously
        context,
        MaterialPageRoute(
          builder: (context) {
            return Homepage();
          },
        ),
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('No user found for that email')));
      } else if (e.code == 'wrong-password') {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Wrong password provided by user')),
        );
      } else {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(e.code)));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            padding: const EdgeInsets.only(top: 60.0, left: 20.0),
            height: MediaQuery.of(context).size.height / 2,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xffb91635),
                  Color(0xff621d3c),
                  Color(0xff311937),
                ],
              ),
            ),
            child: Row(
              children: [
                Text(
                  'Hello\nSignIn!',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30.0,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(width: 50.0),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return AdminLogin();
                        },
                      ),
                    );
                  },
                  child: Text(
                    'Admin Dashboard',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 30.0,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.only(
                top: 30.0,
                left: 30.0,
                right: 30.0,
                bottom: 25.0,
              ),
              margin: EdgeInsets.only(
                top: MediaQuery.of(context).size.height / 4,
              ),
              height: MediaQuery.of(context).size.height,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40.0),
                  topRight: Radius.circular(40.0),
                ),
              ),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Gmail',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 25.0,
                        color: Color(0xffb91635),
                      ),
                    ),
                    TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your gmail';
                        }
                        return null;
                      },
                      controller: mailController,
                      decoration: InputDecoration(
                        hintText: 'Gmail',
                        prefixIcon: Icon(Icons.mail_outlined),
                      ),
                    ),
                    const SizedBox(height: 40.0),
                    Text(
                      'Password',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 25.0,
                        color: Color(0xffb91635),
                      ),
                    ),
                    TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter a password';
                        }
                        return null;
                      },
                      controller: passwordController,
                      obscureText: obscure,
                      decoration: InputDecoration(
                        hintText: 'Password',
                        prefixIcon: Icon(Icons.password_outlined),
                        suffixIcon: GestureDetector(
                          onTap: () {
                            setState() {
                              obscure = !(obscure);
                            }
                          },
                          child: Icon(Icons.remove_red_eye_outlined),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ForgotPasswordPage(),
                              ),
                            );
                          },
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                // ignore: use_build_context_synchronously
                                context,
                                MaterialPageRoute(
                                  builder: (context) {
                                    return ForgotPasswordPage();
                                  },
                                ),
                              );
                            },
                            child: Text(
                              'Forget Password?',
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 18.0,
                                color: Color(0xff311937),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 70.0),
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 15.0),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30.0),
                        gradient: LinearGradient(
                          colors: [
                            Color(0xffb91635),
                            Color(0xff621d3c),
                            Color(0xff311937),
                          ],
                        ),
                      ),
                      child: Center(
                        child: GestureDetector(
                          onTap: () {
                            CircularProgressIndicator();
                            if (_formKey.currentState!.validate()) {
                              setState(() {
                                email = mailController.text;
                                password = passwordController.text;
                              });
                              userLogin();
                            }
                          },
                          child: Text(
                            'SIGN IN',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                              fontSize: 20.0,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10.0),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: Text(
                        'Don\'t have an account?',
                        style: TextStyle(
                          color: Color(0xff621d3c),
                          fontWeight: FontWeight.w500,
                          fontSize: 15.0,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap:
                          () => Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => SignUpPage(),
                            ),
                          ),
                      child: Align(
                        alignment: Alignment.bottomRight,
                        child: Text(
                          'Sign Up',
                          style: TextStyle(
                            color: Color(0xff621d3c),
                            fontWeight: FontWeight.bold,
                            fontSize: 20.0,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
