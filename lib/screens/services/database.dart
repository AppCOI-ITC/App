import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {

  final String uid;
  DatabaseService({ this.uid});

  // collection reference
  final CollectionReference collectionData = FirebaseFirestore.instance.collection('DataUsuarios');
  final CollectionReference collectionRespuestas = FirebaseFirestore.instance.collection('Respuestas');

  Future updateUserData(String email,String nombre, int documento) async {
    createTree(documento, nombre);
    return await collectionData.doc(uid).set({
      'email': email,
      'nombre': nombre,
      'documento': documento,
    });
  }

  Future createTree(int dni, String nombre) async {
    String dniN = dni.toString() + "-" + nombre[0];
    return await collectionRespuestas.doc(dniN).set({});
  }
  //get stream 
  Stream<QuerySnapshot> get data {
    return collectionData.snapshots();
  }
}