import 'dart:async';
import 'dart:math';
import 'dart:typed_data';

import 'package:appwrite/appwrite.dart' as appwrite;
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

  final appwrite.Client client = appwrite.Client();
  appwrite.Account? account;
  appwrite.Databases? db;
  appwrite.Avatars? avatars;
  appwrite.Storage? storage;
  final logger = Logger(
    printer: PrettyPrinter(
        methodCount: 1,
        lineLength: 50,
        errorMethodCount: 3,
        colors: true,
        printEmojis: true),
  );
  appwrite.Realtime? realtime;

  ApiService._internal() {
    //_debug("At ${DateTime.now()} Initial Appwrite connection using ApiService");
    client.setEndpoint(AppConstants.endpoint).setProject(AppConstants.project);
    account = appwrite.Account(client);
    db = appwrite.Databases(client);
    avatars = appwrite.Avatars(client);
    storage = appwrite.Storage(client);
    realtime = appwrite.Realtime(client);
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
        .createEmailSession(email: email, password: password)
        .then((value) {
      _debug(
          "At ${DateTime.now()} ApiService login($email) value runtimeType " +
              value.runtimeType.toString());
      _debug("At ${DateTime.now()} ApiService login($email) success " +
          value.toMap().toString());
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
      //_debug("ApiService signup() success");
      //_debug(value.toMap().toString());
      return value;
    });
  }

  Future logout({String? sessionId}) async {
    //_debug(
    //    "At ${DateTime.now()} logout($sessionId) => ApiService Anonymous logout");
    dynamic _dynamic =
        //    _debug('Session ID is ' + sessionId);
        account!.deleteSession(sessionId: sessionId!).then((value) {
      //_debug("ApiService Anonymous logout success");
      return value;
    }).catchError((exception, stackTrace) async {
      //_debug("ApiService Anonymous logout fail");
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
    //_debug(
    //    "At ${DateTime.now()} logout() => Starting ApiService Anonymous logout all sessions");
//    dynamic _dynamic;
    account!.deleteSessions().then((value) {
      //_debug("ApiService Anonymous all sessions logout success");
      return value;
    }).catchError((exception, stackTrace) async {
      //_debug("ApiService Anonymous all sessions logout fail");
      await Sentry.captureException(
        exception,
        stackTrace: stackTrace,
      );
      return stackTrace;
    });
//    return _dynamic;
  }

  Future<File?> uploadFile(
      {required appwrite.InputFile inFile,
      required appwrite.Account user,
      required String bucketId,
      String fileId = "unique()"}) async {
    _debug(
        "At ${DateTime.now()} uploadFile() => Starting ApiService uploadFile");
    //File file = File($id: $id, bucketId: bucketId, $createdAt: $createdAt, $updatedAt: $updatedAt, $permissions: $permissions, name: name, signature: signature, mimeType: mimeType, sizeOriginal: sizeOriginal, chunksTotal: chunksTotal, chunksUploaded: chunksUploaded);
    try {
      return await storage!
          .createFile(
        bucketId: bucketId,
        fileId: fileId,
        file: inFile,
      )
          .then((file) {
        _debug(
            "At ${DateTime.now()} uploadFile() => result ${file.toString()}");
        return file;
      });
    } on AppwriteException catch (exception, stackTrace) {
      _debug("AppwriteException: uploadFile fail!");
      await Sentry.captureException(
        exception,
        stackTrace: stackTrace,
      );
      return null;
    }

    //return storage!
    //    .createFile(
    //  bucketId: bucketId,
    //  fileId: fileId,
    //  file: inFile,
    //)
    //    .then((file) {
    //  _debug("At ${DateTime.now()} uploadFile() => result ${file.toString()}");
    //  return file;
    //}).catchError((exception, stackTrace) async {
    //  _debug("uploadFile fail!");
    //});
  }

  Future<Document?> createDocument({
    required String collectionId,
    required Map<String, dynamic> data,
    String documentId = "unique()",
    List<dynamic> readPermission = const ['*'],
    List<dynamic> writePermission = const ['*'],
  }) async {
    _debug(
        "At ${DateTime.now()} createDocument() => Starting ApiService uploadFile");
    try {
      return await db!
          .createDocument(
        databaseId: 'default',
        collectionId: collectionId,
        data: data,
        documentId: documentId,
      )
          .then((document) {
        _debug(
            "At ${DateTime.now()} createDocument() => result ${document.toString()}");
        return document;
      });
    } on AppwriteException catch (exception, stackTrace) {
      _debug("AppwriteException: createDocument fail!");
      await Sentry.captureException(
        exception,
        stackTrace: stackTrace,
      );
      return null;
    }

    //return db!
    //    .createDocument(
    //  databaseId: 'default',
    //  collectionId: collectionId,
    //  data: data,
    //  documentId: documentId,
    //)
    //    .then((document) {
    //  _debug(
    //      "At ${DateTime.now()} createDocument() => result ${document.toString()}");
    //  return document;
    //}).catchError((exception, stackTrace) async {
    //  _debug("createDocument fail!");
    //});
  }

  Future<DocumentList?> listDocuments({required String collectionId}) async {
    try {
      return await db!.listDocuments(
        collectionId: collectionId,
        databaseId: 'default',
        queries: [
          appwrite.Query.limit(50),
          appwrite.Query.orderAsc('isCompleted'),
          appwrite.Query.orderAsc('year'),
          appwrite.Query.orderAsc('month'),
          appwrite.Query.orderAsc('day'),
        ],
      ).then((value) {
        return value;
      });
    } on AppwriteException catch (exception, stackTrace) {
      _debug("AppwriteException: listDocuments fail!");
      await Sentry.captureException(
        exception,
        stackTrace: stackTrace,
      );
      return null;
    }

    //return db!.listDocuments(
    //  collectionId: collectionId,
    //  databaseId: 'default',
    //  queries: [
    //    appwrite.Query.limit(50),
    //    appwrite.Query.orderAsc('isCompleted'),
    //    appwrite.Query.orderAsc('year'),
    //    appwrite.Query.orderAsc('month'),
    //    appwrite.Query.orderAsc('day'),
    //  ],
    //).then((value) {
    //  return value;
    //}).catchError((exception, stackTrace) async {
    //  await Sentry.captureException(
    //    exception,
    //    stackTrace: stackTrace,
    //  );
    //});
  }

  appwrite.Realtime getRealtime() {
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

  Future<User?> getUserSession() async {
    //_debug(
    //    "At ${DateTime.now()} getUserSession() => Starting ApiService getUserSession");
    try {
      return account!.get().then((value) {
        //_debug("GetUserSession success!");
        return value;
      });
    } on AppwriteException catch (exception, stackTrace) {
      _debug("AppwriteException: listDocuments fail!");
      await Sentry.captureException(
        exception,
        stackTrace: stackTrace,
      );
      return null;
    }
    //return account!.get().then((value) {
    //  //_debug("GetUserSession success!");
    //  return value;
    //}).catchError((exception, stackTrace) async {
    //  _debug("GetUserSession fail!");
    //});
  }

  Future<String> getAnonymousSession() async {
    //_debug("At ${DateTime.now()} get() => Starting ApiService get()");
    String _result = "result";
    try {
      await account!.get().then((response) {
        User _response = response;
        _result = _response.$id;
        if (AppConstants.debug) {
          _debug(
              "appwriteLogin()** getAnonymousSession() response is ${_response.toMap().toString()} and _result is $_result");
        }
      });
    } on appwrite.AppwriteException catch (e) {
      _result = e.response["code"].toString();
      if (AppConstants.debug) {
        _debug(
            "appwriteLogin()** getAnonymousSession() error is ${e.response}.\nget() status is ${e.response["code"]}\n_result is $_result");
      }
      try {
        await account!.createAnonymousSession().then((loginAnonymousSession) {
          if (AppConstants.debug) {
            _debug(
                "appwriteLogin()** getAnonymousSession() loginAnonymousSession is ${loginAnonymousSession.toString()}");
          }
          Session _session = loginAnonymousSession;
          _result = _session.userId;
        });
      } on appwrite.AppwriteException catch (e) {
        if (AppConstants.debug) {
          _debug(
              "appwriteLogin()** createAnonymousSession() error is ${e.response}.\nget() status is ${e.response["code"]}\n_result is $_result");
        }
        _result = "error";
      }
    }
    return _result;
  }

  Future<String> get() async {
    //_debug("At ${DateTime.now()} get() => Starting ApiService get()");
    String _result = "result";
    try {
      await account!.get().then((response) {
        User _response = response;
        _result = _response.$id;
        if (AppConstants.debug) {
          _debug(
              "appwriteLogin()** get() response is ${_response.toMap().toString()}\n_result is $_result");
        }
      });
      //.catchError((error) {
      //  _result = error.response["code"].toString();
      //  _debug(
      //      "get() error is ${error.response}.\nget() status is ${error.response["code"]}\n_result is $_result");
      //});
    } on appwrite.AppwriteException catch (e) {
      _result = e.response["code"].toString();
      if (AppConstants.debug) {
        _debug(
            "appwriteLogin()** get() error is ${e.response}.\nget() status is ${e.response["code"]}\n_result is $_result");
      }
    }
    if (AppConstants.debug) {
      _debug("appwriteLogin()** Final result vaule is $_result");
    }
    return _result;
  }

//  Future<Session> getSession(String? sessionID) async {
//  Future getSession(String? sessionID) async {
  Future getSession(String? sessionID) async {
    _debug(
        "At ${DateTime.now()} getSession($sessionID) => Starting ApiService getSession()");
    String _result = "result";

    try {
      Future result = account!.getSession(sessionId: sessionID!);

      _debug(
          "At ${DateTime.now()} getSession($sessionID) result type is ${result.runtimeType}");
      result.then((response) {
        _debug("getSession($sessionID) response is");
        _result = response.toString();
        _debug("getSession($sessionID) _result is $_result");
        return response;
      }).catchError((error) {
        _debug("getSessions() error is ${(error.response)}");
      });
    } on appwrite.AppwriteException catch (exception, stackTrace) {
      _debug("getSession($sessionID) fail! on AppwriteException");
      _debug(stackTrace.toString());
      await Sentry.captureException(
        exception,
        stackTrace: stackTrace,
      );
    } on Exception catch (exception, stackTrace) {
      _debug("getSession($sessionID) fail! on Exception");
      _debug(stackTrace.toString());
      await Sentry.captureException(
        exception,
        stackTrace: stackTrace,
      );
    }
    _debug(
        "At ${DateTime.now()} getSession($sessionID) => Completed ApiService getSession()");
  }

  Future<String> getSessions() async {
    //_debug(
    //    "At ${DateTime.now()} getSessions() => Starting ApiService getSessions()");
    String _result = "result";
    try {
      Future result = account!.listSessions();
      //_debug("getSessions() result for count!.getSessions() is $result");
      result.then((response) {
        //_debug("getSessions() response is $response");
//        _result = response.toString();
        //_debug("getSessions() _result is $_result");
      }).catchError((error) {
        //_debug("getSessions() error is ${(error.response)}");
      });
    } on appwrite.AppwriteException catch (e) {
      _result = e.response["code"].toString();
      //_debug(
      //    "getSessions() error is ${e.response}.\nget() status is ${e.response["code"]}\n_result is $_result");
    }
    //_debug(
    //    "At ${DateTime.now()} getSessions() => Starting ApiService getSessions() result is $_result");
    return _result;
  }

  Future updatePrefs(Map<String, dynamic> data) async {
    //_debug("At ${DateTime.now()} updatePrefs() => Starting ApiService ");
    try {
      return account!.updatePrefs(prefs: data).then((value) {
        //_debug("updatePrefs() success!");
        return value;
      });
    } on AppwriteException catch (exception, stackTrace) {
      _debug("AppwriteException: updatePrefs fail!");
      await Sentry.captureException(
        exception,
        stackTrace: stackTrace,
      );
      return null;
    }
    //return account!.updatePrefs(prefs: data).then((value) {
    //  //_debug("updatePrefs() success!");
    //  return value;
    //}).catchError((exception, stackTrace) async {
    //  //_debug("updatePrefs() fail!");
    //  await Sentry.captureException(
    //    exception,
    //    stackTrace: stackTrace,
    //  );
    //});
  }

  Future getInitialsAvatar(String name) async {
    //_debug(
    //    "At ${DateTime.now()} getInitialsAvatar($name) => Starting ApiService ");
    try {
      return avatars!.getInitials(name: name, width: 200).then((value) {
        //_debug("getInitialsAvatar($name) success!");
        return value;
      });
    } on AppwriteException catch (exception, stackTrace) {
      _debug("AppwriteException: getInitialsAvatar fail!");
      await Sentry.captureException(
        exception,
        stackTrace: stackTrace,
      );
      return null;
    }
    //return avatars!.getInitials(name: name, width: 200).then((value) {
    //  //_debug("getInitialsAvatar($name) success!");
    //  return value;
    //}).catchError((exception, stackTrace) async {
    //  //_debug("getInitialsAvatar($name) fail!");
    //  await Sentry.captureException(
    //    exception,
    //    stackTrace: stackTrace,
    //  );
    //});
  }

  Future getPrefs() async {
    //_debug("At ${DateTime.now()} getPrefs() => Starting ApiService ");
    try {
      return account!.getPrefs().then((value) {
        //_debug("getPrefs() success!");
        return value;
      });
    } on AppwriteException catch (exception, stackTrace) {
      _debug("AppwriteException: getPrefs fail!");
      await Sentry.captureException(
        exception,
        stackTrace: stackTrace,
      );
      return null;
    }
    //return account!.getPrefs().then((value) {
    //  //_debug("getPrefs() success!");
    //  return value;
    //}).catchError((exception, stackTrace) async {
    //  //_debug("getPrefs() fail!");
    //  await Sentry.captureException(
    //    exception,
    //    stackTrace: stackTrace,
    //  );
    //});
  }

  Future<Uint8List> getFile(String fileId, {int quality = 100}) {
    return storage!
        .getFilePreview(bucketId: "default", fileId: fileId, quality: quality)
        .then((value) {
      return value;
    });
  }

  Future getPhoto(String collectionName) {
//    _debug("At ${DateTime.now()} getPhoto() => Starting ApiService ");
    return db!
        .listDocuments(collectionId: "photos", databaseId: 'default')
        .then((listDocuments) {
//      _debug(
//          "At ${DateTime.now()} getPhoto() number ${listDocuments.sum.toString()} ");
      Iterable<Document> documentList = listDocuments.documents
          .where((element) => element.data["collectionName"] == collectionName);
//      _debug(
//          "At ${DateTime.now()} getPhoto() photo ${documentList.first.data["photo"].toString()} ");

      return documentList.first.data;
    });
  }

  Future<DocumentList?> getWhatNewsDocument() async {
    if (AppConstants.debug) {
      _debug(
          "getWhatNewsDocument()** At ${DateTime.now()} getWhatNewsDocument in api_service");
    }
    try {
      return db!
          .listDocuments(
        databaseId: 'default',
        queries: [
          appwrite.Query.limit(50),
          appwrite.Query.orderAsc('isCompleted'),
          appwrite.Query.orderAsc('year'),
          appwrite.Query.orderAsc('month'),
          appwrite.Query.orderAsc('day'),
        ],
        collectionId: '61b1cc5580c71',
      )
          .then((value) {
        if (AppConstants.debug) {
          _debug(
              "getWhatNewsDocument()** At ${DateTime.now()} getWhatNewsDocument in api_service return the value");
          _debug(
              "getWhatNewsDocument()** At ${DateTime.now()} getWhatNewsDocument in api_service return the value is ${value.total.toString()}");
        }
        return value;
      });
    } on AppwriteException catch (exception, stackTrace) {
      _debug("AppwriteException: getWhatNewsDocument fail!");
      await Sentry.captureException(
        exception,
        stackTrace: stackTrace,
      );
      return null;
    }
    //return db!
    //    .listDocuments(
    //  databaseId: 'default',
    //  queries: [
    //    appwrite.Query.limit(50),
    //    appwrite.Query.orderAsc('isCompleted'),
    //    appwrite.Query.orderAsc('year'),
    //    appwrite.Query.orderAsc('month'),
    //    appwrite.Query.orderAsc('day'),
    //  ],
    //  collectionId: '61b1cc5580c71',
    //)
    //    .then((value) {
    //  if (AppConstants.debug) {
    //    _debug(
    //        "getWhatNewsDocument()** At ${DateTime.now()} getWhatNewsDocument in api_service return the value");
    //  }
    //  return value;
    //}).catchError((exception, stackTrace) async {
    //  if (AppConstants.debug) {
    //    _debug(
    //        "getWhatNewsDocument()** At ${DateTime.now()} getWhatNewsDocument in api_service return the error");
    //  }
    //  await Sentry.captureException(
    //    exception,
    //    stackTrace: stackTrace,
    //  );
    //});
  }

  Future<DocumentList?> getPracticePlaceDocument() async {
    try {
      return db!.listDocuments(
        collectionId: 'practicePlace',
        databaseId: 'default',
        queries: [appwrite.Query.limit(100)],
      ).then((value) {
        //_debug("getPracticePlaceDocument information " + value.sum.toString());
        //_debug(value.documents.map((e) => _debug(e.data.toString())));
        //_debug(value);
        return value;
      });
    } on AppwriteException catch (exception, stackTrace) {
      _debug("AppwriteException: getPracticePlaceDocument fail!");
      await Sentry.captureException(
        exception,
        stackTrace: stackTrace,
      );
      return null;
    }
    //return db!.listDocuments(
    //  collectionId: 'practicePlace',
    //  databaseId: 'default',
    //  queries: [appwrite.Query.limit(100)],
    //).then((value) {
    //  //_debug("getPracticePlaceDocument information " + value.sum.toString());
    //  //_debug(value.documents.map((e) => _debug(e.data.toString())));
    //  //_debug(value);
    //  return value;
    //}).catchError((exception, stackTrace) async {
    //  await Sentry.captureException(
    //    exception,
    //    stackTrace: stackTrace,
    //  );
    //  //_debug(stackTrace);
    //});
  }

  Future<DocumentList?> getPracticeTimeDocument() async {
    try {
      return db!.listDocuments(
        collectionId: 'practiceTime',
        databaseId: 'default',
        queries: [appwrite.Query.limit(100)],
      ).then((value) {
        //_debug("getpracticeTimeDocument information " + value.sum.toString());
        //_debug(value.documents.map((e) => _debug(e.data.toString())));
        //_debug(value);
        return value;
      });
    } on AppwriteException catch (exception, stackTrace) {
      _debug("AppwriteException: getPracticeTimeDocument fail!");
      await Sentry.captureException(
        exception,
        stackTrace: stackTrace,
      );
      return null;
    }
    //return db!.listDocuments(
    //  collectionId: 'practiceTime',
    //  databaseId: 'default',
    //  queries: [appwrite.Query.limit(100)],
    //).then((value) {
    //  //_debug("getpracticeTimeDocument information " + value.sum.toString());
    //  //_debug(value.documents.map((e) => _debug(e.data.toString())));
    //  //_debug(value);
    //  return value;
    //}).catchError((exception, stackTrace) async {
    //  await Sentry.captureException(
    //    exception,
    //    stackTrace: stackTrace,
    //  );
    //  //_debug(stackTrace);
    //});
  }

  Future<DocumentList?> getRequirementDocument() async {
    try {
      return db!.listDocuments(
        collectionId: 'requirement',
        databaseId: 'default',
        queries: [appwrite.Query.limit(100)],
      ).then((value) {
        //_debug("getRequirementDocument information " + value.sum.toString());
        //_debug(value.documents.map((e) => _debug(e.data.toString())));
        //_debug(value);
        return value;
      });
    } on AppwriteException catch (exception, stackTrace) {
      _debug("AppwriteException: getRequirementDocument fail!");
      await Sentry.captureException(
        exception,
        stackTrace: stackTrace,
      );
      return null;
    }
    //return db!.listDocuments(
    //  collectionId: 'requirement',
    //  databaseId: 'default',
    //  queries: [appwrite.Query.limit(100)],
    //).then((value) {
    //  //_debug("getRequirementDocument information " + value.sum.toString());
    //  //_debug(value.documents.map((e) => _debug(e.data.toString())));
    //  //_debug(value);
    //  return value;
    //}).catchError((exception, stackTrace) async {
    //  await Sentry.captureException(
    //    exception,
    //    stackTrace: stackTrace,
    //  );
    //  //_debug(stackTrace);
    //});
  }

  Future<DocumentList?> getAnchkOrganizationDocument() async {
    try {
      return db!.listDocuments(
        collectionId: 'anchkOrganization',
        databaseId: 'default',
        queries: [appwrite.Query.limit(100)],
      ).then((value) {
        //_debug(          "getAnchkOrganizationDocument information " + value.sum.toString());
        //_debug(value.documents.map((e) => _debug(e.data.toString())));
        //_debug(value);
        return value;
      });
    } on AppwriteException catch (exception, stackTrace) {
      _debug("AppwriteException: getAnchkOrganizationDocument fail!");
      await Sentry.captureException(
        exception,
        stackTrace: stackTrace,
      );
      return null;
    }
    //return db!.listDocuments(
    //  collectionId: 'anchkOrganization',
    //  databaseId: 'default',
    //  queries: [appwrite.Query.limit(100)],
    //).then((value) {
    //  //_debug(          "getAnchkOrganizationDocument information " + value.sum.toString());
    //  //_debug(value.documents.map((e) => _debug(e.data.toString())));
    //  //_debug(value);
    //  return value;
    //}).catchError((exception, stackTrace) async {
    //  await Sentry.captureException(
    //    exception,
    //    stackTrace: stackTrace,
    //  );
    //  //_debug(stackTrace);
    //});
  }

  Future<DocumentList?> getAnchkMissionDocument() async {
    try {
      return db!.listDocuments(
        collectionId: 'anchkMission',
        databaseId: 'default',
        queries: [appwrite.Query.limit(100)],
      ).then((value) {
        //_debug("getAnchkMissionDocument information " + value.sum.toString());
        //_debug(value.documents.map((e) => _debug(e.data.toString())));
        //_debug(value);
        return value;
      });
    } on AppwriteException catch (exception, stackTrace) {
      _debug("AppwriteException: getAnchkMissionDocument fail!");
      await Sentry.captureException(
        exception,
        stackTrace: stackTrace,
      );
      return null;
    }
    //return db!.listDocuments(
    //  collectionId: 'anchkMission',
    //  databaseId: 'default',
    //  queries: [appwrite.Query.limit(100)],
    //).then((value) {
    //  //_debug("getAnchkMissionDocument information " + value.sum.toString());
    //  //_debug(value.documents.map((e) => _debug(e.data.toString())));
    //  //_debug(value);
    //  return value;
    //}).catchError((exception, stackTrace) async {
    //  await Sentry.captureException(
    //    exception,
    //    stackTrace: stackTrace,
    //  );
    //  //_debug(stackTrace);
    //});
  }

  Future<DocumentList?> getConductorMessage() async {
    try {
      return db!.listDocuments(
        collectionId: 'conductorMessage',
        databaseId: 'default',
        queries: [appwrite.Query.limit(100)],
      ).then((value) {
        //_debug("getconductorMessage information " + value.sum.toString());
        //_debug(value.documents.map((e) => _debug(e.data.toString())));
        //_debug(value);
        return value;
      });
    } on AppwriteException catch (exception, stackTrace) {
      _debug("AppwriteException: getConductorMessage fail!");
      await Sentry.captureException(
        exception,
        stackTrace: stackTrace,
      );
      return null;
    }
    //return db!.listDocuments(
    //  collectionId: 'conductorMessage',
    //  databaseId: 'default',
    //  queries: [appwrite.Query.limit(100)],
    //).then((value) {
    //  //_debug("getconductorMessage information " + value.sum.toString());
    //  //_debug(value.documents.map((e) => _debug(e.data.toString())));
    //  //_debug(value);
    //  return value;
    //}).catchError((exception, stackTrace) async {
    //  await Sentry.captureException(
    //    exception,
    //    stackTrace: stackTrace,
    //  );
    //  //_debug(stackTrace);
    //});
  }

  Future<DocumentList?> getPreachersMessage() async {
    try {
      return db!.listDocuments(
        collectionId: 'preachersMessage',
        databaseId: 'default',
        queries: [appwrite.Query.limit(100)],
      ).then((value) {
        //_debug("getPreachersMessage information " + value.sum.toString());
        //_debug(value.documents.map((e) => _debug(e.data.toString())));
        //_debug(value);
        return value;
      });
    } on AppwriteException catch (exception, stackTrace) {
      _debug("AppwriteException: getPreachersMessage fail!");
      await Sentry.captureException(
        exception,
        stackTrace: stackTrace,
      );
      return null;
    }
    //return db!.listDocuments(
    //  collectionId: 'preachersMessage',
    //  databaseId: 'default',
    //  queries: [appwrite.Query.limit(100)],
    //).then((value) {
    //  //_debug("getPreachersMessage information " + value.sum.toString());
    //  //_debug(value.documents.map((e) => _debug(e.data.toString())));
    //  //_debug(value);
    //  return value;
    //}).catchError((exception, stackTrace) async {
    //  await Sentry.captureException(
    //    exception,
    //    stackTrace: stackTrace,
    //  );
    //  //_debug(stackTrace);
    //});
  }

  Future<DocumentList?> getContactList() async {
    try {
      return db!.listDocuments(
        collectionId: 'contactList',
        databaseId: 'default',
        queries: [appwrite.Query.limit(100)],
      ).then((value) {
        //_debug("getContactList information " + value.sum.toString());
        //_debug(value.documents.map((e) => _debug(e.data.toString())));
        //_debug(value);
        return value;
      });
    } on AppwriteException catch (exception, stackTrace) {
      _debug("AppwriteException: getContactList fail!");
      await Sentry.captureException(
        exception,
        stackTrace: stackTrace,
      );
      return null;
    }
    //return db!.listDocuments(
    //  collectionId: 'contactList',
    //  databaseId: 'default',
    //  queries: [appwrite.Query.limit(100)],
    //).then((value) {
    //  //_debug("getContactList information " + value.sum.toString());
    //  //_debug(value.documents.map((e) => _debug(e.data.toString())));
    //  //_debug(value);
    //  return value;
    //}).catchError((exception, stackTrace) async {
    //  await Sentry.captureException(
    //    exception,
    //    stackTrace: stackTrace,
    //  );
    //  //_debug(stackTrace);
    //});
  }

  Future<DocumentList?> getAnchkorgEventCategory() async {
    try {
      return db!.listDocuments(
        collectionId: 'category',
        databaseId: 'default',
        queries: [appwrite.Query.limit(100)],
      ).then((value) {
        //_debug("getAnchkorgEventCategory information " + value.sum.toString());
        //_debug(value.documents.map((e) => _debug(e.data.toString())));
        //_debug(value);
        return value;
      });
    } on AppwriteException catch (exception, stackTrace) {
      _debug("AppwriteException: getAnchkorgEventCategory fail!");
      await Sentry.captureException(
        exception,
        stackTrace: stackTrace,
      );
      return null;
    }
    //return db!.listDocuments(
    //  collectionId: 'category',
    //  databaseId: 'default',
    //  queries: [appwrite.Query.limit(100)],
    //).then((value) {
    //  //_debug("getAnchkorgEventCategory information " + value.sum.toString());
    //  //_debug(value.documents.map((e) => _debug(e.data.toString())));
    //  //_debug(value);
    //  return value;
    //}).catchError((exception, stackTrace) async {
    //  await Sentry.captureException(
    //    exception,
    //    stackTrace: stackTrace,
    //  );
    //  //_debug(stackTrace);
    //});
  }

  Future<DocumentList?> getAnchkorgEvent() async {
    try {
      return db!.listDocuments(
        databaseId: 'default',
        collectionId: 'event',
        queries: [appwrite.Query.limit(100)],
      ).then((value) {
        //_debug("getAnchkorgEvent information " + value.sum.toString());
        //_debug(value.documents.map((e) => _debug(e.data.toString())));
        //_debug(value);
        return value;
      });
    } on AppwriteException catch (exception, stackTrace) {
      _debug("AppwriteException: getAnchkorgEvent fail!");
      await Sentry.captureException(
        exception,
        stackTrace: stackTrace,
      );
      return null;
    }
    //return db!.listDocuments(
    //  databaseId: 'default',
    //  collectionId: 'event',
    //  queries: [appwrite.Query.limit(100)],
    //).then((value) {
    //  //_debug("getAnchkorgEvent information " + value.sum.toString());
    //  //_debug(value.documents.map((e) => _debug(e.data.toString())));
    //  //_debug(value);
    //  return value;
    //}).catchError((exception, stackTrace) async {
    //  await Sentry.captureException(
    //    exception,
    //    stackTrace: stackTrace,
    //  );
    //  //_debug(stackTrace);
    //});
  }

  Future<DocumentList?> getVideoList() async {
    try {
      return db!.listDocuments(
        databaseId: 'default',
        collectionId: 'videoList',
//        queries: [appwrite.Query.orderAsc('youtubeTitle')],
        queries: [appwrite.Query.orderDesc('\$id')],
      ).then((value) {
//      _debug("getVideoList information " + value.sum.toString());
//      _debug(value.documents.map((e) => _debug(e.data.toString())));
//      _debug(value);
        return value;
      });
    } on AppwriteException catch (exception, stackTrace) {
      _debug("AppwriteException: getVideoList fail!");
      await Sentry.captureException(
        exception,
        stackTrace: stackTrace,
      );
      return null;
    }
    //return db!.listDocuments(
    //  databaseId: 'default',
    //  collectionId: 'videoList',
    //  queries: [appwrite.Query.orderAsc('youtubeTitle')],
    //).then((value) {
//  //    _debug("getVideoList information " + value.sum.toString());
//  //    _debug(value.documents.map((e) => _debug(e.data.toString())));
//  //    _debug(value);
    //  return value;
    //}).catchError((exception, stackTrace) async {
    //  await Sentry.captureException(
    //    exception,
    //    stackTrace: stackTrace,
    //  );
    //  //_debug(stackTrace);
    //});
  }

  Future createApplication(Map<dynamic, dynamic> data) {
    _debug("Starting createApplication");
    _debug("createApplication data is " + data.toString());
    String documentId = _generateUniquekey(10) + data["phone"].toString();
    _debug("createApplication documentId is " + documentId);
    return db!
        .createDocument(
      databaseId: 'default',
      collectionId: 'applicationList',
      documentId: documentId,
      data: data,
    )
        .then((response) {
      _debug("createApplication data is " + response.data.toString());
      _debug("Finish createApplication");
    }).catchError((error) {
      print(error.message);
    }, test: (e) => e is appwrite.AppwriteException);
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
    //_debug(
    //    "At ${DateTime.now()} updateAccountPassword() => Trying to ApiService updateAccountPassword");
    return account!
        .updatePassword(password: password, oldPassword: oldPassword)
        .then((value) {
      //_debug("At ${DateTime.now()} ApiService updateAccountPassword() success");
      //_debug(value.toMap().toString());
      return value;
    });
  }

  Future<DocumentList?> getChatRooms() async {
    try {
      return db!
          .listDocuments(
        databaseId: 'default',
        collectionId: 'chatRoom',
      )
          .then((value) {
        //_debug("getChatRooms information " + value.total.toString());
        //_debug(value.toString());
        return value;
      });
    } on AppwriteException catch (exception, stackTrace) {
      _debug("AppwriteException: getChatRooms fail!");
      await Sentry.captureException(
        exception,
        stackTrace: stackTrace,
      );
      return null;
    }
    //return db!
    //    .listDocuments(
    //  databaseId: 'default',
    //  collectionId: 'chatRoom',
    //)
    //    .then((value) {
    //  //_debug("getChatRooms information " + value.total.toString());
    //  //_debug(value.toString());
    //  return value;
    //}).catchError((exception, stackTrace) async {
    //  await Sentry.captureException(
    //    exception,
    //    stackTrace: stackTrace,
    //  );
    //  //_debug(stackTrace);
    //});
  }

  Future<DocumentList?> getChatMessages() async {
    try {
      return db!
          .listDocuments(
        databaseId: 'default',
        collectionId: 'chatMessage',
      )
          .then((value) {
        _debug("getChatMessages information " + value.total.toString());
        _debug(value.toString());
        return value;
      });
    } on AppwriteException catch (exception, stackTrace) {
      _debug("AppwriteException: getChatMessages fail!");
      await Sentry.captureException(
        exception,
        stackTrace: stackTrace,
      );
      return null;
    }
    //return db!
    //    .listDocuments(
    //  databaseId: 'default',
    //  collectionId: 'chatMessage',
    //)
    //    .then((value) {
    //  _debug("getChatMessages information " + value.total.toString());
    //  _debug(value.toString());
    //  return value;
    //}).catchError((exception, stackTrace) async {
    //  _debug("getChatMessages information Error" + stackTrace.toString());
    //  await Sentry.captureException(
    //    exception,
    //    stackTrace: stackTrace,
    //  );
    //});
  }
}
