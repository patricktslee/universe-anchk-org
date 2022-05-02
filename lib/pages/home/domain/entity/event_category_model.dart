//import 'dart:math';

import 'package:universe/pages/home/domain/entity/event_history_model.dart';

class EventCategory {
  final String name;
  final List<EventHistory> events;

  EventCategory(this.name, this.events);
  factory EventCategory.fromMap(Map<String, dynamic> map) {
    List<EventHistory> _events =
        EventHistory.fromMap(map['events']) as List<EventHistory>;
    return EventCategory(
      map['name'],
      _events,
    );
  }
  factory EventCategory.fromCategoryName(
      String name, Map<String, dynamic> map) {
    List<EventHistory> _events =
        EventHistory.fromMap(map) as List<EventHistory>;
    List<EventHistory> _categoryEvents =
        _events.where((element) => element.category == name).toList();
    return EventCategory(
      name,
      _categoryEvents,
    );
  }
  factory EventCategory.byCategoryName(String name, List<EventHistory> events) {
    List<EventHistory> _categoryEvents =
        events.where((element) => element.category == name).toList();
    return EventCategory(
      name,
      _categoryEvents,
    );
  }
  @override
  String toString() {
    return 'EventCategory\nname: $name\nnumber of events: ${events.length}\nEvents\n${events.toString()}';
  }

  Map<String, dynamic> toEventJson() => {
        "name": name,
        "events":
            List<dynamic>.from(events.map((x) => x.fromCategoryToJson(name))),
      };
}
