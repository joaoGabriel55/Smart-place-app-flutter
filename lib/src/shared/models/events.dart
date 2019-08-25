class Events {

  String ambientTemperature;
  String airConditioningTemperature;
  String humidity;
  String moviment;
  String airConditioningStatus;
  String qtdPeople;

  Events({
    this.ambientTemperature, 
    this.airConditioningTemperature, 
    this.humidity, 
    this.moviment,
    this.airConditioningStatus,
    this.qtdPeople
  });

  Events.fromJson(Map<String,dynamic> json) {
    ambientTemperature = json['ambient_temperature'];
    airConditioningTemperature = json['air_conditioning_temperature'];
    humidity = json['humidity'];
    moviment = json['moviment'];
    airConditioningStatus = json['air_conditioning_status'];
    qtdPeople = json['qtd_people'];
  }

  Map<String, dynamic> toJson(){
    final Map<String, dynamic> data = new Map();
    data['ambient_temperature'] = this.ambientTemperature;
    data['air_conditioning_temperature'] = this.airConditioningTemperature;
    data['humidity'] = this.humidity;
    data['moviment'] = this.moviment;
    data['air_conditioning_status'] = this.airConditioningStatus;
    data['qtd_people'] = this.qtdPeople;
    return data;
  }
  
}