import 'package:flutter/material.dart';
import 'package:flutter_app/screens/home/home.dart';

class Cuestionario2 extends StatelessWidget {
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
              print('En absoluto');
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

void cambiodePagina(context){
  Route route =MaterialPageRoute(builder: (bc) => Home());
  Navigator.of(context).push(route);
}