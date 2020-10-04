import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/screens/cuestionario/cuestionario.dart';
import 'package:flutter_app/screens/services/auth.dart';
import 'package:flutter_app/screens/services/database.dart';
import 'package:provider/provider.dart';


class Home extends StatelessWidget {

  final AuthService _auth = AuthService();
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown[50],
      //===================================
      //==============DRAWNER==============
      //===================================
      drawer: Drawer(
        child: ListView(
          children: [
            UserAccountsDrawerHeader(
              accountName: Text('Nombre'),
              accountEmail: Text('campo de texto'),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.grey[400],
              ),
              decoration: BoxDecoration(color: Colors.grey[350]),
            ),
            ListTile(
              leading: Icon(Icons.assistant_photo),
              title: Text('reportar error'),
              onTap: (){
                print('en proceso...');
                proceso(context);
              } 
            )
          ],
        ),
      ),
      //===================================
      //==============APPBAR===============
      //===================================
      appBar: AppBar(
        title: Text('COI - ITC'),
        backgroundColor: Colors.brown[400],
        elevation: 0.0,
        actions: <Widget>[
          FlatButton.icon( 
            icon: Icon(Icons.person),
            label: Text('logout'), 
            onPressed: () async {
              await _auth.signOut();
            }
          )
        ],
      ),
      //===================================
      //==============BODY=================
      //===================================
      body: 
      Container(
        color: Colors.grey[100],
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                //=====BOTON->Reportes===============
                RaisedButton(
                  elevation: 5.0,
                  color: Colors.redAccent[400],
                  onPressed: () {
                    print('en proceso');
                    proceso(context);
                  },
                  child: Text('Reportes', style: TextStyle(fontSize: 30.0)),
                  padding: EdgeInsets.fromLTRB(25.0, 70.0, 35.0, 70.0),
                ),
                //=====BOTON->Calendario=============
                RaisedButton(
                  elevation: 5.0,
                  color: Colors.blueAccent[400],
                  onPressed: () {
                    print('en proceso');
                    proceso(context);
                  },
                  child: Text('Calendario', style: TextStyle(fontSize: 30.0)),
                  padding: EdgeInsets.fromLTRB(10.0, 70.0, 10.0, 70.0), //35.0, 70.0, 25.0, 70.0
                ),
              ],
            ),
            //=====BOTON->Cuestionario excepcional===
            RaisedButton(
              elevation: 5.0,
              color: Colors.greenAccent[400],
              onPressed: () {
                print('cuestionario presionado');
                Route route =MaterialPageRoute(builder: (bc) => Cuestionario());
                Navigator.of(context).push(route);
              },
              child: Text('Cuestionario extra', style: TextStyle(fontSize: 30.0)),
              padding: EdgeInsets.fromLTRB(70.0, 100.0, 70.0, 100.0),
            )
          ],
        ),
      ),
    );
  }
}

void proceso(context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('En proceso!'),
        content: Text('Esta aplicación está en etapa de pruebas. Esta función será implementada en el futuro'),
        actions: [
          RaisedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cerrar'))
        ],
      );
    }
  );
}
