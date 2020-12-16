import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Plantillas {

  Widget formatoAppBar(String texto){
    return AppBar(
      title: Text(texto,style: TextStyle(color: Color.fromARGB(255, 0x14, 0x53, 0x9A),fontWeight: FontWeight.bold)),
      centerTitle: true,
      elevation: 0.0,
      backgroundColor: Color.fromARGB(255, 0xFF, 0xED, 0xE1),
      leading: Container(),
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
    );
  }

  Widget formatoBottomBar(){
    return BottomAppBar(
      elevation: 0.0,
      color: Color.fromARGB(255, 0xFF, 0xED, 0xE1),
      child: Padding(
        padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: 1.5,
              color: Color.fromARGB(255, 0x14, 0x53, 0x9A),
            ),
            SizedBox(
              height: 50.0,
            )
          ],
        )
      ),
    );
  }
}