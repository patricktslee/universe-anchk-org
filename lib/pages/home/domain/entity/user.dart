import 'dart:convert';

// import 'package:flutter/foundation.dart';
import 'package:universe/pages/home/domain/entity/user_prefs.dart';

class User {
  final String? id;
  final String? name;
  final DateTime? registration;
  final int? status;
  final String? email;
  final bool? emailVerification;
  final UserPrefs? prefs;

  User({
    this.id = "00000000",
    this.name = "Null name",
    this.registration,
    this.status = 0,
    this.email = "name@email.com",
    this.emailVerification = false,
    this.prefs,
  });

  User copyWith({
    String? id,
    String? name,
    DateTime? registration,
    int? status,
    String? email,
    bool? emailVerification,
    UserPrefs? prefs,
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      registration: registration ?? this.registration,
      status: status ?? this.status,
      email: email ?? this.email,
      emailVerification: emailVerification ?? this.emailVerification,
      prefs: prefs ?? this.prefs,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'registration': registration!.millisecondsSinceEpoch,
      'status': status,
      'email': email,
      'emailVerification': emailVerification,
      'prefs': prefs!.toMap(),
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'],
      name: map['name'],
      registration: DateTime.fromMillisecondsSinceEpoch(map['registration']),
      status: map['status'],
      email: map['email'],
      emailVerification: map['emailVerification'],
      prefs: UserPrefs.fromMap(map['prefs']),
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) => User.fromMap(json.decode(source));

  @override
  String toString() {
    return 'User(id: $id, name: $name, registration: $registration, status: $status, email: $email, emailVerification: $emailVerification, prefs: $prefs)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is User &&
        other.id == id &&
        other.name == name &&
        other.registration == registration &&
        other.status == status &&
        other.email == email &&
        other.emailVerification == emailVerification &&
        other.prefs == prefs;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        registration.hashCode ^
        status.hashCode ^
        email.hashCode ^
        emailVerification.hashCode ^
        prefs.hashCode;
  }
}
