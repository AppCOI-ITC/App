import 'package:flutter/material.dart';
import 'package:flutter_app/screens/calendario/visualizar_calendario.dart';

/*
Notas:
 Actualizar las clases Dia y Evento para que trabajen con datos de tipo DateTime
 Poder ordenar según fecha
 Poder ordenar según hora
 Evitar que se añadan eventos duplicados

Dudas:
  CheckBox
    Añadir check box al calendario? Para que se utilizaría?
    Para eliminar eventos concretados o simplemente para llevar un registro?
    Se le enviarían estas confirmaciones al médico?
  Eliminar
    Eliminar eventos ya pasados o dejarlos como registro?
  Visualización:
    Se puede empezar a mostrar desde hoy pero poder mirar los otros?
  Botón:
    Añadir boton para abrir el calendario? Queda en la página principal o pertenece al widget?
    No es más comodo usar Gesture Detector?
  +Info:
    Al hacer click en un evento, desplegar más info?
 */
/*Lista de Dias para calendario y visualizar calendario
 */
List<Dia> dias = [
  /*Dia(fecha: DateTime(2020, 1, 1, 00, 00), eventos: [
    Eventos(
        titulo: 'evento de prueba',
        hora: DateTime(2020, 1, 1, 00, 00),
        lugar: 'chacarita',
        tipo: 'semanal')
  ])*/
];

//Funciones globales
//Función ordenar Dia
//Devuelve un int que indica en que posición agregar el día
int ordenarDia(Dia agregar) {
  int dia = 0;
  bool distinto = true; //Indica si el día ya existe o no
  print('Ordenar Dia');
  for (int cont = 0; cont < dias.length; cont++) {
    if (agregar.fecha.month > dias[cont].fecha.month) {
      dia = cont + 1;
      print('el mes de tu evento es mayor al de $cont');
      distinto = true;
    } else if (agregar.fecha.month == dias[cont].fecha.month) {
      print('el mes de tu evento es igual al de $cont');
      if (agregar.fecha.day > dias[cont].fecha.day) {
        dia = cont + 1;
        print('el día de tu evento es mayor al de $cont');
        distinto = true;
      } else if (agregar.fecha.day == dias[cont].fecha.day) {
        print('el dia de tu evento es igual al de $cont');
        distinto = false;
        dia = cont;
        cont = dias.length;
      } else {
        distinto = true;
        dia = cont;
        print('el día de tu evento es menor al de $cont');
        cont = dias.length;
      }
    } else {
      distinto = true;
      print('el mes de tu evento es menor al de $cont');
      dia = cont;
      cont = dias.length;
    }
    print('posición: $dia');
    print('distinto: $distinto');
  }
  if (distinto == true) {
    dias.insert(dia, agregar);
    print('el dia se agregó en $dia');
  } else {
    print('el dia no se agregó');
  }
  return dia;
}

//Función ordena los eventos
//Devuelve int que indica dentro de la lista de eventos de un día, en qué posición colocarlo
//Igual a ordenar día pero sin bool distinto. Falta agregarlo
int ordenarEvento(Dia agregar, diaEvento) {
  int evento = 0;
  print('Ordenar Prueba');
  for (int j = 0; j < dias[diaEvento].eventos.length; j++) {
    if (agregar.fecha.hour > dias[diaEvento].eventos[j].hora.hour) {
      evento = j + 1;
      // print('la hora tu evento es mayor a la de $j');
    } else if (agregar.fecha.hour == dias[diaEvento].eventos[j].hora.hour) {
      //  print('la hora tu evento es igual a la de $j');
      if (agregar.fecha.minute >= dias[diaEvento].eventos[j].hora.minute) {
        evento = j + 1;
        // print('los min de tu evento son mayores o iguales a los de $j');
      } else {
        evento = j;
        //print('los min de tu evento son menores a los de $j');
        j = dias[diaEvento].eventos.length;
      }
    } else {
      // print('la hora de tu evento es menor a la de $j');
      evento = j;
      j = dias[diaEvento].eventos.length;
    }
    //print('posición: $evento');
  }
  return evento;
}

//Método para añadir eventos

void addEvento({fecha, titulo, lugar, tipo}) {
  Dia nuevoDia = new Dia(fecha: fecha, eventos: []);
  int d = ordenarDia(nuevoDia);
  //Evitar que se añadan eventos repetidos en ordenar evento. Hay que comparar el evento completo. Con título, tipo, etc
  int e = ordenarEvento(nuevoDia, d);
  dias[d].eventos.insert(
      e, Eventos(titulo: titulo, hora: fecha, lugar: lugar, tipo: tipo));
  print('evento añadido');
}

class Calendario extends StatefulWidget {
  @override
  _CalendarioState createState(/*[bool remove, String elDia]*/) =>
      _CalendarioState();
}

class _CalendarioState extends State<Calendario> {
  void eliminarVacios() {
    //recorre la lista y elimina los dias vacios
    //Sirve para los dias que se generan al ver las fechas de Visualizar calendario
    for (int i = 0; i < dias.length; i++) {
      if (dias[i].eventos.isEmpty) {
        dias.removeAt(i);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    eliminarVacios();
    return Column(
      children: [
        FlatButton(
          onPressed: () async {
            await Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (bc) => VisualizarCalendario(
                        //diass: dias,
                        )));
            setState(() {});
          },
          color: Color(0xff14539A),
          child: Text(
            'Calendario Extendido',
            style: TextStyle(
              color: Color(0xffF26522),
            ),
          ),
        ),
        Container(
          height: 300,
          color: Colors.white,
          margin: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
          padding: EdgeInsets.all(3),
          //List view que recorre los días
          child: ListView.builder(
              itemBuilder: (context, dia) {
                return VerEventos(
                  dia: dia,
                );
              },
              itemCount: dias.length),
        ),
      ],
    );
  }
}

//Clases
class Eventos {
  List datos = []; //Para poder subir a firebase
  //Atributos. Agregar hora en String facilitaría la visualización en el widget
  String titulo = 'Título por defecto';
  DateTime hora;
  Color color;
  String lugar;
  String tipo;
  String descripcion = 'descripción de prueba n°';

  Eventos({this.titulo, this.hora, this.lugar, this.tipo}) {
    //Se guardan los datos para firebase
    datos.add(hora.year);
    datos.add(hora.month);
    datos.add(hora.day);
    datos.add(hora.hour);
    datos.add(hora.minute);
    datos.add(titulo);
    datos.add(lugar);
    datos.add(tipo);
    //Se imprimen los datos para comprobar
    for (int i = 0; i < datos.length; i++) {
      print('dato en $i= ${datos[i]}');
    }
    //Cambiar estos if por un switch.
    //Hacerlo cuando se mejore la interfaz para generar eventos
    if (tipo == 'diario') {
      color = Colors.blue[200];
    } else if (tipo == 'semanal') {
      color = Colors.green[200];
    }
  }
}

//Cada lista de eventos tiene una fecha asignada
class Dia {
  //Esto sirve para obtener el mes en string y poder ponerlo en stFecha
  List<String> Meses = [
    'Enero',
    'Febrero',
    'Marzo',
    'Abril',
    'Mayo',
    'Junio',
    'Julio',
    'Agosto',
    'Septiembre',
    'Octubre',
    'Noviembre',
    'Diciembre'
  ];
  DateTime fecha; //Fecha en formato de fecha
  String stFecha; //Para visualizar de forma mas cómodamente la fecha
  List<Eventos> eventos; //Lista de eventos para el día
  Dia({this.fecha, this.eventos}) {
    //Convierte a texto la fecha y la guarda en stFecha
    stFecha = '${fecha.day}' + ' de ' + Meses[fecha.month - 1];
  }
}

class VerEventos extends StatefulWidget {
  DateTime fecha;
  bool porFecha = false;
  int dia = 0;

  VerEventos({Key key, this.dia, this.fecha}) : super(key: key) {
    print('la fecha es');
    print(fecha);
    if (fecha != null) {
      porFecha = true;
      print('la fecha no es null');
    }
  }

  @override
  _VerEventosState createState() => _VerEventosState();
}

class _VerEventosState extends State<VerEventos> {
  int dia = 0;

  void removeEvento(int dd, int ee) {
    dias[dd]
        .eventos
        .removeAt(ee); //Elimina el evento en concreto del dia seleccionado
    //si se termina de vaciar la lista de eventos para un día, elimina el día
    if (dias[dd].eventos.isEmpty) {
      dias.removeAt(dd);
      if (dias.isEmpty) {
        print('Se vació la lista de días');
        dias = [];
      }
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    if (widget.porFecha == true) {
      print('día definido por fecha');
      dia = ordenarDia(Dia(fecha: widget.fecha, eventos: []));
      print(dia);
    } else {
      dia = widget.dia;
    }
    if (dias.isNotEmpty) {
      return Column(
        //fecha del día
        children: [
          Text(
            dias[dia].stFecha,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              fontFamily: 'NunitoSans',
            ),
          ),
          //Espécie de separador
          Text(
              '--------------------------------------------------------------------------------------------'),
          ListView.builder(
            itemBuilder: (context, evento) {
              return Card(
                color: dias[dia].eventos[evento].color,
                child: ListTile(
                  onTap: () {},
                  //Muestra todos los datos del evento
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        dias[dia].eventos[evento].titulo,
                        style: TextStyle(
                          fontFamily: 'NunitoSans',
                        ),
                      ),
                      Row(
                        children: [
                          Text(
                            '${dias[dia].eventos[evento].hora.hour}:${dias[dia].eventos[evento].hora.minute}',
                            style: TextStyle(
                              fontFamily: 'NunitoSans',
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            dias[dia].eventos[evento].lugar,
                            style: TextStyle(
                              fontFamily: 'NunitoSans',
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  leading: FlatButton.icon(
                      onPressed: () {
                        setState(() {
                          removeEvento(dia, evento);
                        });
                      },
                      icon: Icon(Icons.delete),
                      label: Text('Borrar',
                      style: TextStyle(
                        fontFamily: 'NunitoSans',
                        fontWeight: FontWeight.bold,
                      ),)),
                ),
              );
            },
            itemCount: dias[dia].eventos.length,
            physics: ClampingScrollPhysics(),
            //Esto modifica algo del scrool porque si no al tener dos ListView se traba
            shrinkWrap: true, //Esto permite anidar ListViews
          ),
        ],
      );
    } else {
      return Center(child: Text('Ningún evento disponible'));
    }
  }
}
