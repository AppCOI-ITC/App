import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {

  final String uid;
  DatabaseService({ this.uid});

  // collection reference
  final CollectionReference collectionBD = FirebaseFirestore.instance.collection('DataUsuarios');

  Future updateUserData(String email,String nombre, int documento) async {
    return await collectionBD.doc(uid).set({
      'email': email,
      'nombre': nombre,
      'documento': documento,
    });
  }

  //get stream 
  Stream<QuerySnapshot> get data {
    return collectionBD.snapshots();
  }
}