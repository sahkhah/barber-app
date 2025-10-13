import 'package:barber_booking_app/services/database.dart';
import 'package:barber_booking_app/services/shared_pref.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class Booking extends StatefulWidget {
  final String service;
  const Booking({super.key, required this.service});

  //const Booking({super.key});

  @override
  State<Booking> createState() => _BookingState();
}

class _BookingState extends State<Booking> {
  String? name, image, email;

  getDataFromShared() async {
    name = await SharedPrefHelper().getUserName();
    image = await SharedPrefHelper().getUserImage();
    email = await SharedPrefHelper().getUserEmail();
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

  DateTime _selectedDate = DateTime.now();

  TimeOfDay _selectedTime = TimeOfDay.now();

  //  SELECT DATE
  Future<void> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2024),
      lastDate: DateTime(2026),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  // SELECT TIME
  Future<void> selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _selectedTime,
    );
    if (picked != null && picked != _selectedTime) {
      setState(() {
        _selectedTime = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff2b1615),
      body: Container(
        margin: const EdgeInsets.only(top: 50.0, left: 15.0, right: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Icon(
                Icons.arrow_back_rounded,
                color: Colors.white,
                size: 30.0,
              ),
            ),
            const SizedBox(height: 20.0),
            Text(
              'Let the \njourney begin.',
              style: TextStyle(
                fontSize: 25.0,
                fontWeight: FontWeight.w500,
                color: Colors.white70,
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Image.asset('images/discount.png', fit: BoxFit.cover),
            ),
            SizedBox(height: 20.0),
            Text(
              widget.service,
              style: TextStyle(
                fontSize: 25.0,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 20.0),
            Container(
              padding: const EdgeInsets.only(top: 5.0, bottom: 20),
              decoration: BoxDecoration(
                color: Color(0xffb4817e),
                borderRadius: BorderRadius.circular(20.0),
              ),
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: [
                  Text(
                    'Set a Date',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 10.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          selectDate(context);
                        },
                        child: Icon(
                          Icons.calendar_month,
                          color: Colors.white,
                          size: 30.0,
                        ),
                      ),
                      const SizedBox(width: 20.0),
                      Text(
                        '${_selectedDate.day}/${_selectedDate.month}/${_selectedDate.year}',
                        style: TextStyle(
                          fontSize: 30.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20.0),
            Container(
              padding: const EdgeInsets.only(top: 5.0, bottom: 20),
              decoration: BoxDecoration(
                color: Color(0xffb4817e),
                borderRadius: BorderRadius.circular(20.0),
              ),
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: [
                  Text(
                    'Set a Time',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 10.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          selectTime(context);
                        },
                        child: Icon(
                          Icons.alarm,
                          color: Colors.white,
                          size: 30.0,
                        ),
                      ),
                      const SizedBox(width: 20.0),
                      Text(
                        _selectedTime.format(context),
                        style: TextStyle(
                          fontSize: 30.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20.0),
            GestureDetector(
              onTap: () async {
                Map<String, dynamic> userBookingMap = {
                  'Service': widget.service,
                  'Date':
                      '${_selectedDate.day}/${_selectedDate.month}/${_selectedDate.year}'
                          .toString(),
                  'Time': _selectedTime.format(context).toString(),
                  'Name': name,
                  'image': image,
                  'Email': email,
                };
                await DatabaseMethods().addUserBooking(userBookingMap);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('${widget.service} Booked Successfully')),
                );
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Color(0xffFE8F33),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Center(
                  child: Text(
                    'BOOK NOW',
                    style: TextStyle(
                      fontSize: 22,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
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
