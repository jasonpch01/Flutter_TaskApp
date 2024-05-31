import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_apptask/models/model_task.dart';

class MyServiceFireStore {
  String collection;
  MyServiceFireStore({required this.collection});

  late final CollectionReference _collectionReference =
      FirebaseFirestore.instance.collection(collection);

  // add
  Future<String> addTask(ModelTask modelTask) async {
    DocumentReference documentReference =
        await _collectionReference.add(modelTask.toJson());
    String id = documentReference.id;
    return id;
  }

  //delete

  Future<void> finishedTask(String taskId) async {
    await _collectionReference.doc(taskId).update({'status': false});
  }

  //update

  Future<void> UpdateTask(ModelTask modelTask) async {
    print(modelTask.toJson());
    await _collectionReference.doc(modelTask.id).update({
      'title': modelTask.title,
      'descripcion': modelTask.descripcion,
      'date': modelTask.date,
      'status': true
    });
  }
}
