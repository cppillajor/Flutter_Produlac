import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:intl/intl.dart';

class chartDefault extends StatefulWidget {
  List lista_fecha_litros;
  chartDefault(this.lista_fecha_litros) ;

  @override
  _chartDefaultState createState() => _chartDefaultState();
}

class _chartDefaultState extends State<chartDefault> {
  bool isCardView = false;
  List<_ChartData>? chartData=[];

  @override
  void initState() {
    for (var item in widget.lista_fecha_litros) {      
      _ChartData valor= _ChartData(DateTime.parse(item['pglo_fecha']), double.parse(item['sum_pglo_litros'].toString()) as double );
      chartData?.add(valor);
    }  
    super.initState();
  }

  @override
  void dispose() {
    chartData!.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SfCartesianChart(
      plotAreaBorderWidth: 0,
      title: ChartTitle(
          text: isCardView ? '' : 'Producción Litros de leche'),
      primaryXAxis: DateTimeAxis(
        edgeLabelPlacement: EdgeLabelPlacement.shift,
        labelRotation: 90,
        dateFormat: DateFormat.yMMMd(),
        intervalType: DateTimeIntervalType.days,
        interval: 3,
      ),
      primaryYAxis: NumericAxis(
          labelFormat: '{value}L',
          axisLine: const AxisLine(width: 0),
          majorTickLines: const MajorTickLines(color: Colors.transparent)),
      series: _getDefaultLineSeries(),
      tooltipBehavior: TooltipBehavior(enable: true),
    );
  }

  List<LineSeries<_ChartData, DateTime>> _getDefaultLineSeries() {
    return <LineSeries<_ChartData, DateTime>>[
      LineSeries<_ChartData, DateTime>(
          animationDuration: 2500,
          dataSource: chartData!,
          xValueMapper: (_ChartData sales, _) => sales.x,
          yValueMapper: (_ChartData sales, _) => sales.y,
          width: 2,
          name: 'Producción de Leche',
          markerSettings: const MarkerSettings(isVisible: true)),
    ];
  }
}

class _ChartData {
  _ChartData(this.x, this.y);
  final DateTime x;
  final double y;
}
