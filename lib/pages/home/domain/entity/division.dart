import 'dart:convert';
//import 'package:flutter/foundation.dart';

import 'package:universe/pages/home/domain/entity/paragraph_model.dart';

abstract class Division {
  final String? name;
  final List<Paragraph>? message;
  final String? photo;

  Division({this.name, this.message, this.photo});

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'message': List<dynamic>.from(message!.map((e) => e.toMap())),
      'photo': photo,
    };
  }

  String toJson() => json.encode(toMap());

  @override
  String toString() {
    return 'Division(name: $name, message: $message, photo: $photo)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Division &&
        other.name == name &&
        other.message == message &&
        other.photo == photo;
  }

  @override
  int get hashCode {
    return name.hashCode ^ message.hashCode ^ photo.hashCode;
  }
}
