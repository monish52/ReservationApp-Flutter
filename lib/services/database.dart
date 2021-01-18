import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:reservation/models/order.dart';
import 'package:reservation/models/user.dart';
import 'package:reservation/screens/home/order_list.dart';

class DatabaseService {
  final String uid;
  DatabaseService({this.uid});
  //collection reference
  final CollectionReference orderCollection =
      FirebaseFirestore.instance.collection('orders');

  Future updateUserData(String name, int contactNo, String emailId,
      DateTime date, String time) async {
    return await orderCollection.doc(uid).set({
      'name': name,
      'contactNo': contactNo,
      'emailId': emailId,
      'date': date,
      'time': time
    });
  }

  //order list from snapshot
  List<Order> _orderListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return Order(
        name: doc.data()['name'] ?? '',
        contactNo: doc.data()['contactNo'] ?? 0,
        emailId: doc.data()['emailId'] ?? '',
        date: doc.data()['date'].toDate() ?? '',
        time: doc.data()['time'] ?? '',
      );
    }).toList();
  }

  //userData from snapshot
  UserData _userDataSnapshot(DocumentSnapshot snapshot) {
    return UserData(
      uid: uid,
      name: snapshot.data()['name'],
      contactNo: snapshot.data()['contactNo'],
      emailId: snapshot.data()['emailId'],
      date: snapshot.data()['date'].toDate(),
      time: snapshot.data()['time'],
    );
  }

  //get orders stream
  Stream<List<Order>> get orders {
    return orderCollection.snapshots().map(_orderListFromSnapshot);
  }

  //get user doc stream
  Stream<UserData> get userData {
    return orderCollection.doc(uid).snapshots().map(_userDataSnapshot);
  }
}
