import 'package:appwrite/appwrite.dart';
import 'package:universe/shared/app_constants.dart';

class ApiService {
  static late final ApiService _instance;
  static bool _isInstanceCreated = false;

  final Client client = Client();
  Account? account;
  Database? db;
  Avatars? avatars;

  ApiService._internal() {
    print("Initial Appwrite connection using ApiService");
    client.setEndpoint(AppConstants.endpoint).setProject(AppConstants.project);
    account = Account(client);
    db = Database(client);
    avatars = Avatars(client);
  }

  static ApiService get instance {
    if (_isInstanceCreated == false) {
      _isInstanceCreated = true;
      _instance = ApiService._internal();
    }
    return _instance;
  }

  Future login({required String email, required String password}) async {
    print('Trying to ApiService login');
    return await account!.createSession(email: email, password: password);
  }

  Future<Response<dynamic>> signup(
      {required String name,
      required String email,
      required String password}) async {
    return account!.create(name: name, email: email, password: password);
  }

  Future<Response<dynamic>> logout({String? sessionId}) async {
//    print('Session ID is ' + sessionId);

    return sessionId == 'null'
        ? account!.deleteSessions()
        : account!.deleteSession(sessionId: sessionId.toString());
  }

  Future getUserSession() async {
    return account!.get();
  }

  Future getSessions() async {
    return account!.getSessions();
  }

  Future updatePrefs(Map<String, dynamic> data) {
    return account!.updatePrefs(prefs: data);
  }

  Future getInitialsAvatar(String name) {
    return avatars!.getInitials(name: name, width: 200);
  }
}
