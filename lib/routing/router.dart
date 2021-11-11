import 'package:flutter/material.dart';
import 'package:universe/pages/home/presentation/views/application_view.dart';
import 'package:universe/pages/home/presentation/views/contact_view.dart';
import 'package:universe/pages/home/presentation/views/history_view.dart';
import 'package:universe/pages/home/presentation/views/introduction_view.dart';
import 'package:universe/pages/home/presentation/views/leaders_view.dart';
import 'package:universe/pages/home/presentation/views/mission_view.dart';
import 'package:universe/pages/home/presentation/views/conductor_view.dart';
import 'package:universe/pages/home/presentation/views/practice_view.dart';
import 'package:universe/pages/home/presentation/views/preachers_view.dart';
import 'package:universe/pages/home/presentation/views/requirement_view.dart';
import 'package:universe/pages/home/presentation/views/video_view.dart';
import 'package:universe/pages/home/presentation/views/what_news_view.dart';
import 'package:universe/routing/routes.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case whatNewsPageRoute:
      return _getPageRoute(const WhatNewsPage());
    case introductionPageRoute:
      return _getPageRoute(const IntroductionPage());
    case missionPageRoute:
      return _getPageRoute(const MissionPage());
    case leadersPageRoute:
      return _getPageRoute(const LeadersPage());
    case conductorPageRoute:
      return _getPageRoute(const ConductorPage());
    case preachersPageRoute:
      return _getPageRoute(const PreachersPage());
    case historyPageRoute:
      return _getPageRoute(const HistoryPage());
    case videoPageRoute:
      return _getPageRoute(const VideoPage());
    case practicePageRoute:
      return _getPageRoute(const PracticePage());
    case requirementPageRoute:
      return _getPageRoute(const RequirementPage());
    case applicationPageRoute:
      return _getPageRoute(ApplicationPage());
    case contactPageRoute:
      return _getPageRoute(const ContactPage());
//    case covid19PageRoute:
//      return _getPageRoute(HomeView());
    default:
      return _getPageRoute(const WhatNewsPage());
  }
}

PageRoute _getPageRoute(Widget child) {
  return MaterialPageRoute(builder: (context) => child);
}
