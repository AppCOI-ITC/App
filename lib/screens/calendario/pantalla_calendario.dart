import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/Calendario/calendario.dart';

class PantallaCalendario extends StatefulWidget {
  @override
  _PantallaCalendarioState createState() => _PantallaCalendarioState();
}

class _PantallaCalendarioState extends State<PantallaCalendario> {
  Calendario calendario=new Calendario();

  /*List <Eventos> dia1 = [
    Eventos(titulo: 'Cuestionario 1', hora: '19:30', lugar: 'Neuquén', frecuencia: 'diario'),
    Eventos(titulo: 'Cuestionario 5', hora: '19:45', lugar: 'Neuquén', frecuencia: 'diario'),
    Eventos(titulo: 'Cuestionario 3', hora: '20:00', lugar: 'Neuquén', frecuencia: 'semanal'),
    Eventos(titulo: 'Tomar pastilla azul', hora: '20:15', lugar: 'Neuquén', frecuencia: 'diario'),
    Eventos(titulo: 'Tomar pastilla roja', hora: '20:15', lugar: 'Neuquén', frecuencia: 'semanal'),
  ];*/
  //Crear objetos días
  /*Dia objDia1 = Dia(fecha: 'Mar, 6 OCT', eventos: [
    Eventos(titulo: 'Cuestionario 1', hora: '19:30', lugar: 'Neuquén', frecuencia: 'diario'),
    Eventos(titulo: 'Cuestionario 2', hora: '19:45', lugar: 'Neuquén', frecuencia: 'diario'),
    Eventos(titulo: 'Cuestionario 3', hora: '20:00', lugar: 'Neuquén', frecuencia: 'semanal'),
    Eventos(titulo: 'Tomar pastilla azul', hora: '20:15', lugar: 'Neuquén', frecuencia: 'diario'),
  ]);
  Dia objDia2 =Dia(fecha: 'Mier, 7 OCT', eventos:[
    Eventos(titulo: 'Cuestionario 4', hora: '19:30', lugar: 'Neuquén', frecuencia: 'diario'),
    Eventos(titulo: 'Cuestionario 5', hora: '19:45', lugar: 'Neuquén', frecuencia: 'diario'),
    Eventos(titulo: 'Cuestionario 6', hora: '20:00', lugar: 'Neuquén', frecuencia: 'semanal'),
    Eventos(titulo: 'Tomar pastilla azul', hora: '20:15', lugar: 'Neuquén', frecuencia: 'diario'),
  ]);*/
  //Lista de días

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.grey[300],
        title: Text('Calendario'),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  FlatButton(
                    onPressed: (){
                      setState(() {
                        calendario=Calendario(remove: true, elDia: '8 de Marzo',);
                      });
                    },
                    color: Colors.red,
                    child: Text('borrar 8 M'),
                  ),
                  SizedBox(height: 10,),
                  FlatButton(
                    onPressed: (){
                      setState(() {
                        calendario=Calendario(remove: true, elDia: '5 de Marzo',);
                      });
                    },
                    color: Colors.red,
                    child: Text('borrar 5 M'),
                  ),
                ],
              ),
              SizedBox(width: 10,),
              Column(
                children: [
                  FlatButton(
                    onPressed: ({ titulo: 'Evento agregado', hora:'7:00',lugar: 'Cipolletti', frecuencia: 'semanal'}){
                      setState(() {
                        calendario=Calendario(add: true, elDia: '8 de Marzo',);
                      });
                    },
                    color: Colors.green,
                    child: Text('agregar 8 M'),
                  ),
                  SizedBox(height: 10,),
                  FlatButton(
                    onPressed: ({ titulo: 'Evento agregado', hora:'7:00',lugar: 'Cipolletti', frecuencia: 'semanal'}){
                      setState(() {
                        calendario=Calendario(add: true, elDia: '5 de Marzo',);
                      });
                    },
                    color: Colors.green,
                    child: Text('agregar 5 M'),
                  ),
                ],
              ),
            ],
          ),
          calendario,
        ],
      ),

    );
  }
}