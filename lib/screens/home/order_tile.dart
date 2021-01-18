import 'package:flutter/material.dart';
import 'package:reservation/models/order.dart';

class OrderTile extends StatelessWidget {
  final Order order;
  OrderTile({this.order});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 8.0),
      child: Card(
          margin: EdgeInsets.fromLTRB(20, 6, 20, 0),
          child: ListTile(
            leading: CircleAvatar(
              radius: 25.0,
              backgroundColor: Colors.brown[900],
              child: Icon(
                Icons.person,
                color: Colors.brown[100],
              ),
            ),
            isThreeLine: true,
            title: Text(order.name),
            subtitle: Text(
                'Contact No: ${order.contactNo} and Email: ${order.emailId}. Date and time is ${order.date} at ${order.time}'),
            trailing: Icon(
              Icons.delete,
              color: Colors.brown[600],
              size: 30.0,
            ),
          )),
    );
  }
}
