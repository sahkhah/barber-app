import 'package:barber_booking_app/pages/homepage.dart';
import 'package:barber_booking_app/pages/login.dart';
import 'package:barber_booking_app/services/database.dart';
import 'package:barber_booking_app/services/shared_pref.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:random_string/random_string.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  String? name, email, password;
  String imageUrl =
      'https://firebasestorage.googleapis.com/v0/b/barberapp-ebcc.com/0/icon1.png?alt=media&token=0fad24a5-a01b-4d67-b4a0-676fbc75a34a';
  bool obscure = true;

  TextEditingController nameController = TextEditingController();
  TextEditingController mailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  registration() async {
    if (password != null && email != null && name != null) {
      try {
        UserCredential credential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email!, password: password!);

        String id = randomAlphaNumeric(10);

        await SharedPrefHelper().saveUserId(id);
        await SharedPrefHelper().saveUsername(nameController.text);
        await SharedPrefHelper().saveUserEmail(mailController.text);
        await SharedPrefHelper().saveUserImage(imageUrl);

        Map<String, dynamic> userInfo = {
          'name': name,
          'email': email,
          'id': id,
          'image': imageUrl,
        };

        await DatabaseMethods().addUser(userInfo, id);

        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Registered Successfully')));
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Homepage()),
        );
      } on FirebaseAuthException catch (e) {
        switch (e.code) {
          case 'weak-password':
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text('Passwotd is too weak')));
            break;
          case 'email-already-in-use':
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text('Account already exists')));
            break;
          default:
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(e.code)));
        }
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
            child: Text(
              'Create your\nAccount',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 30.0,
                color: Colors.white,
              ),
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
                      'Name',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 25.0,
                        color: Color(0xffb91635),
                      ),
                    ),
                    TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your name';
                        }
                        return null;
                      },
                      controller: nameController,
                      decoration: InputDecoration(
                        hintText: 'Name',
                        prefixIcon: Icon(Icons.person_outlined),
                      ),
                    ),
                    const SizedBox(height: 30.0),
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
                    const SizedBox(height: 30.0),
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
                            obscure = !(obscure);
                            //setState(){};
                          },
                          child: Icon(Icons.remove_red_eye_outlined),
                        ),
                      ),
                    ),
                    const SizedBox(height: 50.0),
                    GestureDetector(
                      onTap: () {
                        if (_formKey.currentState!.validate()) {
                          setState(() {
                            email = mailController.text;
                            password = passwordController.text;
                            name = nameController.text;
                          });
                          registration();
                        }
                      },
                      child: Container(
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
                          child: Text(
                            'SIGN UP',
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
                        'Already have an account?',
                        style: TextStyle(
                          color: Color(0xff621d3c),
                          fontWeight: FontWeight.w500,
                          fontSize: 15.0,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => LoginPage()),
                        );
                      },
                      child: Align(
                        alignment: Alignment.bottomRight,
                        child: Text(
                          'Sign In',
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
