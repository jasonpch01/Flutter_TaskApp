import 'package:flutter/material.dart';
import 'package:flutter_apptask/models/model_task.dart';
import 'package:flutter_apptask/services/services_firestore.dart';
import 'package:flutter_apptask/ui/general/colors.dart';
import 'package:flutter_apptask/ui/general/general_widget.dart';
import 'package:flutter_apptask/ui/widgets/content_category_task.dart';
import 'package:flutter_apptask/ui/widgets/formtask_widget.dart';

class WidgetContainerTask extends StatelessWidget {
  ModelTask modelTask;

  WidgetContainerTask({
    required this.modelTask,
  });

  final MyServiceFireStore _myServiceFireStore =
      MyServiceFireStore(collection: 'Task');

  showTaskForm(BuildContext context, ModelTask task) {
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        backgroundColor: Colors.transparent,
        builder: (BuildContext context) {
          return Padding(
            padding: MediaQuery.of(context).viewInsets,
            child: WidgetFormTask(
              id: task.id,
              title: task.title,
              descripcion: task.descripcion,
              date: task.date,
            ),
          );
        });
  }

  showFinishedDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Column(mainAxisSize: MainAxisSize.min, children: [
              Text(
                'Finalizar tare',
                style: TextStyle(
                  color: kBrandPrimaryColor.withOpacity(0.87),
                  fontWeight: FontWeight.w600,
                ),
              ),
              hdivider6(),
              Text(
                '¿Desea finalizar la tarea?',
                style: TextStyle(
                    color: kBrandPrimaryColor.withOpacity(0.87),
                    fontWeight: FontWeight.w400,
                    fontSize: 13.0),
              ),
              hdivider10(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                      onPressed: () {},
                      child: Text(
                        'Cancelar',
                        style: TextStyle(
                            color: kBrandPrimaryColor.withOpacity(0.5),
                            fontWeight: FontWeight.w400,
                            fontSize: 14),
                      )),
                  wdivider10(),
                  ElevatedButton(
                    onPressed: () {
                      _myServiceFireStore.finishedTask(modelTask.id!);
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                        primary: kBrandPrimaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        )),
                    child: Text('Finalizar'),
                  )
                ],
              )
            ]),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 0),
      padding:
          const EdgeInsetsDirectional.symmetric(horizontal: 14, vertical: 16),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.04),
                offset: const Offset(4, 4),
                blurRadius: 12)
          ]),
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              WidgetContainerCategoryTask(
                categoria: modelTask.categoria,
              ),
              hdivider3(),
              Text(
                modelTask.title,
                style: TextStyle(
                    decoration: modelTask.status
                        ? TextDecoration.none
                        : TextDecoration.lineThrough,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: kBrandPrimaryColor.withOpacity(0.85)),
              ),
              Text(
                modelTask.descripcion,
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: kBrandPrimaryColor.withOpacity(0.75)),
              ),
              hdivider6(),
              Text(
                modelTask.date,
                style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: kBrandPrimaryColor.withOpacity(0.75)),
              ),
            ],
          ),
          Positioned(
              top: -10,
              right: -12,
              child: PopupMenuButton(
                elevation: 2,
                color: Colors.white,
                icon: Icon(
                  Icons.more_vert,
                  color: kBrandPrimaryColor.withOpacity(0.85),
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
                onSelected: (value) {
                  if (value == 1) {
                    showTaskForm(context, modelTask);
                    print(modelTask.title);
                  } else if (value == 2) {
                    showFinishedDialog(context);
                  }
                },
                itemBuilder: (BuildContext context) {
                  return [
                    PopupMenuItem(
                        value: 1,
                        child: Text(
                          'Editar',
                          style: TextStyle(
                            fontSize: 14,
                            color: kBrandPrimaryColor.withOpacity(0.85),
                          ),
                        )),
                    modelTask.status
                        ? PopupMenuItem(
                            value: 2,
                            child: Text(
                              'Finalizar',
                              style: TextStyle(
                                fontSize: 14,
                                color: kBrandPrimaryColor.withOpacity(0.85),
                              ),
                            ),
                          )
                        : const PopupMenuItem(
                            value: 3,
                            child: Text(''),
                          ),
                  ];
                },
              ))
        ],
      ),
    );
  }
}
