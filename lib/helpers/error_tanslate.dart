class ErrorTanslate {
//  String errorCode(int code) {
//    switch (code) {
//      case 401:
//        return ('不正確的密碼');
//      case 403:
//        return ('不允許訪問');
//      case 404:
//        return ('請求的 URI 無效或請求的資源');
//      case 429:
//        return ('當由於資源的應用程序的速率限制已用盡而無法處理請求時返回。');
//      default:
//        return ('請聯繫管理員!  ${code.toString()}');
//    }
//  }

  List<Map<int, String>> data = [
    {401: "不正確的密碼"},
    {403: "不允許訪問"},
    {404: "請求的 URI 無效或請求的資源"},
    {429: "當由於資源的應用程序的速率限制已用盡而無法處理請求時返回。"},
  ];

  String findValue(int code) {
    final item = data.firstWhere((element) => element.containsKey(code));
    return item[code] ?? "請聯繫管理員!  ${code.toString()}";
  }
}
