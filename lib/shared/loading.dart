import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color.fromARGB(255, 0xFF, 0xED, 0xE1),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            Container(
                child: Image.asset(
              "assets/images/logo.png",
              width: 300,
              height: 300,
            )),
            SpinKitThreeBounce(
              color: Color.fromARGB(255, 0x14, 0x53, 0x9A),
            )
          ],
        ),
      ),
    );
  }
}
