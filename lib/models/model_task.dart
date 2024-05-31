class ModelTask {
  String? id;
  String title;
  String descripcion;
  String date;
  String categoria;
  bool status;

  ModelTask(
      {this.id,
      required this.title,
      required this.descripcion,
      required this.date,
      required this.categoria,
      required this.status});

  factory ModelTask.fromJson(Map<String, dynamic> json) => ModelTask(
        id: json['id'] ?? '',
        title: json['title'],
        descripcion: json['descripcion'],
        date: json['date'],
        categoria: json['categoria'],
        status: json['status'],
      );

  Map<String, dynamic> toJson() => {
        'title': title,
        'descripcion': descripcion,
        'date': date,
        'categoria': categoria,
        'status': status
      };
}
