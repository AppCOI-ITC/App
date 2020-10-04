import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_app/screens/services/auth.dart';
import 'package:flutter_app/shared/constants.dart';
import 'package:flutter_app/shared/loading.dart';

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
    return loading ? Loading() : Scaffold(  
      backgroundColor: Colors.blueGrey[50],  
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(109, 213, 250, 1),
        elevation: 0.0,
        title: Text('Inicio de Sesion', style: TextStyle(color: Colors.black)),
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
                    decoration: textInputDecoration.copyWith(labelText: 'Email',hintText: 'ejemplo@mail.com'),
                    validator: (val) => val.isEmpty ? 'ingrese un mail' : null,
                    onChanged: (val) {
                      setState(() => email = val);
                    }
                  ),
                  SizedBox(height: 20.0),
                  TextFormField(
                    decoration: textInputDecoration.copyWith(labelText: 'Contraseña',hintText: '******'),
                    obscureText: true,
                    validator: (val) => val.length < 6 ? 'Ingrese una clave de mas de 6 digitos' : null,
                    onChanged: (val) {
                      setState(() => password = val);
                    }
                  ),
                  SizedBox(height: 20.0),
                  RaisedButton(
                    color: Colors.blueGrey,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    elevation: 6.0,
                    padding: EdgeInsets.fromLTRB(60, 10, 60, 10),
                    child: Text(
                      'Ingresar',
                      style: TextStyle(color: Colors.white,fontSize: 18.0),
                    ),
                    
                    onPressed: () async {
                      if (_formKey.currentState.validate()){
                        setState(() => loading = true);
                        dynamic result = await _auth.SignInWhitEmailAndPassword(email, password);
                        if(result == null){
                          setState(() {
                            error = 'Error al ingresar intente nuevamente';
                            loading = false;
                          });
                        }
                      }
                    }
                    
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
        ],
      ),
    );
  }
}