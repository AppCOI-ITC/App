import 'package:flutter/material.dart';
import 'package:flutter_app/models/plantillas.dart';
import 'package:flutter_app/screens/services/auth.dart';
import 'package:flutter_app/shared/constants.dart';
import 'package:flutter_app/shared/loading.dart';

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
  String nombre = '';
  int documento;
  String email = '';
  String password = '';
  String error = '';

  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return loading ? Loading() : Scaffold(
      backgroundColor: Color.fromARGB(255, 0xFF, 0xED, 0xE1),
      appBar: AppBar(
        title: Text("Registrarse",style: TextStyle(color: Color.fromARGB(255, 0x14, 0x53, 0x9A),fontWeight: FontWeight.bold)),
        centerTitle: true,
        elevation: 0.0,
        backgroundColor: Color.fromARGB(255, 0xFF, 0xED, 0xE1),
        actions: [
          IconButton(
            icon: Icon(Icons.arrow_forward_ios, 
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
        padding: EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              padding: EdgeInsets.symmetric(vertical: 20.0,horizontal: 50.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                  SizedBox(),
                  TextFormField(
                    decoration: textInputDecoration.copyWith(labelText: 'NOMBRE'),
                    //validator: (val) => val.length < 6 ? 'ingrese un mail' : null,
                    onChanged: (val) {
                      setState(() => nombre = val);
                    }
                  ),
                  SizedBox(height: 20.0),
                  TextFormField(
                    decoration: textInputDecoration.copyWith(labelText: 'DOCUMENTO'),
                    validator: (val) => val.length > 9 ? 'ingrese un dni valido' : null,
                    onChanged: (val) {
                      setState(() => documento = int.parse(val));
                    }
                  ),
                  SizedBox(height: 20.0),
                  TextFormField(
                    decoration: textInputDecoration.copyWith(labelText: 'MAIL'),
                    validator: (val) {                   
                    if (!val.contains('@')){
                        return 'ingrese un mail';
                      }else{
                        return null;
                      }
                    },
                    onChanged: (val) {
                      setState(() => email = val);
                    }
                  ),
                  SizedBox(height: 20.0),
                  TextFormField(
                    decoration: textInputDecoration.copyWith(labelText: 'CONTRASEÑA'),
                    obscureText: true,
                    validator: (val) => val.length < 6 ? 'ingrese una clave de mas de 6 digitos' : null,
                    onChanged: (val) => setState(() => password = val)
                  ),
                  SizedBox(height: 20.0),
                  RaisedButton(
                    color: Color.fromARGB(255, 0x14, 0x53, 0x9A),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
                    elevation: 6.0,
                    padding: EdgeInsets.fromLTRB(60, 10, 60, 10),
                    child: Text('REGISTRARSE', style: TextStyle(color: Colors.white,fontSize: 20.0)),
                    onPressed: () async {
                      setState(() => loading = true);
                      bool emailValid = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(email);
                      if (emailValid) {
                        if (_formKey.currentState.validate()) {
                          dynamic result = await _auth.registerWhitEmailAndPassword(email, password,nombre,documento);
                          print(result);
                          if (result == null) {
                            loading = false;
                            setState(() => error = 'Write a valid email');
                          }
                        }
                      }else{loading = false;} 
                    },
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
      ),
      bottomNavigationBar: Plantillas().formatoBottomBar(),
    );
  }
}


/*
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
                  color: Colors.black54,
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
                  SizedBox(),
                  TextFormField(
                    decoration: textInputDecoration.copyWith(labelText: 'Nombre',hintText: 'Pedro Morales'),
                    //validator: (val) => val.length < 6 ? 'ingrese un mail' : null,
                    onChanged: (val) {
                      setState(() => nombre = val);
                    }
                  ),
                  SizedBox(height: 20.0),
                  TextFormField(
                    decoration: textInputDecoration.copyWith(labelText: 'N° documento',hintText: '12345678'),
                    validator: (val) => val.length > 9 ? 'ingrese un dni valido' : null,
                    onChanged: (val) {
                      setState(() => documento = int.parse(val));
                    }
                  ),
                  SizedBox(height: 20.0),
                  TextFormField(
                    decoration: textInputDecoration.copyWith(labelText: 'Mail',hintText: 'ejemplo@mail.com'),
                    validator: (val) {                   
                    if (!val.contains('@')){
                        return 'ingrese un mail';
                      }else{
                        return null;
                      }
                    },
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
                      setState(() => loading = true);
                      bool emailValid = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(email);
                      if (emailValid) {
                        if (_formKey.currentState.validate()) {
                          dynamic result = await _auth.registerWhitEmailAndPassword(email, password,nombre,documento);
                          print(result);
                          if (result == null) {
                            loading = false;
                            setState(() => error = 'Write a valid email');
                          }
                        }
                      }else{loading = false;} 
                    },
                    color: Colors.blueGrey,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    elevation: 6.0,
                    padding: EdgeInsets.fromLTRB(60, 10, 60, 10),
                    child: Text(
                      'Registrarse',
                      style: TextStyle(color: Colors.white,fontSize: 18.0),
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
 */