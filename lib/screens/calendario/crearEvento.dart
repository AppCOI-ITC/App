import 'package:flutter/material.dart';
/*
Creación 24/10/20
Notas:
Acá vamos a mostrar el calendario con todos los días. Ese
También va a estar para crear eventos acá, por ahora
valta hacer que el objeto DateTime que se crea se pase a Home para pasarlo como parametro en la función para crear un evento
 */
class CrearEvento extends StatefulWidget {
  @override
  _CrearEventoState createState() => _CrearEventoState();
}

class _CrearEventoState extends State<CrearEvento> {
  //Estos sirven para almacenar el valor del campo de texto
  TextEditingController titulo =TextEditingController();
  TextEditingController mes =TextEditingController();
  TextEditingController dia =TextEditingController();
  TextEditingController hora =TextEditingController();
  TextEditingController minuto =TextEditingController();
  //variables
  List <String> Meses=['Enero','Febrero','Marzo','Abril','Mayo','Junio','Agosto','Septiembre','Octubre','Noviembre','Diciembre'];
  //Titulo del Evento
  String tit;
  //Mes
  int m=0;
  //Día
  int d=1;
  //Hora
  int h=12;
  //Minuto
  int min=30;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text('Crear Evento Personalizado'),
          //Acá están todos los campos de texto
          SizedBox(
            height: 10,
          ),
          TextField(
            controller: titulo,
            autofocus: false,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              hintText: 'Ingrese el título del evento',
            ),
          ),
          SizedBox(height: 10,),
          TextField(
            controller: mes,
            autofocus: false,
            textCapitalization: TextCapitalization.sentences,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              hintText: 'Ingrese el mes',
            ),
          ),
          SizedBox(height: 10,),
          TextField(
            controller: dia,
            autofocus: false,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              hintText: 'Ingrese el dia',
            ),
          ),
          SizedBox(height: 10,),
          TextField(
            controller: hora,
            autofocus: false,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              hintText: 'Ingrese la hora',
            ),
          ),
          SizedBox(height: 10,),
          TextField(
            controller: minuto,
            autofocus: false,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              hintText: 'Ingrese el minuto',
            ),
          ),
          SizedBox(height: 10,),
          FlatButton(
            onPressed: (){
              /*
              Se extraen los valores de los objetos Controller y se transforman
              en int en los casos en los que es necesario
               */
              tit=titulo.text;
              print(tit);
              m= 1+Meses.indexOf(mes.text);
              print(m);
              d=int.parse(dia.text);
              print(d);
              h=int.parse(hora.text);
              print(h);
              min=int.parse(minuto.text);
              print(min);
              DateTime prueba=new DateTime(2020,m,d,h,min);
              print(prueba);
              //Manda el dato de vuelta
              Navigator.pop(context, prueba);
            },
            child: Text('Crear'),
          )
        ],
      ),
    );
  }
}
