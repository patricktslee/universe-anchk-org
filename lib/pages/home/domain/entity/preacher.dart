import 'dart:convert';
import 'dart:typed_data';

import 'package:universe/pages/home/domain/entity/person.dart';

class Preacher implements Person {
  @override
  String? name;

  @override
  String? message;

  @override
  String? photo;

  Uint8List? photoFile;

  Preacher({this.name, this.message, this.photo, this.photoFile});

  Preacher copyWith({
    String? name,
    String? message,
    String? photo,
    Uint8List? photoFile,
  }) {
    return Preacher(
        name: name ?? this.name,
        message: message ?? this.message,
        photo: photo ?? this.photo,
        photoFile: photoFile ?? this.photoFile);
  }

  factory Preacher.fromMap(Map<String, dynamic> map) {
    return Preacher(
      name: map['name'],
      message: map['message'],
      photo: map['photo'],
    );
  }

  factory Preacher.fromJson(String source) =>
      Preacher.fromMap(json.decode(source));

  @override
  String toJson() {
    throw UnimplementedError();
  }

  @override
  Map<String, dynamic> toMap() {
    throw UnimplementedError();
  }
}
