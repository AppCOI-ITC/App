import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_app/models/plantillas.dart';
import 'package:flutter_app/screens/services/auth.dart';
import 'package:flutter_app/shared/constants.dart';
import 'package:flutter_app/shared/loading.dart';

class SignIn extends StatefulWidget {
  final Function toggleView;
  SignIn({this.toggleView});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  // Text field state
  String email = '';
  String password = '';
  String error = '';

  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            backgroundColor: Color.fromARGB(255, 0xFF, 0xED, 0xE1),
            //Plantillas().formatoAppBar("Inicio de sesión")
            appBar: AppBar(
              title: Text("Inicio de sesión",
                  style: TextStyle(
                      color: Color.fromARGB(255, 0x14, 0x53, 0x9A),
                      fontWeight: FontWeight.bold)),
              centerTitle: true,
              elevation: 0.0,
              backgroundColor: Color.fromARGB(255, 0xFF, 0xED, 0xE1),
              actions: [
                IconButton(
                  icon: Icon(
                    Icons.arrow_forward_ios,
                    color: Color.fromARGB(255, 0x14, 0x53, 0x9A),
                  ),
                  onPressed: () => widget.toggleView(),
                )
              ],
              leading: Container(),
              bottom: PreferredSize(
                preferredSize: Size.fromHeight(10.0),
                child: Padding(
                  padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
                  child: Container(
                    height: 1.3,
                    color: Color.fromARGB(255, 0x14, 0x53, 0x9A),
                  ),
                ),
              ),
            ),
            body: Padding(
              padding: EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 0.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    child: Column(
                      children: [
                        Image.asset(
                          'assets/images/logo.png',
                          width: 200,
                          height: 200,
                        ),
                        Text('OncoSALUD',
                            style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.w600,
                              color: Color.fromARGB(255, 0x14, 0x53, 0x9A),
                            ))
                      ],
                    ),
                  ),
                  SizedBox(height: 16),
                  Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        TextFormField(
                            textAlign: TextAlign.center,
                            showCursor: false,
                            style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.w600,
                              color: Color.fromARGB(255, 0x14, 0x53, 0x9A),
                            ),
                            decoration: textInputDecoration.copyWith(
                                hintText: 'USUARIO'),
                            validator: (val) =>
                                val.isEmpty ? 'ingrese un usuario' : null,
                            onChanged: (val) {
                              setState(() => email = val);
                            }),
                        SizedBox(height: 10.0),
                        TextFormField(
                            textAlign: TextAlign.center,
                            decoration: textInputDecoration.copyWith(
                                hintText:
                                    'CONTRASEÑA'), //<==== RESOLVER LABELTEXT
                            showCursor: false,
                            style: TextStyle(
                                color: Color.fromARGB(255, 0x14, 0x53, 0x9A)),
                            obscureText: true,
                            validator: (val) =>
                                val.isEmpty ? 'Ingrese una clave' : null,
                            onChanged: (val) {
                              setState(() => password = val);
                            }),
                        SizedBox(height: 20.0),
                        RaisedButton(
                            color: Color.fromARGB(255, 0x14, 0x53, 0x9A),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30.0)),
                            elevation: 6.0,
                            padding: EdgeInsets.fromLTRB(60, 10, 60, 10),
                            child: Text('INGRESAR',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 20.0)),
                            onPressed: () async {
                              if (_formKey.currentState.validate()) {
                                setState(() => loading = true);
                                dynamic result =
                                    await _auth.SignInWhitEmailAndPassword(
                                        email, password);
                                if (result == null) {
                                  setState(() {
                                    error =
                                        'Error al ingresar intente nuevamente';
                                    loading = false;
                                  });
                                }
                              }
                            }),
                        Text(
                          error,
                          style: TextStyle(color: Colors.red, fontSize: 14.0),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            bottomNavigationBar: Plantillas().formatoBottomBar(),
          );
  }
}
