import 'package:flutter/material.dart';
import 'package:flutter_apptask/ui/general/colors.dart';

class WidgetContainerCategoryTask extends StatelessWidget {
  String categoria;

  WidgetContainerCategoryTask({required this.categoria});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:
          const EdgeInsetsDirectional.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
          color: CategoryColor[categoria],
          borderRadius: BorderRadius.circular(6)),
      child: Text(
        categoria,
        style: TextStyle(color: Colors.white, fontSize: 10),
      ),
    );
  }
}
