import 'dart:typed_data';

class WhatNews {
  final int? year;
  final int? month;
  final int? day;
  final String? event;
  final String? place;
  final String? photo;
  final String? photoId;
  final bool? isCompleted;
  final String? bgPhoto;
  final String? bgPhotoId;
  Uint8List? bgPhotoFile;
  Uint8List? photoFile;

  WhatNews(
      {this.year,
      this.month,
      this.day,
      this.event,
      this.place,
      this.photo,
      this.photoId,
      this.isCompleted,
      this.bgPhoto,
      this.bgPhotoId,
      this.bgPhotoFile,
      this.photoFile});
  factory WhatNews.fromMap(Map<String, dynamic> map) {
    return WhatNews(
      year: map['year'],
      month: map['month'],
      day: map['day'],
      event: map['event'],
      place: map['place'],
      photo: map['photo'],
      photoId: map['photoId'],
      isCompleted: map['isCompleted'],
      bgPhoto: map['bgPhoto'],
      bgPhotoId: map['bgPhotoId'],
    );
  }

  factory WhatNews.fromObject(
      {Map<String, dynamic>? map,
      Uint8List? bgPhotoFile,
      Uint8List? photoFile}) {
    return WhatNews(
      year: map!['year'],
      month: map['month'],
      day: map['day'],
      event: map['event'],
      place: map['place'],
      photo: map['photo'],
      photoId: map['photoId'],
      isCompleted: map['isCompleted'],
      bgPhoto: map['bgPhoto'],
      bgPhotoId: map['bgPhotoId'],
      bgPhotoFile: bgPhotoFile,
      photoFile: photoFile,
    );
  }

  @override
  String toString() {
    return 'WhatNews(Year:$year, Month:$month, Day:$day, Event:$event, Place:$place, Photo Id:$photoId, IsComplete:$isCompleted, BGPhoto Id:$bgPhotoId)';
  }
}
