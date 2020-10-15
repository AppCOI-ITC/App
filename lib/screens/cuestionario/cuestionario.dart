import 'package:flutter/material.dart';
import 'package:flutter_app/screens/cuestionario/cuestionario2.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

DocumentReference ref;

class Cuestionario extends StatefulWidget {
  @override
  _CuestionarioState createState() => _CuestionarioState();
}

class _CuestionarioState extends State<Cuestionario> {
  final CollectionReference collectionBD =
      FirebaseFirestore.instance.collection('DataUsuarios');
  final FirebaseAuth auth = FirebaseAuth.instance;
  User user;

  initUser() async {
    user = await auth.currentUser;
    setState(() {});
  }

  get uid => auth.currentUser.uid;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Text('¿Tuvo fiebre hoy?',
            style: TextStyle(
              fontSize: 30.0,
            )),
        RaisedButton(
            padding: EdgeInsets.all(40.0),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50.0),
                side: BorderSide(color: Colors.blue[200])),
            onPressed: () {
              print('Sí');
              ref = collectionBD.doc(uid).collection('Reportes').doc();
              ref
                  .collection('Cuestionarios')
                  .add({'Respuesta': 'Sí', 'Pregunta': '¿Tuvo fiebre hoy?'});
              cambiodePagina(context);
            },
            child: Text('Sí', style: TextStyle(fontSize: 30.0))),
        RaisedButton(
            padding: EdgeInsets.all(40.0),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50.0),
                side: BorderSide(color: Colors.blue[200])),
            onPressed: () {
              print('No');
              ref = collectionBD.doc(uid).collection('Reportes').doc();
              ref
                  .collection('Cuestionarios')
                  .add({'Respuesta': 'No', 'Pregunta': '¿Tuvo fiebre hoy?'});
              cambiodePagina(context);
            },
            child: Text('No',
                style: TextStyle(
                  fontSize: 30.0,
                )))
      ],
    )));
  }
}

void cambiodePagina(context) {
  //se configura la ruta
  Route route = MaterialPageRoute(builder: (bc) => Cuestionario2());
  //se hace aparecer la ventana Cuestionario2
  Navigator.of(context).push(route);
}
