import 'package:reservation/screens/home/reserve_form.dart';
import 'package:reservation/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:reservation/services/database.dart';
import 'package:provider/provider.dart';
import 'package:reservation/screens/home/order_list.dart';
import 'package:reservation/models/order.dart';

class Home extends StatelessWidget {
  final AuthService _auth = AuthService();
  @override
  Widget build(BuildContext context) {
    void _showAddReserve() {
      showModalBottomSheet(
          context: context,
          backgroundColor: Colors.brown[100],
          isScrollControlled: true,
          builder: (context) {
            return Container(
              padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
              child: ReserveForm(),
            );
          });
    }

    return StreamProvider<List<Order>>.value(
      value: DatabaseService().orders,
      child: Scaffold(
        backgroundColor: Colors.brown[200],
        appBar: AppBar(
          title: Text('Reservation App Home'),
          backgroundColor: Colors.brown,
          centerTitle: true,
          elevation: 10.0,
          actions: <Widget>[
            FlatButton.icon(
                onPressed: () async {
                  await _auth.signOut();
                },
                icon: Icon(Icons.logout),
                label: Text('Logout')),
            FlatButton.icon(
                icon: Icon(Icons.add_to_queue_rounded),
                label: Text('Reserve'),
                onPressed: () {
                  _showAddReserve();
                }),
          ],
        ),
        body: OrderList(),
      ),
    );
  }
}
