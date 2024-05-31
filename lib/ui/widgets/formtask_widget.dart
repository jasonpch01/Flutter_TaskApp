import 'package:flutter/material.dart';
import 'package:flutter_apptask/models/model_task.dart';
import 'package:flutter_apptask/services/services_firestore.dart';
import 'package:flutter_apptask/ui/widgets/textfield_widget.dart';
import 'package:flutter_apptask/ui/widgets/buttonicon_widget.dart';
import 'package:flutter_apptask/ui/general/colors.dart';

import 'package:flutter_apptask/ui/general/general_widget.dart';

class WidgetFormTask extends StatefulWidget {
  @override
  String? id;
  String? title;
  String? descripcion;
  String? date;

  WidgetFormTask({Key? key, this.id, this.title, this.descripcion, this.date})
      : super(key: key);

  State<WidgetFormTask> createState() => _WidgetFormTaskState();
}

class _WidgetFormTaskState extends State<WidgetFormTask> {
  final formKey = GlobalKey<FormState>();

  MyServiceFireStore serviceFireStore = MyServiceFireStore(collection: 'Task');

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descripcionController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();

  //_WidgetFormTaskState({this.title_, this.descripcion_, this.date_});

  String categorySelected = 'personal';

  showSelectedDate() async {
    DateTime? dateTime = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2022),
        lastDate: DateTime(2025),
        cancelText: 'Cancelar',
        confirmText: 'Aceptar',
        helpText: 'Seleccionar fecha',
        builder: (BuildContext context, Widget? widget) {
          return Theme(
            data: ThemeData.light().copyWith(
                dialogBackgroundColor: Colors.white,
                dialogTheme: DialogTheme(
                  elevation: 0,
                  backgroundColor: kBrandSecondaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18),
                  ),
                ),
                colorScheme: ColorScheme.light(
                  primary: kBrandPrimaryColor,
                )),
            child: widget!,
          );
        });

    if (dateTime != null) {
      widget.date = dateTime.toString().substring(0, 10);
      //_dateController.text = dateTime.toString().substring(0, 10);
      setState(() {});
    }
  }

  actualizarTask(String taskId) {
    if (formKey.currentState!.validate()) {
      ModelTask modelTask = ModelTask(
          id: taskId,
          title: _titleController.text,
          descripcion: _descripcionController.text,
          date: _dateController.text,
          categoria: categorySelected,
          status: true);
      print(modelTask);
      serviceFireStore.UpdateTask(modelTask)
          .then(
        (value) => {
          Navigator.pop(context),
          showSnackBarSuccess(context, 'Registrado correctamente'),
          //   if (value.isNotEmpty)
          //     {
          //       Navigator.pop(context),
          //       showSnackBarSuccess(context, 'Registrado correctamente'),
          //     }
        },
      )
          .catchError((onError) {
        showSnackBarError(context, 'Error');
        Navigator.pop(context);
      });
    }
  }

  registrarTask() {
    if (formKey.currentState!.validate()) {
      ModelTask modelTask = ModelTask(
          title: _titleController.text,
          descripcion: _descripcionController.text,
          date: _dateController.text,
          categoria: categorySelected,
          status: true);

      serviceFireStore
          .addTask(modelTask)
          .then(
            (value) => {
              if (value.isNotEmpty)
                {
                  Navigator.pop(context),
                  showSnackBarSuccess(context, 'Registrado correctamente'),
                }
            },
          )
          .catchError((onError) {
        showSnackBarError(context, 'Error');
        Navigator.pop(context);
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    _titleController.text = widget.title ?? "";
    _descripcionController.text = widget.descripcion ?? "";
    _dateController.text = widget.date ?? "";
  }

  @override
  Widget build(BuildContext context) {
    String id = widget.id ?? "";

    return Container(
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(22), topRight: Radius.circular(22))),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Agregar yarea',
                style: TextStyle(
                  fontWeight: FontWeight.w300,
                  fontSize: 15,
                ),
              ),
              hdivider10(),
              WidgetTextField(
                hintText: 'Titulo',
                icon: Icons.text_fields,
                controller: _titleController,
              ),
              hdivider10(),
              WidgetTextField(
                hintText: 'Descripcion',
                icon: Icons.description,
                controller: _descripcionController,
              ),
              hdivider10(),
              WidgetButtonIcon(
                texto: id == "" ? 'Registrar' : 'Actualizar',
                onPressed: () {
                  if (!formKey.currentState!.validate()) {
                    return;
                  }

                  if (id == "") {
                    registrarTask();
                  } else {
                    actualizarTask(id);
                  }
                },
              ),
              Wrap(
                crossAxisAlignment: WrapCrossAlignment.start,
                runAlignment: WrapAlignment.start,
                spacing: 10,
                children: [
                  FilterChip(
                    selected: categorySelected == 'personal',
                    backgroundColor: kBrandSecondaryColor,
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    selectedColor: CategoryColor[categorySelected],
                    checkmarkColor: Colors.white,
                    labelStyle: TextStyle(
                        color: categorySelected == 'personal'
                            ? Colors.white
                            : kBrandPrimaryColor),
                    label: Text('Personal'),
                    onSelected: (bool value) {
                      categorySelected = 'personal';
                      setState(() {});
                    },
                  )
                ],
              ),
              Wrap(
                crossAxisAlignment: WrapCrossAlignment.start,
                runAlignment: WrapAlignment.start,
                spacing: 10,
                children: [
                  FilterChip(
                    selected: categorySelected == 'trabajo',
                    backgroundColor: kBrandSecondaryColor,
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    selectedColor: CategoryColor[categorySelected],
                    checkmarkColor: Colors.white,
                    labelStyle: TextStyle(
                        color: categorySelected == 'trabajo'
                            ? Colors.white
                            : kBrandPrimaryColor),
                    label: const Text('Trabajo'),
                    onSelected: (bool value) {
                      categorySelected = 'trabajo';
                      setState(() {});
                    },
                  )
                ],
              ),
              WidgetTextField(
                hintText: 'Fecha',
                icon: Icons.date_range,
                onTap: () {
                  showSelectedDate();
                },
                controller: _dateController,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
