import 'dart:convert';
import 'dart:typed_data';

import 'package:universe/pages/home/domain/entity/person.dart';

class Conductor implements Person {
  @override
  String? name;

  @override
  String? message;

  @override
  String? photo;

  Uint8List? photoFile;

  Conductor({this.name, this.message, this.photo, this.photoFile});

  Conductor copyWith({
    String? name,
    String? message,
    String? photo,
    Uint8List? photoFile,
  }) {
    return Conductor(
      name: name ?? this.name,
      message: message ?? this.message,
      photo: photo ?? this.photo,
      photoFile: photoFile ?? this.photoFile,
    );
  }

  factory Conductor.fromMap(Map<String, dynamic> map) {
    return Conductor(
      name: map['name'],
      message: map['message'],
      photo: map['photo'],
    );
  }

  factory Conductor.fromJson(String source) =>
      Conductor.fromMap(json.decode(source));

  @override
  String toJson() {
    throw UnimplementedError();
  }

  @override
  Map<String, dynamic> toMap() {
    throw UnimplementedError();
  }
}
