import 'package:universe/pages/home/domain/entity/chat_message.dart';
import 'package:universe/pages/home/domain/entity/chat_room.dart';
import 'package:universe/pages/home/domain/entity/event_category_model.dart';
import 'package:universe/pages/home/domain/entity/event_history_model.dart';
import 'package:universe/pages/home/domain/entity/organization_info_model.dart';
import 'package:universe/pages/home/domain/entity/paragraph_model.dart';
import 'package:universe/pages/home/domain/entity/what_news_model.dart';
import 'package:universe/pages/home/domain/entity/youtube_model.dart';
import 'package:universe/shared/app_constants.dart';

class InitialData {
  static List<ChatMessage> chatMessages = [
    ChatMessage(
        messageFrom: "yoX8fU67hP",
        messageTo: "Test2",
        messageContent: "Hello, Will",
        messageType: "receiver"),
    ChatMessage(
        messageFrom: "yoX8fU67hP",
        messageTo: "Test2",
        messageContent: "How have you been?",
        messageType: "receiver"),
    ChatMessage(
        messageFrom: "yoX8fU67hP",
        messageTo: "Test2",
        messageContent: "Hey Kriss, I am doing fine dude. wbu?",
        messageType: "sender"),
    ChatMessage(
        messageFrom: "yoX8fU67hP",
        messageTo: "Test2",
        messageContent: "ehhhh, doing OK.",
        messageType: "receiver"),
    ChatMessage(
        messageFrom: "yoX8fU67hP",
        messageTo: "Test2",
        messageContent: "Is there any thing wrong?",
        messageType: "sender"),
  ];

  static List<ChatRoom> chatRooms = [
    ChatRoom(
        name: "Jane Russel",
        messageText: "Awesome Setup",
        imageURL: "images/userImage1.jpeg",
        time: "Now"),
    ChatRoom(
        name: "Glady's Murphy",
        messageText: "That's Great",
        imageURL: "images/userImage2.jpeg",
        time: "Yesterday"),
    ChatRoom(
        name: "Jorge Henry",
        messageText: "Hey where are you?",
        imageURL: "images/userImage3.jpeg",
        time: "31 Mar"),
    ChatRoom(
        name: "Philip Fox",
        messageText: "Busy! Call me in 20 mins",
        imageURL: "images/userImage4.jpeg",
        time: "28 Mar"),
    ChatRoom(
        name: "Debra Hawkins",
        messageText: "Thankyou, It's awesome",
        imageURL: "images/userImage5.jpeg",
        time: "23 Mar"),
    ChatRoom(
        name: "Jacob Pena",
        messageText: "will update you in evening",
        imageURL: "images/userImage6.jpeg",
        time: "17 Mar"),
    ChatRoom(
        name: "Andrey Jones",
        messageText: "Can you please share the file?",
        imageURL: "images/userImage7.jpeg",
        time: "24 Feb"),
    ChatRoom(
        name: "John Wick",
        messageText: "How are you?",
        imageURL: "images/userImage8.jpeg",
        time: "18 Feb"),
  ];

  static List<EventCategory> anchkorgEventCategory1 = [
    EventCategory(
      '音樂佈道會',
      [
        EventHistory('1992年12月', '聖樂佈道會-生命的抉擇(大專會堂)'),
        EventHistory('1993年12月', '聖誕節佈道會(長康浸信會)'),
        EventHistory('1994年1月', '香港浸會醫院元旦佈道會'),
        EventHistory('1994年12月', '聯會菲傭團契佈道會'),
        EventHistory('1994年12月', '聖樂佈道會(大興浸信會)'),
        EventHistory('1996年1月', '聖樂佈道會(宣道浸信會)'),
        EventHistory('1996年4月', '聖樂佈道會(元朗平安福音堂)'),
        EventHistory('1997年7月', '大興浸信會主辦綜合晚會'),
        EventHistory('1998年7月', '綜合佈道會–迷失世界之真情'),
        EventHistory('1999年12月', '朗邊聖誕佈道會'),
        EventHistory('2000年4月', '復活節聖樂佈道會–復活的光輝'),
        EventHistory('2002年12月', '12月佈道會(新福協辦聖誕節晚會)'),
        EventHistory('2002年12月', '這個冬天不太冷 - 佈道會(長康浸信會)'),
        EventHistory('2004年6月', '無比的愛 - 佈道會 (觀塘浸信會)'),
        EventHistory('2005年6月', '無比的愛 - 佈道會 (學基浸信會)'),
        EventHistory('2005年12月', '佈道會 (觀塘浸信會)'),
        EventHistory('2007年12月', '福音出擊(葵盛浸信會)'),
        EventHistory('2007年12月', '光的慶典 - 佈道會(大學浸信會)'),
      ],
    ),
    EventCategory(
      '協辦培靈會',
      [
        EventHistory('1996年4月', '聖樂培靈會'),
        EventHistory('1996年11月', '華人聖樂培靈分享會 一聖樂飄飄處處聞'),
        EventHistory('1999年4月', '受難節聖樂培靈會–奇妙十架'),
        EventHistory('2001年4月', '受難節培靈會(基督教香港信義會真理堂)'),
        EventHistory('2002年3月', '受難節培靈會'),
        EventHistory('2002年10月', '聯會培靈會 (學基浸信會)'),
        EventHistory('2007年4月', '受難節聖樂培靈會'),
      ],
    ),
    EventCategory(
      '聖樂交流會',
      [
        EventHistory('1999年9月', '楊伯倫先生聖樂事奉五十周年獻唱會'),
        EventHistory('2000年9月', '世紀頌讚唱頌會(浸信會出版社)'),
        EventHistory('2009年11月', '感恩之歌 - 陳贊一聖樂交流音樂會'),
        EventHistory('2017年5月', '聖樂促進會 '),
        EventHistory('2017年12月', '聖經信息協會25周年崇拜'),
        EventHistory('2017年12月', '觀潮浸信會獻唱'),
      ],
    ),
    EventCategory(
      '工作坊',
      [
        EventHistory('2012年5月', '詩班工作坊 - 尖沙咀浸信會'),
        EventHistory('2013年9月', '合唱工作坊 - 鑽石山浸信會'),
        EventHistory('2018年12月', '合唱工作坊 - 基督教尖沙咀潮人生命堂'),
      ],
    ),
  ];

  static List<EventCategory> anchkorgEventCategory2 = [
    EventCategory(
      '大型音樂會',
      [
        EventHistory('1998年1月', '「來!讚美祂!」中國浸信會神學院拓院籌款音樂會（香港文化中心音樂廳）'),
        EventHistory('1998年6月', '九十年代華人聖樂頌（香港浸信會神學院）'),
        EventHistory('1998年11月', '中國水災籌款音樂會 （世界華人聖樂促進會）'),
        EventHistory('2006年11月', '讚美的時光 - 15周年感恩音樂會'),
        EventHistory('2007年1月', '袮的名在全地何其美「香港基督徒中樂團」籌款音樂會'),
        EventHistory('2008年1月', '香港基督徒中樂團10周年音樂會'),
        EventHistory('2010年4月', '聯會受難節音樂會「十架七言」'),
        EventHistory('2011年4月', '主辨受難節音樂會「十架七言」'),
        EventHistory('2012年7月', '聖詩頌唱會 （沙田大會堂）'),
        EventHistory('2012年1月', '救主恩情感恩無盡 - 20周年感恩音樂會'),
        EventHistory('2012年7月', '聖樂頌唱會音樂會 - 沙田大會堂'),
        EventHistory('2013年11月', '聖詩頌唱會 - 灣仔新伊館'),
        EventHistory('2014年10月', '陳贊一音樂會'),
        EventHistory('2014年12月', '聖詩會頌唱 --- 廣福堂'),
        EventHistory('2017年1月', '不可思議的恩典與榮耀 - 25周年音樂會'),
        EventHistory('2017年12月', '跨媒體平安夜音樂會'),
        EventHistory('2018年1月', '香港基督徒中樂團音樂會'),
      ],
    ),
    EventCategory(
      '海外聖樂交流及短宣',
      [
        EventHistory('1992~1996年', '分別在印尼、廣州、東莞、澳門、台灣及順德聖樂交流'),
        EventHistory('1999~2001年', '分別在越南、東馬、湛江聖樂交流'),
        EventHistory('2005~2007年', '分別在澳門、淡水及肇興聖樂交流'),
        EventHistory('2009~2019年', '分別在惠東、台山、三水、 汕頭、廣西、江門、澳門、溫州及海南島聖樂交流'),
      ],
    ),
    EventCategory(
      '其他獻唱',
      [
        EventHistory('2015年1月', '中浸神學院培靈研經會'),
        EventHistory('2016年1月', '中浸神學院培靈研經會'),
        EventHistory('2017年12月', '除夕跨年感恩祈禱會（創世電視主辦）'),
        EventHistory('2019年4月', '逾越節晚宴暨紀念基督受難聖餐崇拜（創世電視主辦）'),
        EventHistory('歴年', '萬國宣道浸信聯會各堂會主日獻唱'),
      ],
    ),
  ];

  static List<WhatNews> whatNews = [
    WhatNews(
      year: 2021,
      month: 12,
      day: 26,
      event: "深恩堂福音主日",
      place: "陳白沙中學",
      photo:
          "${AppConstants.endpoint}/v1/storage/files/61b1cd2a06b53/view?project=61b0428203f09&mode=admin",
      isCompleted: true,
      bgPhoto:
          "${AppConstants.endpoint}/v1/storage/files/621441dad2b50285aa3d/view?project=61b0428203f09&mode=admin",
    ),
    WhatNews(
      year: 2022,
      month: 12,
      day: 4,
      event: "恆安浸信會聖樂主日",
      place: "恆安浸信會",
      photo:
          "${AppConstants.endpoint}/v1/storage/files/61b1cd9f655c1/view?project=61b0428203f09&mode=admin",
      isCompleted: false,
      bgPhoto:
          "${AppConstants.endpoint}/v1/storage/files/621441dad2b50285aa3d/view?project=61b0428203f09&mode=admin",
    ),
    WhatNews(
      year: 2021,
      month: 12,
      day: 2,
      event: "中浸神學院培靈會",
      place: "學基浸信會",
      photo:
          "${AppConstants.endpoint}/v1/storage/files/61b1ce100fcf2/view?project=61b0428203f09&mode=admin",
      isCompleted: true,
      bgPhoto:
          "${AppConstants.endpoint}/v1/storage/files/621441dad2b50285aa3d/view?project=61b0428203f09&mode=admin",
    ),
    WhatNews(
      year: 2020,
      month: 11,
      day: 29,
      event: "恆安浸信會聖樂主日",
      place: "恆安浸信會",
      photo:
          "${AppConstants.endpoint}/v1/storage/files/61b1cd9f655c1/view?project=61b0428203f09&mode=admin",
      isCompleted: true,
      bgPhoto:
          "${AppConstants.endpoint}/v1/storage/files/621441dad2b50285aa3d/view?project=61b0428203f09&mode=admin",
    ),
    WhatNews(
      year: 2019,
      month: 8,
      day: 2,
      event: "海南島聖樂交流",
      place: "海南島",
      photo:
          "${AppConstants.endpoint}/v1/storage/files/61b1cec5762dd/view?project=61b0428203f09&mode=admin",
      isCompleted: true,
      bgPhoto:
          "${AppConstants.endpoint}/v1/storage/files/621441dad2b50285aa3d/view?project=61b0428203f09&mode=admin",
    ),
  ];

  static List<Paragraph> practicePlace = [
    Paragraph('宣道浸信會'),
    Paragraph('深水埗順寧道47號嘉寧閣一樓'),
  ];

  static List<Paragraph> practiceTime = [
    Paragraph('練習時間為每月第一、第三及第五週的星期四晚上八時至十時。'),
    Paragraph('有需要時亦會增加練習時間。'),
  ];

  static List<Paragraph> requirement = [
    Paragraph('年滿十八歲'),
    Paragraph('已接受浸禮，並加入基督教教會的信徒。'),
    Paragraph('喜愛歌唱，具傳福音心志，樂意以聖樂事奉主。'),
    Paragraph('願意委身聖樂事工，恆常出席練習'),
    Paragraph('申請者須連續出席練習不少於三次，並經本團查問心志，及試音合格，即可成為本詠團團員。'),
  ];

  static List<Paragraph> anchkOrganization = [
    Paragraph('本詠團成立於1991年，乃「萬國宣道浸信聯會」屬下之聖樂事工小組。'),
    Paragraph(
        '創團成員皆由聯會各堂會之會友組成，設職員會及團牧推動各項音樂培訓、聚會和佈道事工。當中包括大型的培靈會、音樂佈道會、籌款/感恩音樂會等等。'),
    Paragraph(
        '海外佈道方面，詠團亦曾前赴星加坡、馬來西亞、印尼、越南、台灣、澳門及中國大陸等地作聖樂短宣/培訓工作。其中亦曾與不同的團體合作以多元化的形式舉行佈道培靈事工，如大型的短宣隊及專業的福音話劇團等。'),
    Paragraph('近年亦吸引了不同宗派弟兄姊妹加入音樂事奉的行列。'),
  ];
  static List<Paragraph> anchkMission = [
    Paragraph('回應主耶穌的大使命，藉詩歌傳揚主福音。主理/協辦聖樂佈道聚會，及進行國內及海外聖樂短宣。'),
    Paragraph('協力推動聖樂事工；透過主領聖樂崇拜、講座或大型聖樂聚會，讓聯會或各宗派教會認識聖樂的重要性。'),
    Paragraph('藉聖樂提升信徒的屬靈和音樂藝術素養，與主關係更親近。'),
    Paragraph('推介古今中外優質聖樂作品，舉辦讚美會、聖樂研討會、專題講座等。'),
  ];
  static String conductorMessage =
      '葉成芝先生乃「萬國宣道詠團」創團指揮。曾師承凌忍揚博士學習合唱指揮，張汝鈞先生和翁強先生等學習聲樂。葉氏現任觀塘浸信會和香港靈糧堂聖樂顧問，香港聖詩會董事及發展委員會主席，香港浸信會聯會聖樂部理事，香港聖樂服務社董事。曾香港聖樂促進會副會長，大學浸信會聖樂主任多年。現任創世之聲合唱團，香港聖詩會詩班，及多個教會詩班指揮。葉氏一生致力推動教會音樂出版及聖樂培訓事工，曾翻譯出版數十首詩班合唱曲。他經常應邀主領聖樂專題講座和合唱工作坊，組織海外及國內音樂培訓和聖樂交流/短宣等活動。';

  static String preachersMessage =
      '林得坤先生於1991年神學畢業後，有十年時間在教會牧養事奉，跟著有三年多於基督教出版社服事及參與國內的信徒領䄂培訓，往後便一直至今參與國內港人的職場牧養，並且在電子出版工作上參與基督教多媒體平台的開發與應用，服事國內外華人教會。近年蒙神引領在港參與學校的生命教育服工，協助教會於青少年人的福音工作發展。與詠團是多年的合作夥伴，曾多次參與詠團的短宣，一起透過詩歌，證道傳揚福音，見證神恩典。';

  static List<OrganizationInfo> contactList = [
    OrganizationInfo("萬國宣道詠團", "2744 4083", "https://www.anchk.org",
        "info@anchk.org", "https://www.facebook.com/anc.org.hk"),
    OrganizationInfo(
        "萬國宣道浸信聯會",
        "2744 4083",
        "http://hkabwe.org/",
        "abwefhk@gmail.com",
        "https://www.facebook.com/香港萬國宣道浸信聯會-196427550420768"),
  ];

  static List<YoutubeModel> videosList = const [
    YoutubeModel(
        id: 1,
        youtubeId: 'Hp8P_CXOQ68',
        youtubeTitle: "萬國宣道詠團30周年音樂會招募",
//        thumbnailImage: "Hp8P_CXOQ68.jpg"),
        thumbnailImage:
            "${AppConstants.endpoint}/v1/storage/files/61fa03501566e7c7e9f5/view?project=61b0428203f09&mode=admin"),
    YoutubeModel(
        id: 2,
        youtubeId: 'b53oI2p-UrI',
        youtubeTitle: "朋友請聽 2019",
//        thumbnailImage: "b53oI2p-UrI.jpg"),
        thumbnailImage:
            "${AppConstants.endpoint}/v1/storage/files/61fa03b010bb5b1a9e37/view?project=61b0428203f09&mode=admin"),
    YoutubeModel(
        id: 3,
        youtubeId: 'ArJj0pMqJls',
        youtubeTitle: "同來讚美救主",
//        thumbnailImage: "ArJj0pMqJls.jpg"),
        thumbnailImage:
            "${AppConstants.endpoint}/v1/storage/files/61fa0413da27c99de0e2/view?project=61b0428203f09&mode=admin"),
    YoutubeModel(
        id: 4,
        youtubeId: 'UXP9sR0A0vQ',
        youtubeTitle: "全心全意愛上帝 2014年7月",
//        thumbnailImage: "UXP9sR0A0vQ.jpg"),
        thumbnailImage:
            "${AppConstants.endpoint}/v1/storage/files/61fa044fabb08c9ad763/view?project=61b0428203f09&mode=admin"),
    YoutubeModel(
        id: 5,
        youtubeId: 'C2szYJuQymI',
        youtubeTitle: "敬拜頌歌",
//        thumbnailImage: "C2szYJuQymI.jpg"),
        thumbnailImage:
            "${AppConstants.endpoint}/v1/storage/files/61fa049502e56e485502/view?project=61b0428203f09&mode=admin"),
    YoutubeModel(
        id: 6,
        youtubeId: 'CkjbpbRrRYo',
        youtubeTitle: "靠近我 2014年7月",
//        thumbnailImage: "CkjbpbRrRYo.jpg"),
        thumbnailImage:
            "${AppConstants.endpoint}/v1/storage/files/61fa04d454a878685a54/view?project=61b0428203f09&mode=admin"),
    YoutubeModel(
        id: 7,
        youtubeId: 'gCwHitVRirI',
        youtubeTitle: "祝福",
//        thumbnailImage: "gCwHitVRirI.jpg"),
        thumbnailImage:
            "${AppConstants.endpoint}/v1/storage/files/61fa05204108db2edb40/view?project=61b0428203f09&mode=admin"),
    YoutubeModel(
        id: 8,
        youtubeId: '7pc4rNCmEqo',
        youtubeTitle: "不動搖的國度",
//        thumbnailImage: "7pc4rNCmEqo.jpg"),
        thumbnailImage:
            "${AppConstants.endpoint}/v1/storage/files/61fa0587498cdb051b57/view?project=61b0428203f09&mode=admin"),
  ];
}
