
import 'package:flutter/material.dart';
import 'package:smart_place_app/src/shared/models/device.dart';
import 'package:charts_flutter/flutter.dart' as charts;


class ChartPage extends StatefulWidget {
  final List<Device> deviceListHistory;
  
  const ChartPage({Key key, this.deviceListHistory}) : super(key: key);

  @override
  _ChartPageState createState() => _ChartPageState();
}

class TimeSeriesSales {
  final DateTime time;
  final double sales;

  TimeSeriesSales(this.time, this.sales);
}

class _ChartPageState extends State<ChartPage> {

  @override
  Widget build(BuildContext context) {
    var data = widget.deviceListHistory.map((elem)=>new TimeSeriesSales(
      DateTime.parse(elem.createdAt), double.parse(elem.events.ambientTemperature))).toList();
    var data2 = widget.deviceListHistory.map((elem)=>new TimeSeriesSales(
      DateTime.parse(elem.createdAt), double.parse(elem.events.airConditioningTemperature))).toList();
    var data3 = widget.deviceListHistory.map((elem)=>new TimeSeriesSales(
      DateTime.parse(elem.createdAt), double.parse(elem.events.humidity))).toList();

     List<charts.Series<TimeSeriesSales, DateTime>> series = [
      new charts.Series(
        id: '1',
        domainFn: (TimeSeriesSales clickData, _) => clickData.time,
        measureFn: (TimeSeriesSales clickData, _) => clickData.sales,
        colorFn: (_, __) => charts.MaterialPalette.red.shadeDefault,
        data: data,
      ),
       new charts.Series(
        id: '2',
        domainFn: (TimeSeriesSales clickData, _) => clickData.time,
        measureFn: (TimeSeriesSales clickData, _) => clickData.sales,
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        data: data2,
      ),
       new charts.Series(
        id: '3',
        domainFn: (TimeSeriesSales clickData, _) => clickData.time,
        measureFn: (TimeSeriesSales clickData, _) => clickData.sales,
        colorFn: (_, __) => charts.MaterialPalette.purple.shadeDefault,
        data: data3,
      ),
    ];

    return new Scaffold(
      appBar: new AppBar(
        centerTitle: true,
        title: new Text("History chart"),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(2.0),
          child: Theme(
            data: Theme.of(context).copyWith(accentColor: Colors.black),
            child: Column(
              children: <Widget>[
                 
                Container(
                  margin: EdgeInsets.only(top: 4),
                  height: 2.0,
                  color: Theme.of(context).accentColor,
                  alignment: Alignment.center,
                ),
              ],
            )
          ),
        ),
      ),
      body: SingleChildScrollView(
          child: Container(
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    child: Card(
                      child: Container(
                        padding: EdgeInsets.all(12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text("Params", style: TextStyle(fontWeight: FontWeight.bold),),
                            Text("Ambient temperature", style: TextStyle(color: Colors.red),),
                            Text("Air conditioning temperature", style: TextStyle(color: Colors.blue),),
                            Text("Humidity", style: TextStyle(color: Colors.purple),),
                          ]),
                      )
                  )),                     
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.8,
                    child: charts.TimeSeriesChart(series)
                  )
                ],
              )
            )
          )
      )
    );
  }
}
