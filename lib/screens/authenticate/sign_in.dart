import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_app/screens/services/auth.dart';
import 'package:flutter_app/shared/constants.dart';

class SignIn extends StatefulWidget {

  final Function toggleView;
  SignIn({ this.toggleView }); 

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  
  final AuthService _auth = AuthService();
  final _formKey =  GlobalKey<FormState>();
  bool loading = false;

  // Text field state
  String email = '';
  String password = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(    //loading ? Loading() : 
      appBar: AppBar(
        backgroundColor: Color.fromARGB(100, 0, 145, 245),
        elevation: 0.0,
        title: Text('Inicio de Sesion'),
        actions: <Widget>[
          FlatButton.icon(
            icon: Icon(Icons.person), 
            label: Text('Registrarse'),
            onPressed: (){
              widget.toggleView();
            }
          )
        ],
      ),
      body: ListView(
        children: <Widget>[
          Container(
            padding: EdgeInsets.symmetric(vertical: 20.0,horizontal: 50.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  SizedBox(height: 20.0),
                  TextFormField(
                    decoration: textInputDecoration.copyWith(hintText: 'Email'),
                    validator: (val) => val.isEmpty ? 'Enter an email' : null,
                    onChanged: (val) {
                      setState(() => email = val);
                    }
                  ),
                  SizedBox(height: 20.0),
                  TextFormField(
                    decoration: textInputDecoration.copyWith(hintText: 'Password'),
                    obscureText: true,
                    validator: (val) => val.length < 6 ? 'Enter a password 6+ chars longs' : null,
                    onChanged: (val) {
                      setState(() => password = val);
                    }
                  ),
                  SizedBox(height: 20.0),
                  /*
                  RaisedButton(
                    onPressed: () async {
                      // check the form for empty spots and validity
                      bool emailValid = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(email);
                      if (emailValid) {
                        if (_formKey.currentState.validate()) {
                          setState(() => loading = false);
                          dynamic result = await _auth.SignInWhitEmailAndPassword(email, password);
                          print(result);
                          if (result == null) {
                          setState(() => error = 'Write a valid email');
                          loading = false;
                        }
                      } else {
                        setState(
                            () => error = 'Write a valid email you moron!');
                            loading = false;
                      }
                    }},
                    color: Colors.pink[300],
                    child: Text(
                      'Sign in ',
                      style: TextStyle(color: Colors.white),
                    )
                  ),*/
                  ///*
                  RaisedButton(
                    color: Colors.pink[400],
                    child: Text(
                      'sign in',
                      style: TextStyle(color: Colors.white),
                    ),
                    
                    onPressed: () async {
                      if (_formKey.currentState.validate()){
                        setState(() => loading = true);
                        dynamic result = await _auth.SignInWhitEmailAndPassword(email, password);
                        if(result == null){ //+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++EVALUAR PORQUE NO CAPTURA EL ERROR
                          setState(() {
                            error = 'could not sign in with those credentials';
                            loading = false;
                          });
                        }
                      }
                    }
                    
                  ),//*/
                  SizedBox(height: 12.0),
                  Text(
                    error,
                    style: TextStyle(color: Colors.red, fontSize: 14.0),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}