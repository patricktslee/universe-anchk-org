import 'package:flutter/material.dart';

class AppConstants {
  static const String appTitle = '萬國宣道詠團';
  static const String version = '1.0.7';
  static const bool debug = true;
  static const String project = "61b0428203f09";
  static const String endpoint = "https://appwrite.anchk.org/v1";
//  static const String endpoint = "https://backend-02.anchk.org/v1";
//  static const String endpoint = "https://backend.anchk.org/v1";
  static const String bgImage =
      "https://images.pexels.com/photos/3902882/pexels-photo-3902882.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940";
  static const String countryPath = '/home/country';
  static const String profilePath = '/profile';
  static const Color defaultTextColor = Colors.black;
  static Color defaultSubTextColor = Colors.grey.withOpacity(0.7);
  static const TextStyle desktopTextStyle = TextStyle(
    fontWeight: FontWeight.bold,
    color: Colors.black,
  );
  static const TextStyle mobileTextStyle = TextStyle(
    fontWeight: FontWeight.bold,
    color: Colors.black,
  );
  static const TextStyle mobileOutlineBtnTextStyle =
      TextStyle(color: Colors.black);
  static const TextStyle mobileDataTextStyle =
      TextStyle(fontSize: 45, fontWeight: FontWeight.bold);
  static const TextStyle mobileTitleTextStyle = TextStyle(fontSize: 30);
  static const TextStyle desktopOutlineBtnTextStyle =
      TextStyle(color: Colors.black);
  static const TextStyle desktopDataTextStyle =
      TextStyle(fontSize: 60, fontWeight: FontWeight.bold);
  static const TextStyle desktopTitleTextStyle = TextStyle(fontSize: 45);

  static const TextStyle mobileProfileDataTextStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  static const TextStyle desktopProfileDataTextStyle =
      TextStyle(fontSize: 60, fontWeight: FontWeight.bold);
}
