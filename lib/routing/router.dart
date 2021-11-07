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
      return _getPageRoute(WhatNewsPage());
    case introductionPageRoute:
      return _getPageRoute(IntroductionPage());
    case missionPageRoute:
      return _getPageRoute(MissionPage());
    case leadersPageRoute:
      return _getPageRoute(LeadersPage());
    case conductorPageRoute:
      return _getPageRoute(ConductorPage());
    case preachersPageRoute:
      return _getPageRoute(PreachersPage());
    case historyPageRoute:
      return _getPageRoute(HistoryPage());
    case videoPageRoute:
      return _getPageRoute(VideoPage());
    case practicePageRoute:
      return _getPageRoute(PracticePage());
    case requirementPageRoute:
      return _getPageRoute(RequirementPage());
    case applicationPageRoute:
      return _getPageRoute(ApplicationPage());
    case contactPageRoute:
      return _getPageRoute(ContactPage());
//    case covid19PageRoute:
//      return _getPageRoute(HomeView());
    default:
      return _getPageRoute(WhatNewsPage());
  }
}

PageRoute _getPageRoute(Widget child) {
  return MaterialPageRoute(builder: (context) => child);
}
