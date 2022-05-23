import 'dart:convert';

// import 'package:flutter/foundation.dart';
import 'package:universe/pages/home/domain/entity/user_prefs.dart';

class LoginUser {
  final String? id;
  final String? name;
  final DateTime? registration;
  final bool? status;
  final String? email;
  final bool? emailVerification;
  final UserPrefs? prefs;

  LoginUser({
    this.id = "00000000",
    this.name = "Null name",
    this.registration,
    this.status = false,
    this.email = "name@email.com",
    this.emailVerification = false,
    this.prefs,
  });

  LoginUser copyWith({
    String? id,
    String? name,
    DateTime? registration,
    bool? status,
    String? email,
    bool? emailVerification,
    UserPrefs? prefs,
  }) {
    return LoginUser(
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

  factory LoginUser.fromMap(Map<String, dynamic> map) {
    return LoginUser(
      id: map['\$id'],
      name: map['name'],
      registration: DateTime.fromMillisecondsSinceEpoch(map['registration']),
      status: map['status'],
      email: map['email'],
      emailVerification: map['emailVerification'],
      prefs: UserPrefs.fromMap(map['prefs']),
    );
  }

  String toJson() => json.encode(toMap());

  factory LoginUser.fromJson(String source) =>
      LoginUser.fromMap(json.decode(source));

  @override
  String toString() {
    return 'User(id: $id, name: $name, registration: $registration, status: $status, email: $email, emailVerification: $emailVerification, prefs: $prefs)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is LoginUser &&
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
