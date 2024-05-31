import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_apptask/ui/general/colors.dart';
import 'package:flutter_apptask/ui/general/general_widget.dart';
import 'package:flutter_apptask/ui/widgets/container_task.dart';
import 'package:flutter_apptask/ui/widgets/textfield_widget.dart';
import 'package:flutter_apptask/models/model_task.dart';
import 'package:flutter_apptask/ui/widgets/buttonicon_widget.dart';
import 'package:flutter_apptask/ui/widgets/formtask_widget.dart';
import 'package:flutter_apptask/ui/widgets/search_task.dart';

class HomrePage extends StatelessWidget {
  List<ModelTask> TaskGeneral = [];
  final TextEditingController _searchController = TextEditingController();

  CollectionReference taskReference =
      FirebaseFirestore.instance.collection('Task');

  ModelTask modelTask = ModelTask(
      title: '', descripcion: '', date: '', categoria: '', status: false);

  showTaskForm(BuildContext context) {
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        backgroundColor: Colors.transparent,
        builder: (BuildContext context) {
          return Padding(
              padding: MediaQuery.of(context).viewInsets,
              child: WidgetFormTask(
                id: '',
                title: '',
                descripcion: '',
                date: '',
              ));
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: kBrandSecondaryColor,
        floatingActionButton: InkWell(
          onTap: () {
            showTaskForm(context);
          },
          child: Container(
            padding: const EdgeInsetsDirectional.symmetric(
                horizontal: 16, vertical: 3),
            decoration: BoxDecoration(
              color: kBrandPrimaryColor,
            ),
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.add,
                  color: Colors.white,
                ),
                Text(
                  'Nueva tarea',
                  style: TextStyle(color: Colors.white),
                )
              ],
            ),
          ),
        ),
        appBar: AppBar(
          title: Text('App Task'),
        ),
        body: SingleChildScrollView(
            child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 18),
              //width: double.infinity,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.only(
                      bottomRight: Radius.circular(20),
                      bottomLeft: Radius.circular(20)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 12,
                      offset: const Offset(4, 4),
                    )
                  ]),
              child: SafeArea(
                child: Column(
                  children: [
                    Text(
                      'Mis Tareas',
                      style: TextStyle(
                        fontSize: 35,
                        fontWeight: FontWeight.bold,
                        color: kBrandPrimaryColor,
                      ),
                    ),
                    hdivider10(),
                    WidgetTextField(
                      hintText: 'Buscar tarea',
                      icon: Icons.search,
                      controller: _searchController,
                      onTap: () async {
                        await showSearch(
                            context: context,
                            delegate: SearchTask(modelTask: TaskGeneral));
                      },
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(5),
              child: Column(
                children: [
                  StreamBuilder(
                      stream: taskReference.snapshots(),
                      builder: (BuildContext context, AsyncSnapshot snap) {
                        if (snap.hasData) {
                          List<ModelTask> tasks = [];
                          QuerySnapshot collection = snap.data;

                          // tasks = collection.docs
                          //     .map(
                          //       (e) => ModelTask.fromJson(
                          //           e.data() as Map<String, dynamic>),
                          //     )
                          //     .toList();
                          tasks = collection.docs.map((e) {
                            ModelTask modelTask = ModelTask.fromJson(
                                e.data() as Map<String, dynamic>);
                            modelTask.id = e.id;
                            return modelTask;
                          }).toList();
                          TaskGeneral.clear();
                          TaskGeneral = tasks;

                          return ListView.builder(
                            itemCount: tasks.length,
                            shrinkWrap: true,
                            physics: const ScrollPhysics(),
                            itemBuilder: (BuildContext context, int index) {
                              tasks[0];
                              return WidgetContainerTask(
                                  modelTask: tasks[index]);
                            },
                          );
                        }
                        return loadingWidget();
                      })
                ],
              ),
            )
          ],
        ))
        // StreamBuilder(
        //   stream: taskReference.snapshots(),
        //   builder: (BuildContext context, AsyncSnapshot snap) {
        //     if (snap.hasData) {
        //       QuerySnapshot collection = snap.data;
        //       List<QueryDocumentSnapshot> docs = collection.docs;
        //       List<Map<String, dynamic>> docsMap =
        //           docs.map((e) => e.data() as Map<String, dynamic>).toList();
        //       print(docsMap);
        //       return ListView.builder(
        //           itemCount: docsMap.length,
        //           itemBuilder: (BuildContext context, int index) {
        //             return ListTile(
        //               title: Text(
        //                 docsMap[index]['title'],
        //               ),
        //             );
        //           });
        //     }
        //     return Center(
        //       child: CircularProgressIndicator(),
        //     );
        //   },
        // ),
        );
  }
}

/*
Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                print(taskReference.get());
                taskReference.get().then((value) {
                  // QuerySnapshot collection = value;
                  // List<QueryDocumentSnapshot> docs = collection.docs;
                  // QueryDocumentSnapshot doc = docs[0];
                  // print(doc.data());

                  QuerySnapshot collection = value;
                  collection.docs.forEach((QueryDocumentSnapshot element) {
                    Map<String, dynamic> myMap =
                        element.data() as Map<String, dynamic>;

                    print(myMap);
                  });
                });
              },
              child: Text('Data'),
            ),
            ElevatedButton(
              onPressed: () {
                taskReference
                    .add({
                      "title": "flutter",
                      "descripcion": "otra descripcrion"
                    })
                    .then((DocumentReference value) => {print(value)})
                    .catchError((onError) {
                      print(onError);
                    })
                    .whenComplete(() => {print('El registrar a terminado')});
              },
              child: Text('Agregar data'),
            ),
            ElevatedButton(
              onPressed: () {
                taskReference.doc('vUThwprbyieGWSF3jmKo').update({
                  'title': 'actualizado',
                  'descripcion': 'actualizado'
                }).catchError((onError) {
                  print(onError);
                }).whenComplete(
                  () => {print('Actualizado correctamento')},
                );
              },
              child: Text('Actualizar data'),
            ),
            ElevatedButton(
              onPressed: () {
                taskReference
                    .doc('vUThwprbyieGWSF3jmKo')
                    .delete()
                    .catchError((onError) {
                  print(onError);
                }).whenComplete(() {
                  print('Eliminado Correctamente');
                });
              },
              child: Text('Eliminar doc'),
            ),
          
          ],
        ),
      ),
*/
