import 'dart:convert';
import 'dart:typed_data';
import 'package:universe/pages/home/domain/entity/paragraph_model.dart';

class PracticeInfo {
  final List<Paragraph>? practicePlace;
  final List<Paragraph>? practiceTime;

  String? photo;

  Uint8List? photoFile;

  PracticeInfo(
      {this.practicePlace, this.practiceTime, this.photo, this.photoFile});

  factory PracticeInfo.fromMap(Map<String, dynamic> map) => PracticeInfo(
        practicePlace: List<Paragraph>.from(
            map["practicePlace"].map((x) => Paragraph.fromMap(x))),
        practiceTime: List<Paragraph>.from(
            map["practiceTime"].map((x) => Paragraph.fromMap(x))),
        photo: map['photo'],
      );

  factory PracticeInfo.fromJson(String source) =>
      PracticeInfo.fromMap(json.decode(source));

  PracticeInfo copyWith({
    List<Paragraph>? practicePlace,
    List<Paragraph>? practiceTime,
    String? photo,
    Uint8List? photoFile,
  }) {
    return PracticeInfo(
        practicePlace: practicePlace ?? this.practicePlace,
        practiceTime: practiceTime ?? this.practiceTime,
        photo: photo ?? this.photo,
        photoFile: photoFile ?? this.photoFile);
  }

  Map<String, dynamic> toMap() {
    return {
      'practicePlace': List<dynamic>.from(practicePlace!.map((e) => e.toMap())),
      'practiceTime': List<dynamic>.from(practiceTime!.map((e) => e.toMap())),
      'photo': photo,
    };
  }

  String toJson() => json.encode(toMap());
}
