import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/custom_icons_icons.dart';
import 'package:flutter_app/screens/home/home.dart';
import 'package:flutter_app/shared/constants.dart';

class CExcepcional extends StatefulWidget {
  final bool excepcional;
  const CExcepcional({Key key, this.excepcional}) : super(key: key);

  @override
  _CExcepcionalState createState() => _CExcepcionalState();
}

class _CExcepcionalState extends State<CExcepcional> {
  final CollectionReference collectionBD =
      FirebaseFirestore.instance.collection('DataUsuarios');
  final FirebaseAuth auth = FirebaseAuth.instance;
  final _formKey = GlobalKey<FormState>();
  String respuesta = '';
  String excepcion = "Síntomas anormales";
  String error = "Defina su error";

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: new Scaffold(
          backgroundColor: Color.fromARGB(255, 0xFF, 0xED, 0xE1),
          appBar: AppBar(
            //icono del drawer
            automaticallyImplyLeading: false,
            title: Text(
              widget.excepcional ? excepcion : error,
              style: TextStyle(
                  color: Color.fromARGB(255, 0x14, 0x53, 0x9A), fontSize: 25.0),
              textAlign: TextAlign.center,
            ),
            leading: Builder(builder: (BuildContext context) {
              return IconButton(
                icon: Icon(CustomIcons.home),
                color: Color.fromARGB(255, 0x14, 0x53, 0x9A),
                onPressed: () {
                  Route casa = MaterialPageRoute(builder: (bc) => Home());
                  Navigator.pop(context);
                  Navigator.of(context).push(casa);
                },
              );
            }),
            centerTitle: true,
            elevation: 0.0,
            backgroundColor: Color.fromARGB(255, 0xFF, 0xED, 0xE1),

            //barra inferior del appbar
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(10.0),
              child: Padding(
                padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
                child: Container(
                  height: 1.3,
                  color: Color.fromARGB(255, 0x14, 0x53, 0x9A),
                ),
              ),
            ),
          ),
          body: new Container(
            padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      SizedBox(),
                      TextField(
                        minLines: 10,
                        maxLines: 20,
                        decoration: textInputDecoration,
                        onChanged: (value) {
                          setState(() => respuesta = value);
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 300,
                  height: 50,
                  child: RaisedButton.icon(
                    icon: Icon(
                      Icons.send,
                      color: Color.fromARGB(255, 0x14, 0x53, 0x9A),
                      size: 25.0,
                    ),
                    elevation: 1,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        side: BorderSide(
                          width: 2,
                          color: Color.fromARGB(255, 0x14, 0x53, 0x9A),
                        )),
                    color: Colors.black.withOpacity(0.05),
                    label: Text(
                      'Enviar',
                      style: TextStyle(
                          color: Color.fromARGB(255, 0x14, 0x53, 0x9A),
                          fontSize: 22.0),
                      textAlign: TextAlign.center,
                    ),
                    onPressed: () {
                      if (_formKey.currentState.validate()) {
                        inputData(respuesta, widget.excepcional);
                      }
                    },
                  ),
                ),
              ],
            ),
          )),
    );
  }

  void inputData(String answer, bool excepcion) {
    final User user = auth.currentUser;
    final uid = user.uid;
    // here you write the codes to input the data into firestore
    //collectionBD.doc(uid).set({'Cuestionario Excepcional': answer,});
    if (excepcion == true) {
      collectionBD
          .doc(uid)
          .collection('Cuestionarios excepcionales')
          .add({'Cuestionario': answer});
    } else {
      FirebaseFirestore.instance.collection('Error').add({'Error': answer});
    }
    Navigator.of(context).pop();
  }
}