class Paragraph {
  final String text;
  Paragraph(this.text);
  factory Paragraph.fromMap(Map<String, dynamic> map) {
    return Paragraph(
      map['text'],
    );
  }
  @override
  String toString() {
    return 'Paragraph(text:$text)';
  }

  Map<String, dynamic> toMap() {
    return {
      'text': text,
    };
  }
}
