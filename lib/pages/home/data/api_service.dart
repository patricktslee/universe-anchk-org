import 'dart:async';
import 'dart:math';

import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
//import 'package:get/state_manager.dart';
import 'package:logger/logger.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:universe/shared/app_constants.dart';

class ApiService {
  static late final ApiService _instance;
  static bool _isInstanceCreated = false;
  final List<String> _apiLog = [];
  List<String> get apiLog => _apiLog;
  set apiLog(List<String> value) {
    _apiLog.addAll(value);
  }

  final Client client = Client();
  Account? account;
  Database? db;
  Avatars? avatars;
  Storage? storage;
  final logger = Logger(
    printer: PrettyPrinter(
        methodCount: 1,
        lineLength: 50,
        errorMethodCount: 3,
        colors: true,
        printEmojis: true),
  );
  Realtime? realtime;

  ApiService._internal() {
    //_debug("At ${DateTime.now()} Initial Appwrite connection using ApiService");
    client.setEndpoint(AppConstants.endpoint).setProject(AppConstants.project);
    account = Account(client);
    db = Database(client);
    avatars = Avatars(client);
    storage = Storage(client);
    realtime = Realtime(client);
  }

  static ApiService get instance {
    if (_isInstanceCreated == false) {
      _isInstanceCreated = true;
      _instance = ApiService._internal();
    }
    return _instance;
  }

  void addApiLog(String value) => _apiLog.add(value);

  void _debug(String value) {
    value = "At ApiService class - " + value;
    print(value);
    logger.i(value);
    addApiLog(value);
  }

  Future login({required String email, required String password}) async {
    _debug('login($email) => Trying to ApiService login');
    return await account!
        .createSession(email: email, password: password)
        .then((value) {
      _debug("At ${DateTime.now()} ApiService login($email) success");
      _debug(value.toMap().toString());
      return value;
    });
  }

  Future createAnonymousSession() async {
    //_debug(
    //    "At ${DateTime.now()} createAnonymousSession() => Trying to ApiService Anonymous login");
    return await account!.createAnonymousSession().then((value) {
      //_debug(
      //    '2.1  ApiService Anonymous login success\n${value.toMap().toString()}');
      //_debug("ApiService Anonymous login success");
      //_debug(value.toMap().toString());
      return value;
    });
  }

  Future signup(
      {required String name,
      required String email,
      required String password}) async {
    _debug(
        "At ${DateTime.now()} signup($name,$email) => Trying to ApiService SignUp");
    String _userId = _generateUniquekey(10);
    return account!
        .create(userId: _userId, name: name, email: email, password: password)
        .then((value) {
      _debug("ApiService signup() success");
      _debug(value.toMap().toString());
      return value;
    });
  }

  Future logout({String? sessionId}) async {
    _debug(
        "At ${DateTime.now()} logout($sessionId) => ApiService Anonymous logout");
    dynamic _dynamic =
        //    _debug('Session ID is ' + sessionId);
        account!.deleteSession(sessionId: sessionId!).then((value) {
      _debug("ApiService Anonymous logout success");
      return value;
    }).catchError((exception, stackTrace) async {
      _debug("ApiService Anonymous logout fail");
      await Sentry.captureException(
        exception,
        stackTrace: stackTrace,
      );
    });
//    return sessionId == 'null'
//        ? account!.deleteSessions()
//        : account!.deleteSession(sessionId: sessionId.toString());
    return _dynamic;
  }

  Future logoutAll() async {
    _debug(
        "At ${DateTime.now()} logout() => Starting ApiService Anonymous logout all sessions");
//    dynamic _dynamic;
    account!.deleteSessions().then((value) {
      _debug("ApiService Anonymous all sessions logout success");
      return value;
    }).catchError((exception, stackTrace) async {
      _debug("ApiService Anonymous all sessions logout fail");
      await Sentry.captureException(
        exception,
        stackTrace: stackTrace,
      );
      return stackTrace;
    });
//    return _dynamic;
  }

  Realtime getRealtime() {
    return realtime!;
  }

  //late final subscription;
  //subscribe() {
  //  try {
  //    _debug("Running subscribe");
  //    subscription = realtime!.subscribe(['documents']);
  //    subscription.stream.listen((event) {
  //      _debug("subscription event");
  //    });
  //    Timer(const Duration(seconds: 20), () async {
  //      unsubscribe();
  //    });
  //    _debug("finish subscribe");
  //  } on AppwriteException catch (e) {
  //    _debug("Envelope message is " + e.message.toString());
  //  }
  //}
//
  //unsubscribe() {
  //  subscription.close();
  //}

  Future<User> getUserSession() async {
    //_debug(
    //    "At ${DateTime.now()} getUserSession() => Starting ApiService getUserSession");
    return account!.get().then((value) {
      //_debug("GetUserSession success!");
      return value;
    }).catchError((exception, stackTrace) async {
      _debug("GetUserSession fail!");
    });
  }

  Future<String> get() async {
    //_debug("At ${DateTime.now()} get() => Starting ApiService get()");
    String _result = "result";
    await account!.get().then((response) {
      User _response = response;
      _result = _response.$id;
      //_debug(
      //    "get() response is ${_response.toMap().toString()}\n_result is $_result");
    }).catchError((error) {
      _result = error.response["code"].toString();
      _debug(
          "get() error is ${error.response}.\nget() status is ${error.response["code"]}\n_result is $_result");
    });
    return _result;
  }

  Future<Session> getSession(String? sessionID) async {
    _debug(
        "At ${DateTime.now()} getSession($sessionID) => Starting ApiService getSession()");
    return account!.getSession(sessionId: sessionID!).then((value) {
//      _debug("getSession($sessionID) success!");
      return value;
    }).catchError((exception, stackTrace) async {
      _debug("getSession($sessionID) fail!");
      _debug(stackTrace);
      await Sentry.captureException(
        exception,
        stackTrace: stackTrace,
      );
    });
  }

  Future getSessions() async {
    //_debug("At ${DateTime.now()} getSessions()  => Starting ApiService ");
    return account!.getSessions().then((value) {
      _debug("getSessions() success!");
      return value;
    }).catchError((exception, stackTrace) async {
      _debug("getSessions() fail!");
      await Sentry.captureException(
        exception,
        stackTrace: stackTrace,
      );
    });
  }

  Future updatePrefs(Map<String, dynamic> data) {
    //_debug("At ${DateTime.now()} updatePrefs() => Starting ApiService ");
    return account!.updatePrefs(prefs: data).then((value) {
      //_debug("updatePrefs() success!");
      return value;
    }).catchError((exception, stackTrace) async {
      _debug("updatePrefs() fail!");
      await Sentry.captureException(
        exception,
        stackTrace: stackTrace,
      );
    });
  }

  Future getInitialsAvatar(String name) {
    _debug(
        "At ${DateTime.now()} getInitialsAvatar($name) => Starting ApiService ");
    return avatars!.getInitials(name: name, width: 200).then((value) {
      _debug("getInitialsAvatar($name) success!");
      return value;
    }).catchError((exception, stackTrace) async {
      _debug("getInitialsAvatar($name) fail!");
      await Sentry.captureException(
        exception,
        stackTrace: stackTrace,
      );
    });
  }

  Future getPrefs() {
    _debug("At ${DateTime.now()} getPrefs() => Starting ApiService ");
    return account!.getPrefs().then((value) {
      _debug("getPrefs() success!");
      return value;
    }).catchError((exception, stackTrace) async {
      _debug("getPrefs() fail!");
      await Sentry.captureException(
        exception,
        stackTrace: stackTrace,
      );
    });
  }

  Future getFile(String fileId, {int quality = 100}) {
//    _debug("At ${DateTime.now()} getPhoto($fileId) => Starting ApiService ");
    return storage!
        .getFilePreview(bucketId: "default", fileId: fileId, quality: quality)
        .then((value) {
//      _debug(
//          "At ${DateTime.now()} getFile(String $fileId) , type is ${value.runtimeType}");
      return value;
    });
  }

  Future getPhoto(String collectionName) {
//    _debug("At ${DateTime.now()} getPhoto() => Starting ApiService ");
    return db!.listDocuments(collectionId: "photos").then((listDocuments) {
//      _debug(
//          "At ${DateTime.now()} getPhoto() number ${listDocuments.sum.toString()} ");
      Iterable<Document> documentList = listDocuments.documents
          .where((element) => element.data["collectionName"] == collectionName);
//      _debug(
//          "At ${DateTime.now()} getPhoto() photo ${documentList.first.data["photo"].toString()} ");

      return documentList.first.data;
    });
  }

  Future<DocumentList> getWhatNewsDocument() {
    List<dynamic> orderTypes = ['ASC', 'ASC', 'ASC', 'ASC'];
    List<dynamic> orderAttributes = ['isCompleted', 'year', 'month', 'day'];
    return db!
        .listDocuments(
      collectionId: '61b1cc5580c71',
      limit: 50,
      orderAttributes: orderAttributes,
      orderTypes: orderTypes,
    )
        .then((value) {
//      _debug("getWhatNewsDocument information " + value.sum.toString());
//      _debug(value.documents
//          .map((e) => print(e.data.toString()))
//          .toList()
//          .toString());
//      _debug(value.toString());
      return value;
    }).catchError((exception, stackTrace) async {
      await Sentry.captureException(
        exception,
        stackTrace: stackTrace,
      );
    });
  }

  Future<DocumentList> getPracticePlaceDocument() {
    return db!
        .listDocuments(
      collectionId: 'practicePlace',
      limit: 50,
    )
        .then((value) {
      //_debug("getPracticePlaceDocument information " + value.sum.toString());
      //_debug(value.documents.map((e) => _debug(e.data.toString())));
      //_debug(value);
      return value;
    }).catchError((exception, stackTrace) async {
      await Sentry.captureException(
        exception,
        stackTrace: stackTrace,
      );
      _debug(stackTrace);
    });
  }

  Future<DocumentList> getPracticeTimeDocument() {
    return db!
        .listDocuments(
      collectionId: 'practiceTime',
      limit: 50,
    )
        .then((value) {
      //_debug("getpracticeTimeDocument information " + value.sum.toString());
      //_debug(value.documents.map((e) => _debug(e.data.toString())));
      //_debug(value);
      return value;
    }).catchError((exception, stackTrace) async {
      await Sentry.captureException(
        exception,
        stackTrace: stackTrace,
      );
      _debug(stackTrace);
    });
  }

  Future<DocumentList> getRequirementDocument() {
    return db!
        .listDocuments(
      collectionId: 'requirement',
      limit: 50,
    )
        .then((value) {
      //_debug("getRequirementDocument information " + value.sum.toString());
      //_debug(value.documents.map((e) => _debug(e.data.toString())));
      //_debug(value);
      return value;
    }).catchError((exception, stackTrace) async {
      await Sentry.captureException(
        exception,
        stackTrace: stackTrace,
      );
      _debug(stackTrace);
    });
  }

  Future<DocumentList> getAnchkOrganizationDocument() {
    return db!
        .listDocuments(
      collectionId: 'anchkOrganization',
      limit: 50,
    )
        .then((value) {
      //_debug(          "getAnchkOrganizationDocument information " + value.sum.toString());
      //_debug(value.documents.map((e) => _debug(e.data.toString())));
      //_debug(value);
      return value;
    }).catchError((exception, stackTrace) async {
      await Sentry.captureException(
        exception,
        stackTrace: stackTrace,
      );
      _debug(stackTrace);
    });
  }

  Future<DocumentList> getAnchkMissionDocument() {
    return db!
        .listDocuments(
      collectionId: 'anchkMission',
      limit: 50,
    )
        .then((value) {
      //_debug("getAnchkMissionDocument information " + value.sum.toString());
      //_debug(value.documents.map((e) => _debug(e.data.toString())));
      //_debug(value);
      return value;
    }).catchError((exception, stackTrace) async {
      await Sentry.captureException(
        exception,
        stackTrace: stackTrace,
      );
      _debug(stackTrace);
    });
  }

  Future<DocumentList> getConductorMessage() {
    return db!
        .listDocuments(
      collectionId: 'conductorMessage',
      limit: 50,
    )
        .then((value) {
      //_debug("getconductorMessage information " + value.sum.toString());
      //_debug(value.documents.map((e) => _debug(e.data.toString())));
      //_debug(value);
      return value;
    }).catchError((exception, stackTrace) async {
      await Sentry.captureException(
        exception,
        stackTrace: stackTrace,
      );
      _debug(stackTrace);
    });
  }

  Future<DocumentList> getPreachersMessage() {
    return db!
        .listDocuments(
      collectionId: 'preachersMessage',
      limit: 50,
    )
        .then((value) {
      //_debug("getPreachersMessage information " + value.sum.toString());
      //_debug(value.documents.map((e) => _debug(e.data.toString())));
      //_debug(value);
      return value;
    }).catchError((exception, stackTrace) async {
      await Sentry.captureException(
        exception,
        stackTrace: stackTrace,
      );
      _debug(stackTrace);
    });
  }

  Future<DocumentList> getContactList() {
    return db!
        .listDocuments(
      collectionId: 'contactList',
      limit: 50,
    )
        .then((value) {
      //_debug("getContactList information " + value.sum.toString());
      //_debug(value.documents.map((e) => _debug(e.data.toString())));
      //_debug(value);
      return value;
    }).catchError((exception, stackTrace) async {
      await Sentry.captureException(
        exception,
        stackTrace: stackTrace,
      );
      _debug(stackTrace);
    });
  }

  Future<DocumentList> getAnchkorgEventCategory() {
    return db!
        .listDocuments(
      collectionId: 'category',
      limit: 100,
    )
        .then((value) {
      //_debug("getAnchkorgEventCategory information " + value.sum.toString());
      //_debug(value.documents.map((e) => _debug(e.data.toString())));
      //_debug(value);
      return value;
    }).catchError((exception, stackTrace) async {
      await Sentry.captureException(
        exception,
        stackTrace: stackTrace,
      );
      _debug(stackTrace);
    });
  }

  Future<DocumentList> getAnchkorgEvent() {
    return db!
        .listDocuments(
      collectionId: 'event',
      limit: 100,
    )
        .then((value) {
      //_debug("getAnchkorgEvent information " + value.sum.toString());
      //_debug(value.documents.map((e) => _debug(e.data.toString())));
      //_debug(value);
      return value;
    }).catchError((exception, stackTrace) async {
      await Sentry.captureException(
        exception,
        stackTrace: stackTrace,
      );
      _debug(stackTrace);
    });
  }

  Future<DocumentList> getVideoList() {
    List<dynamic> orderTypes = ['ASC'];
    List<dynamic> orderAttributes = ['youtubeTitle'];
    return db!
        .listDocuments(
      collectionId: 'videoList',
      orderAttributes: orderAttributes,
      orderTypes: orderTypes,
      limit: 50,
    )
        .then((value) {
//      _debug("getVideoList information " + value.sum.toString());
//      _debug(value.documents.map((e) => _debug(e.data.toString())));
//      _debug(value);
      return value;
    }).catchError((exception, stackTrace) async {
      await Sentry.captureException(
        exception,
        stackTrace: stackTrace,
      );
      _debug(stackTrace);
    });
  }

  Future createApplication(Map<dynamic, dynamic> data) {
    _debug("Starting createApplication");
    _debug("createApplication data is " + data.toString());
    String documentId = _generateUniquekey(10) + data["phone"].toString();
    _debug("createApplication documentId is " + documentId);
    return db!.createDocument(
      collectionId: 'applicationList',
      documentId: documentId,
      data: data,
      read: ['role:all'],
      write: ['role:all'],
    ).then((response) {
      _debug("createApplication data is " + response.data.toString());
      _debug("Finish createApplication");
    }).catchError((error) {
      print(error.message);
    }, test: (e) => e is AppwriteException);
    //catchError((exception, stackTrace) async {
    //  _debug("createApplication error is " + stackTrace);
    //  await Sentry.captureException(
    //    exception,
    //    stackTrace: stackTrace,
    //  );
    //});
  }

  String _generateUniquekey(int length) {
    const _chars =
        'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
    Random _rnd = Random();

    String getRandomString(int length) =>
        String.fromCharCodes(Iterable.generate(
            length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));
    return getRandomString(length);
  }

  Future updateAccountPassword(String password, String oldPassword) {
    _debug(
        "At ${DateTime.now()} updateAccountPassword() => Trying to ApiService updateAccountPassword");
    return account!
        .updatePassword(password: password, oldPassword: oldPassword)
        .then((value) {
      _debug("At ${DateTime.now()} ApiService updateAccountPassword() success");
      _debug(value.toMap().toString());
      return value;
    });
  }
}
