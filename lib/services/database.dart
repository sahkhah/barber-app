import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseMethods {
  Future addUser(Map<String, dynamic> userInfo, String id) async {
    return await FirebaseFirestore.instance
        .collection('Users')
        .doc(id)
        .set(userInfo);
  }

  Future addUserBooking(Map<String, dynamic> userInfo) async {
    return await FirebaseFirestore.instance
        .collection('Bookings')
        .add(userInfo);
  }

  Future<Stream<QuerySnapshot>> getBookings() async {
    return FirebaseFirestore.instance.collection('Bookings').snapshots();
  }

  deleteBooking(String id) async {
    await FirebaseFirestore.instance.collection('Bookings').doc(id).delete();
  }
}
