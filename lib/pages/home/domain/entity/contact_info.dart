import 'dart:convert';
import 'dart:typed_data';
import 'package:universe/pages/home/domain/entity/organization_info_model.dart';

class ContactInfo {
  final List<OrganizationInfo>? organizationInfo;

  String? photo;

  Uint8List? photoFile;

  ContactInfo({this.organizationInfo, this.photo, this.photoFile});

  factory ContactInfo.fromMap(Map<String, dynamic> map) => ContactInfo(
        organizationInfo: List<OrganizationInfo>.from(
            map["message"].map((x) => OrganizationInfo.fromMap(x))),
        photo: map['photo'],
      );

  factory ContactInfo.fromJson(String source) =>
      ContactInfo.fromMap(json.decode(source));

  ContactInfo copyWith({
    List<OrganizationInfo>? organizationInfo,
    String? photo,
    Uint8List? photoFile,
  }) {
    return ContactInfo(
        organizationInfo: organizationInfo ?? this.organizationInfo,
        photo: photo ?? this.photo,
        photoFile: photoFile ?? this.photoFile);
  }

  Map<String, dynamic> toMap() {
    return {
      'organizationInfo':
          List<dynamic>.from(organizationInfo!.map((e) => e.toMap())),
      'photo': photo,
    };
  }

  String toJson() => json.encode(toMap());
}
