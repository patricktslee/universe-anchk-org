import 'dart:async';
import 'dart:typed_data';

//import 'package:appwrite/models.dart';
//import 'package:appwrite/appwrite.dart';
import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:universe/constants/style.dart';
//import 'package:universe/constants/style.dart';
import 'package:universe/pages/home/data/initial_data.dart';

import 'package:universe/pages/home/domain/adapters/repository_adapter.dart';
import 'package:universe/pages/home/domain/entity/anchk_organization.dart';
import 'package:universe/pages/home/domain/entity/cases_model.dart';
import 'package:universe/pages/home/domain/entity/conductor.dart';
import 'package:universe/pages/home/domain/entity/contact_info.dart';
import 'package:universe/pages/home/domain/entity/practice_info.dart';
import 'package:universe/pages/home/domain/entity/preacher.dart';
import 'package:universe/pages/home/domain/entity/what_news_model.dart';
import 'package:universe/routing/routes.dart';
import 'package:universe/pages/home/domain/entity/user.dart';

class HomeController extends SuperController<CasesModel> {
  HomeController({required this.homeRepository});
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey();
  final logger = Logger(
    printer: PrettyPrinter(
        methodCount: 1,
        lineLength: 50,
        errorMethodCount: 3,
        colors: true,
        printEmojis: true),
  );

  void _debug(String value) {
    value = "At HomeController class - " + value;
    print(value);
    logger.i(value);
    homeRepository.addApiLog(value);
  }

  /// inject repo abstraction dependency
  final IHomeRepository homeRepository;

  RxString sessionId = ''.obs;
  var activeItem = whatNewsPageDisplayName.obs;
  final RxString _username = ''.obs;

  var hoverItem = "".obs;
  var selectedIndex = 2.obs;
  final _loginStatus = "Status.uninitialized".obs;
  var dataStatus = "Status.uninitialized".obs;
  var datalog = "Logging the information".obs;
  final RxString displayName = '訪客'.obs;
  final RxString _providerBox = ''.obs;
  get providerBox {
    _providerBox.value = homeRepository.providerBox;
    _providerBox.value == "anonymous"
        ? displayName.value = "訪客"
        : displayName.value = "會員";
    //_debug("providerBox displayName is ${displayName.value}");
    return _providerBox;
  }

  late LoginUser _currentUser;

  get currentUser {
    _currentUser = homeRepository.user;
    return _currentUser;
  }

  late Session _currentSession;

  get currentSession {
    _currentSession = homeRepository.session;
    return _currentSession;
  }

  RxString get currentUsername {
    _username.value = homeRepository.user.name.toString();
    return _username;
  }

  RxString get loginStatus {
    _loginStatus.value = homeRepository.status.toString();
    return _loginStatus;
  }

//  RxList whatNewsItem = [].obs;
  RxList<WhatNews> whatNews = <WhatNews>[].obs;

//  RxList anchkOrganizationItem = [].obs;
  var anchkOrganizationPhoto = '621489f59e05d1b3752b'.obs;
  Rx<AnchkOrganization> introdutcion = AnchkOrganization(
    name: 'introduction',
    message: InitialData.anchkOrganization,
    photo: '621489f59e05d1b3752b',
  ).obs;
  Rx<AnchkOrganization> mission = AnchkOrganization(
    name: 'mission',
    message: InitialData.anchkMission,
    photo: '62148c5a23e6fe098547',
  ).obs;
  Rx<AnchkOrganization> requirement = AnchkOrganization(
    name: 'requirement',
    message: InitialData.requirement,
    photo: '621486b379b02f56ff6c',
  ).obs;
//  RxList anchkMissionItem = [].obs;
//  var anchkMissionPhoto = '621489f59e05d1b3752b'.obs;
//  var conductorMessagetext = ''.obs;
//  var conductorMessagePhoto = ''.obs;
//  Rx<Uint8List> conductorMessagePhotoFile = Uint8List(0).obs;
//  var preachersMessagetext = ''.obs;
//  var preachersMessagePhoto = ''.obs;
//  Rx<Uint8List> preachersMessagePhotoFile = Uint8List(0).obs;
  Rx<Preacher> preacher = Preacher().obs;
  Rx<Conductor> conductor = Conductor().obs;
  Rx<ContactInfo> contact = ContactInfo().obs;
  Rx<PracticeInfo> practice = PracticeInfo(photo: "loadingdata").obs;

//  RxList contactInfoItem = [].obs;
//  var contactPhoto = ''.obs;
//  Rx<Uint8List> contactListFile = Uint8List(0).obs;
//  RxList requirementItem = [].obs;
//  var requirementPhoto = ''.obs;
//  RxList practiceTimeItem = [].obs;
//  RxList practicePlaceItem = [].obs;
//  var practicePhoto = ''.obs;
//  Rx<Uint8List> practicePhotoFile = Uint8List(0).obs;
  RxList eventHistoryItem1 = [].obs;
  RxList eventHistoryItem2 = [].obs;
  RxList chatRooms = [].obs;
  RxList chatMessages = [].obs;
  RxList videosList = [].obs;
  RxList apiLogList = [].obs;
  RxInt tabAuthIndexSelected = 0.obs;
  late RealtimeSubscription subscription;
  Timer? timer;

  /// When the controller is initialized, make the http request
  @override
  Future<void> onInit() async {
    super.onInit();
//    loadingData();
    await appwriteLogin();
    //_debug("Starting onInit for subscribe");
    await subscribe();
    //_debug("Finished onInit for subscribe");
    getLoginStatus();
    // show loading on start, data on success
    // and error message on error with 0 boilerplate
    //homeRepository.getCases().then((data) {
    //  _debug(data.toJson().toString());
    //  change(data, status: RxStatus.success());
    //}, onError: (err) {
    //  change(null, status: RxStatus.error(err.toString()));
    //});
    scheduleTimer();
  }

  void scheduleTimer() {
    Timer.periodic(
      const Duration(seconds: 120),
      (timer) {
        // Update user about remaining time
        _debug("At ${DateTime.now()} restart the subscription");
        unsubscribe();
        subscribe();
      },
    );
  }

  subscribe() {
    //  homeRepository.subscribe();
    subscription = homeRepository.realtime.subscribe(['documents']);
    _debug("At ${DateTime.now()} subscription subscribed");
    subscription.printInfo();
    subscription.stream.listen((event) {
      _debug("At ${DateTime.now()} subscription event start");
      loadingData();
      _debug(
          "At ${DateTime.now()} subscription event completed to run loadingData()");
    });
  }

  unsubscribe() {
    //  homeRepository.unsubscribe();
    subscription.close();
  }

  Future<dynamic> navigateTo(String routeName) {
    return navigatorKey.currentState!.pushNamed(routeName);
  }

  goBack() => navigatorKey.currentState!.pop();

  changeSelectedIndex(int index) {
    selectedIndex.value = index;
    //_debug("SelectedIndex changed to $selectedIndex");
  }

  changeActiveItemTo(String itemName) {
    itemName == authenticationPageDisplayName
        ? activeItem.value = whatNewsPageDisplayName
        : activeItem.value = itemName;
  }

  onHover(String itemName) {
    if (!isActive(itemName)) hoverItem.value = itemName;
  }

  isHovering(String itemName) => hoverItem.value == itemName;

  isActive(String itemName) => activeItem.value == itemName;

  Widget returnIconFor(String itemName) {
    switch (itemName) {
      case whatNewsPageDisplayName:
        return _customIcon(Icons.info, itemName);
      case introductionPageDisplayName:
        return _customIcon(Icons.call_made, itemName);
      case missionPageDisplayName:
        return _customIcon(Icons.check_box_sharp, itemName);
      case leadersPageDisplayName:
        return _customIcon(Icons.leaderboard, itemName);
      case conductorPageDisplayName:
        return _customIcon(Icons.drive_eta, itemName);
      case preachersPageDisplayName:
        return _customIcon(Icons.people_alt_outlined, itemName);
      case historyPageDisplayName:
        return _customIcon(Icons.history, itemName);
      case videoPageDisplayName:
        return _customIcon(Icons.video_collection, itemName);
      case practicePageDisplayName:
        return _customIcon(Icons.list, itemName);
      case requirementPageDisplayName:
        return _customIcon(Icons.notifications, itemName);
      case applicationtPageDisplayName:
        return _customIcon(Icons.run_circle, itemName);
      case contactPageDisplayName:
        return _customIcon(Icons.add_business, itemName);
//      case covid19PageDisplayName:
//        return _customIcon(Icons.bug_report, itemName);
      case authenticationPageDisplayName:
        return _customIcon(Icons.exit_to_app, itemName);
      case debugPageDisplayName:
        return _customIcon(Icons.bug_report, itemName);
      default:
        return _customIcon(Icons.exit_to_app, itemName);
    }
  }

  Widget _customIcon(IconData icon, String itemName) {
    if (isActive(itemName)) return Icon(icon, size: 22);

//    _debug("What is the status of _isWeb ${_isWeb.toString()}");

    return _isWeb
        ? Icon(
            icon,
            color: isHovering(itemName) ? menuHoverColor : menuColor,
          )
        : Icon(
            icon,
          );
  }

  bool _isWeb = true;

  void setWebEnv(bool isWeb) {
    _isWeb = isWeb;
  }

  void getLoginStatus() {
//    _debug("Before getLoginStatus");
//    _debug(loginStatus.value);
    loginStatus.value = homeRepository.status.toString();
//    datalog.value = homeRepository.apiLog.last;
//    _debug("getLoginStatus ${homeRepository.apiLog.last}");
//    _debug("After getLoginStatus");
//    _debug(lo          ginStatus.value);
  }

  Future<void> appwriteLogin() async {
    bool isLogin = false;
    //_debug("1.  The runtime classname is HomeController - Start login");
    await homeRepository.createAnonymousSession().then((value) {
      isLogin = homeRepository.isLogin;
      //_debug(
      //    "At ${DateTime.now()} running A.  isLogin is " + isLogin.toString());
      datalog.value = "A.  isLogin is " + isLogin.toString();
      if (isLogin) {
        //_debug(
        //    "At ${DateTime.now()} Starting to run Logout when isLogin is ${isLogin.toString()}");
        loadingData();
        providerBox();
//        sessionId.value = homeRepository.session.$id;
        //_debug(
        //    "At ${DateTime.now()} the currentUsername is ${currentUsername.value.toString()}");
        //Timer(const Duration(seconds: 15), () async {
        //  await homeRepository.logoutAll().then((response) {
        //    getLoginStatus();
        //    dataStatus.value = 'Status.authenticated';
        //  }).catchError((error) {
        //    _debug(error.response);
        //  });
        //});
      } else {
        //_debug(
        //    "At ${DateTime.now()} running Login error when isLogin is ${isLogin.toString()}");
        dataStatus.value = 'Status.unauthenticated';
        //_debug(homeRepository.error);
      }
    }).catchError((onError) {
      //_debug(
      //    "At ${DateTime.now()} running Login error when isLogin is ${onError.toString()}");
    });
  }

  Future updateAccountPassword(String password, String oldPassword) async {
    return await homeRepository.updateAccountPassword(password, oldPassword);
  }

  Future getSessions() async {
    return await homeRepository.getSessions();
  }

  Future<String> getPhoto(String collectionName) async {
    return await homeRepository.getPhoto(collectionName).then((value) {
//      _debug(
//          "At ${DateTime.now()} homeController getPhoto() photo is ${value.toString()}");

      return value;
    });
  }

  Future<String> getPhotoFileId(String collectionName) async {
    return await homeRepository.getPhotoFileId(collectionName).then((value) {
//      _debug(
//          "At ${DateTime.now()} homeController getPhoto() photo is ${value.toString()}");

      return value;
    });
  }

  Future getWhatNews() async {
    await homeRepository.getWhatNewsDocument().then((value) {
      //_debug(
      //    "at ${DateTime.now()} Start getWhatNews length ${whatNews.length.toString()}");
      whatNews.value = homeRepository.whatNews;
      //_debug(
      //    "at ${DateTime.now()} Finished getWhatNews length ${whatNews.length.toString()}");
    });
  }

  Future getAnchkOrganizationItem() async {
    //_debug("at ${DateTime.now()} getAnchkOrganizationItem start");

    return await homeRepository
        .getAnchkOrganizationDocument()
        .then((value) async {
      //_debug("at ${DateTime.now()} getAnchkOrganizationItem 1");
      getPhotoFileId("anchkOrganization")
          .then((value) => anchkOrganizationPhoto.value = value);
//      anchkOrganizationItem.clear();
//      anchkOrganizationItem.addAll(homeRepository.anchkOrganization.toList());
      //_debug("at ${DateTime.now()} getAnchkOrganizationItem ");
      introdutcion.value = homeRepository.introduction;
      //_debug(
      //    "at ${DateTime.now()} getAnchkOrganizationItem ${introdutcion.value.message![0].toString()}");
//      return homeRepository.anchkOrganization.toList();
    });
  }

  Future getAnchkMissionItem() async {
    return await homeRepository.getAnchkMissionDocument().then((value) {
//      getPhotoFileId("anchkMission").then((value) {
//        anchkMissionPhoto.value = value;
//          return value;
//      });
//      anchkMissionItem.clear();
//      anchkMissionItem.addAll(homeRepository.anchkMission.toList());
      mission.value = homeRepository.mission;
//      return homeRepository.anchkMission.toList();
    });
  }

  Future getConductor() async {
    return await homeRepository.getConductorMessage().then((value) {
      conductor.value = Conductor(
        name: homeRepository.conductor.name,
        message: homeRepository.conductor.message,
        photo: homeRepository.conductor.photo,
        photoFile: homeRepository.conductor.photoFile as Uint8List,
      );
//      conductorMessagePhoto.value = homeRepository.conductor.photo!;
//      homeRepository.getFile(conductorMessagePhoto.value).then((value) {
//        _debug(
//            "At ${DateTime.now()} getFile(String ${conductorMessagePhoto.value}) , type is ${homeRepository.conductorFile.runtimeType} ");
//        conductorMessagePhotoFile.value = homeRepository.conductorFile;
//        return value;
//      });
//      conductorMessagetext.value = homeRepository.conductor.message!;
      return homeRepository.conductor;
    });
  }

  Future getPreacher() async {
    return await homeRepository.getPreachersMessage().then((value) {
      preacher.value = Preacher(
        name: homeRepository.preacher.name,
        message: homeRepository.preacher.message,
        photo: homeRepository.preacher.photo,
        photoFile: homeRepository.preacher.photoFile as Uint8List,
      );
//      preachersMessagetext.value = homeRepository.preacher.message!;
//      preachersMessagePhoto.value = homeRepository.preacher.photo!;
//      preachersMessagePhotoFile.value =
//          homeRepository.preacher.photoFile as Uint8List;
      return homeRepository.preacher;
    });
  }

  Future getPracticeInfo() async {
    return await homeRepository
        .getPractice()
        .then((value) => practice.value = homeRepository.practice);
  }

  //Future getPracticePlaceItem() async {
  //  return await homeRepository.getPracticePlaceDocument().then((value) async {
  //    practicePlaceItem.clear();
  //    practicePlaceItem.addAll(homeRepository.practicePlace.toList());
  //    getPhotoFileId("practicePlace").then((photo) {
  //      practicePhoto.value = photo;
  //    });
  //    return homeRepository.practicePlace.toList();
  //  });
  //}
//
  //Future getPracticeTimeItem() async {
  //  return await homeRepository.getPracticeTimeDocument().then((value) {
  //    practiceTimeItem.clear();
  //    practiceTimeItem.addAll(homeRepository.practiceTime.toList());
  //    practicePhotoFile.value = homeRepository.practiceFile;
  //    return homeRepository.practiceTime.toList();
  //  });
  //}

  Future getRequirementItem() async {
    return await homeRepository.getRequirementDocument().then((value) {
//      requirementItem.clear();
//      requirementItem.addAll(homeRepository.requirement.toList());
//      getPhotoFileId("requirement").then((photo) {
//        requirementPhoto.value = photo;
//      });
      requirement.value = homeRepository.anchkRequirement;
//      return homeRepository.requirement.toList();
    });
  }

  Future getContactList() async {
    return await homeRepository.getContactList().then((value) {
      //getPhotoFileId("contactList").then((photo) {
      //  contactPhoto.value = photo;
      //});
      //contactInfoItem.clear();
      //contactInfoItem.addAll(homeRepository.contactList.toList());
      //contactListFile.value = homeRepository.contactListFile;
      contact.value = homeRepository.contact;
      //return homeRepository.contactList.toList();
    });
  }

  Future getAnchkorgEventCategory1() async {
    return await homeRepository.getAnchkorgEventCategory1().then((value) {
      eventHistoryItem1.clear();
      eventHistoryItem1.addAll(homeRepository.anchkorgEventCategory1.toList());
      return homeRepository.anchkorgEventCategory1.toList();
    });
  }

  Future getAnchkorgEventCategory2() async {
    return await homeRepository.getAnchkorgEventCategory2().then((value) {
      //print(
      //    'at ${DateTime.now()} Testing on _anchkorgEventCategory2 on getAnchkorgEventCategory2 ${homeRepository.anchkorgEventCategory2.length}');
      eventHistoryItem2.clear();
      eventHistoryItem2.addAll(homeRepository.anchkorgEventCategory2.toList());
      return homeRepository.anchkorgEventCategory2.toList();
    });
  }

  Future getAnchkorgVideoList() async {
//    getWhatNews();

    return await homeRepository.getVideoList().then((value) {
      videosList.clear();
      videosList.addAll(homeRepository.videoList.toList());
      return homeRepository.videoList;
    });
  }

  Future createChatDocument({
    required String messageContent,
    required String messageFrom,
    required String messageTo,
  }) async {
    List<dynamic> readPermission = const ['*'];
    List<dynamic> writePermission = const ['*'];
    Map<String, dynamic> data = {
      "messageFrom": messageFrom,
      "messageTo": messageTo,
      "messageContent": messageContent,
      "messageType": "text",
    };
    return await homeRepository
        .createChatDocument(
      data: data,
      readPermission: readPermission,
      writePermission: writePermission,
    )
        .then((value) {
      chatMessages.clear();
      chatMessages.addAll(homeRepository.chatMessages.toList());
      _debug("At ${DateTime.now()} getChatMessages() finished ");
      return homeRepository.chatRooms;
    });
  }

  Future getChatRooms() async {
    return await homeRepository.getChatRooms().then((value) {
      chatRooms.clear();
      chatRooms.addAll(homeRepository.chatRooms.toList());
      return homeRepository.chatRooms;
    });
  }

  Future getChatMessages() async {
    _debug("At ${DateTime.now()} getChatMessages() started ");
    return await homeRepository.getChatMessages().then((value) {
      chatMessages.clear();
      chatMessages.addAll(homeRepository.chatMessages.toList());
      _debug("At ${DateTime.now()} getChatMessages() finished ");
      return homeRepository.chatRooms;
    });
  }

  Future<void> loadingData() async {
    _debug("At ${DateTime.now()} running loading data");
    await getWhatNews();
    //while (homeRepository.firstTimeLoading) {
    //  _debug(
    //      "At ${DateTime.now()} running loading firstTimeLoading dataStatus.value is ${dataStatus.value.toString()}");
    //  if (whatNews.isNotEmpty) {
    //    break;
    //  }
    //}
    dataStatus.value = 'Status.dataUpdated';
    _debug(
        "At ${DateTime.now()} running loading data and dataStatus.value is ${dataStatus.value.toString()}");
    getConductor();
    getPreacher();
    getAnchkOrganizationItem();
    getAnchkMissionItem();
    getRequirementItem();
    getPracticeInfo();
    getContactList();
    videosList.addAll(homeRepository.videoList.toList());
    getChatRooms();
    getChatMessages();

//    Timer(const Duration(seconds: 2), () async {
//      whatNewsItem.addAll(homeRepository.whatNews.toList());
//      for (var element in whatNews) {
//        _debug(
//            "At ${DateTime.now()} loadingData WhatNews is ${element.toString()}");
//      }
//      dataStatus.value = 'Status.dataUpdated';

//      getPracticeTimeItem();
//    });
//    Timer(const Duration(seconds: 5), () async {
//      practicePlaceItem.addAll(homeRepository.practicePlace.toList());
//      practiceTimeItem.addAll(homeRepository.practiceTime.toList());
    // requirementItem.addAll(homeRepository.requirement.toList());
//      anchkOrganizationItem.addAll(homeRepository.anchkOrganization.toList());
//      anchkMissionItem.addAll(homeRepository.anchkMission.toList());
//      conductorMessagetext.value = homeRepository.conductor.message!;
//      conductorMessagePhoto.value = homeRepository.conductor.photo!;
//      preachersMessagetext.value = homeRepository.preacher.message!;
//      preachersMessagePhoto.value = homeRepository.preacher.photo!;
    //contactInfoItem.addAll(homeRepository.contactList.toList());
//      eventHistoryItem1.addAll(homeRepository.anchkorgEventCategory1.toList());
//      eventHistoryItem2.addAll(homeRepository.anchkorgEventCategory2.toList());
//    });
    var period = const Duration(seconds: 1);

    Timer.periodic(period, (timer) {
      apiLogList.clear();
      apiLogList.addAll(homeRepository.apiLog.toList());
    });
  }

  void createApplication(Map<dynamic, dynamic> data) {
    homeRepository.createApplication(data);
//    _debug("createApplication at home_controller.dart" + result.toString());
  }

  Future userLogin({required String email, required String password}) async {
    return await homeRepository
        .login(email: email, password: password)
        .then((value) {
      providerBox();
      return value;
    });
  }

  Future userRegistration(
      {required String name,
      required String email,
      required String password}) async {
    return await homeRepository
        .signup(name: name, email: email, password: password)
        .then((value) {
      providerBox();
      return value;
    });
//    _debug("createApplication at home_controller.dart" + result.toString());
  }

  Future userLogout({required String sessionId}) async {
    return await homeRepository.logout(sessionId: sessionId).then((value) {
      providerBox();
      return value;
    }).catchError((onError) {
      providerBox();
      _debug(onError);
      return value;
    });
    //  return await homeRepository
    //      .logout(sessionId: sessionId)
    //      .catchError((onError) async {
    //    _debug("Userlogout Error: Trying to logout all Sessions.\n" +
    //        onError.toString());
    //    await homeRepository.logoutAll();
    //  });
  }

  @override
  void onReady() {
    //_debug('The build method is done. '        'Your controller is ready to call dialogs and snackbars');
    super.onReady();
  }

  @override
  void onClose() {
    //_debug('onClose called');
    unsubscribe();
    timer!.cancel();
    super.onClose();
  }

  @override
  void didChangeMetrics() {
    //_debug('the window size did change');
    super.didChangeMetrics();
  }

  @override
  void didChangePlatformBrightness() {
    //_debug('platform change ThemeMode');
    super.didChangePlatformBrightness();
  }

  @override
  Future<bool> didPushRoute(String route) {
    //_debug('the route $route will be open');
    return super.didPushRoute(route);
  }

  @override
  Future<bool> didPopRoute() {
    //_debug('the current route will be closed');
    return super.didPopRoute();
  }

  @override
  void onDetached() {
    //_debug('onDetached called');
  }

  @override
  void onInactive() {
    //_debug('onInative called');
  }

  @override
  void onPaused() {
    //_debug('onPaused called');
  }

  @override
  void onResumed() {
    //_debug('onResumed called');
  }
}
