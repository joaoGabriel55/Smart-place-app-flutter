import 'events.dart';

class Device {
  
  String id;
  String username;
  String createdAt;
  Events events;
    
  Device({this.id, this.username, this.createdAt, this.events});

  Device.fromJson(Map<String,dynamic> json) {
    id = json['id'];
    username = json['username'];
    createdAt = json['created_at'];
    events = Events.fromJson(json['events']);
  }

  Map<String, dynamic> toJson(){
    final Map<String, dynamic> data = new Map();
    data['id'] = this.id;
    data['username'] = this.username;
    data['created_at'] = this.createdAt;
    data['events'] = this.events;
    return data;
  }
  
}