import 'dart:convert';
import 'dart:typed_data';

import 'package:universe/pages/home/domain/entity/division.dart';
import 'package:universe/pages/home/domain/entity/paragraph_model.dart';

class AnchkOrganization implements Division {
  @override
  String? name;

  @override
  final List<Paragraph>? message;

  @override
  String? photo;

  Uint8List? photoFile;

  AnchkOrganization({this.name, this.message, this.photo, this.photoFile});

  factory AnchkOrganization.fromMap(Map<String, dynamic> map) =>
      AnchkOrganization(
        name: map['name'],
        message: List<Paragraph>.from(
            map["message"].map((x) => Paragraph.fromMap(x))),
        photo: map['photo'],
      );

  factory AnchkOrganization.fromJson(String source) =>
      AnchkOrganization.fromMap(json.decode(source));

  AnchkOrganization copyWith({
    String? name,
    List<Paragraph>? message,
    String? photo,
    Uint8List? photoFile,
  }) {
    return AnchkOrganization(
        name: name ?? this.name,
        message: message ?? this.message,
        photo: photo ?? this.photo,
        photoFile: photoFile ?? this.photoFile);
  }

  @override
  String toJson() {
    throw UnimplementedError();
  }

  @override
  Map<String, dynamic> toMap() {
    throw UnimplementedError();
  }
}
