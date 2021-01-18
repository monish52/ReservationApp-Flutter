import 'package:reservation/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:reservation/shared/loading.dart';
import 'package:reservation/shared/shared.dart';

class Register extends StatefulWidget {
  final Function toggleView;
  Register({this.toggleView});
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;
  String email = '';
  String password = '';
  String error = '';
  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            backgroundColor: Colors.brown[200],
            appBar: AppBar(
              backgroundColor: Colors.brown,
              elevation: 0.1,
              title: Text('Register'),
              actions: <Widget>[
                FlatButton.icon(
                    onPressed: () {
                      widget.toggleView();
                    },
                    icon: Icon(Icons.person),
                    label: Text('Log In'))
              ],
            ),
            body: Container(
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 50),
                child: Form(
                    key: _formKey,
                    child: Column(
                      children: <Widget>[
                        SizedBox(height: 20.0),
                        TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          decoration:
                              textInputDecoration.copyWith(hintText: 'Email'),
                          validator: (val) =>
                              val.isEmpty ? 'Enter a valid email' : null,
                          onChanged: (val) {
                            setState(() => email = val);
                          },
                        ),
                        SizedBox(height: 20.0),
                        TextFormField(
                          decoration: textInputDecoration.copyWith(
                              hintText: 'Password'),
                          validator: (val) => val.length < 5
                              ? 'Enter a password of atleast 6 characters'
                              : null,
                          onChanged: (val) {
                            setState(() => password = val);
                          },
                          obscureText: true,
                        ),
                        SizedBox(height: 30.0),
                        ButtonTheme(
                          minWidth: 100.0,
                          height: 50.0,
                          child: RaisedButton(
                              color: Colors.pink[300],
                              elevation: 3.0,
                              child: Text('Register',
                                  style: TextStyle(color: Colors.white)),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18.0)),
                              onPressed: () async {
                                if (_formKey.currentState.validate()) {
                                  setState(() {
                                    loading = true;
                                  });
                                  dynamic result =
                                      await _auth.registerWithEmailAndPass(
                                          email, password);
                                  if (result == null) {
                                    setState(() => error =
                                        'Please provide a valid email address');
                                    loading = false;
                                  }
                                }
                              }),
                        ),
                        SizedBox(height: 12.0),
                        Text(
                          error,
                          style: TextStyle(color: Colors.red, fontSize: 14.0),
                        ),
                      ],
                    ))),
          );
  }
}
