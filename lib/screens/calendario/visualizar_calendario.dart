import 'package:flutter/material.dart';
import 'package:flutter_app/Calendario/calendario.dart';
import 'package:numberpicker/numberpicker.dart';

import 'package:table_calendar/table_calendar.dart';

/*
Acá se va a mostrar un calendario con forma de tabla que vamos a importar
abajo de eso se van a mostrar dos cosas
 */
class VisualizarCalendario extends StatefulWidget {
  @override
  _VisualizarCalendarioState createState() => _VisualizarCalendarioState();
}

class _VisualizarCalendarioState extends State<VisualizarCalendario> {
  List<dynamic> prueba1 = [];
  List<dynamic> prueba2 = [];
  DateTime prueba3 = DateTime.now();
  CalendarController _controller;

  @override
  void initState() {
    super.initState();
    _controller = CalendarController();
  }

  List<Dia> hi = [];
  StatefulWidget secundario = VerEventos(fecha: DateTime.now());
  SelectorDeHora sel = SelectorDeHora(fecha: DateTime.now());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: EdgeInsets.all(3),
        child: ListView(
          children: [
            Expanded(
              flex: 5,
              child: TableCalendar(
                calendarController: _controller,
                headerStyle: HeaderStyle(
                    titleTextStyle: TextStyle(
                      fontFamily: 'NunitoSans',
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    )
                ),
                calendarStyle: CalendarStyle(
                    todayColor: Color(0xffF26522),
                    selectedStyle: TextStyle(
                      fontFamily: 'NunitoSans',
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    selectedColor: Color(0xffF26522),
                    weekdayStyle: TextStyle(
                      fontFamily: 'NunitoSans',
                    ),
                    weekendStyle: TextStyle(
                        fontFamily: 'NunitoSans',
                        color: Colors.black,
                        fontWeight: FontWeight.bold
                    )
                ),
                onDaySelected: (prueba3, prueba1, prueba2) {
                  prueba3 = _controller.selectedDay;
                  print(prueba3);
                  setState(() {
                    secundario = VerEventos(
                      /*listaEventos: hi,*/
                      fecha: prueba3,
                    );
                    sel = SelectorDeHora(
                      /*listaDias: hi,*/
                      fecha: prueba3,
                    );
                  });
                },
              ),
            ),
            Expanded(
              flex: 5,
              child: Container(
                  margin: EdgeInsets.symmetric(vertical: 10, horizontal: 3),
                  padding: EdgeInsets.all(3),
                  color: Color(0xffFFEDE1),
                  child: Center(child: secundario)),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xff14539A),
        onPressed: () {
          setState(() {
            print('me ofendistes regacho');
            secundario = sel;
          });
        },
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}

class SelectorDeHora extends StatefulWidget {
  DateTime fecha;
  int mes;
  int dia;

  SelectorDeHora({Key key, this.mes, this.dia, this.fecha}) : super(key: key) {
    print(fecha);
    if (fecha != null) {
      dia = fecha.day;
      mes = fecha.month;
      print('dia: $dia');
      print('mes: $mes');
    }
  }

  @override
  _SelectorDeHoraState createState() => _SelectorDeHoraState();
}

class _SelectorDeHoraState extends State<SelectorDeHora> {
  int dia = 0;
  TextEditingController titulo = TextEditingController();
  String tit;
  int m = 2;
  int d = 1;
  DateTime horaYminutos;
  int hora = 15;
  int minutos = 30;

  @override
  Widget build(BuildContext context) {
    m = widget.mes;
    d = widget.dia;
    print('mes y dia');
    print(m);
    print(d);
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextField(
            controller: titulo,
            autofocus: false,
            keyboardType: TextInputType.text,
            textCapitalization: TextCapitalization.sentences,
            decoration: InputDecoration(
              hintText: 'Ingrese el título del evento',
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              NumberPicker.integer(
                initialValue: hora,
                minValue: 0,
                maxValue: 23,
                step: 1,
                infiniteLoop: true,
                onChanged: (value) => setState(() => hora = value),
              ),
              Text(':'),
              NumberPicker.integer(
                initialValue: minutos,
                minValue: 0,
                maxValue: 60,
                step: 1,
                infiniteLoop: true,
                onChanged: (value) => setState(() => minutos = value),
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          FlatButton(
            onPressed: () {
              horaYminutos =
                  new DateTime(DateTime.now().year, m, d, hora, minutos);
              print(horaYminutos);
              addEvento(
                  fecha: horaYminutos,
                  titulo: titulo.text,
                  lugar: 'San Martín',
                  tipo: 'semanal');
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (bc) => VisualizarCalendario()));
            },
            child: Text('Crear Evento'),
          ),
        ],
      ),
    );
  }
}
