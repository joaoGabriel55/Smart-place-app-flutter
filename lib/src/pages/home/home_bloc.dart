import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:rxdart/rxdart.dart';
import 'package:smart_place_app/src/pages/home/home_repository.dart';
import 'package:smart_place_app/src/shared/models/device.dart';

class HomeBloc extends BlocBase {

  final HomeRepository repository;
  
  HomeBloc(this.repository);
  
  var listDevice = BehaviorSubject<List<Device>>();
  Sink<List<Device>> get responseIn => listDevice.sink;
  Observable<List<Device>> get responseOut => listDevice.stream;

  void getDeviceHistory() async{
    try {
      var response = await repository.getDeviceHistory();
      responseIn.add(response);
    } catch (e) {
      listDevice.addError(e);
    }
  }
  
  //dispose will be called automatically by closing its streams
  @override
  void dispose() {
    listDevice.close();
    super.dispose();
  }
}
