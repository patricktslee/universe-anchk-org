//import 'package:flutter/material.dart';

//import 'package:universe/pages/home/domain/entity/event_category_model.dart';
//import 'package:universe/pages/home/domain/entity/event_history_model.dart';
//import 'package:universe/pages/home/domain/entity/organization_info_model.dart';
//import 'package:universe/pages/home/domain/entity/paragraph_model.dart';

const rootRoute = "/";

const whatNewsPageDisplayName = "最新消息";
const whatNewsPageRoute = "/whatnews";

const introductionPageDisplayName = "詠團組織";
const introductionPageRoute = "/introduction";

const missionPageDisplayName = "詠團宗旨";
const missionPageRoute = "/mission";

const conductorPageDisplayName = "詠團指揮";
const conductorPageRoute = "/conductor";

const preachersPageDisplayName = "詠團團牧";
const preachersPageRoute = "/preachers";

const leadersPageDisplayName = "團牧/指揮";
const leadersPageRoute = "/leaders";

const historyPageDisplayName = "歷年事工";
const historyPageRoute = "/history";

const videoPageDisplayName = "詠團影片";
const videoPageRoute = "/video";

const practicePageDisplayName = "詠團練習";
const practicePageRoute = "/practice";

const requirementPageDisplayName = "申請者條件";
const requirementPageRoute = "/requirement";

const applicationtPageDisplayName = "團員申請";
const applicationPageRoute = "/application";

const contactPageDisplayName = "聯絡";
const contactPageRoute = "/contact";

const authenticationPageDisplayName = "Log out";
const authenticationPageRoute = "/auth";

const profilePageDisplayName = "Profile";
const profilePageRoute = "/profile";

const debugPageDisplayName = "Debug";
const debugpageRoute = "/debug";

class CustomMenuItem {
  final String name;
  final String route;

  CustomMenuItem(this.name, this.route);
}

List<CustomMenuItem> sideMenuItemRoutes = [
  CustomMenuItem(whatNewsPageDisplayName, whatNewsPageRoute),
  CustomMenuItem(introductionPageDisplayName, introductionPageRoute),
//  CustomMenuItem(missionPageDisplayName, missionPageRoute),
  CustomMenuItem(leadersPageDisplayName, leadersPageRoute),
//  CustomMenuItem(conductorPageDisplayName, conductorPageRoute),
//  CustomMenuItem(preachersPageDisplayName, preachersPageRoute),
  CustomMenuItem(historyPageDisplayName, historyPageRoute),
  CustomMenuItem(videoPageDisplayName, videoPageRoute),
  CustomMenuItem(practicePageDisplayName, practicePageRoute),
  CustomMenuItem(requirementPageDisplayName, requirementPageRoute),
  CustomMenuItem(applicationtPageDisplayName, applicationPageRoute),
  CustomMenuItem(contactPageDisplayName, contactPageRoute),
//  CustomMenuItem(debugPageDisplayName, debugpageRoute),
//  CustomMenuItem(covid19PageDisplayName, covid19PageRoute),
//  CustomMenuItem(authenticationPageDisplayName, authenticationPageRoute),
];

//class Paragraph {
//  final String text;
//  Paragraph(this.text);
//}

//class OrganizationInfo {
//  final String name;
//  final String telephone;
//  final String url;
//  final String email;
//  final String facebook;
//
//  OrganizationInfo(
//      this.name, this.telephone, this.url, this.email, this.facebook);
//}
//
//class EventHistory {
//  final String year;
//  final String event;
//
//  EventHistory(this.year, this.event);
//}
//
//class EventCategory {
//  final String name;
//  final List<EventHistory> events;
//
//  EventCategory(this.name, this.events);
//}

//final List<Paragraph> anchkOrganization = [
//  Paragraph('本詠團成立於1991年，乃「萬國宣道浸信聯會」屬下之聖樂事工小組。'),
//  Paragraph(
//      '創團成員皆由聯會各堂會之會友組成，設職員會及團牧推動各項音樂培訓、聚會和佈道事工。當中包括大型的培靈會、音樂佈道會、籌款/感恩音樂會等等。'),
//  Paragraph(
//      '海外佈道方面，詠團亦曾前赴星加坡、馬來西亞、印尼、越南、台灣、澳門及中國大陸等地作聖樂短宣/培訓工作。其中亦曾與不同的團體合作以多元化的形式舉行佈道培靈事工，如大型的短宣隊及專業的福音話劇團等。'),
//  Paragraph('近年亦吸引了不同宗派弟兄姊妹加入音樂事奉的行列。'),
//];

//final List<Paragraph> anchkMission = [
//  Paragraph('回應主耶穌的大使命，藉詩歌傳揚主福音。主理/協辦聖樂佈道聚會，及進行國內及海外聖樂短宣。'),
//  Paragraph('協力推動聖樂事工；透過主領聖樂崇拜、講座或大型聖樂聚會，讓聯會或各宗派教會認識聖樂的重要性。'),
//  Paragraph('藉聖樂提升信徒的屬靈和音樂藝術素養，與主關係更親近。'),
//  Paragraph('推介古今中外優質聖樂作品，舉辦讚美會、聖樂研討會、專題講座等。'),
//];

//const String conductorMessage =
//    '葉成芝先生乃「萬國宣道詠團」創團指揮。曾師承凌忍揚博士學習合唱指揮，張汝鈞先生和翁強先生等學習聲樂。葉氏現任觀塘浸信會和香港靈糧堂聖樂顧問，香港聖詩會董事及發展委員會主席，香港浸信會聯會聖樂部理事，香港聖樂服務社董事。曾香港聖樂促進會副會長，大學浸信會聖樂主任多年。現任創世之聲合唱團，香港聖詩會詩班，及多個教會詩班指揮。葉氏一生致力推動教會音樂出版及聖樂培訓事工，曾翻譯出版數十首詩班合唱曲。他經常應邀主領聖樂專題講座和合唱工作坊，組織海外及國內音樂培訓和聖樂交流/短宣等活動。';

//const String preachersMessage =
//    '林得坤先生於1991年神學畢業後，有十年時間在教會牧養事奉，跟著有三年多於基督教出版社服事及參與國內的信徒領䄂培訓，往後便一直至今參與國內港人的職場牧養，並且在電子出版工作上參與基督教多媒體平台的開發與應用，服事國內外華人教會。近年蒙神引領在港參與學校的生命教育服工，協助教會於青少年人的福音工作發展。與詠團是多年的合作夥伴，曾多次參與詠團的短宣，一起透過詩歌，證道傳揚福音，見證神恩典。';
//final List<OrganizationInfo> contactList = [
//  OrganizationInfo("萬國宣道詠團", "2744 4083", "https://www.anchk.org",
//      "info@anchk.org", "https://www.facebook.com/anc.org.hk"),
//  OrganizationInfo(
//      "萬國宣道浸信聯會",
//      "2744 4083",
//      "http://hkabwe.org/",
//      "abwefhk@gmail.com",
//      "https://www.facebook.com/香港萬國宣道浸信聯會-196427550420768"),
//];

//final List<Paragraph> requirementList = [
//  Paragraph('年滿十八歲'),
//  Paragraph('已接受浸禮，並加入基督教教會的信徒。'),
//  Paragraph('喜愛歌唱，具傳福音心志，樂意以聖樂事奉主。'),
//  Paragraph('願意委身聖樂事工，恆常出席練習'),
//  Paragraph('申請者須連續出席練習不少於三次，並經本團查問心志，及試音合格，即可成為本詠團團員。'),
//];

//final List<Paragraph> practiceTime = [
//  Paragraph('練習時間為每月第一、第三及第五週的星期四晚上八時至十時。'),
//  Paragraph('有需要時亦會增加練習時間。'),
//];

//final List<Paragraph> practicePlace = [
//  Paragraph('宣道浸信會'),
//  Paragraph('深水埗順寧道47號嘉寧閣一樓'),
//];

//class WhatNews {
//  final String year;
//  final String month;
//  final String day;
//  final String event;
//  final String place;
//  final String photo;
//  final bool isCompleted;
//
//  WhatNews(this.year, this.month, this.day, this.event, this.place, this.photo,
//      this.isCompleted);
//  factory WhatNews.fromMap(Map<String, dynamic> map) {
//    return WhatNews(
//      map['year'],
//      map['month'],
//      map['day'],
//      map['event'],
//      map['place'],
//      map['photo'],
//      map['isCompleted'],
//    );
//  }
//}
//
//final List<WhatNews> whatNewsItemList = [
//  WhatNews("2021年", "12月", "26", "深恩堂福音主日", "陳白沙中學",
//      "assets/images/BountifulGraceChurch.jpg", false),
//  WhatNews("2022年", "12月", "04", "恆安浸信會聖樂主日", "恆安浸信會",
//      "assets/images/heng_on_baptist_church.png", false),
//  WhatNews("2021年", "12月", "02", "中浸神學院培靈會", "學基浸信會", "assets/images/cbtc.jpg",
//      true),
//  WhatNews("2020年", "11月", "29", "恆安浸信會聖樂主日", "恆安浸信會",
//      "assets/images/heng_on_baptist_church.png", true),
//  WhatNews("2019年", "8月", "02", "海南島聖樂交流", "海南島", "assets/images/IMG_5635.JPG",
//      true),
//];
