import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reservation/models/user.dart';
import 'package:reservation/services/database.dart';
import 'package:reservation/shared/shared.dart';
import 'package:flutter/services.dart';
import 'package:reservation/screens/home/table_calendar.dart';

class ReserveForm extends StatefulWidget {
  @override
  _ReserveFormState createState() => _ReserveFormState();
}

class _ReserveFormState extends State<ReserveForm> {
  final _formKey = GlobalKey<FormState>();
  final List<String> times = [
    '10am',
    '11am',
    '12pm',
    '1pm',
    '2pm',
    '3pm',
    '7pm',
    '8pm',
    '9pm',
    '10pm',
    '11pm',
    '12am'
  ];
  String _currentName;
  int _currentContactNo;
  String _currentEmail;
  DateTime _currentDate;
  String _currentTime;
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserId>(context);

    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          Text(
            'Add your reservation',
            style: TextStyle(fontSize: 18.0),
          ),
          SizedBox(height: 20.0),
          TextFormField(
            decoration: textInputDecoration.copyWith(hintText: 'Enter name'),
            validator: (val) => val.isEmpty ? 'Please enter a name' : null,
            onChanged: (val) => setState(() => _currentName = val),
          ),
          TextFormField(
            decoration:
                textInputDecoration.copyWith(hintText: 'Enter contact No'),
            validator: (val) {
              if (val.isEmpty) {
                return "Please enter a contact no";
              } else if (val.length < 10) {
                return "Please enter a 10 digit contact No";
              } else {
                return null;
              }
            },
            onChanged: (val) =>
                setState(() => _currentContactNo = int.parse(val)),
            keyboardType: TextInputType.number,
          ),
          TextFormField(
            decoration: textInputDecoration.copyWith(hintText: 'Enter email'),
            validator: (val) => val.isEmpty ? 'Please enter an email' : null,
            onChanged: (val) => setState(() => _currentEmail = val),
            keyboardType: TextInputType.emailAddress,
          ),
          SizedBox(height: 15.0),
          Card(
            margin: EdgeInsets.all(8.0),
            clipBehavior: Clip.antiAlias,
            child: Text(_currentDate == null
                ? 'No date has been picked yet'
                : _currentDate.toString()),
          ),
          Card(
              margin: EdgeInsets.all(8.0),
              clipBehavior: Clip.antiAlias,
              child: FlatButton(
                child: Text(
                  'Pick a Date',
                  style: TextStyle(color: Colors.white),
                ),
                color: Colors.pink,
                onPressed: () {
                  showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2001),
                    lastDate: DateTime(2022),
                  ).then((date) {
                    setState(() {
                      _currentDate = date;
                    });
                  });
                },
              )),
          SizedBox(height: 15.0),
          DropdownButtonFormField(
            decoration: textInputDecoration,
            items: times.map((time) {
              return DropdownMenuItem(
                value: time,
                child: Text('$time'),
              );
            }).toList(),
            onChanged: (val) => setState(() => _currentTime = val),
          ),
          RaisedButton(
            color: Colors.pink,
            child: Text(
              'Update',
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () async {
              // print(_currentName);
              // print(_currentTime);
              // print(_currentContactNo);
              // print(_currentEmail);
              // print(_currentDate);
              if (_formKey.currentState.validate()) {
                await DatabaseService(uid: user.uid).updateUserData(
                    _currentName,
                    _currentContactNo,
                    _currentEmail,
                    _currentDate,
                    _currentTime);
                Navigator.pop(context);
              }
            },
          ),
        ],
      ),
    );
  }
}
