class YoutubeModel {
  final int id;
  final String youtubeId;
  final String youtubeTitle;
  final String thumbnailImage;

  const YoutubeModel({
    required this.youtubeTitle,
    required this.id,
    required this.youtubeId,
    required this.thumbnailImage,
  });
  factory YoutubeModel.fromMap(Map<String, dynamic> map) {
    return YoutubeModel(
      youtubeId: map['youtubeId'],
      id: map['id'],
      youtubeTitle: map['youtubeTitle'],
      thumbnailImage: map['thumbnailImage'],
    );
  }
  @override
  String toString() {
    return 'YoutubeModel\nyoutubeId: $youtubeId\nyoutubeTitle: $youtubeTitle';
  }
}
