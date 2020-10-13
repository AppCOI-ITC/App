import 'package:flutter/material.dart';

class Calendario extends StatefulWidget {
  //bool setState=false;
  bool add=false;
  bool remove=false;
  String elDia;

  /*void addEvento({dia,titulo, hora,lugar, frecuencia}){
    print('hi');
    dias[dia].eventos.add(Eventos(titulo: titulo,   hora: hora, lugar: lugar, frecuencia: frecuencia));
   print(dias[dia].eventos.last.titulo);
    setState=true;
    @override
    _CalendarioState createState() => _CalendarioState();
  }*/
  /*void removeEvento(){
    print('bye');
    dias[0].eventos.removeLast();
    setState=true;
    @override
    _CalendarioState createState() => _CalendarioState();
  }*/
  Calendario({Key key,this.add,this.remove,this.elDia}): super(key: key);
  @override
  _CalendarioState createState() => _CalendarioState();
}
class _CalendarioState extends State<Calendario> {
  int dia =0;
  bool distinto = false;
  List <Dia> dias =[];
  DateTime now = DateTime.now();
  void addEvento({titulo, hora,lugar, frecuencia}){
    Dia nuevoDia= new Dia(fecha: widget.elDia, eventos:[]);
    if(dias.isNotEmpty){
      for(int i=0;i<dias.length;i++){
        if(dias[i].fecha!=nuevoDia.fecha){
          distinto=true;
        }
        else{
          distinto=false;
          print('el dia ya existe');
          dia=i;
          print('está en la posición $i');
          i=dias.length;
        }
      }
      if(distinto){
        dias.add(nuevoDia);
        dia=dias.length-1;
      }
    }
    else{
      dias.add(nuevoDia);
      dia=0;
    }
    print('hi');
    setState(() {
      dias[dia].eventos.add(Eventos(titulo: titulo,   hora: hora, lugar: lugar, frecuencia: frecuencia));
    });
    print('dia');
    print(dia);
    print(dias[dia].eventos.last.titulo);
    widget.add=false;
  }
  void removeEvento(){
    print('bye');
    for(int i=0;i<dias.length;i++){
      if(dias[i].fecha==widget.elDia){
        setState(() {
          dias[i].eventos.removeLast();
        });
        if(dias[i].eventos.isEmpty){
          dias.removeAt(i);
        }
      }
    }
    widget.remove=false;
  }

  @override
  Widget build(BuildContext context) {
    if(widget.add==true){
      addEvento(titulo: "Añadir evento 2", hora: "8:00", lugar: "Roca", frecuencia: 'semanal');
      widget.add=false;
    }
    if(widget.remove==true){
      removeEvento();
      widget.remove=false;
    }
    /*if(widget.setState==true){
      print(widget.setState);
      setState(() {
        widget.dias;
      });
      widget.setState=false;
    }*/
    return Container(
      height: 300,
      color: Colors.white,
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
      padding: EdgeInsets.fromLTRB(3,3,3,3),
      child: ListView.builder(itemBuilder: (context,dia){
        return Column(
          children: [
            Text(dias[dia].fecha,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),),
            Text('--------------------------------------------------------------------------------------------'),
            ListView.builder(
              itemBuilder: (context,evento){
                return Card(
                  color: dias[dia].eventos[evento].color,
                  child: ListTile(
                    onTap: (){
                      dias[dia].eventos[evento].descripcion = dias[dia].eventos[evento].descripcion+'$evento';
                      print(dias[dia].eventos[evento].descripcion);
                      now=now.add(new Duration(days: 7));
                      print(now);
                    },
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
                              dias[dia].eventos[evento].hora,
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
                  ),
                );
              },
              itemCount: dias[dia].eventos.length,
              physics: ClampingScrollPhysics(),
              shrinkWrap: true,
            ),
          ],
        );
      },
          itemCount: dias.length),
    );
  }
}

//evento
class Eventos{
  String titulo;
  String hora;
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
  String fecha;
  List <Eventos> eventos;
  Dia({this.fecha,this.eventos});
}