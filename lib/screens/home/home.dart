import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_app/screens/cuestionario/cuestionario.dart';
import 'package:flutter_app/screens/cuestionario/cuestionarioExcepcional.dart';
import 'package:flutter_app/screens/services/auth.dart';


class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final AuthService _auth = AuthService();

  final FirebaseAuth auth = FirebaseAuth.instance;
  User user;

  @override
  void initState() {
    super.initState();
    initUser();
  }

  initUser() async {
    user = await auth.currentUser;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[50],
      //===================================
      //==============DRAWNER==============
      //===================================
      drawer: Drawer(
        elevation: 10.0,
        child: ListView(
          children: [
            UserAccountsDrawerHeader(
              accountName: Text("${user?.displayName}"),
              accountEmail: Text("${user?.email}"),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.grey[400],
              ),
              decoration: BoxDecoration(color: Color.fromRGBO(109, 213, 250, 1)),
            ),
            ListTile(
              leading: Icon(Icons.assistant_photo),
              title: Text('reportar error'),
              onTap: (){
                print('en proceso...');
                proceso(context);
              },    
            ),
            ListTile(
              leading: Icon(Icons.exit_to_app),
              title: Text('cerrar sesion'), 
              onTap: () async {
                await _auth.signOut();
              }
            )
          ],
        ),
      ),
      //===================================
      //==============APPBAR===============
      //===================================
      appBar: AppBar(
        title: Text('COI - ITC', style: TextStyle(color: Colors.black)),
        centerTitle: true,
        backgroundColor: Color.fromRGBO(109, 213, 250, 1),
        elevation: 4.0,
        iconTheme: IconThemeData(color: Colors.black),
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
            //=====BOTON->Cuestionario===========
            SizedBox(
              height: 100.0,
              width: 400.0,
              child: RaisedButton(
                color: Colors.green[300],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0)
                ),
                elevation: 6.0,
                child: Text('Cuestionario',style: TextStyle(fontSize: 40.0),),
                onPressed: (){
                  Route route = MaterialPageRoute(builder: (bc) => Cuestionario());
                  Navigator.of(context).push(route);
                },
              ), 
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                //=====BOTON->Reportes===============
                SizedBox(
                  height: 50.0,
                  width: 175.0,
                  child: RaisedButton.icon(
                    icon: Icon(Icons.receipt),
                    elevation: 6.0,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                    color: Colors.green[300],
                    label: Text('Reportes', style: TextStyle(fontSize: 23.0)),
                    onPressed: () {
                     print('en proceso');
                      proceso(context);
                   },
                  ),
                ),
                //=====BOTON->Calendario=============
                SizedBox(
                  height: 50.0,
                  width: 175.0,
                  child: RaisedButton.icon(
                    icon: Icon(Icons.calendar_today),
                    elevation: 6.0,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                    label: Text('Calendario', style: TextStyle(fontSize: 22.0)),
                    color: Colors.green[300],
                    onPressed: () {
                     print('en proceso');
                      proceso(context);
                   },
                  ),
                ),
              ],
            ),
            //=====BOTON->Cuestionario excepcional===
            SizedBox(
              height: 100.0,
              width: 400.0,
              child: RaisedButton.icon(
                icon: Icon(Icons.assignment_late,size: 35.0,),
                elevation: 6.0,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                color: Colors.red[400],
                label: Text('Cuestionario Excepcional', style: TextStyle(fontSize: 25.0),textAlign: TextAlign.center,),
                onPressed: () {
                  advertencia(context);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void pantallaCE(context) {
  Route route = MaterialPageRoute(builder: (bc) => CExcepcional());
  Navigator.of(context).push(route);
}

void advertencia(context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Advertencia'),
        content: Text('Esta seguro de querer realizar un cuestionario excepcional'),
        actions: [
          RaisedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('No')
          ),
          RaisedButton(
              onPressed: () {
                Navigator.of(context).pop();
                pantallaCE(context);
              },
              child: Text('Si'),
          )
        ],
      );
    }
  );

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