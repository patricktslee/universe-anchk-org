import 'dart:convert';
import 'dart:typed_data';

class AppwriteFile {
  String? id;
  Uint8List? file;

  AppwriteFile({
    this.id,
    this.file,
  });

  AppwriteFile copyWith({
    String? id,
    Uint8List? file,
  }) {
    return AppwriteFile(id: id ?? this.id, file: file ?? this.file);
  }

  factory AppwriteFile.fromMap(Map<String, dynamic> map) {
    return AppwriteFile(
      id: map['id'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
    };
  }

  factory AppwriteFile.fromJson(String source) =>
      AppwriteFile.fromMap(json.decode(source));

  String toJson() => json.encode(toMap());

  @override
  String toString() {
    return 'AppwriteFile(id: $id, FileSize: ${file!.length.toString()})';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is AppwriteFile && other.id == id && other.file == file;
  }

  @override
  int get hashCode {
    return id.hashCode ^ file.hashCode;
  }
}
