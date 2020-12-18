import 'dart:async';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_app/models/plantillas.dart';
import 'package:flutter_app/screens/home/home.dart';
import 'package:flutter_app/shared/loading.dart';
import 'package:flutter_app/custom_icons_icons.dart';

DocumentReference ref;

class Cuestionario extends StatefulWidget {
  @override
  _CuestionarioState createState() => _CuestionarioState();
}

class _CuestionarioState extends State<Cuestionario> {
  final CollectionReference collectionBD =
      FirebaseFirestore.instance.collection('DataUsuarios');
  final FirebaseAuth auth = FirebaseAuth.instance;
  User user;
  get uid => auth.currentUser.uid;
  Future<List<dynamic>> preguntas = FirebaseFirestore.instance
      .collection('Preguntas')
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
  bool dosr = false;
  final reset = <bool>[false, false, false, false, false, false, false];
  final isSelected = <bool>[false, false, false, false, false, false, false];
  List<int> respuestasCuest = List.filled(31, -1);

  Widget build(BuildContext context) {
    Future<String> recuperar() async {
      String out;
      out = await collectionBD.doc(uid).get().then((value) {
        var dni = value['documento'];
        var nombre = value['nombre'];
        var outInt = dni.toString() + "-" + nombre[0];
        return outInt;
      });
      return out;
    }

    void analisisRespuesta() {
      String alarma = "El paciente XXXX presenta los siguientes síntomas:";
      String mensaje = "Se le recomienda: ";
      bool alarmaPresente = false;
      bool mensajePresente = false;
      if (respuestasCuest[7] >= 3) {
        alarma += "\n\n Disnea";
        alarmaPresente = true;
      }
      if (respuestasCuest[8] >= 3 ||
          respuestasCuest[17] >= 2 ||
          respuestasCuest[18] >= 2) {
        alarma += "\n\n Dolor";
        alarmaPresente = true;
      }
      if (respuestasCuest[9] == 4 || respuestasCuest[10] == 4) {
        alarma += "\n\n Insomnio";
        alarmaPresente = true;
      }
      if (respuestasCuest[11] >= 3 ||
          respuestasCuest[12] >= 3 ||
          respuestasCuest[13] >= 3) {
        alarma += "\n\n Náuseas";
        alarmaPresente = true;
      }
      if (respuestasCuest[14] >= 2) {
        alarma += "\n\n Vómitos";
        alarmaPresente = true;
        mensaje +=
            "\n\n Tomar quince (15) gotas de reliveran o un (1) comprimido de ondansetron";
        mensajePresente = true;
      }
      if (respuestasCuest[15] >= 2) {
        mensaje +=
            "\n\n Tomar abundante líquido, intentar moverse más, comer más verduras y frutas, menos queso y harinas";
        mensajePresente = true;
        if (respuestasCuest[15] == 4) {
          alarma += "\n\n Constipación";
          alarmaPresente = true;
        }
      }
      if (respuestasCuest[16] >= 2) {
        mensaje +=
            "\n\n Comer arroz o polenta con queso, evitar comidas ricas en grasas y cosas que aumentan la diarrea como salsas, frutas o jugos";
        mensajePresente = true;
        if (respuestasCuest[16] == 4) {
          alarma += "\n\n Diarrea";
          alarmaPresente = true;
        }
      }
      for (int i = 19; i < 27; i++) {
        if (respuestasCuest[i] == 4) {
          alarma += "\n\n Psicológica";
          alarmaPresente = true;
        }
      }
      showDialog(
          //Se va a modificar en un futuro
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('¡Cuestionario subido exitosamente!',
                  style: TextStyle(
                      color: Color.fromARGB(255, 0x14, 0x53, 0x9A),
                      fontWeight: FontWeight.bold)),
              content: Text(
                  (alarmaPresente ? alarma : "") +
                      "\n\n" +
                      (mensajePresente ? mensaje : ""),
                  style:
                      TextStyle(color: Color.fromARGB(255, 0x14, 0x53, 0x9A))),
              actions: [
                RaisedButton(
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.pop(context);
                    },
                    child: Text('Cerrar'))
              ],
            );
          });
    }

    void subirRespuestas() async {
      String dniN = await recuperar();
      FirebaseFirestore.instance
          .collection('Respuestas')
          .doc(dniN)
          .update(creadorMaps(respuestasCuest));
      print(respuestasCuest);
      analisisRespuesta();
    }

//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
    List<Widget> crearBotones(int cant) {
      List listings = List<Widget>();
      List<String> respuestas = [];
      respuestas = ["1", "2", "3", "4", "5", "6", "7"];
      //if (cant == 4) respuestas = ["En absoluto", "Un poco", "Bastante", "Mucho"];
      //else respuestas = ["1", "2", "3", "4", "5", "6", "7"];
      for (int i = 0; i < cant; i++) {
        listings.add(Padding(
          //10
          padding: EdgeInsets.all(2.5),
          child: SizedBox.fromSize(
              //40,40
              size: Size(50, 50),
              child: MaterialButton(
                  elevation: 0.0,
                  shape: CircleBorder(
                      side: BorderSide(
                          width: 1.5,
                          color: Color.fromARGB(255, 0x14, 0x53, 0x9A))),
                  textColor: !isSelected[i]
                      ? Color.fromARGB(255, 0x14, 0x53, 0x9A)
                      : Colors.white,
                  color: !isSelected[i]
                      ? Colors.black.withOpacity(0.05)
                      : Color.fromARGB(255, 0x14, 0x53, 0x9A),
                  child: Padding(
                    padding: const EdgeInsets.all(5),
                    child: Text(
                      respuestas[i],
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 25.0),
                    ),
                  ),
                  onPressed: () {
                    setState(() {
                      isSelected.setAll(0, reset);
                      isSelected[i] = true;
                    });
                    respuestasCuest[index] = i + 1;
                  })),
        ));
      }
      double espacio;
      if (listings.length == 2) {
        dosr = true;
      } else if (listings.length == 4) {
        espacio = 250;
      } else if (listings.length == 7) {
        espacio = 400;
      }
      List listafinal = List<Widget>();
      listafinal.add(SizedBox(
        child: Column(
          children: [
            Row(
              children: listings,
            ),
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                children: [
                  SizedBox(
                    width: dosr ? 100 : espacio,
                    child: Text(dosr ? "No" : "En absoluto",
                        style: TextStyle(
                            color: Color.fromARGB(255, 0x14, 0x53, 0x9A),
                            fontWeight: FontWeight.bold)),
                  ),
                  Center(
                    child: Text(dosr ? "Sí" : "Mucho",
                        style: TextStyle(
                            color: Color.fromARGB(255, 0x14, 0x53, 0x9A),
                            fontWeight: FontWeight.bold)),
                  ),
                ]),
          ],
        ),
      ));
      return listafinal;
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
                appBar:
                    Plantillas().formatoAppBar("Pregunta ${index + 1} de 31"),
                body: Center(
                  child: AspectRatio(
                    aspectRatio: 2 / 3,
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
                              children: [
                                Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Row(children: crearBotones(cant)),
                                    ])
                              ]),
                        ),
                      ],
                    ),
                  ),
                ),
                bottomNavigationBar: BottomAppBar(
                  elevation: 0.0,
                  color: Color.fromARGB(255, 0xFF, 0xED, 0xE1),
                  child: Column(
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
                          IconButton(
                              icon: Icon(CustomIcons.flecha1),
                              onPressed: () {
                                setState(() {
                                  if (index - 1 > -1) {
                                    index--;
                                    isSelected.setAll(0, reset);
                                    if (respuestasCuest[index] != -1) {
                                      isSelected[respuestasCuest[index] - 1] =
                                          true;
                                    }
                                  }
                                  dosr = false;
                                });
                              }),
                          RaisedButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0)),
                            child: Text("Subir cuestionario",
                                style: TextStyle(
                                    color:
                                        Color.fromARGB(255, 0x14, 0x53, 0x9A),
                                    fontWeight: FontWeight.bold)),
                            onPressed:
                                cuestionarioF ? () => subirRespuestas() : null,
                          ),
                          IconButton(
                              icon: Icon(CustomIcons.flecha),
                              onPressed: () {
                                setState(() {
                                  if (index + 1 < 31) {
                                    index++;
                                    //navegacion();
                                    if (respuestasCuest[index] != -1) {
                                      isSelected.setAll(0, reset);
                                      isSelected[respuestasCuest[index] - 1] =
                                          true;
                                    } else {
                                      isSelected.setAll(0, reset);
                                    }
                                  }
                                  if ((index == 30) &&
                                      (respuestasCuest.indexOf(-1) == -1))
                                    cuestionarioF = true;
                                  dosr = false;
                                });
                              })
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
  Map<String, dynamic> map = {
    "${fecha.substring(0, 16).replaceAll('T', '_')}": lista
  };
  return map;
}
