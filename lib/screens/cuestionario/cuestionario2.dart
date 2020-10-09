import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/screens/cuestionario/cuestionario.dart';
import 'package:flutter_app/screens/home/home.dart';
import 'cuestionario.dart';

class Cuestionario2 extends StatelessWidget {
  final CollectionReference collectionBD =
      FirebaseFirestore.instance.collection('DataUsuarios');
  final FirebaseAuth auth = FirebaseAuth.instance;
  User user;

  initUser() async {
    user = await auth.currentUser;
  }

  get uid => auth.currentUser.uid;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Text('¿Tuvo dolor hoy?',
            style: TextStyle(
              fontSize: 30.0,
            )),
        RaisedButton(
            padding: EdgeInsets.all(40.0),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50.0),
                side: BorderSide(color: Colors.blue[200])),
            onPressed: () {
              ref.collection('Cuestionarios').add(
                  {'Respuesta': 'En absoluto', 'Pregunta': '¿Tuvo dolor hoy?'});
              cambiodePagina(context);
            },
            child: Text('En absoluto',
                style: TextStyle(
                  fontSize: 30.0,
                ))),
        RaisedButton(
            padding: EdgeInsets.all(40.0),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50.0),
                side: BorderSide(color: Colors.blue[200])),
            onPressed: () {
              print('Un poco');
              ref.collection('Cuestionarios').add(
                  {'Respuesta': 'Un poco', 'Pregunta': '¿Tuvo dolor hoy?'});
              cambiodePagina(context);
            },
            child: Text('Un poco',
                style: TextStyle(
                  fontSize: 30.0,
                ))),
        RaisedButton(
            padding: EdgeInsets.all(40.0),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50.0),
                side: BorderSide(color: Colors.blue[200])),
            onPressed: () {
              print('Bastante');
              ref.collection('Cuestionarios').add(
                  {'Respuesta': 'Bastante', 'Pregunta': '¿Tuvo dolor hoy?'});
              cambiodePagina(context);
            },
            child: Text('Bastante',
                style: TextStyle(
                  fontSize: 30.0,
                ))),
        RaisedButton(
            padding: EdgeInsets.all(40.0),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50.0),
                side: BorderSide(color: Colors.blue[200])),
            onPressed: () {
              print('Mucho');
              ref
                  .collection('Cuestionarios')
                  .add({'Respuesta': 'Mucho', 'Pregunta': '¿Tuvo dolor hoy?'});

              cambiodePagina(context);
            },
            child: Text('Mucho',
                style: TextStyle(
                  fontSize: 30.0,
                ))),
      ],
    )));
  }
}

void cambiodePagina(context) {
  //se configura la primer ruta
  Route route = MaterialPageRoute(builder: (bc) => Cuestionario());
  //se configura la segunda ruta
  Route route2 = MaterialPageRoute(builder: (bc) => Home());
  //se hace un pop a Cuestionario y luego a Home
  Navigator.of(context).pop(route);
  Navigator.of(context).pop(route2);
}
