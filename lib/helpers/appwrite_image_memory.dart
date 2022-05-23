import 'dart:typed_data';

import 'package:flutter/material.dart';
//import 'package:get/state_manager.dart';
import 'package:universe/pages/home/data/api_service.dart';

class AppwriteImageMemory extends StatelessWidget {
  const AppwriteImageMemory(
      {Key? key, required this.fileId, this.quality = 100})
      : super(key: key);
  final String fileId;
  final int quality;

  @override
  Widget build(BuildContext context) {
    ApiService apiService = ApiService.instance;
    print("At ${DateTime.now()} AppwriteImageMemory");
    return newMethod(apiService);
  }

  FutureBuilder<Uint8List> newMethod(ApiService apiService) {
    return FutureBuilder<Uint8List>(
        future: apiService.getFile(fileId).then((value) {
          print("At ${DateTime.now()} FutureBuilder<Uint8List>");
          return value;
        }),
        builder: (context, AsyncSnapshot<Uint8List> snapshot) {
          return snapshot.hasData && snapshot.data != null
              ? Image.memory(
                  snapshot.data as Uint8List,
                  fit: BoxFit.cover,
                )
              : Image.asset("assets/images/anchk-logo.PNG");
        });
  }
}
