import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/Calendario/calendario.dart';
import 'package:flutter_app/screens/calendario/crearEvento.dart';

/*
Esta es la página principal. Acá es donde se puede ver el calendario
 */



class PantallaCalendario extends StatefulWidget {
  @override
  _PantallaCalendarioState createState() => _PantallaCalendarioState();
}

class _PantallaCalendarioState extends State<PantallaCalendario> {
  //Esto almacena la fecha que llega de crear Evento
  DateTime nuevo= new DateTime.now();
  //Se crea un objeto de tipo calendario
  Calendario calendario=new Calendario();


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
          /*Botón para ir a CalendarioExpandido. Despues hay que ver si esto lo incluimos directamente
            en el widget calendario o si lo reemplazamos or un GestureDetector para que al hacer click
            o doble click en el calendario te lleve a la otra página
             */
          FlatButton(
            onPressed: () async {
              Route route =MaterialPageRoute(builder: (bc) => CrearEvento());
              dynamic result = await Navigator.of(context).push(route);
              nuevo=result;
              if(nuevo!=null){
                setState(() {
                  calendario=Calendario(add: true, fechaYhora: nuevo);
                });
              }

            },
            color: Colors.blue[300],
            child: Text('Crear evento presonalizado',
              style: TextStyle(),),
          ),
          /*
            Esta fila contiene cuatro botones, son los que se usan actualmente para crear y eliminar nuevos eventos
             */
          /*
            Lo que se hace es crear un nuevo objeto calendario y asignarselo a la variable de antes.
            "remove", "add" y "elDia" son atributos de la clase calendario, que se pueden pasar al crear el objeto.
            Si vos reemplazas un Stateful Widget por otro igual, el estado del que destruiste se pasa al nuevo,
            es por eso que se crean más eventos y no se reemplazan por uno nuevo
            Se repite en los cuatro botones
            */
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FlatButton(
                onPressed: ({ titulo: 'Evento agregado', hora:'7:00',lugar: 'Cipolletti', frecuencia: 'semanal'}){
                  setState(() {
                    //Acá está lo que te decía de crear y reemplazar
                    calendario=Calendario(add: true, fechaYhora: DateTime(2020,3,8,17,30),);
                  });
                },
                color: Colors.green,
                child: Text('agregar 8 M'),
              ),
              SizedBox(width: 10,),
              FlatButton(
                onPressed: ({ titulo: 'Evento agregado', hora:'7:00',lugar: 'Cipolletti', frecuencia: 'semanal'}){
                  setState(() {
                    //Acá está lo que te decía de crear y reemplazar
                    calendario=Calendario(add: true, fechaYhora: DateTime(2020,3,5,12,30),);
                  });
                },
                color: Colors.green,
                child: Text('agregar 5 M'),
              ),
            ],
          ),
          //Se muestra el objeto calendario creado al principio
          calendario,
        ],
      ),
    );
  }
}