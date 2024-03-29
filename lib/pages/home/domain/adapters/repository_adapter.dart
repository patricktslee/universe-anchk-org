import 'dart:typed_data';

import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:universe/pages/home/domain/entity/anchk_organization.dart';
import 'package:universe/pages/home/domain/entity/chat_message.dart';
import 'package:universe/pages/home/domain/entity/chat_room.dart';
import 'package:universe/pages/home/domain/entity/conductor.dart';
import 'package:universe/pages/home/domain/entity/contact_info.dart';
import 'package:universe/pages/home/domain/entity/event_category_model.dart';
//import 'package:universe/pages/home/domain/entity/organization_info_model.dart';
import 'package:universe/pages/home/domain/entity/paragraph_model.dart';
import 'package:universe/pages/home/domain/entity/practice_info.dart';
import 'package:universe/pages/home/domain/entity/preacher.dart';
import 'package:universe/pages/home/domain/entity/user.dart';
import 'package:universe/pages/home/domain/entity/what_news_model.dart';
import 'package:universe/pages/home/domain/entity/youtube_model.dart';
//import 'package:universe/pages/home/presentation/views/introduction_view.dart';
//import 'package:universe/routing/routes.dart';
import 'package:universe/shared/enum.dart';

import '../entity/cases_model.dart';

// ignore: one_member_abstracts
abstract class IHomeRepository {
  Future<CasesModel> getCases();
  Future signup({String name, String email, String password});
  Future login({String email, String password});
  Future updateAccountPassword(String password, String oldPassword);
  Future logout({String sessionId});
  Future logoutAll();
  Future createChatDocument({
    required Map<String, dynamic> data,
    List<dynamic> readPermission = const ['*'],
    List<dynamic> writePermission = const ['*'],
  });
  Future createAnonymousSession();
  Future getSession(String? sessionID);
  Future getSessions();
  Future getUserSession();
  Future getPrefs();
  Future<String> getPhoto(String collectionName);
  Future<String> getPhotoFileId(String collectionName);
  Future getFile(String fileId, {int quality = 100});
  Future getWhatNewsDocument();
  Future getPractice();
  Future getPracticePlaceDocument();
  Future getPracticeTimeDocument();
  Future getRequirementDocument();
  Future getAnchkOrganizationDocument();
  Future getAnchkMissionDocument();
  Future getConductorMessage();

  Future getPreachersMessage();
  Future getContactList();
  Future getChatRooms();
  Future getChatMessages();
  Future getVideoList();
  Future getAnchkorgEventCategory();
  Future getAnchkorgEventCategory1();
  Future getAnchkorgEventCategory2();
  void createApplication(Map<dynamic, dynamic> data);
  //Future subscribe();
  //Future unsubscribe();
  String get error;
  bool get isLoading;
  LoginUser get user;
  Session get session;
  Status get status;
  bool get isLogin;
  bool get firstTimeLoading;
  Realtime get realtime;
  Document get currentChat;
  List<String> get apiLog;
  void addApiLog(String value);
  String get providerBox;
//  List<Document> get whatNewsList;
  List<WhatNews> get whatNews;
  PracticeInfo get practice;
  List<Paragraph> get practicePlace;
  List<Paragraph> get practiceTime;
  Uint8List get practiceFile;
//  List<Paragraph> get requirement;
//  List<Paragraph> get anchkOrganization;
  AnchkOrganization get introduction;
  AnchkOrganization get mission;
  AnchkOrganization get anchkRequirement;

//  List<Paragraph> get anchkMission;
  ContactInfo get contact;
//  List<OrganizationInfo> get contactList;
//  Uint8List get contactListFile;
  List<ChatRoom> get chatRooms;
  List<ChatMessage> get chatMessages;
  List<YoutubeModel> get videoList;
  //String get conductorMessage;
  //String get conductorPhoto;
  Conductor get conductor;
  Uint8List get conductorFile;
  Preacher get preacher;
  //String get preachersMessage;
  //String get preachersPhoto;
  List<EventCategory> get anchkorgEventCategory1;
  List<EventCategory> get anchkorgEventCategory2;
}
