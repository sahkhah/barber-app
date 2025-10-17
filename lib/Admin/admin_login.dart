// ignore_for_file: use_build_context_synchronously

import 'package:barber_booking_app/Admin/admin_booking.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AdminLogin extends StatefulWidget {
  const AdminLogin({super.key});

  @override
  State<AdminLogin> createState() => _AdminLoginState();
}

class _AdminLoginState extends State<AdminLogin> {
  TextEditingController userNameController = TextEditingController();
  TextEditingController passWordController = TextEditingController();

  bool obscure = true;
  bool loading = false;

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
              'Admin\nPanel',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 30.0,
                color: Colors.white,
              ),
            ),
          ),
          Container(
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Username',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 25.0,
                      color: Color(0xffb91635),
                    ),
                  ),
                  TextFormField(
                    controller: userNameController,
                    decoration: InputDecoration(
                      hintText: 'username',
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
                    controller: passWordController,
                    obscureText: obscure,
                    decoration: InputDecoration(
                      hintText: 'Password',
                      prefixIcon: Icon(Icons.password_outlined),
                      suffixIcon: IconButton(
                        icon: Icon(
                          obscure ? Icons.visibility_off : Icons.visibility,
                        ),
                        onPressed: () {
                          setState(() {
                            obscure = !obscure;
                          });
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 50.0),
                  GestureDetector(
                    onTap: () async {
                      print('clicked!');

                      setState(() {
                        loading = true;
                      });

                      await loginAdmin();
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
                        child:
                            loading
                                ? Center(
                                  child: const CircularProgressIndicator(
                                    color: Colors.white,
                                  ),
                                )
                                : Text(
                                  'LOGIN',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 20.0,
                                  ),
                                ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  loginAdmin() async {
    await FirebaseFirestore.instance.collection('Admin').get().then((snapshot) {
      print('first password is ${snapshot.docs[0].data()['password']}');
      for (var result in snapshot.docs) {
        print('id is ${result.data()['id']}');
        print('password  is ${result.data()['passowrd']}');
        if (result.data()['id'] != userNameController.text.trim()) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(' Incorrect Username')));
          setState(() {
            loading = false;
          });
        } else if (result.data()['password'] !=
            passWordController.text.trim()) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(' Incorrect password')));
          setState(() {
            loading = false;
          });
        } else {
          setState(() {
            loading = false;
          });
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AdminBookingPage()),
          );
        }
      }
    });
  }
}
