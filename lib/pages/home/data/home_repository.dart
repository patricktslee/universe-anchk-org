//import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:get_storage/get_storage.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:universe/pages/home/domain/entity/anchk_organization.dart';
import 'package:universe/pages/home/domain/entity/conductor.dart';
import 'package:universe/pages/home/domain/entity/contact_info.dart';
import 'package:universe/pages/home/domain/entity/event_category_model.dart';
import 'package:universe/pages/home/domain/entity/event_history_model.dart';
import 'package:universe/pages/home/domain/entity/organization_info_model.dart';
import 'package:universe/pages/home/domain/entity/paragraph_model.dart';
import 'package:universe/pages/home/domain/entity/practice_info.dart';
import 'package:universe/pages/home/domain/entity/preacher.dart';
import 'package:universe/pages/home/domain/entity/user.dart';
import 'package:universe/pages/home/domain/entity/user_prefs.dart';
import 'package:universe/pages/home/domain/entity/what_news_model.dart';
import 'package:universe/pages/home/domain/entity/youtube_model.dart';
import 'package:universe/shared/enum.dart';
import '../domain/adapters/repository_adapter.dart';
import '../domain/entity/cases_model.dart';
import 'home_api_provider.dart';
import 'package:logger/logger.dart';
import 'initial_data.dart';

class HomeRepository implements IHomeRepository {
  HomeRepository({required this.provider});
  final IHomeProvider provider;
  Status _status = Status.uninitialized;
  late Session _session;
  LoginUser _user = LoginUser(registration: DateTime.now(), prefs: UserPrefs());
  String _error = '';
  bool _loading = false;

  bool _firstTimeLoading = true;
  @override
  bool get firstTimeLoading => _firstTimeLoading;

  @override
  Realtime get realtime => provider.apiService.getRealtime();

  bool _isLogin = false;
  @override
  bool get isLogin => _isLogin;
  List<String> _apiLog = [];
  @override
  List<String> get apiLog => _apiLog;

  final box = GetStorage();
  String get _sessionIDBox => box.read('sessionID') ?? "No session ID";
  String get _providerBox => box.read('provider') ?? "No session ID";
  @override
  String get providerBox => _providerBox;

  List<WhatNews> _whatNews = InitialData.whatNews;
  @override
  List<WhatNews> get whatNews => _whatNews;

  List<Paragraph> _practicePlace = InitialData.practicePlace;
  @override
  List<Paragraph> get practicePlace => _practicePlace;

  List<Paragraph> _practiceTime = InitialData.practiceTime;
  @override
  List<Paragraph> get practiceTime => _practiceTime;

  Uint8List _practiceFile = Uint8List(0);
  @override
  Uint8List get practiceFile => _practiceFile;

  PracticeInfo _practice = PracticeInfo();
  @override
  PracticeInfo get practice => _practice;

  //List<Paragraph> _requirement = InitialData.requirement;
  //@override
  //List<Paragraph> get requirement => _requirement;

  //List<Paragraph> _anchkOrganization = InitialData.anchkOrganization;
  //@override
  //List<Paragraph> get anchkOrganization => _anchkOrganization;

  AnchkOrganization _introduction = AnchkOrganization();
  @override
  AnchkOrganization get introduction => _introduction;

  AnchkOrganization _mission = AnchkOrganization();
  @override
  AnchkOrganization get mission => _mission;

  AnchkOrganization _anchkRequirement = AnchkOrganization();
  @override
  AnchkOrganization get anchkRequirement => _anchkRequirement;

  //List<Paragraph> _anchkMission = InitialData.anchkMission;
  //@override
  //List<Paragraph> get anchkMission => _anchkMission;

  Conductor _conductor = Conductor(
      name: InitialData.conductorMessage,
      message: InitialData.conductorMessage,
      photo: InitialData.conductorMessage);
  @override
  Conductor get conductor => _conductor;

  Uint8List _conductorFile = Uint8List(0);
  @override
  Uint8List get conductorFile => _conductorFile;

  Preacher _preacher = Preacher(
      name: InitialData.preachersMessage,
      message: InitialData.preachersMessage,
      photo: InitialData.preachersMessage);
  @override
  Preacher get preacher => _preacher;

//  String _conductorMessage = InitialData.conductorMessage;
//  @override
//  String get conductorMessage => _conductorMessage;
//
//  String _conductorPhoto = InitialData.conductorMessage;
//  @override
//  String get conductorPhoto => _conductorPhoto;

//  String _preachersMessage = InitialData.preachersMessage;
//  @override
//  String get preachersMessage => _preachersMessage;
//
//  String _preachersPhoto = InitialData.preachersMessage;
//  @override
//  String get preachersPhoto => _preachersPhoto;
  ContactInfo _contact = ContactInfo();
  @override
  ContactInfo get contact => _contact;

//  List<OrganizationInfo> _contactList = InitialData.contactList;
//  @override
//  List<OrganizationInfo> get contactList => _contactList;
//
//  Uint8List _contactListFile = Uint8List(0);
//  @override
//  Uint8List get contactListFile => _contactListFile;

  List<YoutubeModel> _videoList = InitialData.videosList;
  @override
  List<YoutubeModel> get videoList => _videoList;

  List<EventCategory> _anchkorgEventCategory1 = [];
  //  InitialData.anchkorgEventCategory1;
  @override
  List<EventCategory> get anchkorgEventCategory1 => _anchkorgEventCategory1;

  List<EventCategory> _anchkorgEventCategory2 = [];
  // InitialData.anchkorgEventCategory2;
  @override
  List<EventCategory> get anchkorgEventCategory2 => _anchkorgEventCategory2;

  @override
  String get error => _error;
  @override
  bool get isLoading => _loading;
  @override
  LoginUser get user => _user;
  @override
  Session get session => _session;
  @override
  Status get status => _status;

  final logger = Logger(
    printer: PrettyPrinter(
        methodCount: 1,
        lineLength: 50,
        errorMethodCount: 3,
        colors: true,
        printEmojis: true),
  );

  @override
  void addApiLog(String value) => provider.apiService.addApiLog(value);

  void _debug(String value) {
    value = "At HomeRespository class - " + value;
    print(value);
    logger.i(value);
    addApiLog(value);
  }

  @override
  Future<CasesModel> getCases() async {
    final cases = await provider.getCases("/summary");
    if (cases.status.hasError) {
      return Future.error(cases.statusText!);
    } else {
      return cases.body!;
    }
  }

  @override
  Future signup(
      {String name = 'name',
      String email = 'name@email.com',
      String password = 'password'}) async {
//    logger.i("signup Appwrite connection using HomeRepository");
    _status = Status.authenticating;
    try {
      await provider.apiService
          .signup(name: name, email: email, password: password)
          .then((value) => login(email: email, password: password));
      return true;
    } catch (e) {
      _debug("signup on catch (e)\n ${e.toString()}");
      return e;
    }
  }

  @override
  Future login(
      {String email = 'name@email.com', String password = 'password'}) async {
    _status = Status.authenticating;
    try {
      await provider.apiService
          .login(email: email, password: password)
          .then((value) async {
        //_debug("Login=====\n");
        Type sessionType = _session.runtimeType;
        Type valueType = value.runtimeType;
        if (sessionType == valueType) {
          //_debug("sessionType  is match");
          await _getInfo(value);
          return value;
        } else {
          //_debug("sessionType  isn't match");
          return value;
        }
      });
    } catch (e) {
      _debug("login on catch (e)\n ${e.toString()}");
      return e;
    }
  }

  @override
  Future updateAccountPassword(String password, String oldPassword) async {
    _status = Status.authenticating;
    try {
      await provider.apiService
          .updateAccountPassword(password, oldPassword)
          .then((value) {
        //_debug("updateAccountPassword success");
        return value;
      });
      return true;
    } catch (e) {
      _debug("updateAccountPassword on catch (e)\n ${e.toString()}");
      return e;
    }
  }

  @override
  Future createAnonymousSession() async {
    //_debug("2. login Appwrite connection using HomeRepository");
    _status = Status.authenticating;
    String loginInfo = "Initial";
    await provider.apiService.get().then((value) async {
      loginInfo = value;
      //_debug(
      //    "At ${DateTime.now()} running the result for provider.apiService.get() is $loginInfo");
      if (loginInfo == "401") {
        //_debug("Running login");
        //_debug("At ${DateTime.now()} running the createAnonymousSession");
        await _loginAnonymous();
      } else {
        //_debug("Login Provider is $_providerBox");
        if (_providerBox == "anonymous") {
          //_debug(
          //    "At ${DateTime.now()} Running get data and logout first and running the createAnonymousSession");
          //_debug(
          //    "At ${DateTime.now()} Running get data only with sessionID $_sessionIDBox");
          await provider.apiService
              .getSession(_sessionIDBox)
              .then((value) async => await _getInfo(value));
//          await provider.apiService.logoutAll().then((value) async {
//            await _loginAnonymous();
//          });
        } else {
          //_debug(
          //    "At ${DateTime.now()} Running get data only with sessionID $_sessionIDBox");
          await provider.apiService
              .getSession(_sessionIDBox)
              .then((value) async => await _getInfo(value));
        }
      }
    });
    //_debug(
    //    "2. login Appwrite connection using HomeRepository _isLogin is ${_isLogin.toString()}");
  }

  Future<void> _loginAnonymous() async {
    try {
      await provider.apiService.createAnonymousSession().then((value) async {
        await _getInfo(value);
      });
    } on AppwriteException catch (e) {
      //_debug('HomeRepository login error ' + e.message!);
      _error = e.message!;
      _status = Status.unauthenticated;
      _apiLog = provider.apiService.apiLog;
      _isLogin = false;
    }
  }

  Future<void> _getInfo(value) async {
    _session = value;
    _isLogin = true;
    box.write("sessionID", _session.$id);
    box.write("provider", _session.provider);
    //await getSession(_sessionIDBox);
    await getUserSession();
    dataLoading();
    _status = Status.authenticated;
    _apiLog = provider.apiService.apiLog;
  }

  void dataLoading() {
    //_debug("At ${DateTime.now()} running dataLoading");
//    addApiLog("At ${DateTime.now()} running dataLoading");
//    getWhatNewsDocument();
    getPractice();
    getPracticePlaceDocument();
    getPracticeTimeDocument();
    getRequirementDocument();
    getAnchkOrganizationDocument();
    getConductorMessage();
    getPreachersMessage();
    getContactList();
    getVideoList();
    getAnchkorgEventCategory();
  }

  @override
  Future logout({String sessionId = 'null'}) async {
    logger.i("logout Appwrite connection using HomeRepository");
    _status = Status.authenticating;
    try {
      await provider.apiService.logout(sessionId: sessionId);
      _status = Status.uninitialized;
      box.write("provider", "anonymous");
      return true;
    } on AppwriteException catch (e) {
      logger.i('HomeRepository signup error ' + e.message!);
      _error = e.message!;
      _status = Status.unauthenticated;
      return false;
    }
  }

  @override
  Future logoutAll() async {
    logger.i("logout ALl Appwrite connection using HomeRepository");
    _status = Status.authenticating;
    try {
      await provider.apiService.logoutAll();
      _status = Status.uninitialized;
      box.write("provider", "anonymous");
      return true;
    } on AppwriteException catch (e) {
      logger.i(
          'HomeRepository logout ALl Appwrite connection error ' + e.message!);
      _error = e.message!;
      _status = Status.unauthenticated;
      return false;
    }
  }

  //@override
  //Future subscribe() async {
  //  return await provider.apiService.subscribe();
  //}
//
  //@override
  //Future unsubscribe() async {
  //  return await provider.apiService.unsubscribe();
  //}

  @override
  Future<Session> getSession(String? sessionID) async {
    getPrefs();
    //_debug(
    //    "4.1 getSession by ID $sessionID Appwrite connection using HomeRepository");
    try {
      await provider.apiService.getSession(sessionID).then((res) {
        //_debug('4.2 getSession by ID $sessionID for res.userId');
        //_debug(res.userId);
        _session = res;
        //_debug('4.2 _session updated.');
      });
    } on AppwriteException catch (e) {
      _error = e.message!;
    } finally {
      _loading = false;
    }
    return _session;
  }

  @override
  Future getSessions() async {
    //logger.i("getUserSession Appwrite connection using HomeRepository");
    try {
      await provider.apiService.getSessions().then((res) {
        logger.i('getSessions res.data');
//        logger.i(res);
//        logger.i(res['sessions'].toString());
//        _session = Session.fromMap(res['sessions']);
        //logger.i('_session is' + _session.toString());
      });
    } on AppwriteException catch (e) {
      _error = e.message!;
    } finally {
      _loading = false;
    }
  }

  @override
  Future getUserSession() async {
    //logger.i("5.1  getUserSession Appwrite connection using HomeRepository");
    try {
      await provider.apiService.getUserSession().then((res) {
        //logger.i('5.1.2 getUserSession res.data ');
        //logger.i("Loading the data from res \$id " + res.$id.toString());
        //logger.i("Loading the data from res registration " +            res.registration.toString());

        _user = LoginUser.fromMap(res.toMap());
        //logger.i('5.1.3 _user info ' + _user.toString());
        _saveUserPrefs();
        _status = Status.authenticated;
      });
    } on AppwriteException catch (e) {
      _status = Status.unauthenticated;
      _error = e.message!;
    } finally {
      _loading = false;
    }
  }

  @override
  Future getPrefs() async {
    _loading = true;
    try {
      await provider.apiService.getPrefs().then((value) {
        //logger.i("*******************getPrefs()");
        //logger.i(value.toString());
      });
    } on AppwriteException catch (e) {
      _error = e.message!;
    } finally {
      _loading = false;
    }
    return null;
  }

  _saveUserPrefs() async {
//    if (_user == null) return;
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    int buildNumber = int.parse(packageInfo.buildNumber);
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    var deviceId = '';
    if (kIsWeb) {
      WebBrowserInfo webBrowserInfo = await deviceInfo.webBrowserInfo;
      deviceId = webBrowserInfo.userAgent!;
    } else {
      if (Platform.isAndroid) {
        AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
        deviceId = androidInfo.androidId!;
      } else if (Platform.isIOS) {
        IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
        deviceId = iosInfo.identifierForVendor!;
      }
    }

    var prefs = UserPrefs();
    prefs = prefs.copyWith(
      buildNumber: buildNumber,
      //    lastLoggedIn: DateTime.now(),
      introSeen: false,
      deviceId: deviceId,
    );
    await provider.apiService.updatePrefs(prefs.toMap());
    _user = _user.copyWith(prefs: prefs);
  }

  @override
  Future<String> getPhoto(String collectionName) async {
    _loading = true;
    String _photo =
        "https://appwrite.anchk.org/v1/storage/files/621441dad2b50285aa3d/view?project=61b0428203f09&mode=admin";
    try {
      await provider.apiService.getPhoto(collectionName).then((value) {
        //_debug(
        //    "At ${DateTime.now()} home_repository getPhoto() photo value is ${value.toString()}");
        _loading = false;
        _photo = value['photo'];
      });
    } on AppwriteException catch (e) {
      _error = e.message!;
      _loading = false;
    }
    //_debug(
    //    "At ${DateTime.now()} home_repository getPhoto() _photo is ${_photo.toString()}");
    return _photo;
  }

  @override
  Future<String> getPhotoFileId(String collectionName) async {
    _loading = true;
    String _photo = "621441dad2b50285aa3d";
    try {
      await provider.apiService.getPhoto(collectionName).then((value) {
        //_debug(
        //    "At ${DateTime.now()} home_repository getPhoto() photo value is ${value.toString()}");
        _loading = false;
        _photo = value['fileId'];
      });
    } on AppwriteException catch (e) {
      _error = e.message!;
      _loading = false;
    }
//    _debug(
//        "At ${DateTime.now()} home_repository getPhoto() _photo is ${_photo.toString()}");
    return _photo;
  }

  @override
  Future getFile(String fileId, {int quality = 100}) async {
    //logger.i("6.8 getFile Appwrite connection using HomeRepository");
    try {
      await provider.apiService.getFile(fileId, quality: quality).then((res) {
        //_debug(
        //    "At ${DateTime.now()} getFile(String $fileId), type is ${res.runtimeType}");
        _conductorFile = res;
        return res;
      });
    } on AppwriteException catch (e) {
      _error = e.message!;
    } finally {
      _loading = false;
    }
  }

  @override
  Future getWhatNewsDocument() async {
    //logger.i(
    //    "GetWhatNewsDocument Appwrite connection using HomeRepository at ${DateTime.now()}");
    _loading = true;
    //_debug(
    //    "At ${DateTime.now()} _loading in getWhatNewsDocument() Start ${_loading.toString()}");

    List<WhatNews> _whatNewsTmp = [];
    try {
      await provider.apiService.getWhatNewsDocument().then((res) async {
        //logger.i("Complete to get the getWhatNewsDocument from Appwrite");
//        List<Uint8List> _files = [];
        //_debug(
        //    "At ${DateTime.now()} getWhatNews length res.documents length is ${res.documents.length.toString()} _whatNews is ${_whatNews.length.toString()}");
//          _whatNews = [];
//          _whatNews.clear();

        for (var element in res.documents) {
          Uint8List _bgPhoto = Uint8List(0);
          Uint8List _photo = Uint8List(0);
          //_debug(
          //    "At ${DateTime.now()} res.documents.indexOf(element) ${res.documents.indexOf(element).toString()}");
          //_debug(
          //    "At ${DateTime.now()} res.documents.indexOf(element) ${_whatNews[res.documents.indexOf(element)].bgPhotoId.toString()} and ${element.data['bgPhotoId'].toString()} and isEqual ${_whatNews[res.documents.indexOf(element)].bgPhotoId == element.data['bgPhotoId']}");
          //_debug(
          //    "At ${DateTime.now()} res.documents.indexOf(element) ${_whatNews[res.documents.indexOf(element)].photoId.toString()} and ${element.data['photoId'].toString()} and isEqual ${_whatNews[res.documents.indexOf(element)].photoId == element.data['photoId']}");

          if (_whatNews[res.documents.indexOf(element)].bgPhotoId ==
              element.data['bgPhotoId']) {
            _bgPhoto = _whatNews[res.documents.indexOf(element)].bgPhotoFile!;
            //_debug(
            //    "At ${DateTime.now()} res.documents.indexOf(element) _bgPhoto size is ${_bgPhoto.length}");
          } else {
            await provider.apiService
                .getFile(element.data['bgPhotoId'], quality: 5)
                .then((bgPhotofile) async {
              _bgPhoto = bgPhotofile;
              //_debug(
              //    "At ${DateTime.now()} res.documents.indexOf(element) _bgPhoto size is ${_bgPhoto.length}");
            });
          }

          if (_whatNews[res.documents.indexOf(element)].photoId ==
              element.data['photoId']) {
            _photo = _whatNews[res.documents.indexOf(element)].photoFile!;
            //_debug(
            //    "At ${DateTime.now()} res.documents.indexOf(element) _photo size is ${_photo.length}");
          } else {
            await provider.apiService
                .getFile(element.data['photoId'], quality: 5)
                .then((photoFile) {
              _photo = photoFile;
              //_debug(
              //    "At ${DateTime.now()} res.documents.indexOf(element) _photo size is ${_photo.length}");
            });
          }

          //_debug(
          //    "At ${DateTime.now()} getWhatNews length adding _whatNews ${_whatNews.length.toString()}");
          _whatNewsTmp.add(WhatNews.fromObject(
              map: element.data, bgPhotoFile: _bgPhoto, photoFile: _photo));
          //_debug(
          //    "At ${DateTime.now()} getWhatNews length added _whatNews ${_whatNews.length.toString()}");
          //_debug("At ${DateTime.now()} getWhatNews length");
          //_debug(
          //    "At ${DateTime.now()} getWhatNewsDocument WhatNews ${res.documents.indexOf(element)} is ${_whatNews.last.event} and ${_whatNews.last.year}");

          //await provider.apiService
          //    .getFile(element.data['bgPhotoId'], quality: 5)
          //    .then((bgPhotofile) async {
          //  await provider.apiService
          //      .getFile(element.data['photoId'], quality: 5)
          //      .then((photoFile) {
          //    _debug(
          //        "At ${DateTime.now()} getWhatNews length adding _whatNews ${_whatNews.length.toString()}");
          //    _whatNewsTmp.add(WhatNews.fromObject(
          //        map: element.data,
          //        bgPhotoFile: bgPhotofile,
          //        photoFile: photoFile));
          //    _debug(
          //        "At ${DateTime.now()} getWhatNews length added _whatNews ${_whatNews.length.toString()}");
          //    _debug("At ${DateTime.now()} getWhatNews length");
          //    _debug(
          //        "At ${DateTime.now()} getWhatNewsDocument WhatNews ${res.documents.indexOf(element)} is ${_whatNews.last.event} and ${_whatNews.last.year}");
          //  });
          //});
        }
        _whatNews = _whatNewsTmp;
        //_debug(
        //    "At ${DateTime.now()} getWhatNews length _whatNews is ${_whatNews.length.toString()}");

//        _whatNews = res.convertTo<WhatNews>((p0) {
//          Uint8List _file = Uint8List(0);
//
//          provider.apiService
//              .getFile(p0['bgPhotoId'])
//              .then((file) => _file = file);
//          return WhatNews.fromMap((Map<String, dynamic>.from(p0)), _file);
//        });

        //_whatNews = res.convertTo<WhatNews>(
        //    (p0) => WhatNews.fromMap((Map<String, dynamic>.from(p0))));
        //logger.i(            "Complete to load the getWhatNewsDocument " + _whatNews.toString());
        //  logger.i(
        //      "Completed to run GetWhatNewsDocument Appwrite connection using HomeRepository at ${DateTime.now()}");
      });
    } on AppwriteException catch (e) {
      _error = e.message!;
    } finally {
      _loading = false;
      _firstTimeLoading = false;
      //_debug(
      //    "At ${DateTime.now()} _loading in getWhatNewsDocument() finally ${_loading.toString()}");
    }
  }

  @override
  Future getPracticePlaceDocument() async {
    //logger.i(        "6.2 getPracticePlaceDocument Appwrite connection using HomeRepository");
    try {
      await provider.apiService.getPracticePlaceDocument().then((res) {
        //logger.i("Complete to get the practicePlace from Appwrite");
        _practicePlace = res.convertTo<Paragraph>(
            (p0) => Paragraph.fromMap((Map<String, dynamic>.from(p0))));
        //logger.i(            "Complete to load the practicePlace " + _practicePlace.toString());
      });
    } on AppwriteException catch (e) {
      _error = e.message!;
    } finally {
      _loading = false;
    }
  }

  @override
  Future getPracticeTimeDocument() async {
    //logger.i(        "6.3 getPracticeTimeDocument Appwrite connection using HomeRepository");
    try {
      await provider.apiService.getPracticeTimeDocument().then((res) {
        _practiceTime = res.convertTo<Paragraph>(
            (p0) => Paragraph.fromMap((Map<String, dynamic>.from(p0))));
        //logger.i("Complete to load the practiceTime " + _practiceTime.toString());
      });
      await provider.apiService.getPhoto("practicePlace").then((value) async =>
          await provider.apiService
              .getFile(value['fileId'])
              .then((file) => _practiceFile = file));
    } on AppwriteException catch (e) {
      _error = e.message!;
    } finally {
      _loading = false;
    }
  }

  @override
  Future getPractice() async {
    //logger.i(        "6.3 getPracticeTimeDocument Appwrite connection using HomeRepository");
    List<Paragraph> _practiceTimeTmp = [];
    List<Paragraph> _practicePlaceTmp = [];
    PracticeInfo _practiceInfoTmp = PracticeInfo();
    Uint8List _photoFile = Uint8List(0);
    try {
      await provider.apiService.getPracticeTimeDocument().then((res) async {
        _practiceTimeTmp = res.convertTo<Paragraph>(
            (p0) => Paragraph.fromMap((Map<String, dynamic>.from(p0))));
        await provider.apiService.getPracticePlaceDocument().then((res) {
          _practicePlaceTmp = res.convertTo<Paragraph>(
              (p0) => Paragraph.fromMap((Map<String, dynamic>.from(p0))));
        });
        await provider.apiService.getPhoto("practicePlace").then((value) async {
          if (_practice.photo == value['fileId']) {
            _photoFile = _practice.photoFile!;
          } else {
            await provider.apiService.getFile(value['fileId']).then((file) {
              _photoFile = file;
            });
          }
          _practiceInfoTmp = PracticeInfo(
            practicePlace: _practicePlaceTmp,
            practiceTime: _practiceTimeTmp,
            photo: value['fileId'],
            photoFile: _photoFile,
          );
          _practice = _practiceInfoTmp;
        });
      });
    } on AppwriteException catch (e) {
      _error = e.message!;
    } finally {
      _loading = false;
    }
  }

  @override
  Future getRequirementDocument() async {
    //logger.i(        "6.4 getRequirementDocument Appwrite connection using HomeRepository");
    try {
      await provider.apiService.getRequirementDocument().then((res) async {
        //_requirement = res.convertTo<Paragraph>(
        //    (p0) => Paragraph.fromMap((Map<String, dynamic>.from(p0))));
        //logger.i("Complete to load the Requirement Document " +            _requirement.toString());

        AnchkOrganization _tmp = AnchkOrganization(name: "Requirement");
        Uint8List _photoTmp = Uint8List(0);
        await provider.apiService.getPhoto("requirement").then((value) async {
          if (_anchkRequirement.photo == value['fileId']) {
            _photoTmp = _introduction.photoFile!;
          } else {
            await provider.apiService.getFile(value['fileId']).then((file) {
              _photoTmp = file;
            });
          }
          _tmp = AnchkOrganization(
            name: "Requirement",
            message: res
                .convertTo<Paragraph>(
                    (p0) => Paragraph.fromMap((Map<String, dynamic>.from(p0))))
                .toList(),
            photo: value['fileId'],
            photoFile: _photoTmp,
          );
        });
        _anchkRequirement = _tmp;

        //await provider.apiService.getPhoto("requirement").then((value) async {
        //  await provider.apiService.getFile(value['fileId']).then((file) {
        //    _debug(
        //        "at ${DateTime.now()} getRequirementDocument value is ${value.toString()} photoFile is ${file.runtimeType} mesage lenght is ${res.convertTo<Paragraph>((p0) => Paragraph.fromMap((Map<String, dynamic>.from(p0)))).length}");
        //    _anchkRequirement = AnchkOrganization(
        //      name: "Requirement",
        //      message: res
        //          .convertTo<Paragraph>((p0) =>
        //              Paragraph.fromMap((Map<String, dynamic>.from(p0))))
        //          .toList(),
        //      photo: value['fileId'],
        //      photoFile: file,
        //    );
        //  });
        //  return value;
        //});
      });
    } on AppwriteException catch (e) {
      _error = e.message!;
    } finally {
      _loading = false;
    }
  }

  @override
  Future getAnchkOrganizationDocument() async {
    //logger.i(        "6.5 getAnchkOrganizationDocument Appwrite connection using HomeRepository");
    try {
      await provider.apiService
          .getAnchkOrganizationDocument()
          .then((res) async {
        //_debug(
        //    "at ${DateTime.now()} getAnchkOrganizationDocument ${_introduction.toString()}");

        //_anchkOrganization = res.convertTo<Paragraph>((p0) {
        //  return Paragraph.fromMap((Map<String, dynamic>.from(p0)));
        //});

        AnchkOrganization _tmp = AnchkOrganization(name: "Introduction");
        Uint8List _photoTmp = Uint8List(0);
        await provider.apiService
            .getPhoto("anchkOrganization")
            .then((value) async {
          if (_introduction.photo == value['fileId']) {
            _photoTmp = _introduction.photoFile!;
          } else {
            await provider.apiService.getFile(value['fileId']).then((file) {
              _photoTmp = file;
            });
          }
          _tmp = AnchkOrganization(
            name: "Introduction",
            message: res
                .convertTo<Paragraph>(
                    (p0) => Paragraph.fromMap((Map<String, dynamic>.from(p0))))
                .toList(),
            photo: value['fileId'],
            photoFile: _photoTmp,
          );
        });
        _introduction = _tmp;

        //await provider.apiService
        //    .getPhoto("anchkOrganization")
        //    .then((value) async {
        //  await provider.apiService.getFile(value['fileId']).then((file) {
        //    _debug(
        //        "at ${DateTime.now()} getAnchkOrganizationDocument value is ${value.toString()} photoFile is ${file.runtimeType} mesage lenght is ${res.convertTo<Paragraph>((p0) => Paragraph.fromMap((Map<String, dynamic>.from(p0)))).length}");
        //    _introduction = AnchkOrganization(
        //      name: "Introduction",
        //      message: res
        //          .convertTo<Paragraph>((p0) =>
        //              Paragraph.fromMap((Map<String, dynamic>.from(p0))))
        //          .toList(),
        //      photo: value['fileId'],
        //      photoFile: file,
        //    );
        //  });
        //  return value;
        //});

        //_debug(
        //    "at ${DateTime.now()} getAnchkOrganizationDocument ${_introduction.toString()}");

        //logger.i("Complete to load the getAnchkOrganizationDocument Document " +            _anchkOrganization.toString());
      });
    } on AppwriteException catch (e) {
      _error = e.message!;
    } finally {
      _loading = false;
    }
  }

  @override
  Future getAnchkMissionDocument() async {
    //logger.i(        "6.6 getAnchkMissionDocument Appwrite connection using HomeRepository");
    try {
      await provider.apiService.getAnchkMissionDocument().then((res) async {
        //_anchkMission = res.convertTo<Paragraph>(
        //    (p0) => Paragraph.fromMap((Map<String, dynamic>.from(p0))));
        //logger.i("Complete to load the getAnchkMissionDocument Document " +            _anchkMission.toString());
        AnchkOrganization _tmp = AnchkOrganization(name: "Mission");
        Uint8List _photoTmp = Uint8List(0);
        await provider.apiService.getPhoto("anchkMission").then((value) async {
          if (_mission.photo == value['fileId']) {
            _photoTmp = _mission.photoFile!;
          } else {
            await provider.apiService.getFile(value['fileId']).then((file) {
              _photoTmp = file;
            });
          }
          _tmp = AnchkOrganization(
            name: "Mission",
            message: res
                .convertTo<Paragraph>(
                    (p0) => Paragraph.fromMap((Map<String, dynamic>.from(p0))))
                .toList(),
            photo: value['fileId'],
            photoFile: _photoTmp,
          );
        });
        _mission = _tmp;

        //await provider.apiService.getPhoto("anchkMission").then((value) async {
        //  await provider.apiService.getFile(value['fileId']).then((file) {
        //    _debug(
        //        "at ${DateTime.now()} getAnchkMissionDocument value is ${value.toString()} photoFile is ${file.runtimeType} mesage lenght is ${res.convertTo<Paragraph>((p0) => Paragraph.fromMap((Map<String, dynamic>.from(p0)))).length}");
        //    _mission = AnchkOrganization(
        //      name: "Mission",
        //      message: res
        //          .convertTo<Paragraph>((p0) =>
        //              Paragraph.fromMap((Map<String, dynamic>.from(p0))))
        //          .toList(),
        //      photo: value['fileId'],
        //      photoFile: file,
        //    );
        //  });
        //  return value;
        //});
      });
    } on AppwriteException catch (e) {
      _error = e.message!;
    } finally {
      _loading = false;
    }
  }

  @override
  Future getConductorMessage() async {
    //logger.i("6.7 getConductorMessage Appwrite connection using HomeRepository");
    try {
      await provider.apiService.getConductorMessage().then((res) async {
        //logger.i("getConductorMessage is " +            res.documents[0].data['text'].toString());
        Conductor _conductorTmp = Conductor();
        Uint8List _conductorFile = Uint8List(0);
        if (_conductor.photo == res.documents[0].data['photo']) {
          _conductorFile = _conductor.photoFile!;
        } else {
          await provider.apiService
              .getFile(res.documents[0].data['photo'])
              .then((value) => _conductorFile = value);
        }
        _conductorTmp = Conductor(
          name: res.documents[0].data['name'],
          message: res.documents[0].data['text'],
          photo: res.documents[0].data['photo'],
          photoFile: _conductorFile,
        );
        _conductor = _conductorTmp;
        //await provider.apiService
        //    .getFile(res.documents[0].data['photo'])
        //    .then((value) => _conductor = Conductor(
        //          name: res.documents[0].data['name'],
        //          message: res.documents[0].data['text'],
        //          photo: res.documents[0].data['photo'],
        //          photoFile: value,
        //        ));
//        _conductorMessage = res.documents[0].data['text'];
//        _conductorPhoto = res.documents[0].data['photo'];
        //logger.i("Complete to load the getConductorMessage Document " +            _conductorMessage.toString());
      });
    } on AppwriteException catch (e) {
      _error = e.message!;
    } finally {
      _loading = false;
    }
  }

  @override
  Future getPreachersMessage() async {
    //logger.i("6.8 getPreachersMessage Appwrite connection using HomeRepository");

    try {
      await provider.apiService.getPreachersMessage().then((res) async {
        //logger.i("getPreachersMessage is " +            res.documents[0].data['text'].toString());

        Preacher _preacherTmp = Preacher();
        Uint8List _preacherFile = Uint8List(0);
        if (_preacher.photo == res.documents[0].data['photo']) {
          _preacherFile = _preacher.photoFile!;
        } else {
          await provider.apiService
              .getFile(res.documents[0].data['photo'])
              .then((value) => _preacherFile = value);
        }
        _preacherTmp = Preacher(
          name: res.documents[0].data['name'],
          message: res.documents[0].data['text'],
          photo: res.documents[0].data['photo'],
          photoFile: _preacherFile,
        );
        _preacher = _preacherTmp;

        //await provider.apiService
        //    .getFile(res.documents[0].data['photo'])
        //    .then((value) => _preacher = Preacher(
        //          name: res.documents[0].data['name'],
        //          message: res.documents[0].data['text'],
        //          photo: res.documents[0].data['photo'],
        //          photoFile: value,
        //        ));
        //_preachersMessage = res.documents[0].data['text'];
        //_preachersPhoto = res.documents[0].data['photo'];
        //logger.i("Complete to load the getPreachersMessage Document " +            _preachersMessage.toString());
      });
    } on AppwriteException catch (e) {
      _error = e.message!;
    } finally {
      _loading = false;
    }
  }

  @override
  Future getContactList() async {
    //logger.i("6.9 getContactList Appwrite connection using HomeRepository");
    try {
      await provider.apiService.getContactList().then((res) async {
        ContactInfo _contactTmp = ContactInfo();
        Uint8List _photoFile = Uint8List(0);

        //logger.i("Complete to load the contactList Document " +            _contactList.toString());
        await provider.apiService.getPhoto("contactList").then((value) async {
          if (_contact.photo == value['fileId']) {
            _photoFile = _contact.photoFile!;
          } else {
            await provider.apiService.getFile(value['fileId']).then((file) {
              _photoFile = file;
            });
          }
          _contactTmp = ContactInfo(
            organizationInfo: res.convertTo<OrganizationInfo>((p0) =>
                OrganizationInfo.fromMap((Map<String, dynamic>.from(p0)))),
            photo: value['fileId'],
            photoFile: _photoFile,
          );
          _contact = _contactTmp;

          //await provider.apiService.getFile(value['fileId']).then((file) {
          //  _contactList = res.convertTo<OrganizationInfo>((p0) =>
          //      OrganizationInfo.fromMap((Map<String, dynamic>.from(p0))));
          //  _contactListFile = file;
          //});
        });
      });
    } on AppwriteException catch (e) {
      _error = e.message!;
    } finally {
      _loading = false;
    }
  }

  @override
  Future getAnchkorgEventCategory() async {
    //logger.i(
    //    "getAnchkorgEventCategory Appwrite connection using HomeRepository at ${DateTime.now()}");
    try {
      await provider.apiService.getAnchkorgEventCategory().then((categoryRes) {
        provider.apiService.getAnchkorgEvent().then((eventRes) {
          List<EventCategory> _anchkorgEventCategory;

          _anchkorgEventCategory =
              categoryRes.convertTo<EventCategory>((eventCategoryP0) {
            EventCategory _eventCategory;
            String _name;
            _name = eventCategoryP0['name'].toString();
            List<EventHistory> _anchkEventHostory = eventRes.convertTo(
                (p0) => EventHistory.fromMap((Map<String, dynamic>.from(p0))));
            _eventCategory =
                EventCategory.byCategoryName(_name, _anchkEventHostory);
            return _eventCategory;
          });
          _anchkorgEventCategory1 = _anchkorgEventCategory.sublist(0, 4);
          _anchkorgEventCategory2 = _anchkorgEventCategory.sublist(4);
          return _anchkorgEventCategory;

          //logger.i("Complete to load the getAnchkorgEventCategory Document " +              _anchkorgEventCategory.toString());
          //logger.i(
          //    "Completed to run getAnchkorgEventCategory Appwrite connection using HomeRepository at ${DateTime.now()}");
        });
      });
    } on AppwriteException catch (e) {
      _error = e.message!;
    } finally {
      _loading = false;
    }
  }

  @override
  Future getAnchkorgEventCategory1() async {
    //logger.i(
    //    "getAnchkorgEventCategory Appwrite connection using HomeRepository at ${DateTime.now()}");
    try {
      await provider.apiService.getAnchkorgEventCategory().then((categoryRes) {
        provider.apiService.getAnchkorgEvent().then((eventRes) {
          List<EventCategory> _anchkorgEventCategory;

          _anchkorgEventCategory =
              categoryRes.convertTo<EventCategory>((eventCategoryP0) {
            EventCategory _eventCategory;
            String _name;
            _name = eventCategoryP0['name'].toString();
            List<EventHistory> _anchkEventHostory = eventRes.convertTo(
                (p0) => EventHistory.fromMap((Map<String, dynamic>.from(p0))));
            _eventCategory =
                EventCategory.byCategoryName(_name, _anchkEventHostory);
            return _eventCategory;
          });
          _anchkorgEventCategory1 = _anchkorgEventCategory.sublist(0, 4);
          _anchkorgEventCategory2 = _anchkorgEventCategory.sublist(4);
          return _anchkorgEventCategory1;

          //logger.i("Complete to load the getAnchkorgEventCategory Document " +              _anchkorgEventCategory.toString());
          //logger.i(
          //    "Completed to run getAnchkorgEventCategory Appwrite connection using HomeRepository at ${DateTime.now()}");
        });
      });
    } on AppwriteException catch (e) {
      _error = e.message!;
    } finally {
      _loading = false;
    }
  }

  @override
  Future getAnchkorgEventCategory2() async {
    //logger.i(
    //    "getAnchkorgEventCategory Appwrite connection using HomeRepository at ${DateTime.now()}");
    //_anchkorgEventCategory2 = [];
    //_debug(
    //    "at ${DateTime.now()} Before Testing on _anchkorgEventCategory2 ${_anchkorgEventCategory2.length}");
    try {
      await provider.apiService.getAnchkorgEventCategory().then((categoryRes) {
        provider.apiService.getAnchkorgEvent().then((eventRes) {
          List<EventCategory> _anchkorgEventCategory;

          _anchkorgEventCategory =
              categoryRes.convertTo<EventCategory>((eventCategoryP0) {
            EventCategory _eventCategory;
            String _name;
            _name = eventCategoryP0['name'].toString();
            List<EventHistory> _anchkEventHostory = eventRes.convertTo(
                (p0) => EventHistory.fromMap((Map<String, dynamic>.from(p0))));
            _eventCategory =
                EventCategory.byCategoryName(_name, _anchkEventHostory);
            return _eventCategory;
          });
          _anchkorgEventCategory1 = _anchkorgEventCategory.sublist(0, 4);
          _anchkorgEventCategory2 = _anchkorgEventCategory.sublist(4);
          //_debug(
          //    "at ${DateTime.now()} Testing on _anchkorgEventCategory2 ${_anchkorgEventCategory2.length}\n ${_anchkorgEventCategory2.toString()}");
          return _anchkorgEventCategory2;

          //logger.i("Complete to load the getAnchkorgEventCategory Document " +              _anchkorgEventCategory.toString());
          //logger.i(
          //    "Completed to run getAnchkorgEventCategory Appwrite connection using HomeRepository at ${DateTime.now()}");
        });
      });
    } on AppwriteException catch (e) {
      _error = e.message!;
    } finally {
      _loading = false;
    }
  }

  @override
  Future getVideoList() async {
    //logger.i("6.11 getVideoList Appwrite connection using HomeRepository");
    try {
      await provider.apiService.getVideoList().then((res) {
        _videoList = res.convertTo<YoutubeModel>(
            (p0) => YoutubeModel.fromMap((Map<String, dynamic>.from(p0))));
        //logger.i("Complete to load the contactList Document " +            _contactList.toString());
      });
    } on AppwriteException catch (e) {
      _error = e.message!;
    } finally {
      _loading = false;
    }
  }

  @override
  void createApplication(Map<dynamic, dynamic> data) async {
    // Future<dynamic> result;
    logger.i(
        "createApplication Appwrite connection using HomeRepository at ${DateTime.now()}");
    try {
      _status != Status.authenticated
          ? provider.apiService
              .createAnonymousSession()
              .then((value) => _createApplication(data, value.$id))
          : _createApplication(data, session.$id);
    } on AppwriteException catch (e) {
      _error = e.message!;
      logger.i("createApplication error message " + _error);
      //  result = {"e": "e"} as Future;
    } finally {
      _loading = false;
    }
    // return result;
  }

  void _createApplication(Map<dynamic, dynamic> data, String sessionId) {
    provider.apiService
        .createApplication(data)
        .then((value) => logout(sessionId: sessionId));
  }
}
