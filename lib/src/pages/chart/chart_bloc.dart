import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:rxdart/rxdart.dart';
import 'package:smart_place_app/src/pages/home/home_repository.dart';
import 'package:smart_place_app/src/shared/models/events.dart';

class ChartBloc extends BlocBase {
  
  final HomeRepository repository;

  ChartBloc(this.repository);

  String title;
  String body;

  var event = BehaviorSubject<Events>();

  Events get postValue => event.value;
  Observable<int> get responseOut => event.switchMap(observablePost);
  Sink<Events> get postIn => event.sink;

  Stream<int> observablePost (Events data) async*{
    yield 0;
    try {
      var response = await repository.createPost(data.toJson());
      yield response;
    } catch (e) {
      event.addError(e);
    }
  }

  //dispose will be called automatically by closing its streams
  @override
  void dispose() {
    event.close();
    super.dispose();
  }
}
