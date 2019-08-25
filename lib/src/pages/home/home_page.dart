import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:smart_place_app/src/pages/chart/chart_bloc.dart';
import 'package:smart_place_app/src/pages/chart/chart_page.dart';
import 'package:smart_place_app/src/pages/home/home_bloc.dart';
import 'package:smart_place_app/src/shared/models/device.dart';
import 'package:smart_place_app/src/shared/models/events.dart';

import 'home_module.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() { 

    return _HomePageState(); 
  }
}

class _HomePageState extends State<HomePage> {

  var _homeBloc = HomeModule.to.getBloc<HomeBloc>();
  var _createBloc = HomeModule.to.getBloc<ChartBloc>();
  StreamSubscription listenResponse;

  List<Device> deviceListHistory;
  Events lastDeviceHistory;
  String statusLastDevice;

  @override
  void initState() {
    _homeBloc.getDeviceHistory();
    super.initState();
  }

  @override
  void dispose() {
    listenResponse.cancel();
    super.dispose();
  }

  void handleData() async {
    deviceListHistory = await _homeBloc.responseOut.first;
    lastDeviceHistory = deviceListHistory[deviceListHistory.length-1].events;
  }

  @override
  Widget build(BuildContext context) {
    handleData();
    return Scaffold(
      appBar: AppBar(
        elevation: 4,
        centerTitle: true,
        title: Text("Device history"),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.show_chart), onPressed: () {
                     Navigator.push(
             context,
             MaterialPageRoute(
                 builder: (context) => ChartPage(deviceListHistory: deviceListHistory,)));
          },)
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(2.0),
          child: Theme(
            data: Theme.of(context).copyWith(accentColor: Colors.black),
            child: Container(
              height: 2.0,
              color: Theme.of(context).accentColor,
              alignment: Alignment.center,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: StreamBuilder<List<Device>>(
          stream: _homeBloc.responseOut,
          builder: (context, snapshot) {
            if (snapshot.hasError)
              return Center(child: Text(snapshot.error.toString()));

            if (snapshot.hasData) {
              deviceListHistory = snapshot.data;
              lastDeviceHistory = snapshot.data[snapshot.data.length-1].events;
              statusLastDevice = lastDeviceHistory.airConditioningStatus;
              // print(device.createdAt);
              return Column(
                  children: snapshot.data
                      .map((item) {
                        return Card(
                            child: Container(
                          padding: EdgeInsets.all(16),
                          child: Column(
                            children: <Widget>[
                              Container(
                                  width: MediaQuery.of(context).size.width,
                                  child: Row(
                                    children: <Widget>[
                                      Text(
                                        "Air conditioning temperature: ",
                                      ),
                                      Text(item
                                          .events.airConditioningTemperature,style: TextStyle(
                                            fontWeight: FontWeight.bold),),
                                    ],
                                  )),
                              Container(
                                  width: MediaQuery.of(context).size.width,
                                  child: Row(
                                    children: <Widget>[
                                      Text(
                                        "Ambient temperature: ",
                                      ),
                                      Text(item.events.ambientTemperature, style: TextStyle(
                                            fontWeight: FontWeight.bold),),
                                    ],
                                  )),
                              Container(
                                  width: MediaQuery.of(context).size.width,
                                  child: Row(
                                    children: <Widget>[
                                      Text(
                                        "Humidity: ",
                                      ),
                                      Text(item.events.humidity, style: TextStyle(
                                            fontWeight: FontWeight.bold),),
                                    ],
                                  )),
                              Container(
                                  width: MediaQuery.of(context).size.width,
                                  child: Row(
                                    children: <Widget>[
                                      Text(
                                        "Ar conditioning status: ",
                                      ),
                                      Text(item.events.airConditioningStatus, style: TextStyle(
                                            fontWeight: FontWeight.bold),),
                                    ],
                                  )),
                              Container(
                                  width: MediaQuery.of(context).size.width,
                                  child: Row(
                                    children: <Widget>[
                                      Text(
                                        "Moviment: ",
                                      ),
                                      Text(item.events.moviment, style: TextStyle(
                                            fontWeight: FontWeight.bold),),
                                    ],
                                  )),
                              Container(
                                  width: MediaQuery.of(context).size.width,
                                  child: Row(
                                    children: <Widget>[
                                      Text(
                                        "No. of people: ",
                                      ),
                                      Text(item.events.qtdPeople, style: TextStyle(
                                            fontWeight: FontWeight.bold),),
                                    ],
                                  )),
                              Container(
                                  width: MediaQuery.of(context).size.width,
                                  child: Row(
                                    children: <Widget>[
                                      Text(
                                        "Date: ",
                                      ),
                                      Text(item.createdAt.substring(0, 16), style: TextStyle(
                                            fontWeight: FontWeight.bold),),
                                    ],
                                  )),
                            ],
                          ),
                        ));
                      })
                      .toList()
                      .reversed
                      .toList());
            } else
              return Center(child: CircularProgressIndicator());
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: StreamBuilder<List<Device>>(
          stream: _homeBloc.responseOut,
          builder: (context,snapshot){
            if(snapshot.hasData)
              return Icon(
                Icons.offline_bolt,
                color: statusLastDevice == "true" ? Colors.white : Colors.black
              );
            else
              return Icon(Icons.error);
          },
        ),
        onPressed: () {
          Events events = lastDeviceHistory;
          events.airConditioningStatus == "true" ?
          events.airConditioningStatus = "false" : 
          events.airConditioningStatus = "true";
          _createBloc.postIn.add(events);
//          Navigator.push(
//              context,
//              MaterialPageRoute(
//                  builder: (context) => CreatePage(
//                        onSuccess: _homeBloc.getDeviceHistory,
//                      )));
        },
      ),
    );
  }

  @override
  void didChangeDependencies() {
    listenResponse =  _createBloc.responseOut.listen((data){
      if(data == 201){
         _homeBloc.getDeviceHistory();
         handleData();
      }
    });
    super.didChangeDependencies();
  }
}
