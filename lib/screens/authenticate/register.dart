import 'package:flutter/material.dart';
import 'package:flutter_app/screens/services/auth.dart';
import 'package:flutter_app/shared/constants.dart';

//bugs
//23/09 + cuando se ingresa un correo registrado previamente se lanza el error 

class Register extends StatefulWidget {

  final Function toggleView;
  Register({ this.toggleView }); 

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  final AuthService _auth = AuthService();
  final _formKey =  GlobalKey<FormState>();

  // Text field state
  String email = '';
  String password = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(100, 0, 145, 245),
        elevation: 0.0,
        title: Text('COI - ITC'),
        actions: <Widget>[
          FlatButton.icon(
            icon: Icon(Icons.person), 
            label: Text('ingresar'),
            onPressed: (){
              widget.toggleView();
            }
          )
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: ListView(
          children: <Widget>[
            Container(
              //color: Colors.grey,
              alignment: Alignment.center,
              padding: EdgeInsets.fromLTRB(10, 25, 10, 10),
              child: Text(
                'Registro en la aplicacion',
                style: TextStyle(
                  color: Color.fromARGB(100, 0, 145, 245),
                  fontWeight: FontWeight.w500,
                  fontSize: 28
                ), 
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 20.0,horizontal: 50.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                  SizedBox(height: 20.0),
                  TextFormField(
                    decoration: textInputDecoration.copyWith(labelText: 'Mail',hintText: 'ejemplo@mail.com'),
                    validator: (val) => val.length < 6 ? 'ingrese un mail' : null,
                    onChanged: (val) {
                      setState(() => email = val);
                    }
                  ),
                  SizedBox(height: 20.0),
                  TextFormField(
                    decoration: textInputDecoration.copyWith(labelText: 'Contraseña',hintText: '******'),
                    obscureText: true,
                    validator: (val) => val.length < 6 ? 'ingrese una clave de mas de 6 digitos' : null,
                    onChanged: (val) {
                      setState(() => password = val);
                    }
                  ),
                  SizedBox(height: 20.0),
                  RaisedButton(
                    onPressed: () async {
                      // check the form for empty spots and validity
                      bool emailValid = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(email);
                      if (emailValid) {
                        if (_formKey.currentState.validate()) {
                          dynamic result = await _auth.registerWhitEmailAndPassword(email, password);
                          print(result);
                          if (result == null) {
                            setState(() => error = 'Write a valid email');
                          }
                        }
                      } 
                      /*else {
                        setState(() => error = 'ingresar un mail valido');
                      }*/
                    },
                    color: Colors.pink[300],
                    child: Text(
                      'Register',
                      style: TextStyle(color: Colors.white),
                    )
                  ),
                  SizedBox(height: 12.0),
                  Text(
                    error,
                    style: TextStyle(color: Colors.red, fontSize: 14.0),
                  ),
                  ],
                ),
              ),
            ),
          ]
        ),
      )
    );
  }
}