/// Bar chart example
import 'package:flutter/material.dart';

class SimpleBarChart extends StatelessWidget {
  final List<dynamic> seriesList;
  final bool? animate;

  SimpleBarChart(this.seriesList, {this.animate});

  @override
  Widget build(BuildContext context) {
    return Container();
    //return new charts.BarChart(
    //  seriesList,
    //  animate: animate,
    //);
  }
}
