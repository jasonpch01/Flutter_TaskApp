import 'package:flutter/material.dart';
import 'package:flutter_apptask/models/model_task.dart';
import 'package:flutter_apptask/ui/widgets/container_task.dart';

class SearchTask extends SearchDelegate {
  List<ModelTask> modelTask;

  SearchTask({required this.modelTask});

  @override
  String? get searchFieldLabel => "Buscar tarea...";

  @override
  // TODO: implement searchFieldStyle
  TextStyle? get searchFieldStyle => TextStyle(
        fontSize: 16.0,
      );

  @override
  List<Widget>? buildActions(BuildContext context) {
    // TODO: implement buildActions
    return [
      IconButton(
        onPressed: () {
          query = "";
        },
        icon: Icon(
          Icons.close,
        ),
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, "");
      },
      icon: Icon(
        Icons.arrow_back,
      ),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    List<ModelTask> results = modelTask
        .where((element) =>
            element.title.toLowerCase().contains(query.toLowerCase()))
        .toList();

    return Padding(
      padding: const EdgeInsets.all(14.0),
      child: ListView.builder(
        itemCount: results.length,
        itemBuilder: (BuildContext context, int index) {
          return WidgetContainerTask(
            modelTask: ModelTask(
                title: '',
                descripcion: '',
                date: '',
                categoria: '',
                status: false),
          );
        },
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<ModelTask> results = modelTask
        .where((element) =>
            element.title.toLowerCase().contains(query.toLowerCase()))
        .toList();

    return Padding(
      padding: const EdgeInsets.all(14.0),
      child: ListView.builder(
        itemCount: results.length,
        itemBuilder: (BuildContext context, int index) {
          return WidgetContainerTask(
            modelTask: ModelTask(
                title: '',
                descripcion: '',
                date: '',
                categoria: '',
                status: false),
          );
        },
      ),
    );
  }
}
