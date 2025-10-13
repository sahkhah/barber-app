import 'package:barber_booking_app/pages/booking.dart';
import 'package:barber_booking_app/services/shared_pref.dart';
import 'package:flutter/material.dart';

class Homepage extends StatefulWidget {
  Homepage({super.key});
  //String service;
  //Homepage({required this.service});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  String? name, image;

  getDataFromShared() async {
    name = await SharedPrefHelper().getUserName();
    image = await SharedPrefHelper().getUserImage();
    setState(() {});
  }

  getDataOnTheLoad() async {
    getDataFromShared();
    setState(() {});
  }

  @override
  void initState() {
    getDataOnTheLoad();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff2b1315),
      body: Container(
        margin: const EdgeInsets.only(top: 40, left: 20.0, right: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Hello',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                        fontSize: 24.0,
                      ),
                    ),
                     Text(
                      name ?? "User",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 24.0,
                      ),
                    ),
                  ],
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.asset(
                   'images/boy.jpg' ,
                    height: 60,
                    width: 60,
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            ),
            SizedBox(height: 15.0),
            Divider(color: Colors.white38),
            const Text(
              'Services',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontSize: 24.0,
              ),
            ),
            SizedBox(height: 20),
            Row(
              children: [
                Flexible(
                  fit: FlexFit.tight,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return Booking(service: 'Classic Shaving');
                          },
                        ),
                      );
                    },
                    child: Container(
                      height: 150,
                      decoration: BoxDecoration(
                        color: Color(0xffe29452),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            'images/shaving.png',
                            height: 80,
                            width: 80,
                            fit: BoxFit.cover,
                          ),
                          const SizedBox(height: 10.0),
                          const Text(
                            'Classic Shaving',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: 20.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 20.0),
                Flexible(
                  fit: FlexFit.tight,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return Booking(service: 'Hair Washing');
                          },
                        ),
                      );
                    },
                    child: Container(
                      height: 150,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Color(0xffe29452),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            'images/hair.png',
                            height: 80,
                            width: 80,
                            fit: BoxFit.cover,
                          ),
                          const SizedBox(height: 10.0),
                          const Text(
                            'Hair Washing',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: 20.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Row(
              children: [
                Flexible(
                  fit: FlexFit.tight,
                  child: GestureDetector(
                     onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return Booking(service: 'Hair Cutting');
                          },
                        ),
                      );
                    },
                    child: Container(
                      height: 150,
                      decoration: BoxDecoration(
                        color: Color(0xffe29452),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            'images/cutting.png',
                            height: 80,
                            width: 80,
                            fit: BoxFit.cover,
                          ),
                          const SizedBox(height: 10.0),
                          const Text(
                            'Hair Cutting',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: 18.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 20.0),
                Flexible(
                  fit: FlexFit.tight,
                  child: GestureDetector(
                     onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return Booking(service: 'Beard Trimming');
                          },
                        ),
                      );
                    },
                    child: Container(
                      height: 150,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Color(0xffe29452),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            'images/beard.png',
                            height: 80,
                            width: 80,
                            fit: BoxFit.cover,
                          ),
                          const SizedBox(height: 10.0),
                          const Text(
                            'Beard Trimming',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: 18.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Flexible(
                  fit: FlexFit.tight,
                  child: GestureDetector(
                     onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return Booking(service: 'Facials');
                          },
                        ),
                      );
                    },
                    child: Container(
                      height: 150,
                      decoration: BoxDecoration(
                        color: Color(0xffe29452),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            'images/facials.png',
                            height: 80,
                            width: 80,
                            fit: BoxFit.cover,
                          ),
                          const SizedBox(height: 10.0),
                          const Text(
                            'Facials',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: 18.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 20.0),
                Flexible(
                  fit: FlexFit.tight,
                  child: GestureDetector(
                     onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return Booking(service: 'Kids Haircutting');
                          },
                        ),
                      );
                    },
                    child: Container(
                      height: 150,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Color(0xffe29452),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            'images/kids.png',
                            height: 80,
                            width: 80,
                            fit: BoxFit.cover,
                          ),
                          const SizedBox(height: 10.0),
                          const Text(
                            'Kids Haircutting',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: 20.0,
                            ),
                          ),
                        ],
                      ),
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
