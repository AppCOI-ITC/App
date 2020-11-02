import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../Calendario/calendario.dart';
/*
Acá se va a mostrar un calendario con forma de tabla que vamos a importar
abajo de eso se van a mostrar dos cosas
 */
class VisualizarCalendario extends StatefulWidget {
  bool obtenerDias=true;
  @override
  _VisualizarCalendarioState createState() => _VisualizarCalendarioState();
}

class _VisualizarCalendarioState extends State<VisualizarCalendario> {
  List <dynamic>prueba1=[];
  List <dynamic>prueba2=[];
  DateTime prueba3 =DateTime.now();
  CalendarController _controller;
  @override
  void initState( ) {
    super.initState();
    _controller=CalendarController();
  }
  int mes=3;
  int dia=1;
  List <Dia> hi=[];
  StatefulWidget secundario;
  SelectorDeHora sel;
  @override
  Widget build(BuildContext context) {
    print('obtener días');
    print(widget.obtenerDias);
    //data = ModalRoute.of(context).settings.arguments;
    if(widget.obtenerDias) {
     hi = ModalRoute.of(context).settings.arguments;
      //List <Dia> hola =data['dias'];
      //String tittulo=hola[0].eventos[0].titulo;
      print(hi[0].eventos[0].titulo);
      secundario=VerEventos(listaEventos: hi,dia: 0,);
      widget.obtenerDias=false;
    }
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: EdgeInsets.all(3),
        child: Column(
          children: [
            Expanded(
              flex: 5,
              child: TableCalendar(calendarController: _controller,
              onDaySelected:(prueba3 ,prueba1, prueba2){
                prueba3=_controller.selectedDay;
                print(prueba3);
                setState(() {
                  secundario=VerEventos(listaEventos: hi,fecha: prueba3,);
                  sel=SelectorDeHora(listaDias: hi,fecha: prueba3,);
                });
              },),
            ),
            SizedBox(height: 15,),
            Expanded(
              flex: 5,
              child: Container(
                color: Colors.blue[100],
                  child: Center(
                      child: secundario)
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          setState(() {
            secundario=sel;
                //SelectorDeHora(/*mes: mes,dia: dia,*/ listaDias: hi, fecha: prueba3);

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
  List <Dia> listaDias=[];
  int mes;
  int dia;
  SelectorDeHora({Key key,this.mes,this.dia,this.listaDias, this.fecha}): super(key: key){
    print(fecha);
    if(fecha!=null){
      dia=fecha.day;
      mes=fecha.month;
      print('dia: $dia');
      print('mes: $mes');
    }
  }
  @override
  _SelectorDeHoraState createState() => _SelectorDeHoraState();
}

class _SelectorDeHoraState extends State<SelectorDeHora> {
  List <Dia> dias=[];
  int dia=0;
  void ordenarDia(Dia agregar){
    dia=0;
    bool distinto=true;//Indica si el día ya existe o no
    print('Ordenar Dia');
    for (int cont = 0; cont < dias.length; cont++) {
      if(agregar.fecha.month>dias[cont].fecha.month){
        dia=cont+1;
        print('el mes de tu evento es mayor al de $cont');
        distinto=true;
      }
      else if(agregar.fecha.month==dias[cont].fecha.month){
        print('el mes de tu evento es igual al de $cont');
        if(agregar.fecha.day>dias[cont].fecha.day){
          dia = cont+1;
          print('el día de tu evento es mayor al de $cont');
          distinto=true;
        }
        else if(agregar.fecha.day==dias[cont].fecha.day){
          print('el dia de tu evento es igual al de $cont');
          distinto=false;
          dia=cont;
          cont=dias.length;
        }
        else{
          distinto=true;
          dia=cont;
          print('el día de tu evento es menor al de $cont');
          cont=dias.length;
        }
      }
      else{
        distinto=true;
        print('el mes de tu evento es menor al de $cont');
        dia=cont;
        cont=dias.length;
      }
      print('posición: $dia');
      print('distinto: $distinto');
    }
    if(distinto==true) {
      dias.insert(dia, agregar);
      print('el dia se agregó en $dia');
    }
    else{
      print('el dia no se agregó');
    }
  }
  TextEditingController titulo =TextEditingController();
  String tit;
  int m=2;
  int d=1;
  DateTime horaYminutos;
  int hora = 15;
  int minutos = 30;
  @override
  void initState() {

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    dias=widget.listaDias;
    m=widget.mes;
    d=widget.dia;
    print('mes y dia');
    print(m);
    print(d);
    ordenarDia(Dia(fecha: widget.fecha,eventos: []));
    print('se va a añadir en posición');
    print(dia);
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
          SizedBox(height: 20,),
          FlatButton(
            onPressed: () {
              horaYminutos = new DateTime(2020, m, d, hora, minutos);
              print(horaYminutos);
              dias[dia].eventos.add(Eventos(titulo: titulo.text, hora: horaYminutos,lugar: 'San Martín', tipo: 'semanal'));
              print(dias[dia].eventos.last.titulo);
              guardarEvento(context,dias);
              //Navigator.pushReplacementNamed(context, '/visualizarCal', arguments: dias);
            },
            child: Text('Capturar hora'),
          ),
        ],
      ),
    );
  }
}
void guardarEvento(context,List <Dia> hello){
  //se configura la ruta
  Route route =MaterialPageRoute(builder: (bc) => VisualizarCalendario());
  //se hace aparecer la ventana Cuestionario2
  Navigator.of(context).pushReplacement(route,result: hello);
}

