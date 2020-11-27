import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_app/models/userR.dart';
import 'package:flutter_app/screens/authenticate/authenticate.dart';
import 'package:flutter_app/screens/home/home.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserR>(context);
    //return either Home or Authenticate widget
    if (user == null) {
      return Authenticate();
    } else{
      return Home();
    }
  }
}