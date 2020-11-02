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
/*Esto sirve para que al volver hacia atrás y entrar de nuevo al calendario, no se borren los eventos
Después va a ser reemplazado por guardarlos en la base de datos
 */
List <Dia> diasExt =[Dia(fecha: DateTime(2020,11,25,00,00),eventos: [
  Eventos(titulo: 'Navidad',hora: DateTime(2020,11,25,00,00),lugar: 'casa',tipo: 'semanal')]),
  Dia(fecha: DateTime(2020,11,30,23,59),eventos: [
    Eventos(titulo: 'Año Nuevo',hora: DateTime(2020,11,30,23,59),lugar: 'casa',tipo: 'semanal')])];
class Calendario extends StatefulWidget {
  //Atributos
  List <Dia> diasWidget =[];
  bool cargarDias=false;
  bool reemplazarDias=false;
  //[Dia(fecha: DateTime(2020,1,1,00,00),eventos: [
  //  Eventos(titulo: 'evento de prueba',hora: DateTime(2020,1,1,00,00),lugar: 'chacarita',tipo: 'semanal')])];
  bool add=false;//Indica cuando hay que añadir un evento
  bool remove=false;//Indica cuando hay que destruir un evento
  DateTime fechaYhora;//Indica en que día está el evento
  //linea que permite obtener los valores de estos atributos al crear los objetos de tipo calendario
  Calendario({Key key,this.add,this.remove,this.fechaYhora,this.diasWidget,this.cargarDias,this.reemplazarDias}): super(key: key);
  @override
  _CalendarioState createState(/*[bool remove, String elDia]*/) => _CalendarioState();
}
class _CalendarioState extends State<Calendario> {
  //En esta lista dinámica se guardan los días. Si querés ver la clase Dia, está abajo. Es sencilla
  List <Dia> dias=[];
  //Variables auxiliares
  int dia =0;//Indica en que posición de la lista (en que día) hay que añadir el evento
  int evento=0;//Indica en que posicion dentro de la lista de eventos hay que ubicar el nuevo evento
  DateTime now = DateTime.now();
  @override
  void initState(){

    //widget.diasWidget=dias;
    super.initState();
  }
  @override
  void deactivate() {
    print(dias[0].stFecha);
    // TODO: implement deactivate
    super.deactivate();
  }
    //Función ordenar Dia
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
  //Este otro ordena los eventos
  void ordenarEvento(Dia agregar, diaEvento){
    evento=0;
    print('Ordenar Prueba');
    for (int j = 0; j < dias[diaEvento].eventos.length; j++) {
      if(agregar.fecha.hour>dias[diaEvento].eventos[j].hora.hour){
        evento=j+1;
       // print('la hora tu evento es mayor a la de $j');
      }
      else if(agregar.fecha.hour==dias[diaEvento].eventos[j].hora.hour){
      //  print('la hora tu evento es igual a la de $j');
        if(agregar.fecha.minute>=dias[diaEvento].eventos[j].hora.minute){
          evento=j+1;
         // print('los min de tu evento son mayores o iguales a los de $j');
        }
        else{
          evento=j;
          //print('los min de tu evento son menores a los de $j');
          j=dias[diaEvento].eventos.length;
        }
      }
      else{
       // print('la hora de tu evento es menor a la de $j');
        evento=j;
        j=dias[diaEvento].eventos.length;
      }
      //print('posición: $evento');
    }
  }
  //Método para añadir eventos



  void addEvento({fecha,titulo,lugar, tipo}){
    Dia nuevoDia= new Dia(fecha: fecha, eventos:[]);
    ordenarDia(nuevoDia);
    //Intentar incluir el if en ordenar Dia. Tratar de replicar en ordenar evento. Hay que comparar el evento completo. Con título, tipo, etc
    ordenarEvento(nuevoDia, dia);
      setState(() {
      dias[dia].eventos.insert(evento,Eventos(titulo: titulo,  hora: fecha, lugar: lugar, tipo: tipo));
      print('evento añadido');
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
  void recuperarDias(){
    for(int i=0;i<diasExt.length;i++){
      for(int j =0;j<diasExt[i].eventos.length;j++) {
        setState(() {
          addEvento(fecha: DateTime(diasExt[i].eventos[j].datos[0],diasExt[i].eventos[j].datos[1],diasExt[i].eventos[j].datos[2],diasExt[i].eventos[j].datos[3],diasExt[i].eventos[j].datos[4]),titulo: diasExt[i].eventos[j].datos[5],tipo:diasExt[i].eventos[j].datos[7],lugar: diasExt[i].eventos[j].datos[6]);
        });


      }
    }
    /*
    addEvento(fecha: diasExt[i].eventos[j].hora,titulo: diasExt[i].eventos[j].titulo,tipo:diasExt[i].eventos[j].tipo,lugar: diasExt[i].eventos[j].lugar);
    print('hello there');
    dias=widget.diasWidget;
    print(dias[0].stFecha);
    widget.cargarDias=false;*/
  }
  void reemplazarLista(@required List <Dia> nuevoDias){
    dias.removeRange(0, dias.length);
    for(int i=0;i<nuevoDias.length;i++){
      for(int j =0;j<nuevoDias[i].eventos.length;j++) {
        setState(() {
          addEvento(fecha: nuevoDias[i].eventos[j].hora,titulo: nuevoDias[i].eventos[j].titulo,tipo:nuevoDias[i].eventos[j].tipo,lugar: nuevoDias[i].eventos[j].lugar);
        });
        print('j: $j');
      }
      print('i: $i');
    }
  }
  @override
  Widget build(BuildContext context) {
    if(widget.cargarDias==true){
      print(widget.cargarDias);
      print(diasExt[0].eventos[0].titulo);
      recuperarDias();
      widget.cargarDias=false;
    }
    print(widget.cargarDias);
    if(widget.reemplazarDias==true){
      reemplazarLista(widget.diasWidget);
      //recuperarDias();
      widget.reemplazarDias=false;
    }
    //Llamada a los métodos
    if(widget.add==true){
      addEvento(fecha: widget.fechaYhora,titulo: "Añadir evento 2", lugar: "Roca", tipo: 'semanal');

    }
    if(widget.remove==true){
      //removeEvento();
    }
    return Column(
      children: [
        FlatButton(
        onPressed: (){
      //, arguments: {calendario} visualizarCal
          enviarEvento(context, dias);
      //Navigator.pushNamed(context,'/visualizarCal',arguments:  dias);
      //Navigator.pushNamed(context, '/visualizarCal', );
    },
        child: Text('Calendario Extendido'),),
        Container(
          height: 300,
          color: Colors.white,
          margin: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
          padding: EdgeInsets.fromLTRB(3,3,3,3),
          //List view que recorre los días
          child: ListView.builder(itemBuilder: (context,dia){
            return/* Column(
              //fecha del día
              children: [
                Text(dias[dia].stFecha,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),),
                //Espécie de separador
                Text('--------------------------------------------------------------------------------------------'),*/
                //ListView que recorre los eventos
                VerEventos(listaEventos: dias,dia: dia,);
              /*],
            );*/
          },
              itemCount: dias.length),
        ),
      ],
    );
  }
}
//Clases
class Eventos{
  List datos =[];//Para poder subir a firebase
  //Atributos. Agregar hora en String facilitaría la visualización en el widget
  String titulo='Título por defecto';
  DateTime hora;
  Color color;
  String lugar;
  String tipo;
  String descripcion='descripción de prueba n°';

  Eventos({this.titulo,this.hora,this.lugar,this.tipo}){
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
    for(int i=0; i<datos.length;i++){
      print('dato en $i= ${datos[i]}');
    }
    //Cambiar estos if por un switch.
    //Hacerlo cuando se mejore la interfaz para generar eventos
    if(tipo=='diario'){
      color=Colors.blue[200];
    }
    else if(tipo=='semanal'){
      color=Colors.green[200];
    }
  }
}
void enviarEvento(context,List <Dia> hello){
  //se configura la ruta
  Route route =MaterialPageRoute(builder: (bc) => VisualizarCalendario());
  //se hace aparecer la ventana Cuestionario2
  Navigator.of(context).pushReplacement(route,result: hello);
}
//Cada lista de eventos tiene una fecha asignada
class Dia{
  //Esto sirve para obtener el mes en string y poder ponerlo en stFecha
  List <String> Meses=['Enero','Febrero','Marzo','Abril','Mayo','Junio','Agosto','Septiembre','Octubre','Noviembre','Diciembre'];
  DateTime fecha;//Fecha en formato de fecha
  String stFecha;//Para visualizar de forma mas cómodamente la fecha
  List <Eventos> eventos;//Lista de eventos para el día
  Dia({this.fecha,this.eventos}){
    //Convierte a texto la fecha y la guarda en stFecha
    stFecha= '${fecha.day}'+' de '+Meses[fecha.month-1];
  }
}
class VerEventos extends StatefulWidget {
  DateTime fecha;
  bool porFecha=false;
  List <Dia> listaEventos=[];
  int dia=0;
  VerEventos({Key key, @required this.listaEventos, this.dia, this.fecha}):super(key: key){
    print('la fecha es');
    print(fecha);
    if(fecha!=null){
      porFecha=true;
      print('la fecha no es null');
    }
  }
  @override
  _VerEventosState createState() => _VerEventosState();
}

class _VerEventosState extends State<VerEventos> {


  List <Dia> dias=[];
  int dia=0;

  //Método choriado
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

  @override
  Widget build(BuildContext context) {
    dias=widget.listaEventos;
    if(widget.porFecha==true){
      print('día definido por fecha');
      ordenarDia(Dia(fecha: widget.fecha, eventos: []));
      print(dia);
    }
    else {
      dia = widget.dia;
    }
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
          ListView.builder(
          itemBuilder: (context,evento){
            return Card(
              color: dias[dia].eventos[evento].color,
              child: ListTile(
                onTap: (){
                  //Esto imprime un montón de huevadas, pero la idea es que si agregamos la página con más info, abra eso
                  /* dias[dia].eventos[evento].descripcion = dias[dia].eventos[evento].descripcion+'$evento';
                              print(dias[dia].eventos[evento].descripcion);
                              now=now.add(new Duration(days: 7));
                              print(now);*/
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
                        //removeEvento(dia,evento);
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

  }
}
