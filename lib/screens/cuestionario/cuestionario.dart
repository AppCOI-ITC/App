import 'package:flutter/material.dart';
import 'package:flutter_app/screens/cuestionario/cuestionario2.dart';

class Cuestionario extends StatefulWidget {
  @override
  _CuestionarioState createState() => _CuestionarioState();
}

class _CuestionarioState extends State<Cuestionario> {
  // bool flag_eleccion = false;

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
              /*setState(() {
                flag_eleccion = true;
              });*/
              cambiodePagina(context);
            },
            child: Text('Sí',
                style: TextStyle(
                  fontSize: 30.0,
                ))),
        RaisedButton(
            padding: EdgeInsets.all(40.0),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50.0),
                side: BorderSide(color: Colors.blue[200])),
            onPressed: () {
              print('No');
              /*setState(() {
                flag_eleccion = true;
              });*/
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

void cambiodePagina(context){
  Route route =MaterialPageRoute(builder: (bc) => Cuestionario2());
  Navigator.of(context).push(route);
}