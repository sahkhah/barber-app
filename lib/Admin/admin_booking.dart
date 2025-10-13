import 'package:barber_booking_app/services/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AdminBookingPage extends StatefulWidget {
  const AdminBookingPage({super.key});

  @override
  State<AdminBookingPage> createState() => _AdminBookingPageState();
}

class _AdminBookingPageState extends State<AdminBookingPage> {
  Stream? bookingStream;

  getOnTheLoad() async {
    bookingStream = await DatabaseMethods().getBookings();
    setState(() {});
  }

  @override
  void initState() {
    getOnTheLoad();
    super.initState();
  }

  Widget allBookings() {
    return StreamBuilder(
      stream: bookingStream,
      builder: (context, snapshot) {
        return snapshot.hasData
            ? ListView.builder(
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              itemCount: snapshot.data.docs.length,
              itemBuilder: (context, index) {
                DocumentSnapshot ds = snapshot.data.docs[index];
                return Material(
                  elevation: 10.0,
                  child: Container(
                    //margin: const EdgeInsets.only(bottom: 30.0),
                    padding: const EdgeInsets.all(10.0),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.0),
                      gradient: LinearGradient(
                        colors: [
                          Color(0xffb91635),
                          Color(0xff621d3c),
                          Color(0xff311937),
                        ],
                      ),
                    ),
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.topLeft,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(60),
                            child: Image.asset(
                              'images/boy.jpg',
                              height: 80,
                              width: 80,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        const SizedBox(height: 5.0),
                        Text(
                          'Name : ${ds['Name']}',
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 5.0),
                        Text(
                          'Service : ${ds['Service']}',
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 5.0),
                        Text(
                          'Date : ${ds['Date']}',
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 5.0),
                        Text(
                          'Time : ${ds['Time']}',
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 10.0),
                        GestureDetector(
                          onTap: () async {
                            await DatabaseMethods().deleteBooking(ds.id);
                          },
                          child: Container(
                            padding: EdgeInsets.all(10.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              color: Color(0xffFE8F33),
                            ),
                            child: Text(
                              'Done',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontSize: 20.0,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10.0),
                      ],
                    ),
                  ),
                );
                
              },
            )
            : Container(
              child: Text('No Bookeings yet'),
            );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.only(top: 60.0, left: 20.0, right: 20.0),
        child: Column(
          children: [
            Center(
              child: Text(
                'All Bookings',
                style: TextStyle(
                  fontSize: 25.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
            const SizedBox(height: 10.0),
            allBookings(),
          ],
        ),
      ),
    );
  }
}
