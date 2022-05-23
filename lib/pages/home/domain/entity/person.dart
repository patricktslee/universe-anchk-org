import 'dart:convert';

abstract class Person {
  final String? name;
  final String? message;
  final String? photo;

  Person({this.name, this.message, this.photo});

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'message': message,
      'photo': photo,
    };
  }

  String toJson() => json.encode(toMap());

  @override
  String toString() {
    return 'Person(name: $name, message: $message, photo: $photo)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Person &&
        other.name == name &&
        other.message == message &&
        other.photo == photo;
  }

  @override
  int get hashCode {
    return name.hashCode ^ message.hashCode ^ photo.hashCode;
  }
}
