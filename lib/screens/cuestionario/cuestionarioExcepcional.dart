import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/shared/constants.dart';

class CExcepcional extends StatefulWidget {
  final bool excepcional;
  const CExcepcional({Key key, this.excepcional}) : super(key: key);

  @override
  _CExcepcionalState createState() => _CExcepcionalState();
}

class _CExcepcionalState extends State<CExcepcional> {
  final CollectionReference collectionBD =
      FirebaseFirestore.instance.collection('DataUsuarios');
  final FirebaseAuth auth = FirebaseAuth.instance;
  final _formKey = GlobalKey<FormState>();
  String respuesta = '';
  String excepcion = "¿Qué sintomas tiene?";
  String error = "Defina su error";

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: new Scaffold(
          appBar: new AppBar(
            title: Text('COI - ITC', style: TextStyle(color: Colors.black)),
            centerTitle: true,
            backgroundColor: Colors.red[300],
            elevation: 4.0,
            iconTheme: IconThemeData(color: Colors.black),
          ),
          body: new Container(
            padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Text(
                  widget.excepcional ? excepcion : error,
                  style: TextStyle(fontSize: 30.0),
                ),
                Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      SizedBox(),
                      TextField(
                        minLines: 10,
                        maxLines: 15,
                        decoration: textInputDecoration,
                        onChanged: (value) {
                          setState(() => respuesta = value);
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 300,
                  height: 50,
                  child: RaisedButton.icon(
                    icon: Icon(
                      Icons.send,
                      size: 25.0,
                    ),
                    elevation: 6.0,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0)),
                    color: Colors.red[400],
                    label: Text(
                      'Enviar',
                      style: TextStyle(fontSize: 25.0),
                      textAlign: TextAlign.center,
                    ),
                    onPressed: () {
                      if (_formKey.currentState.validate()) {
                        inputData(respuesta, widget.excepcional);
                      }
                    },
                  ),
                ),
              ],
            ),
          )),
    );
  }

  void inputData(String answer, bool excepcion) {
    final User user = auth.currentUser;
    final uid = user.uid;
    // here you write the codes to input the data into firestore
    //collectionBD.doc(uid).set({'Cuestionario Excepcional': answer,});
    if (excepcion == true) {
      collectionBD
          .doc(uid)
          .collection('Cuestionarios excepcionales')
          .add({'Cuestionario': answer});
    } else {
      FirebaseFirestore.instance.collection('Error').add({'Error': answer});
    }
    Navigator.of(context).pop();
  }
}
