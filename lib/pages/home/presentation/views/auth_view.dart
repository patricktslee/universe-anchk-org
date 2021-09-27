import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/auth_controller.dart';

class AuthView extends GetView<AuthController> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        image: DecorationImage(
          fit: BoxFit.cover,
          colorFilter: ColorFilter.linearToSrgbGamma(),
          image: NetworkImage(
              "https://images.pexels.com/photos/3902882/pexels-photo-3902882.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940"),
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: Text('covid'.tr),
          backgroundColor: Colors.white10,
          elevation: 0,
          centerTitle: true,
        ),
        body: Center(
          child: controller.obx(
            (state) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 100,
                  ),
                  Text(
                    'email'.tr,
                    style: TextStyle(
                      fontSize: 30,
                    ),
                  ),
                  Text(
                    '${state!.email}',
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'name'.tr,
                    style: TextStyle(
                      fontSize: 30,
                    ),
                  ),
                  Text(
                    '${state.name}',
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'session_id'.tr,
                    style: TextStyle(
                      fontSize: 30,
                    ),
                  ),
                  Text(
                    '${state.id}',
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
