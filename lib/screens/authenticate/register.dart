import 'package:flutter/material.dart';
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
  //Variable de control de la pantalla de carga 
  bool loading = false;

  //Variables de registro
  String nombre = '';
  int documento;
  String email = '';
  String password = '';
  String error = '';

  
  @override
  Widget build(BuildContext context) {
    return loading ? Loading() : Scaffold(
      backgroundColor: Colors.blueGrey[50],
      //==============APPBAR===============
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(109, 213, 250, 1),
        elevation: 4.0,
        title: Text('COI - ITC',style: TextStyle(color: Colors.black)),
        actions: <Widget>[
          FlatButton.icon(
            icon: Icon(Icons.person), 
            label: Text('ingresar'),
            onPressed: (){widget.toggleView();}
          )
        ],

      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: ListView(
          children: <Widget>[
            //==============TITULO===============
            Container(
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
            //=========CAMPOS DE REGISTRO=======
            Container(
              padding: EdgeInsets.symmetric(vertical: 20.0,horizontal: 50.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                  //->CAMPO: NOMBRE
                  SizedBox(),
                  TextFormField(
                    decoration: textInputDecoration.copyWith(labelText: 'Nombre',hintText: 'Pedro Morales'),
                    //validator: (val) => val.length < 6 ? 'ingrese un mail' : null,
                    onChanged: (val) {
                      setState(() => nombre = val);
                    }
                  ),
                  //->CAMPO: DOCUMENTO
                  SizedBox(height: 20.0),
                  TextFormField(
                    decoration: textInputDecoration.copyWith(labelText: 'N° documento',hintText: '12345678'),
                    validator: (val) => val.length > 9 ? 'ingrese un dni valido' : null,
                    onChanged: (val) {
                      setState(() => documento = int.parse(val));
                    }
                  ),
                  //->CAMPO: MAIL
                  SizedBox(height: 20.0),
                  TextFormField(
                    decoration: textInputDecoration.copyWith(labelText: 'Mail',hintText: 'ejemplo@mail.com'),
                    validator: (val) {                   
                    if (!val.contains('@')){
                        return 'ingrese un mail';
                    }else{return null;}
                    },
                    onChanged: (val) {
                      setState(() => email = val);
                    }
                  ),
                  //->CAMPO: CONTRASEÑA
                  SizedBox(height: 20.0),
                  TextFormField(
                    decoration: textInputDecoration.copyWith(labelText: 'Contraseña',hintText: '******'),
                    obscureText: true,
                    validator: (val) => val.length < 6 ? 'ingrese una clave de mas de 6 digitos' : null,
                    onChanged: (val) {
                      setState(() => password = val);
                    }
                  ),
                  //->BOTON
                  SizedBox(height: 20.0),
                  RaisedButton(
                    onPressed: () async {
                      setState(() => loading = true);
                      bool emailValid = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(email);
                      if (emailValid) {
                        if (_formKey.currentState.validate()) {
                          dynamic result = await _auth.registerWhitEmailAndPassword(email, password,nombre,documento);
                          print(result);    //<=PRINT DE DEBUG
                          if (result == null) {
                            loading = false;
                            setState(() => error = 'Write a valid email');
                          }
                        }
                      }else{loading = false;} 
                    },
                    color: Colors.blueGrey,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                    elevation: 6.0,
                    padding: EdgeInsets.fromLTRB(60, 10, 60, 10),
                    child: Text('Registrarse',style: TextStyle(color: Colors.white,fontSize: 18.0))
                  ),
                  //->CUADRO DE ERROR
                  SizedBox(height: 12.0),
                  Text(error,style: TextStyle(color: Colors.red, fontSize: 14.0)),

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