import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_app/Calendario/calendario.dart';
import 'package:flutter_app/custom_icons_icons.dart';
import 'package:flutter_app/screens/cuestionario/cuestionario.dart';
import 'package:flutter_app/screens/cuestionario/cuestionarioExcepcional.dart';
import 'package:flutter_app/screens/services/auth.dart';
import 'package:flutter_app/messagin.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  //Objetos
  Calendario calendario = new Calendario();
  final AuthService _auth = AuthService();
  final _messaging = FBMessaging.instance;
  //Variables
  bool excepcional = false;

  void setExcepcion() {
    excepcional = false;
  }

//cuadro de "advertencia"
  void advertencia(context, excepcion) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Color.fromARGB(255, 0xF9, 0x35, 0x49),
            title: Text(
              'Cuidado',
              textAlign: TextAlign.center,
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                    '¿Seguro/a de querer reportar síntomas anormales? Esto enviará una alerta a su médico'),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    RaisedButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        onPressed: () {
                          Navigator.of(context).pop();
                          excepcional = false;
                        },
                        child: Text('No')),
                    RaisedButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      onPressed: () {
                        Navigator.of(context).pop(); //?
                        pantallaCE(context, excepcion);
                      },
                      child: Text('Si'),
                    )
                  ],
                )
              ],
            ),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(30.0))),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    //Funcion encargada de escuchar las notificaciones
    _messaging.stream.listen((event) {
      print('New Message: $event');
    });

    //===========Widget===========
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 0xFF, 0xED, 0xE1),
      //===================================
      //==============DRAWNER==============
      //===================================
      drawer: ClipRRect(
        //ClipRRect permite darle al drawer la forma circular
        borderRadius: BorderRadius.only(bottomRight: Radius.circular(60.0)),
        child: Drawer(
          elevation: 5.0,
          child: Container(
            color: Color.fromARGB(255, 0xFF, 0xED, 0xE1),
            child: Column(
              children: [
                //Parte superior del drawer
                SizedBox(
                  height: 15.0,
                ),
                SizedBox(
                  height: 50.0,
                  child: Text(
                    'Menu',
                    style: TextStyle(
                        color: Color.fromARGB(255, 0x14, 0x53, 0x9A),
                        fontSize: 30.0),
                    textAlign: TextAlign.center,
                  ),
                ),
                Container(
                  height: 1.3,
                  color: Color.fromARGB(255, 0x14, 0x53, 0x9A),
                ),

                //Parte inferior del drawer
                //=>Reporte de errores
                ListTile(
                  leading: Icon(Icons.assistant_photo),
                  title: Text('Reportar error'),
                  onTap: () => pantallaCE(context, excepcional),
                ),
                //=>Activar notificaciones
                ListTile(
                  leading: Icon(Icons.ac_unit),
                  title: Text('Notificaciones'),
                  onTap: () {
                    final _messaging = FBMessaging.instance;
                    _messaging.init().then((_) async {
                      await _messaging.requestPermission().then((_) async {
                        final _token = await _messaging.getToken();
                        print('Token: $_token');
                      });
                    });
                  },
                ),
                ListTile(
                    leading: Icon(Icons.accessibility_new),
                    title: Text('Acerca de'),
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              scrollable: true,
                              title: Text('Créditos'),
                              content: Text(
                                  'Esta aplicación fue creada por alumnos de 6to año del colegio ITC en el marco de pasantías en la institución COI.\n\n Uso de cuestionarios QLQ-C30 \n Aaronson NK, Ahmedzai S, Bergman B, Bullinger M, Cull A, Duez NJ, Filiberti A, Flechtner H, Fleishman SB, de Haes JCJM, Kaasa S, Klee MC, Osoba D, Razavi D, Rofe PB, Schraub S, Sneeuw KCA, Sullivan M, Takeda F. The European Organisation for Research and Treatment of Cancer QLQ-C30: A quality-of-life instrument for use in international clinical trials in oncology. Journal of the National Cancer Institute 1993; 85: 365-376. \n\n CREADORES \n\t Apablaza Tomás \n\t Calderón Francisco \n\t Iril Rocco \n\t Triviño Lautaro',
                                  style: TextStyle(
                                    color:
                                        Color.fromARGB(255, 0x14, 0x53, 0x9A),
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.w400,
                                  )),
                              actions: [
                                RaisedButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: Text('Cerrar'))
                              ],
                            );
                          });
                    }),
                //=>Cierre de sesion
                ListTile(
                    leading: Icon(Icons.exit_to_app),
                    title: Text('Cerrar sesión'),
                    onTap: () async {
                      await _auth.signOut();
                    }),
              ],
            ),
          ),
        ),
      ),
      //===================================
      //==============APPBAR===============
      //===================================
      appBar: AppBar(
        //icono del drawer
        automaticallyImplyLeading: false,
        leading: Builder(builder: (BuildContext context) {
          return IconButton(
            icon: Icon(CustomIcons.home),
            color: Color.fromARGB(255, 0x14, 0x53, 0x9A),
            onPressed: () => Scaffold.of(context).openDrawer(),
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
      //===================================
      //==============BODY=================
      //===================================
      body: Container(
        color: Color.fromARGB(255, 0xFF, 0xED, 0xE1),
        child: ListView(
          padding: EdgeInsets.only(top: 50.0),
          // mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            //===========CALENDARIO================
            calendario,
            //=====BOTON->Cuestionario excepcional===
            Row(children: [
              Flexible(
                  flex: 1,
                  fit: FlexFit.tight,
                  child: Container(
                    margin: EdgeInsets.only(right: 17.0, left: 17.0),
                    child: FlatButton.icon(
                      icon: Icon(
                        CustomIcons.info,
                        color: Color.fromARGB(255, 0x14, 0x53, 0x9A),
                        size: 18,
                      ),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0)),
                      color: Color.fromARGB(150, 0xFF, 0xFF, 0xFF),
                      label: Text(
                        'Reporte de sintomas anormales',
                        style: TextStyle(
                          color: Color.fromARGB(255, 0x14, 0x53, 0x9A),
                          fontSize: 18.0,
                          fontWeight: FontWeight.w400,
                        ),
                        textAlign: TextAlign.start,
                      ),
                      onPressed: () {
                        print('En proceso');
                        setState(() => excepcional = true);
                        advertencia(context, excepcional);
                      },
                    ),
                  )),
            ]),
            //=====BOTON->Cuestionario===========
            Row(children: [
              Flexible(
                  flex: 1,
                  fit: FlexFit.tight,
                  child: Container(
                    margin: EdgeInsets.only(right: 17.0, left: 17.0, top: 7.0),
                    child: FlatButton.icon(
                        icon: Icon(
                          CustomIcons.alerta,
                          color: Color.fromARGB(255, 0x14, 0x53, 0x9A),
                          size: 18,
                        ),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0)),
                        color: Color.fromARGB(150, 0xFF, 0xFF, 0xFF),
                        label: Text(
                          'Cuestionario -- QLQ-C30',
                          style: TextStyle(
                            color: Color.fromARGB(255, 0x14, 0x53, 0x9A),
                            fontSize: 18.0,
                            fontWeight: FontWeight.w400,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        onPressed: () {
                          print('En proceso');
                          setState(() {
                            Route route = MaterialPageRoute(
                                builder: (bc) => Cuestionario());
                            Navigator.of(context).push(route);
                          });
                        }),
                  )),
            ])
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
          content: Text(
              'Esta aplicación está en etapa de pruebas. Esta función será implementada en el futuro'),
          actions: [
            RaisedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('Cerrar'))
          ],
        );
      });
}

//cambio a la pantalla del cuestionario excepcional
//dependiendo del estado de la variable bool se envia el registro a excepcion o a cuestionarios expecionales
void pantallaCE(context, bool excepcion) {
  Route route =
      MaterialPageRoute(builder: (bc) => CExcepcional(excepcional: excepcion));
  Navigator.of(context).push(route);
}
