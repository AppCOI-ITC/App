import 'dart:async';
import 'dart:html';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_app/models/plantillas.dart';
import 'package:flutter_app/shared/loading.dart';
import 'package:flutter_app/custom_icons_icons.dart';
DocumentReference ref;

class Cuestionario extends StatefulWidget {
  @override
  _CuestionarioState createState() => _CuestionarioState();
}

class _CuestionarioState extends State<Cuestionario> {
  final CollectionReference collectionBD = FirebaseFirestore.instance.collection('DataUsuarios');
  final FirebaseAuth auth = FirebaseAuth.instance;
  User user;
  get uid => auth.currentUser.uid; 
  Future<List<dynamic>> preguntas = FirebaseFirestore.instance.collection('Preguntas')
      .doc('#001')
      .get()
      .then((docSnap) {
    print("in");
    var preguntas = docSnap['preguntas'];
    print(preguntas);
    print("out");
    return preguntas;
  });

  initUser() async { 
    user = auth.currentUser;
  }
  
  bool cuestionarioF = false;
  int index = 0;
  final reset = <bool>[false, false, false, false, false, false, false];
  final isSelected = <bool>[false, false, false, false, false, false, false];
  List<int> respuestasCuest = List.filled(30, -1);

  Widget build(BuildContext context) {

    Future<String> recuperar() async{
      String out;
      out = await collectionBD.doc(uid).get().then((value) {
        var dni = value['documento'];
        var nombre = value['nombre'];
        var outInt = dni.toString()+"-"+nombre[0]; 
        return outInt;
      });
      return out;
    }

//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
    List<Widget> crearBotones(int cant) {
      List listings = List<Widget>();
      List<String> respuestas = [];
      respuestas = ["1", "2", "3", "4", "5", "6", "7"];
      //if (cant == 4) respuestas = ["En absoluto", "Un poco", "Bastante", "Mucho"];
      //else respuestas = ["1", "2", "3", "4", "5", "6", "7"];
      
      for (int i = 0; i < cant; i++) {
        listings.add(
          Padding(
            //10
            padding: EdgeInsets.all(2.5),
            child: SizedBox.fromSize(
              //40,40
              size: Size(50, 50),
              child: MaterialButton(
                elevation: 0.0,
                shape: CircleBorder(side: BorderSide(width: 1.5,color: Color.fromARGB(255, 0x14, 0x53, 0x9A))),
                textColor: !isSelected[i] ? Color.fromARGB(255, 0x14, 0x53, 0x9A) : Colors.white,
                color: !isSelected[i] ? Colors.black.withOpacity(0.05) : Color.fromARGB(255, 0x14, 0x53, 0x9A),
                child: Padding(
                  padding: const EdgeInsets.all(5),
                  child: Text(respuestas[i],textAlign: TextAlign.center,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25.0),),
                ),
                onPressed: () {
                  setState(() {
                    isSelected.setAll(0, reset);
                    isSelected[i] = true;
                  });
                  respuestasCuest[index] = i;
                }
              )
            ),
          )
        );
      }
      return listings;
    }


//+++++++++++++++++++++++++++++++++++++++++++++++++++++

    return FutureBuilder<List<dynamic>>(
        future: preguntas,
        builder: (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot) {
          try {
            if (snapshot.connectionState == ConnectionState.done) {
              List<dynamic> data = snapshot.data;
              if (data == null) {
                return Text('No hay nada');
              }
              int cant = int.parse(data[index][data[index].length - 1]);
              return Scaffold(
                backgroundColor: Color.fromARGB(255, 0xFF, 0xED, 0xE1),
                appBar: Plantillas().formatoAppBar("Cuestionario"),
                body: Center(
                  child: AspectRatio(
                  aspectRatio: 2/3,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.all(20.0),
                        child: SizedBox(
                          child: Text(
                            data[index].split('-')[0], 
                            style: TextStyle(
                              color: Color.fromARGB(255, 0x14, 0x53, 0x9A),
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      FittedBox(
                        //height: 300.0,
                        fit: BoxFit.fitWidth,
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: crearBotones(cant),
                        ),
                      ),
                      ],
                    ),
                  ),
                ),
                bottomNavigationBar: BottomAppBar(
                  elevation: 0.0,
                  color: Color.fromARGB(255, 0xFF, 0xED, 0xE1),
                  child: cuestionarioF ? 
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                        padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
                        child: Container(
                          height: 1.2,
                          color: Color.fromARGB(255, 0x14, 0x53, 0x9A),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(icon:  Icon(CustomIcons.flecha1), onPressed: (){setState(() {
                          if(index-1 > -1) {
                            index--;
                            isSelected.setAll(0, reset);
                            if (respuestasCuest[index] != -1) {
                                            isSelected[respuestasCuest[index]] =
                                                true;
                            }
                          }
                        });}),
                          IconButton(
                            
                            icon: Icon(Icons.arrow_upward), 
                            onPressed: () async {
                              String dniN = await recuperar();
                              FirebaseFirestore.instance
                              .collection('Respuestas')
                              .doc(dniN)    
                              .update(creadorMaps(respuestasCuest));
                              print(respuestasCuest);
                            }
                            // FirebaseFirestore.instance
                            //     .collection('Respuestas')
                            //     .doc(dniN)
                            //     .get()
                            //     .then((doc) {
                            //   if (doc.exists) {
                            //     FirebaseFirestore.instance
                            //         .collection('Respuestas')
                            //         .doc(dniN)
                            //         .update(
                            //             creadorMaps(respuestasCuest));
                            //   } else {
                            //     FirebaseFirestore.instance
                            //         .collection('Respuestas')
                            //         .doc(dniN)
                            //         .set(
                            //             creadorMaps(respuestasCuest));
                            //   }
                          ),
                          IconButton(
                            icon: Icon(CustomIcons.flecha), 
                            onPressed: (){setState(() {
                              if(index+1 < 30) {
                                index++;
                                if(respuestasCuest[index] != -1){
                                  isSelected.setAll(0, reset);
                                  isSelected[respuestasCuest[index]] = true;
                                }else{
                                  isSelected.setAll(0, reset);
                                }  
                              }
                              if((index==29) && (respuestasCuest.indexOf(-1) == -1)) cuestionarioF = true;
                            });}
                          )
                        ],
                      ) 
                    ],
                  )
                  : 
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                        padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
                        child: Container(
                          height: 1.2,
                          color: Color.fromARGB(255, 0x14, 0x53, 0x9A),
                        ),
                      ),
                      Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(icon:  Icon(CustomIcons.flecha1), onPressed: (){setState(() {
                          if(index-1 > -1) {
                            index--;
                            isSelected.setAll(0, reset);
                            if (respuestasCuest[index] != -1) {
                                            isSelected[respuestasCuest[index]] =
                                                true;
                            }
                          }
                        });}),
                        IconButton(
                          icon: Icon(CustomIcons.flecha), 
                          onPressed: (){setState(() {
                            if(index+1 < 30) {
                              index++;
                              //navegacion();
                              if(respuestasCuest[index] != -1){
                                isSelected.setAll(0, reset);
                                isSelected[respuestasCuest[index]] = true;
                              }else{
                                isSelected.setAll(0, reset);
                              }  
                            }
                            if((index==29) && (respuestasCuest.indexOf(-1) == -1)) cuestionarioF = true;
                          });}
                        )
                      ],
                    ),
                    ],
                  ),
                ),
              );
            }
            return Loading();
          } catch (e) {
            snapshot.hasError ? Text("Error de data") : null;
          }
    });
  }
}

Map creadorMaps(List<int> lista) {
  String fecha = DateTime.now().toIso8601String();
  Map<String, dynamic> map = {"${fecha.substring(0,16).replaceAll('T', '_')}": lista};
  return map;
}