class EventHistory {
  final String year;
  final String event;
  final String category;

  EventHistory(this.year, this.event, {this.category = "null"});
  factory EventHistory.fromMap(Map<String, dynamic> map) {
    return EventHistory(
      map['year'],
      map['event'],
      category: map['category'],
    );
  }
  @override
  String toString() {
    return 'EventHistory(Year: $year, Event: $event, Category: $category)';
  }

  Map<String, dynamic> fromCategoryToJson(String category) => {
        "year": year,
        "event": event,
        "category": category,
      };
}
