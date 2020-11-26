import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

var textInputDecoration = InputDecoration(
  border: OutlineInputBorder(borderRadius: BorderRadius.circular(30.0),borderSide: BorderSide.none),
  filled: true,
  fillColor: Color.fromARGB(150, 0xFF, 0xFF, 0xFF),
  labelStyle: TextStyle(
    fontSize: 20.0,
    fontWeight: FontWeight.w600,
    color: Color.fromARGB(255, 0x14, 0x53, 0x9A),
  ),
  hintStyle: TextStyle(
    fontSize: 20.0,
    fontWeight: FontWeight.w600,
    color: Color.fromARGB(255, 0x14, 0x53, 0x9A),
  ) 
);

