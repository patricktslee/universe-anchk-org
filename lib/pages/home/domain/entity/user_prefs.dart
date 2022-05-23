import 'dart:convert';

import 'package:logger/logger.dart';

class UserPrefs {
  final int? buildNumber;
  final bool? introSeen;
//  final DateTime? lastLoggedIn;
  final String? deviceId;
  final logger = Logger(
    printer: PrettyPrinter(
        methodCount: 1,
        lineLength: 50,
        errorMethodCount: 3,
        colors: true,
        printEmojis: true),
  );

  UserPrefs({
    this.buildNumber = 0,
    this.introSeen = false,
    //  this.lastLoggedIn,
    this.deviceId = '',
  });

  UserPrefs copyWith({
    int buildNumber = 0,
    bool introSeen = false,
//    required DateTime lastLoggedIn,
    String deviceId = '',
  }) {
    return UserPrefs(
      buildNumber: buildNumber,
      introSeen: introSeen,
      //  lastLoggedIn: lastLoggedIn,
      deviceId: deviceId,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'buildNumber': buildNumber,
      'introSeen': introSeen,
      //  'lastLoggedIn': lastLoggedIn!.millisecondsSinceEpoch,
      'deviceId': deviceId,
    };
  }

  factory UserPrefs.fromMap(Map<String, dynamic> map) {
//    logger.i('map is ' + map.isEmpty.toString());
//    UserPrefs __userPrefs;
    return UserPrefs(
      buildNumber: map['buildNumber'],
      introSeen: map['introSeen'],
      //lastLoggedIn: DateTime.fromMillisecondsSinceEpoch(map['lastLoggedIn']),
      deviceId: map['deviceId'],
    );
//    return __userPrefs;
  }

  String toJson() => json.encode(toMap());

  factory UserPrefs.fromJson(String source) =>
      UserPrefs.fromMap(json.decode(source));

  @override
  String toString() {
    return 'UserPrefs(buildNumber: $buildNumber, introSeen: $introSeen,  deviceId: $deviceId)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UserPrefs &&
        other.buildNumber == buildNumber &&
        other.introSeen == introSeen &&
        //other.lastLoggedIn == lastLoggedIn &&
        other.deviceId == deviceId;
  }

  @override
  int get hashCode {
    return buildNumber.hashCode ^
        introSeen.hashCode ^
        // lastLoggedIn.hashCode ^
        deviceId.hashCode;
  }
}
