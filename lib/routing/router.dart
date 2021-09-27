import 'package:flutter/material.dart';
import 'package:universe/pages/home/presentation/views/clients_view.dart';
import 'package:universe/pages/home/presentation/views/drivers_view.dart';
import 'package:universe/pages/home/presentation/views/home_view.dart';
import 'package:universe/pages/home/presentation/views/overview_view.dart';
import 'package:universe/routing/routes.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case overviewPageRoute:
      return _getPageRoute(OverviewPage());
    case driversPageRoute:
      return _getPageRoute(DriversPage());
    case clientsPageRoute:
      return _getPageRoute(ClientsPage());
    case covid19PageRoute:
      return _getPageRoute(HomeView());
    default:
      return _getPageRoute(OverviewPage());
  }
}

PageRoute _getPageRoute(Widget child) {
  return MaterialPageRoute(builder: (context) => child);
}
