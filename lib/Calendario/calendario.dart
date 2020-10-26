import 'package:flutter/material.dart';
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
/*Esto sirve para que al volver hacia atrás y entrar de nuevo al calendario, no se borren los eventos
Después va a ser reemplazado por guardarlos en la base de datos
 */
List <Dia> diasExt =[];
class Calendario extends StatefulWidget {
  //Atributos
  bool add=false;//Indica cuando hay que añadir un evento
  bool remove=false;//Indica cuando hay que destruir un evento
  DateTime fechaYhora;//Indica en que día está el evento

  //linea que permite obtener los valores de estos atributos al crear los objetos de tipo calendario
  Calendario({Key key,this.add,this.remove,this.fechaYhora}): super(key: key);
  @override
  _CalendarioState createState([bool remove, String elDia]) => _CalendarioState();
}
class _CalendarioState extends State<Calendario> {
  //En esta lista dinámica se guardan los días. Si querés ver la clase Dia, está abajo. Es sencilla
  List <Dia> dias =diasExt;
  //Variables auxiliares
  int dia =0;//Indica en que posición de la lista (en que día) hay que añadir el evento
  int evento=0;//Indica en que posicion dentro de la lista de eventos hay que ubicar el nuevo evento
  bool distinto = false;//Indica si el día ya existe o no
  DateTime now = DateTime.now();
  //Chequea que no haya días repetidos
  bool repetido(Dia agregar, i){
    if(dias[i].stFecha!=agregar.stFecha){
      return true;
    }
    else{
      print('el dia ya existe');
      dia=i;
      print('está en la posición $i');
      return false;
    }
  }
  //Este choclo te ordena los días
  void ordenarDias(Dia agregar) {
    for (int cont = 0; cont < dias.length; cont++) {
      if (cont + 1 >= dias.length) {
        if (dias[cont].fecha.month == agregar.fecha.month) {
          if (dias[cont].fecha.day > agregar.fecha.day) {
            dia = cont;
            print('se añadio antes');
          }
          else {
            dia = cont + 1;
            print('se añadió después');
          }
        }
        else if (dias[cont].fecha.month < agregar.fecha.month) {
          dia = cont + 1;
          print('se añadió después');
        }
        else {
          dia = cont;
          print('se añadio antes');
        }
        cont = dias.length;
      }
      else {
        if (dias[cont].fecha.month <= agregar.fecha.month &&
            agregar.fecha.month < dias[cont + 1].fecha.month) {
          print('evento en posición $cont');
          if (dias[cont].fecha.month < agregar.fecha.month) {
            dia = cont + 1;
            print('se añadió después');
          }
          else if (dias[cont].fecha.day > agregar.fecha.day) {
            cont = cont;
            print('se añadio antes');
          }
          else {
            dia = cont + 1;
            print('se añadió después');
          }
          cont = dias.length;
        }
        else {
          print('más chico que el primero');
          if (dias[cont].fecha.month > agregar.fecha.month && cont == 0) {
            dia = 0;
            print('se añadio antes');
            cont = dias.length;
          }
        }
      }
    }
  }
  //Este otro ordena los eventos
  void ordenarHora(Dia agregar,diaEvento) {
    if(dias[dia].eventos.isEmpty){
      evento = 0;
      print('eventos estaba vacio');

    }
    else {
      print('Había eventos');
      for (int j = 0; j < dias[diaEvento].eventos.length; j++) {
        if(j+1>=dias[diaEvento].eventos.length){
          if(dias[diaEvento].eventos[j].hora.hour == agregar.fecha.hour) {
            if (dias[diaEvento].eventos[j].hora.minute > agregar.fecha.minute) {
              evento = j;
              print('se añadio antes');
            }
            else {
              evento = j + 1;
              print('se añadió después');
            }
          }
          else if(dias[diaEvento].eventos[j].hora.hour < agregar.fecha.hour){
            evento = j + 1;
            print('se añadió después');
          }
          else{
            evento = j;
            print('se añadio antes');
          }
          j=dias[diaEvento].eventos.length;
        }
        else {
          if (dias[diaEvento].eventos[j].hora.hour <= agregar.fecha.hour &&
              agregar.fecha.hour < dias[diaEvento].eventos[j + 1].hora.hour) {
            print('evento en posición $j');
            if (dias[diaEvento].eventos[j].hora.hour < agregar.fecha.hour) {
              evento = j + 1;
              print('se añadió después');
            }
            else
            if (dias[diaEvento].eventos[j].hora.minute > agregar.fecha.minute) {
              evento = j;
              print('se añadio antes');
            }
            else {
              evento = j + 1;
              print('se añadió después');
            }
            j = dias[diaEvento].eventos.length;
          }
          else {
            print('más chico que el primero');
            if (dias[diaEvento].eventos[j].hora.hour > agregar.fecha.hour &&
                j == 0) {
              evento = 0;
              print('se añadio antes');
              j = dias[diaEvento].eventos.length;
            }
          }
        }
      }
    }
  }
  //Método para añadir eventos
  void addEvento({titulo, hora,lugar, frecuencia}){
    Dia nuevoDia= new Dia(fecha: widget.fechaYhora, eventos:[]);

    if(dias.isNotEmpty){
      for(int i=0;i <dias.length;i++) {
        distinto = repetido(nuevoDia, i);
        if(!distinto){
          i=dias.length;
        }

      }
      if(distinto){
        ordenarDias(nuevoDia);
        dias.insert(dia,nuevoDia);
      }
    }
    else{
      dias.add(nuevoDia);
      dia=0;

    }
    ordenarHora(nuevoDia, dia);
    setState(() {
      dias[dia].eventos.insert(evento,Eventos(titulo: titulo,  hora: widget.fechaYhora, lugar: lugar, frecuencia: frecuencia));
    });
    print('dia');
    print(dia);
    print(dias[dia].eventos[evento].titulo);
    widget.add=false;
  }
  void removeEvento(int dd,int ee){
    setState(() {
      //confirma ejecución del método
      print('bye');
      dias[dd].eventos.removeAt(ee);
      //si se termina de vaciar la lista de eventos para un día, elimina el día
      if(dias[dd].eventos.isEmpty){
        dias.removeAt(dd);
      }
      //vuelve a false el atributo remove
      widget.remove=false;
    });
  }

  @override
  Widget build(BuildContext context) {
    //Llamada a los métodos
    if(widget.add==true){
      addEvento(titulo: "Añadir evento 2", hora: "8:00", lugar: "Roca", frecuencia: 'semanal');

    }
    if(widget.remove==true){
      //removeEvento();
    }
    //Esta linea podría no ser necesaria. Probé borrarla y la lista externa se mandubo actualizada, pero igual la voy a dejar
    diasExt=dias;
    return Container(
      height: 300,
      color: Colors.white,
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
      padding: EdgeInsets.fromLTRB(3,3,3,3),
      //List view que recorre los días
      child: ListView.builder(itemBuilder: (context,dia){
        return Column(
          //fecha del día
          children: [
            Text(dias[dia].stFecha,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),),
            //Espécie de separador
            Text('--------------------------------------------------------------------------------------------'),
            //ListView que recorre los eventos
            ListView.builder(
              itemBuilder: (context,evento){
                return Card(
                  color: dias[dia].eventos[evento].color,
                  child: ListTile(
                    onTap: (){
                      //Esto imprime un montón de huevadas, pero la idea es que si agregamos la página con más info, abra eso
                      dias[dia].eventos[evento].descripcion = dias[dia].eventos[evento].descripcion+'$evento';
                      print(dias[dia].eventos[evento].descripcion);
                      now=now.add(new Duration(days: 7));
                      print(now);
                    },
                    //Muestra todos los datos del evento
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(dias[dia].eventos[evento].titulo,
                          style: TextStyle(

                          ),
                        ),
                        Row(
                          children: [
                            Text(
                              '${dias[dia].eventos[evento].hora.hour}:${dias[dia].eventos[evento].hora.minute}',
                              style: TextStyle(

                              ),
                            ),
                            SizedBox(width: 10,),
                            Text(
                              dias[dia].eventos[evento].lugar,
                              style: TextStyle(
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    leading: FlatButton.icon(
                        onPressed: (){
                          setState(() {
                            removeEvento(dia,evento);
                          });
                        },
                        icon: Icon(Icons.delete),
                        label: Text('Borrar')),
                  ),
                );
              },
              itemCount: dias[dia].eventos.length,
              physics: ClampingScrollPhysics(),//Esto modifica algo del scrool porque si no al tener dos ListView se traba
              shrinkWrap: true,//Esto permite anidar ListViews
            ),
          ],
        );
      },
          itemCount: dias.length),
    );
  }
}
//Clases
class Eventos{
  String titulo;
//----------------------------------AGREGAR AL GITHUB COMPATIDO!!!!!!!!!!!!!!!!!!-----------------------------------------------------------------
  DateTime hora;
  Color color;
  String lugar;
  String frecuencia;
  String descripcion='descripción de prueba n°';

  Eventos({this.titulo,this.hora,this.lugar,this.frecuencia}){
    if(frecuencia=='diario'){
      color=Colors.blue[200];
    }
    else if(frecuencia=='semanal'){
      color=Colors.green[200];
    }
  }
}

//Cada lista de eventos tiene una fecha asignada
class Dia{
//----------------------------------AGREGAR AL GITHUB COMPATIDO!!!!!!!!!!!!!!!!!!-----------------------------------------------------------------
  List <String> Meses=['Enero','Febrero','Marzo','Abril','Mayo','Junio','Agosto','Septiembre','Octubre','Noviembre','Diciembre'];
//----------------------------------AGREGAR AL GITHUB COMPATIDO!!!!!!!!!!!!!!!!!!-----------------------------------------------------------------
  DateTime fecha;
  String stFecha;
  List <Eventos> eventos;
  Dia({this.fecha,this.eventos}){
//----------------------------------AGREGAR AL GITHUB COMPATIDO!!!!!!!!!!!!!!!!!!-----------------------------------------------------------------
    stFecha= '${fecha.day}'+' de '+Meses[fecha.month-1];
  }
}
