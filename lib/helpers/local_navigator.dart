import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:universe/pages/home/presentation/controllers/navigation_controller.dart';
import 'package:universe/routing/router.dart';
import 'package:universe/routing/routes.dart';

NavigationController navigationController = Get.find();

Navigator localNavigator() => Navigator(
      key: navigationController.navigatorKey,
      onGenerateRoute: generateRoute,
      initialRoute: introductionPageDisplayName,
    );
