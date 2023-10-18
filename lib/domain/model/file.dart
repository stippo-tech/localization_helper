import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';

class File {
  const File({
    required this.name,
    required this.ext,
    required this.bytes,
  });

  factory File.fromPlatformFile(PlatformFile file) => File(
        name: file.name,
        ext: file.name.substring(file.name.split('.').first.length),
        bytes: file.bytes!,
      );

  final String name;
  final String ext;
  final Uint8List bytes;
}
