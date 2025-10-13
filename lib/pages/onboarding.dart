import 'package:barber_booking_app/pages/homepage.dart';
import 'package:flutter/material.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff2b1615),
      body: Container(
        margin: const EdgeInsets.only(top: 120),
        child: Column(
          children: [
            Image.asset('images/barber.png'),
            const SizedBox(height: 50.0),
            GestureDetector(
              onTap:
                  () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) {
                        return Homepage();
                      },
                    ),
                  ),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                
                decoration: BoxDecoration(
                  color: Color(0xffdf711a),
                  borderRadius: BorderRadius.circular(30),
                 ),
                child: Text(
                  'Get a Stylist Haircut',
                  style: TextStyle(fontSize: 22, color: Colors.white, fontWeight: FontWeight.bold,),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
