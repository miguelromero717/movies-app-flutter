import 'package:movies_app/src/model/actor.dart';

class Cast {
  List<Actor> actors = new List();

  Cast.fromJsonList(List<dynamic> jsonList) {
    if (jsonList == null) return;

    jsonList.forEach((item) {
      final actor = Actor.fromJsonMap(item);

      actors.add(actor);
    });
  }
}
